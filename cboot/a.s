*  .T4
* ---------------------------------------------------------------------------
*   R68K LOWCORE AND CONFIGURATION
*   copyright (c) 1984 by Whitesmiths, Ltd.
* ---------------------------------------------------------------------------
* TODO:
*  1> enable rest of ikbd processor (clock,joy*,status)
*  2> spurious interrupt catcher
* ---------------------------------------------------------------------------
* UPDATES:
*  1> (10/30/87) now keeps track and corrects for skipped clock interrupts
*  2> (11/14/87) added explicted setting of 68901 GPIP direction and edges
* ---------------------------------------------------------------------------
* Important fixed tos addresses
* ---------------------------------------------------------------------------
etv_timer  = 0x000400            * (long) system timer handoff vector
_timr_ms   = 0x000442            * (word) system timer-C calibration (in ms)
defshiftmd = 0x00044a            * (byte) default video rez
sshiftmd   = 0x00044c            * (byte) shadow for 'shiftmd' register
nvbls      = 0x000454            * (word) number of longwords in vblqueue
screenpt   = 0x00045e            * (long) pointer to screen base setup
conterm    = 0x000484            * (byte) console configuration byte
_hz_200    = 0x0004ba            * (long) timer C raw tick
_dumpflg   = 0x0004ee            * (word) flag signals screen dump (alt-HELP)
ibufptr    = 0                   * offset for buffer adr in tos input record
ibufsiz    = 4                   * offset for buffer siz in tos input record
ibufhead   = 6                   * offset for head index in tos input record
ibuftail   = 8                   * offset for tail index in tos input record
* ---------------------------------------------------------------------------
    .data
	.globl	__sdata				* first data location
__sdata:
*
    .text
	.globl	__stext
__stext:						* first text location
	jmp     idris
* ---------------------------------------------------------------------------
*   bus error
* ---------------------------------------------------------------------------
*	.globl	__buserr
* __buserr:
*	movem.l	d0-d7/a0-a7,__regs
*	tst.l	__cpu
*	bne.s	1f
*	addq.l	#8,sp						* 68000 only
* 1:
*	mfusp	a0
*	move.l	a0,-(sp)
*	jsr     _buserr
*	move.l	d7,rtefl
*	movem.l	__regs,d0-d7/a0-a7
*	tst.l	rtefl
*	beq		sigbus
*	rte
*
*    .data
* rtefl: .long	0
*	.text
* ---------------------------------------------------------------------------
*	DEVICE INTERRUPT INTERFACES
* ---------------------------------------------------------------------------
*   RS232 interrupts (input, output, and cts)
* ---------------------------------------------------------------------------
    .globl  _iser_int
isrint:
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
	.long	_iser_int
*
    .globl  _oser_int
osrint:
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
	.long	_oser_int
*
    .globl  _cser_int
csrint:
*	bclr.b	#2,0xfffffa11      * clear the cts interrupt (if software eoi)
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
	.long	_cser_int
* ---------------------------------------------------------------------------
*   Hard Disk interrupts
* ---------------------------------------------------------------------------
    .globl  _hd_intr
hdkint:
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
	.long	_hd_intr
* ---------------------------------------------------------------------------
*   PARALLEL Port interrupts
* ---------------------------------------------------------------------------
    .globl  _lpr_int
lprint:
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
	.long	_lpr_int
* ---------------------------------------------------------------------------
* vblank intercept routine, mainly to insure vblqueue disabled for now
* later on as we know more may want to allow these!
* ---------------------------------------------------------------------------
vblint:
    move.w  #0,nvbls               * for safety disable vblqueue processing
    move.w  #0xffff,_dumpflg       * insure screen print never on
    addq.w  #1,_clk_flg            * lock the clock/keyboard
    trap    #0                     * call original vbl handler
    subq.w  #1,_clk_flg            * unlock the clock/keyboard
    rte
* ---------------------------------------------------------------------------
* handle real time clock interrupts at 200hz
* divide by 4 so idris only sees 50hz
* ---------------------------------------------------------------------------
	.globl _clock
    .globl _clk_flg
*
    .data
tc_rot:   .word 0x1111             * set every forth bit to divide by 4
clk_cnt:  .word 0                  * counter for blocked clock interrupts
_clk_flg: .word 0                  * clock normally on
    .text
*
clkint:
    tst.w   _clk_flg			   * is the clock stopped
    bne.s	clkskp                 * exit if is
	move.l	#clkrts,etv_timer	   * don't allow etv_timer, seems to crash
    trap    #3                     * call rom clock handler
clklp:
	tst.w	clk_cnt				   * any skipped interrupts
	beq.s	clkcup				   * branch if not
	trap	#5					   * go do a clock interrupt (clkcup)
	subq.w	#1,clk_cnt			   * count that interrupt done
	bra.s	clklp				   * see if any more to do
clkcup:                            * entry point to catch clock up with
    rol.w   tc_rot                 * rotate divisor bits
    bpl.s   clkrte                 * if not 4th interrupt, then return
    jsr     tstkbm                 * get any characters that are ready
    move.l  d0,-(sp)
    clr.l   d0
    jsr     trapinit
    .long   _clock
clkrte:
    rte
clkskp:
	addq.w	#1,clk_cnt             * count the skipped interrupt
    rte
clkrts:                            * handy return instruction
	rts
* ---------------------------------------------------------------------------
* keyboard/midi interrupt intercept routine
* ---------------------------------------------------------------------------
kbmint:
    move.l  a0,-(sp)               * save registers
    move.l  savmvect,a0            * get address
    move.l  #do_mouse,16(a0)       * set mouse vector cause gem might change
    move.l  (sp)+,a0               * restore registers
* !!!! could do output interrupt processing here !!!!
    trap    #4                     * call original int handler
    move.w  #0xffff,_dumpflg       * insure screen print never on if just set
    tst.w   _clk_flg			   * is the clock stopped, exit if it is cause
    bne.s	kbmrte                 * seems to hang system if process keys then
 	move.l	d0,-(sp)
	clr.l	d0
	jsr		trapinit
    .long   tstkbm
kbmrte:
    rte
* ---------------------------------------------------------------------------
*   check if any input for keyboard or midi, fake interrupt if so
* ---------------------------------------------------------------------------
    .globl _key_int
    .globl _key_dat
    .globl _mid_int
    .globl _mid_dat
*
    .data
_mid_dat: .byte 0,0                * only first byte used but keep even
_key_dat: .long 0                  * low word is char, high is scan code
    .text
* midi stored 1 byte per entry, keyboard is 4 bytes per entry (whoopie)
tstkbm:
	movem.l	d0-d7/a0-a6,-(sp)      * save the registers
lp_midi:                           * process any chars that came in
	move.l  _mid_rec,a0            * point to midi buffer record
	move.w  sr,-(sp)               * protect this upcoming test
	.long   0x007c0700             * ori.w #0x700,sr { spl7() }
	move.w  ibufhead(a0),d1        * get head index
	cmp.w   ibuftail(a0),d1        * if head equal tail then empty
	beq.s   no_midi                * exit if none
	addq.w  #1,d1                  * check for wrap of pointer
	cmp.w   ibufsiz(a0),d1         * if > current bufsiz then wrap
	bcs.s   nw_midi                * branch if no wrap yet
	moveq   #0,d1                  * else force a wrap
nw_midi:
	move.l  ibufptr(a0),a1         * get base address of buffer
	move.b  0(a1,d1.w),_mid_dat    * get the character
	move.w  d1,ibufhead(a0)        * store new head pointer
	move.w  (sp)+,sr               * restore status register
	jsr     _mid_int               * do fake interrupt routine
	bra.s   lp_midi                * do more midi if needed
no_midi:
	move.w  (sp)+,sr               * restore status register
lp_keyb:
	move.l  _key_rec,a0            * point to keyb buffer record
	move.w  sr,-(sp)               * protect this upcoming test
	.long   0x007c0700             * ori.w #0x700,sr { spl7() }
	move.w  ibufhead(a0),d1        * get head index
	cmp.w   ibuftail(a0),d1        * if head equal tail then empty
	beq.s   no_keyb                * exit if none
	addq.w  #4,d1                  * check for wrap of pointer
	cmp.w   ibufsiz(a0),d1         * if > current bufsiz then wrap
	bcs.s   nw_keyb                * branch if no wrap yet
	moveq   #0,d1                  * else force a wrap
nw_keyb:
	move.l  ibufptr(a0),a1         * get base address of buffer
	move.l  0(a1,d1.w),_key_dat    * get the character
	move.w  d1,ibufhead(a0)        * store new head pointer
	move.w  (sp)+,sr               * restore status register
	jsr     _key_int               * do fake interrupt routine
	bra.s   lp_keyb                * do more keyb if needed
no_keyb:
	move.w  (sp)+,sr               * restore status register
	movem.l	(sp)+,d0-d7/a0-a6      * restore registers
	rts
*
* -- keep following code around because may be more portable, if slower!!
*
*tstkbm:
*	movem.l	d0-d7/a0-a6,-(sp)      * save the registers
*lp_midi:                           * process any chars that came in
*	move.w	#3,-(sp)               * push midi     device   number
*	move.w  #1,-(sp)               * push Bconstat function number
*	trap    #13                    * do the system call
*	addq.l  #4,sp                  * clean up the stack
*	tst.w   d0                     * any characters ready, non zero if so
*	beq.s   lp_keyb                * exit if none
*	move.w	#3,-(sp)               * push midi    device   number
*	move.w  #2,-(sp)               * push Bconin  function number
*	trap    #13                    * do the system call
*	addq.l  #4,sp                  * clean up the stack, char. in d0 now
*	move.b  d0,_mid_dat            * set so can pass to 'c' code
*	jsr     _mid_int               * do fake interrupt routine
*	bra.s   lp_midi                * do more midi if needed
*lp_keyb:
*	move.w	#2,-(sp)               * push console  device   number
*	move.w  #1,-(sp)               * push Bconstat function number
*	trap    #13                    * do the system call
*	addq.l  #4,sp                  * clean up the stack
*	tst.w   d0                     * any characters ready, non zero if so
*	beq.s   con_ret                * exit if none
*	move.w	#2,-(sp)               * push console device   number
*	move.w  #2,-(sp)               * push Bconin  function number
*	trap    #13                    * do the system call
*	addq.l  #4,sp                  * clean up the stack, char. in d0 now
*	move.l  d0,_key_dat            * set so can pass to 'c' code
*	jsr     _key_int               * do fake interrupt routine
*	bra.s   lp_keyb                * do more keyb if needed
*con_ret:
*	movem.l	(sp)+,d0-d7/a0-a6      * restore registers
*	rts
* ---------------------------------------------------------------------------
* put a character to the console using rom function
* ---------------------------------------------------------------------------
    .globl   _vidput
_vidput:
	link	a6,#0
	movem.l	d0-d7/a0-a5,-(sp)      * insure all registers saved
    addq.w  #1,_clk_flg            * lock the clock/keyboard
	move.w	10(a6),-(sp)           * push character value
	move.w	#2,-(sp)               * push console device   number
	move.w  #3,-(sp)               * push bconout function number
	trap    #13                    * do the system call
	addq.l  #6,sp                  * clean up the stack
    subq.w  #1,_clk_flg            * unlock the clock/keyboard
	movem.l	(sp)+,d0-d7/a0-a5      * restore saved registers
	unlk	a6
	rts
* ---------------------------------------------------------------------------
*  handle ikbd vector calls (status, mouse, clock, joysticks)
* ---------------------------------------------------------------------------
    .globl _mos_int
    .globl _mos_buf
    .data
_mos_buf: .byte 0,0,0,0,0,0,0,0    * 8 bytes max ever used
    .text
do_stats:
	movem.l	d0-d7/a0-a6,-(sp)       * insure all registers saved
    move.l #_mos_buf,a1             * get destination address
    move.b #0xf6,(a1)+              * put command byte
    move.b (a0)+,(a1)+              * byte 1 (  mode)
    move.b (a0)+,(a1)+              * byte 2 (param1)
    move.b (a0)+,(a1)+              * byte 3 (param2)
    move.b (a0)+,(a1)+              * byte 4 (param3)
    move.b (a0)+,(a1)+              * byte 5 (param4)
    move.b (a0)+,(a1)+              * byte 6 (   pad)
    move.b (a0)+,(a1)+              * byte 7 (   pad)
    jsr    _mos_int                 * go to 'c' handler
	movem.l	(sp)+,d0-d7/a0-a6       * restore saved registers
    rts
do_mouse:
	movem.l	d0-d7/a0-a6,-(sp)       * insure all registers saved
    move.l #_mos_buf,a1             * get destination address
    move.b (a0),d0                  * get the first byte 
    and.b  #0xf0,d0                 * upper bits zero if absolute
    bne.s  rel_mos                  * branch if relative mouse
    move.b #0xf7,(a1)+              * set command byte for absolute mouse
    move.b (a0)+,(a1)+              * byte 1 (abs buttons)
    move.b (a0)+,(a1)+              * byte 2 (abs x-value)
rel_mos:
    move.b (a0)+,(a1)+              * byte 3 (abs x-value)   (rel command byte)
    move.b (a0)+,(a1)+              * byte 4 (abs y-value)   (rel      x-delta)
    move.b (a0)+,(a1)+              * byte 5 (abs y-value)   (rel      y-delta)
    jsr    _mos_int                 * go to 'c' handler
	movem.l	(sp)+,d0-d7/a0-a6       * restore saved registers
    rts
do_clock:
	movem.l	d0-d7/a0-a6,-(sp)       * insure all registers saved
    move.l #_mos_buf,a1             * get destination address
    move.b #0xfc,(a1)+              * put command byte
    move.b (a0)+,(a1)+              * byte 1 (YY)
    move.b (a0)+,(a1)+              * byte 2 (MM)
    move.b (a0)+,(a1)+              * byte 3 (DD)
    move.b (a0)+,(a1)+              * byte 4 (hh)
    move.b (a0)+,(a1)+              * byte 5 (mm)
    move.b (a0)+,(a1)+              * byte 6 (ss)
    jsr    _mos_int                 * go to 'c' handler
	movem.l	(sp)+,d0-d7/a0-a6       * restore saved registers
    rts
do_joyst:
	movem.l	d0-d7/a0-a6,-(sp)       * insure all registers saved
    move.l #_mos_buf,a1             * get destination address
    move.b (a0),d0                  * get the first byte 
    cmp.b  #0xfe,d0                 * is it joystick-0
    bne.s  notjoy0                  * branch if not
    move.b (a0)+,(a1)+              * move command byte
    move.b (a0)+,(a1)+              * move data byte
    bra.s  dojoyx                   * go process command
notjoy0:
    cmp.b  #0xff,d0                 * is it joystick-1
    bne.s  notjoy1                  * branch if not
    move.b (a0),(a1)+               * move command byte
    move.b 2(a0),(a1)+              * move data byte
    bra.s  dojoyx                   * go process command
notjoy1:                            * if get here must be dual joystick
    move.b #0xfd,(a1)+              * move command byte
    move.b (a0)+,(a1)+              * byte 1 (joy0 value)
    move.b (a0)+,(a1)+              * byte 2 (joy1 value)
dojoyx:
    jsr    _mos_int                 * go to 'c' handler
	movem.l	(sp)+,d0-d7/a0-a6       * restore saved registers
    rts
* ---------------------------------------------------------------------------
*	68901 spurious interrupt catcher
*   I don't know why but trap vector at 0x60 seems to get randomly called,
*   so for now we will just ignore it.
* ---------------------------------------------------------------------------
sp60int:
	rte
* ---------------------------------------------------------------------------
*	idle loop
* ---------------------------------------------------------------------------
	.globl _idloop		  * idloop()
_idloop:
	move	sr,d7
	stop	#0x2000		  * stop with priority 0, supervisor mode
	move	d7,sr
	rts
* ---------------------------------------------------------------------------
    .data
    .globl  _bootflg
__tlAsav:   .long 0
__tlEsav:	.long 0
__t01sav:   .long 0
__t02sav:   .long 0
__t13sav:   .long 0
__t14sav:   .long 0
__oldhbl:	.long 0     * not used yet
__oldvbl:	.long 0     * will be set as trap #0
__oldclk:	.long 0     * will be set as trap #3
__oldkey:   .long 0     * will be set as trap #4
savmvect:   .long 0     * pointer to logical input vectors
_bootflg:   .long 0     * 0 if read kernal from floppy, not 0 if hard disk
_key_rec:   .long 0     * address of keyboard input buffer record
_mid_rec:   .long 0     * address of midi     input buffer record
    .text
* ---------------------------------------------------------------------------
*   Idris start up code
* ---------------------------------------------------------------------------
	.globl	idris
idris:
	move    #0x2700,sr
*
*   set up the low-core trap tables
*
*   first save line-A and vdi trap-2 vectors
*   so can restore them later
*   trap-1 is gotten but not replaced since used by idris
*
    move.l	0x028,__tlAsav     	 * save the old line-A  vector
    move.l	0x02c,__tlEsav     	 * save the old line-E  vector
*
 	move.l	0x068,__oldhbl		* 68k auto-vector level 2 ($68)
 	move.l	0x070,__oldvbl		* 68k auto-vector level 4 ($70)
*
    move.l  0x080,_bootflg       * boot set this with boot device
    move.l  0x084,__t01sav       * save the old trap-1  vector
	move.l  0x088,__t02sav     	 * save the old trap-2  vector
    move.l  0x0b4,__t13sav       * save the old trap-13 vector
    move.l  0x0b8,__t14sav       * save the old trap-14 vector
*
    move.l	0x114,__oldclk		* save old 200HZ interrupt vector
    move.l	0x118,__oldkey		* save old MIDI/Keyboard int vector
*
*   do a set-rez call to insure all set up for medium res,
*   since tos thinks it is in low resolution if using color monitor.
*
	move.w  #4,-(sp)            * push 'Getrez' function number
	trap    #14                 * do the system call
	add.l   #2,sp               * clean up the stack
    cmpi.b	#2,d0               * are we in high resolution
    beq.s   ishigh              * skip following if we are
*
	move.b  0x01,defshiftmd     * set up rez flag for TOS
	move.b  0x01,sshiftmd       * set up rez flag for TOS
*
	move.w	#1,-(sp)            * set medium rez
	move.l	#0xffffffff,-(sp)   * physical location
	move.l	#0xffffffff,-(sp)   * logical  location
	move.w  #5,-(sp)            * push 'Setscreen' function number
	trap    #14                 * do the system call
	add.l   #12,sp              * clean up the stack
ishigh:
*
*   get base of input (midi/ikbd) vectors and set to local vectors
*
	move.w  #34,-(sp)           * push 'Kbdvbase' function number
	trap    #14                 * do the system call
	add.l   #2,sp               * clean up the stack
    move.l  d0,savmvect         * save for later
    move.l	d0,a0               * put in address register
    move.l  #do_stats,12(a0)    * set status   vector
    move.l  #do_mouse,16(a0)    * set mouse    vector
    move.l  #do_clock,20(a0)    * set clock    vector
    move.l  #do_joyst,24(a0)    * set joystick vector
*
*   get address of keyboard input buffer record
*
    move.w  #1,-(sp)            * push keyboard device number
	move.w  #14,-(sp)           * push 'Iorec' function number
	trap    #14                 * do the system call
	add.l   #4,sp               * clean up the stack
    move.l  d0,_key_rec         * save for later
*
*   get address of midi     input buffer record
*
    move.w  #2,-(sp)            * push midi     device number
	move.w  #14,-(sp)           * push 'Iorec' function number
	trap    #14                 * do the system call
	add.l   #4,sp               * clean up the stack
    move.l  d0,_mid_rec         * save for later
*
*   insure 68901 interrupts not enabled
*
    move.b  #0,0xfffffa07       * interrupt enable reg A cleared
    move.b  #0,0xfffffa09       * interrupt enable reg B cleared
    move.b  #0,0xfffffa13       * interrupt mask   reg A cleared
    move.b  #0,0xfffffa15       * interrupt mask   reg B cleared
*
	move.l	#__etext,a0			* move data to RAM
	move.l	#__sdata,a1			* first loc of data
	cmpa.l	a0,a1				* does data follow text ?
	beq.s	3f					* yes, not RAM/ROM system
1:
	cmpa.l	#__memory,a1		* copy to end of bss
	beq.s	2f
	move.w	(a0)+,(a1)+			* move by words
	bra.s	1b
2:
	moveq.l	#1,d7
	move.l	d7,_romsys			* set flag for ROM based system
3:
	move.l	#__stext,_sysbot	* lowest address used by Idris
#	move.l  #__memory+4096,sp	* process 0 stack (dms)
	move.l  #__memory+2048,sp	* process 0 stack
	move.l	sp,a6				* save sp
*
	move.l	__vbr,a0			* vector reg is 0 on 68000
	lea		8(a0),a1			* initialize the vector
	lea		1024(a0),a2
1:
	move.l	#sprint,(a1)+
	cmpa.l	a1,a2
	bne.s	1b
*
	lea		8(a0),a1			* patch traps
*	move.l	#__buserr,(a1)+		* catch bus errors
	move.l	#sigbus,(a1)+		* catch bus errors
	move.l	#sigseg,(a1)+		* address error
	move.l	#sigins,(a1)+		* illegal instruction
	move.l	#sigfpt,(a1)+		* zero divide
	move.l	#sigdom,(a1)+		* CHK
	move.l	#sigdom,(a1)+		* TRAPV
	move.l	#sigins,(a1)+		* privilege violation
	move.l	#sigtrc,(a1)+		* trace
*
*   restore tos trap vectors (trap-1 not done since used by idris)
*
    move.l	__tlAsav,0x28      	* patch in the old line-A  vector
    move.l	__tlEsav,0x2c      	* patch in the old line-E  vector
* -----------------------------------------------------------------------
    move.l	#sp60int,0x60  		* looking for a spurious interrupt
	move.l	__oldhbl,0x68		* 68k auto-vector level 2 ($68)
* -----------------------------------------------------------------------
*	move.l	__oldvbl,0x70		* 68k auto-vector level 4 ($70)
	move.l	 #vblint,0x70		* 68k auto-vector level 4 ($70)
*
    move.l	__oldvbl,0x80       * old vbl   interrupt is now   'trap  #0'
*   move.l  __t01sav,0x84       * old gem   call      is still 'trap  #1'
	move.l	 #sigsys,0x84		* idris system call   is now   'trap  #1'
	move.l  __t02sav,0x88      	* old gem/gsx  call   is still 'trap  #2'
    move.l	__oldclk,0x8c       * old 200HZ interrupt is now   'trap  #3'
    move.l	__oldkey,0x90       * old ikbd  interrupt is now   'trap  #4'
	move.l   #clkcup,0x94       * clock catchup entry is now   'trap  #5'
    move.l  __t13sav,0xb4       * old bios     call   is still 'trap #13'
    move.l  __t14sav,0xb8       * old xbios    call   is still 'trap #14'
*
* 68901 interrupts, not needed to set unused to 'sprint' but makes
* better table! 68901 interrupts at IPL-6!
* top of table is lowest priority, bottom is highest priority
*
    move.l	#lprint,256(a0)		* ($100) (-active-) I0 Parallel port interrupt
    move.l	#sprint,260(a0)		* ($104) (disabled) I1 RS232 Carrier Detect
    move.l	#csrint,264(a0)		* ($108) (-active-) I2 RS232 Clear-To-Send
    move.l	#sprint,268(a0)		* ($10c) (disabled) I3 graphics blt done
    move.l	#sprint,272(a0)		* ($110) (disabled) Timer D RS232 Baud-Rate
    move.l	#clkint,276(a0)		* ($114) (-active-) Timer C 200hz System clock
    move.l	#kbmint,280(a0)		* ($118) (-active-) I4 Keyboard/MIDI [6850]
    move.l	#hdkint,284(a0)		* ($11c) (-active-) I5 Polled FDC/HDC
    move.l	#sprint,288(a0)		* ($120) (disabled) Timer B Horz Blank counter
    move.l	#sprint,292(a0)		* ($124) (disabled) RS232 transmit error
    move.l	#osrint,296(a0)		* ($128) (-active-) RS232 transmit buffer empty
    move.l	#sprint,300(a0)		* ($12c) (disabled) RS232 receive error
    move.l	#isrint,304(a0)		* ($130) (-active-) RS232 receive  buffer full
    move.l	#sprint,308(a0)		* ($134) (disabled) Timer A (not used)
    move.l	#sprint,312(a0)		* ($138) (disabled) I6 RS232 ring indicator
    move.l	#sprint,316(a0)		* ($13c) (disabled) I7 Polled monitor type
*
* find base of screen memory, this will be max memory address to allow
* since screen will be already placed in top 32k.
*
    clr.l   d1                  * start with cleared
    move.b	0xffff8201,d1       * get display base address (high)
    asl.l	#8,d1               * roll 8 bits
    move.b	0xffff8203,d1       * get display base address (low )
    asl.l	#8,d1               * roll 8 bits so have high 24 bits

	clr.l   d0					* clear mem, find total memory size
	move.l  #mem1,erraddr
	move.l  #__memory,a1
	move.l  #__memory,a0
1:
	move.l  a0,d7               * (dms)
    cmp.l   d1,d7         		* (dms) stop at base of screen memory
    beq.s	mem1				* (dms) if there then exit loop
*
	move.w  d0,(a1)+
	move.l  a1,a0
	bra.s   1b
mem1:
	clr.l   erraddr             * trapped at bad address
	move.l  a0,d0
	move.l  a0,_memtop          * first unuseable address

	jsr		_main				* allocate memory
*
*   setup 6850 serial chips (midi and keyboard)
*
    move.b  #0x96,0xfffffc00    * keyboard-div64,8bits,1stop,txoff,rxon
*   move.b  #0x16,0xfffffc04    * midiport-div64,8bits,1stop,txoff,rxoff
    move.b  #0x95,0xfffffc04    * midiport-div16,8bits,1stop,txoff,rxon
*
*   ----------------------- (enable 68901 interrupts) ------------------------
*   turn on RS232    input interrupts             (0x10 to iera, 0x10 to imra)
*   turn on cartridge port interrupts (if needed) (0x40 to iera, 0x40 to imra)
*   just set mask for RS232    output, enable off (0x00 to iera, 0x04 to imra)
*   --------------------------------------------------------------------------
*   just set mask for parallel output, enable off (0x00 to ierb, 0x01 to imrb)
*   just set mask for RS232 cts input, enable off (0x00 to ierb, 0x04 to imrb)
*   turn on Timer-C  clock interrupts             (0x20 to ierb, 0x20 to imrb)
*   turn on keyboard input interrupts             (0x40 to ierb, 0x40 to imrb)
*   just set mask for disk done intrs, enable off (0x00 to ierb, 0x80 to imrb)
*
	move.b	#0x00,0xfffffa05    * clear data direction register, all inputs
    move.b  #0x00,0xfffffa03    * catch all interrupts on falling edge
*
    move.b  #0x40,0xfffffa17    * interrupt vector number, auto cycle end
*
    move.b  #0x10,0xfffffa07    * interrupt enable reg A as needed
    move.b  #0x60,0xfffffa09    * interrupt enable reg B as needed
    move.b  #0x14,0xfffffa13    * interrupt mask   reg A as needed
    move.b  #0xe5,0xfffffa15    * interrupt mask   reg B as needed
*
*   start processes 0 and 1
*
	move.l	_u0stack,sp			* allocated stack for process 0
	jsr     _init
*
* 	process 0 (swap)
*
	jsr     _swapp              * should never return
1:
	stop    #0x2000
	bra.s   1b
*
*   PROCESS ONE
*
	.globl	_p1boot, _p1end
_p1boot:
*	move.l  #initlist,-(sp)		* arg vector
	bsr.s	1f
initlist = .-_p1boot
	.long initp, 0				* pointers to arg strings
1:
	move.l	(sp),d0				* relocate arg vector
	move.l	d0,a0
	sub.l	#initlist,d0		* d0 has real p1boot addr
1:
	tst.l	(a0)				* NULL pointer ends the list
	beq.s	1f
	add.l	d0,(a0)+			* add execution bias
	bra.s	1b
1:
*	move.l  #initname,-(sp)		* file to exec
	bsr.s	1f
initname = .-_p1boot
	"/odd/init\0"
	.even
1:
	moveq.l	#11,d7				* exec("/odd/init", "init")
	trap    #1
	move.l  d7,-(sp)
	moveq.l	#1,d7				* exit(-err)
	trap	#1
initp = .-_p1boot				* arg 0
	"init\0"
	.even
_p1end:

*	routine called at end of sync() for each block device.
	.text
	.globl	_dosync
_dosync:				* VOID dosync(dev)
	rts
*
.data
*
*	interrupt entry routines, established by vector() in main.c
*
*	.globl  __ivec
* __ivec:
*	move.l  d0,-(sp)
*	move.l	#0,d0				* devcode
*	jsr     trapinit
*	.long   0					* pfunc
*
*	move.l  d0,-(sp)
*	move.l	#0,d0				* devcode
*	jsr     trapinit
*	.long   0					* pfunc
*
*	move.l  d0,-(sp)
*	move.l	#0,d0				* devcode
*	jsr     trapinit
*	.long   0					* pfunc
*
*	move.l  d0,-(sp)
*	move.l	#0,d0				* devcode
*	jsr     trapinit
*	.long   0					* pfunc
*
*	move.l  d0,-(sp)
*	move.l	#0,d0				* devcode
*	jsr     trapinit
*	.long   0					* pfunc
*
*	.globl	__endvec
* __endvec:

