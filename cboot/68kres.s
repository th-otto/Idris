; a_magic   = 0x9928
; a_text    = 0x000016ee
; a_data    = 0x000005a0
; a_bss     = 0x00000000
; a_syms    = 0x00000e7b
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x000016ee
; a_relocs  = 0x000003c1@0x00002b25


sigbus:
[00000000] 4ab9 0000 0000            tst.l      __cpu
[00000006] 6602                      bne.s      sigbus_1
[00000008] 508f                      addq.l     #8,a7
sigbus_1:
[0000000a] 4ab9 0000 16ee            tst.l      erraddr
[00000010] 6708                      beq.s      sigbus_2
[00000012] 2f39 0000 16ee            move.l     erraddr,-(a7)
[00000018] 4e75                      rts
sigbus_2:
[0000001a] 2f00                      move.l     d0,-(a7)
[0000001c] 202f 0006                 move.l     6(a7),d0
[00000020] 0c80 0000 0482            cmpi.l     #_iniword,d0
[00000026] 650e                      bcs.s      sigbus_3
[00000028] 0c80 0000 0612            cmpi.l     #_stkchk,d0
[0000002e] 6406                      bcc.s      sigbus_3
[00000030] 2e4a                      movea.l    a2,a7
[00000032] 7eff                      moveq.l    #-1,d7
[00000034] 4e75                      rts
sigbus_3:
[00000036] 70f6                      moveq.l    #-10,d0
[00000038] 604a                      bra.s      sigbus_4
sigbus_4: ; not found: 00000084

sigemt:
[0000003a] 2f00                      move.l     d0,-(a7)
[0000003c] 70f9                      moveq.l    #-7,d0
[0000003e] 6044                      bra.s      sigemt_1
sigemt_1: ; not found: 00000084

sigfpe:
[00000040] 2f00                      move.l     d0,-(a7)
[00000042] 70f8                      moveq.l    #-8,d0
[00000044] 603e                      bra.s      sigfpe_1
sigfpe_1: ; not found: 00000084

sigins:
[00000046] 2f00                      move.l     d0,-(a7)
[00000048] 70fc                      moveq.l    #-4,d0
[0000004a] 4eb9 0000 009c            jsr        trapinit
[00000050] 0000 0106                 ori.b      #$06,d0

sigiot:
[00000054] 2f00                      move.l     d0,-(a7)
[00000056] 70fa                      moveq.l    #-6,d0
[00000058] 602a                      bra.s      sigiot_1
sigiot_1: ; not found: 00000084

sigtrap:
[0000005a] 2f00                      move.l     d0,-(a7)
[0000005c] 70fb                      moveq.l    #-5,d0
[0000005e] 6024                      bra.s      sigtrap_1
sigtrap_1: ; not found: 00000084

sigsegv:
[00000060] 4ab9 0000 0000            tst.l      __cpu
[00000066] 6602                      bne.s      sigsegv_1
[00000068] 508f                      addq.l     #8,a7
sigsegv_1:
[0000006a] 4ab9 0000 16ee            tst.l      erraddr
[00000070] 6708                      beq.s      sigsegv_2
[00000072] 2f39 0000 16ee            move.l     erraddr,-(a7)
[00000078] 4e75                      rts
sigsegv_2:
[0000007a] 2f00                      move.l     d0,-(a7)
[0000007c] 70f5                      moveq.l    #-11,d0
[0000007e] 6004                      bra.s      sigsegv_3
sigsegv_3: ; not found: 00000084

sigsys:
[00000080] 2f00                      move.l     d0,-(a7)
[00000082] 2007                      move.l     d7,d0
[00000084] 4eb9 0000 009c            jsr        trapinit
[0000008a] 0000 15a2                 ori.b      #$A2,d0

sprint:
[0000008e] 2f00                      move.l     d0,-(a7)
[00000090] 70f0                      moveq.l    #-16,d0
[00000092] 4eb9 0000 009c            jsr        trapinit
[00000098] 0000 1588                 ori.b      #$88,d0

trapinit:
[0000009c] 48e7 e3e0                 movem.l    d0-d2/d6-d7/a0-a2,-(a7)
[000000a0] 206f 0020                 movea.l    32(a7),a0
[000000a4] 4e69                      move.l     usp,a1
[000000a6] 2f49 0020                 move.l     a1,32(a7)
[000000aa] 2050                      movea.l    (a0),a0
[000000ac] 4e90                      jsr        (a0)
[000000ae] 082f 0005 0028            btst       #5,40(a7)
[000000b4] 670a                      beq.s      trapinit_1
trapinit_4:
[000000b6] 4cdf 07c7                 movem.l    (a7)+,d0-d2/d6-d7/a0-a2
[000000ba] 201f                      move.l     (a7)+,d0
[000000bc] 201f                      move.l     (a7)+,d0
[000000be] 4e73                      rte
trapinit_1:
[000000c0] 4a39 0000 0000            tst.b      _onflag
[000000c6] 6706                      beq.s      trapinit_2
[000000c8] 4eb9 0000 0000            jsr        _dounits
trapinit_2:
[000000ce] 2079 0000 0000            movea.l    _psignal,a0
[000000d4] 4a10                      tst.b      (a0)
[000000d6] 671e                      beq.s      trapinit_3
[000000d8] 2479 0000 18d6            movea.l    _pu,a2
[000000de] d5f9 0000 1a30            adda.l     _usersz,a2
[000000e4] 48ea 7ff8 0010            movem.l    d3-d7/a0-a6,16(a2)
[000000ea] 4e69                      move.l     usp,a1
[000000ec] 2549 0040                 move.l     a1,64(a2)
[000000f0] 4eb9 0000 0000            jsr        _prsig
trapinit_3:
[000000f6] 4ab9 0000 0000            tst.l      _hiproc
[000000fc] 67b8                      beq.s      trapinit_4
[000000fe] 4eb9 0000 0000            jsr        _switchp
[00000104] 60ba                      bra.s      trapinit_1

[00000106] 41ef 002c                 lea.l      44(a7),a0
[0000010a] 2f28 0002                 move.l     2(a0),-(a7)
[0000010e] 4eb9 0000 0482            jsr        _iniword
[00000114] 588f                      addq.l     #4,a7
[00000116] 0c47 4e73                 cmpi.w     #$4E73,d7
[0000011a] 662c                      bne.s      trapinit_5
[0000011c] 4e69                      move.l     usp,a1
[0000011e] d3f9 0000 1a24            adda.l     _uiobase,a1
[00000124] 4eb9 0000 01a6            jsr        $000001A6
[0000012a] 48e7 8040                 movem.l    d0/a1,-(a7)
[0000012e] 4e69                      move.l     usp,a1
[00000130] 2f09                      move.l     a1,-(a7)
[00000132] 4eb9 0000 0f6c            jsr        _chkbuf
[00000138] 588f                      addq.l     #4,a7
[0000013a] 4cdf 0201                 movem.l    (a7)+,d0/a1
[0000013e] 4a87                      tst.l      d7
[00000140] 6706                      beq.s      trapinit_5
[00000142] 0811 0005                 btst       #5,(a1)
[00000146] 6706                      beq.s      trapinit_6
trapinit_5:
[00000148] 4ef9 0000 15a2            jmp        _trap
trapinit_6:
[0000014e] 41ef 002c                 lea.l      44(a7),a0
[00000152] 4eb9 0000 016c            jsr        $0000016C
[00000158] e280                      asr.l      #1,d0
[0000015a] 5380                      subq.l     #1,d0
trapinit_7:
[0000015c] 30d9                      move.w     (a1)+,(a0)+
[0000015e] 51c8 fffc                 dbf        d0,trapinit_7
[00000162] 93f9 0000 1a24            suba.l     _uiobase,a1
[00000168] 4e61                      move.l     a1,usp
[0000016a] 4e75                      rts

x16c:
[0000016c] 48e7 c060                 movem.l    d0-d1/a1-a2,-(a7)
[00000170] 2200                      move.l     d0,d1
[00000172] 2248                      movea.l    a0,a1
[00000174] 4eb9 0000 01a6            jsr        $000001A6
[0000017a] 9081                      sub.l      d1,d0
[0000017c] 6722                      beq.s      x16c_1
[0000017e] 6f0e                      ble.s      x16c_2
[00000180] 224f                      movea.l    a7,a1
[00000182] 9fc0                      suba.l     d0,a7
[00000184] 244f                      movea.l    a7,a2
x16c_4:
[00000186] b3c8                      cmpa.l     a0,a1
[00000188] 6414                      bcc.s      x16c_3
[0000018a] 34d9                      move.w     (a1)+,(a2)+
[0000018c] 60f8                      bra.s      x16c_4
x16c_2:
[0000018e] 2248                      movea.l    a0,a1
[00000190] 2448                      movea.l    a0,a2
[00000192] 95c0                      suba.l     d0,a2
x16c_6:
[00000194] bfc9                      cmpa.l     a1,a7
[00000196] 6404                      bcc.s      x16c_5
[00000198] 3521                      move.w     -(a1),-(a2)
[0000019a] 60f8                      bra.s      x16c_6
x16c_5:
[0000019c] 2e4a                      movea.l    a2,a7
x16c_3:
[0000019e] d1c0                      adda.l     d0,a0
x16c_1:
[000001a0] 4cdf 0603                 movem.l    (a7)+,d0-d1/a1-a2
[000001a4] 4e75                      rts

x1a6:
[000001a6] 4ab9 0000 0000            tst.l      __cpu
[000001ac] 6604                      bne.s      x1a6_1
[000001ae] 7006                      moveq.l    #6,d0
[000001b0] 4e75                      rts
x1a6_1:
[000001b2] 2f09                      move.l     a1,-(a7)
[000001b4] 3029 0006                 move.w     6(a1),d0
[000001b8] 0280 0000 f000            andi.l     #$0000F000,d0
[000001be] e088                      lsr.l      #8,d0
[000001c0] e488                      lsr.l      #2,d0
[000001c2] 2240                      movea.l    d0,a1
[000001c4] d3fc 0000 0000            adda.l     #_ex20sz,a1
[000001ca] 2011                      move.l     (a1),d0
[000001cc] 225f                      movea.l    (a7)+,a1
[000001ce] 4e75                      rts

_onentry:
[000001d0] 2e2f 0008                 move.l     8(a7),d7
[000001d4] 242f 000c                 move.l     12(a7),d2
[000001d8] 222f 0010                 move.l     16(a7),d1
[000001dc] 2c2f 0014                 move.l     20(a7),d6
[000001e0] 2e6f 0004                 movea.l    4(a7),a7
[000001e4] 4e6a                      move.l     usp,a2
[000001e6] d5f9 0000 1a24            adda.l     _uiobase,a2
[000001ec] b5c6                      cmpa.l     d6,a2
[000001ee] 633e                      bls.s      _onentry_1
[000001f0] 4a81                      tst.l      d1
[000001f2] 673a                      beq.s      _onentry_1
[000001f4] 4eba ffb0                 jsr        $000001A6(pc)
[000001f8] dc80                      add.l      d0,d6
[000001fa] b5c6                      cmpa.l     d6,a2
[000001fc] 6300 0030                 bls.w      _onentry_1
[00000200] 43ef 0028                 lea.l      40(a7),a1
[00000204] 2049                      movea.l    a1,a0
[00000206] d3c0                      adda.l     d0,a1
[00000208] e280                      asr.l      #1,d0
[0000020a] 5380                      subq.l     #1,d0
_onentry_2:
[0000020c] 3521                      move.w     -(a1),-(a2)
[0000020e] 51c8 fffc                 dbf        d0,_onentry_2
[00000212] 2502                      move.l     d2,-(a2)
[00000214] 2507                      move.l     d7,-(a2)
[00000216] 2e01                      move.l     d1,d7
[00000218] 4ab9 0000 0000            tst.l      __cpu
[0000021e] 671a                      beq.s      _onentry_3
[00000220] 7008                      moveq.l    #8,d0
[00000222] 4eba ff48                 jsr        $0000016C(pc)
[00000226] 3f7c 0080 002e            move.w     #$0080,46(a7)
[0000022c] 600c                      bra.s      _onentry_3
_onentry_1:
[0000022e] 352f 002e                 move.w     46(a7),-(a2)
[00000232] 252f 002a                 move.l     42(a7),-(a2)
[00000236] 352f 0028                 move.w     40(a7),-(a2)
_onentry_3:
[0000023a] 95f9 0000 1a24            suba.l     _uiobase,a2
[00000240] 4e62                      move.l     a2,usp
[00000242] 2f47 002a                 move.l     d7,42(a7)
[00000246] 426f 0028                 clr.w      40(a7)
[0000024a] 2079 0000 18d6            movea.l    _pu,a0
[00000250] d1f9 0000 1a30            adda.l     _usersz,a0
[00000256] 4ce8 7ff8 0010            movem.l    16(a0),d3-d7/a0-a6
[0000025c] 4efa fe62                 jmp        $000000C0(pc)

_ufork:
[00000260] 4eb9 0000 0626            jsr        __cenb
[00000266] 202f 0004                 move.l     4(a7),d0
[0000026a] 2217                      move.l     (a7),d1
[0000026c] 2c0e                      move.l     a6,d6
[0000026e] 9c8f                      sub.l      a7,d6
[00000270] 2f0e                      move.l     a6,-(a7)
[00000272] 4e68                      move.l     usp,a0
[00000274] 2f08                      move.l     a0,-(a7)
[00000276] 2079 0000 18d6            movea.l    _pu,a0
[0000027c] 208f                      move.l     a7,(a0)
[0000027e] 2e79 0000 1766            movea.l    _u0,a7
[00000284] 48e7 c280                 movem.l    d0-d1/d6/a0,-(a7)
[00000288] 4eb9 0000 0382            jsr        _uout
[0000028e] 4eb9 0000 0e14            jsr        _ucopy
[00000294] 4eb9 0000 0b66            jsr        _mappu
[0000029a] 4cdf 0143                 movem.l    (a7)+,d0-d1/d6/a0
[0000029e] 2e47                      movea.l    d7,a7
[000002a0] 23c7 0000 16f2            move.l     d7,__pux
[000002a6] 33c0 0000 1a1e            move.w     d0,_curbase
[000002ac] 2c47                      movea.l    d7,a6
[000002ae] 2e39 0000 038a            move.l     _jmpbufsz,d7
[000002b4] 9fc7                      suba.l     d7,a7
[000002b6] 2d4f 0004                 move.l     a7,4(a6)
[000002ba] 9fc7                      suba.l     d7,a7
[000002bc] 2d4f 0008                 move.l     a7,8(a6)
[000002c0] 9fc7                      suba.l     d7,a7
[000002c2] 2d4f 000c                 move.l     a7,12(a6)
[000002c6] 9fc6                      suba.l     d6,a7
[000002c8] dc8f                      add.l      a7,d6
[000002ca] 2c46                      movea.l    d6,a6
[000002cc] 2041                      movea.l    d1,a0
[000002ce] 2e39 0000 18d6            move.l     _pu,d7
[000002d4] 4ed0                      jmp        (a0)

_uinit:
[000002d6] 4eb9 0000 0000            jsr        _mapclr
[000002dc] 2c0e                      move.l     a6,d6
[000002de] 9c8f                      sub.l      a7,d6
[000002e0] e486                      asr.l      #2,d6
[000002e2] 205f                      movea.l    (a7)+,a0
[000002e4] 201f                      move.l     (a7)+,d0
[000002e6] 225f                      movea.l    (a7)+,a1
[000002e8] 2457                      movea.l    (a7),a2
[000002ea] 2e79 0000 1766            movea.l    _u0,a7
[000002f0] 48e7 82e0                 movem.l    d0/d6/a0-a2,-(a7)
[000002f4] 4eb9 0000 0e14            jsr        _ucopy
[000002fa] 4eb9 0000 0b66            jsr        _mappu
[00000300] 4cdf 0741                 movem.l    (a7)+,d0/d6/a0-a2
[00000304] 2e47                      movea.l    d7,a7
[00000306] 23c7 0000 16f2            move.l     d7,__pux
[0000030c] 33c0 0000 1a1e            move.w     d0,_curbase
[00000312] 2c47                      movea.l    d7,a6
[00000314] 2e39 0000 038a            move.l     _jmpbufsz,d7
[0000031a] 9fc7                      suba.l     d7,a7
[0000031c] 2d4f 0004                 move.l     a7,4(a6)
[00000320] 9fc7                      suba.l     d7,a7
[00000322] 2d4f 0008                 move.l     a7,8(a6)
[00000326] 9fc7                      suba.l     d7,a7
[00000328] 2d4f 000c                 move.l     a7,12(a6)
[0000032c] 4267                      clr.w      -(a7)
[0000032e] 2f0a                      move.l     a2,-(a7)
[00000330] 4267                      clr.w      -(a7)
[00000332] 42a7                      clr.l      -(a7)
[00000334] 2f09                      move.l     a1,-(a7)
[00000336] 4e61                      move.l     a1,usp
[00000338] 7207                      moveq.l    #7,d1
_uinit_1:
[0000033a] 42a7                      clr.l      -(a7)
[0000033c] 51c9 fffc                 dbf        d1,_uinit_1
[00000340] 2f3c 0000 024a            move.l     #$0000024A,-(a7)
[00000346] 42a7                      clr.l      -(a7)
[00000348] 2c4f                      movea.l    a7,a6
[0000034a] 5386                      subq.l     #1,d6
_uinit_2:
[0000034c] 42a7                      clr.l      -(a7)
[0000034e] 51ce fffc                 dbf        d6,_uinit_2
[00000352] 2e88                      move.l     a0,(a7)
[00000354] 720f                      moveq.l    #15,d1
[00000356] 2079 0000 18d6            movea.l    _pu,a0
[0000035c] d1f9 0000 1a30            adda.l     _usersz,a0
[00000362] d1fc 0000 0010            adda.l     #$00000010,a0
_uinit_3:
[00000368] 4298                      clr.l      (a0)+
[0000036a] 51c9 fffc                 dbf        d1,_uinit_3
[0000036e] 4eb9 0000 0e68            jsr        __fppi
[00000374] 4eb9 0000 0c18            jsr        _setumap
[0000037a] 2e39 0000 18d6            move.l     _pu,d7
[00000380] 4e75                      rts

_uout:
[00000382] 4eb9 0000 0ec0            jsr        __fppsv
[00000388] 4e75                      rts

_jmpbufsz:
[0000038a] 0000 0024                 ori.b      #$24,d0

_longjmp:
[0000038e] 206f 0004                 movea.l    4(a7),a0
[00000392] 4cd0 fa38                 movem.l    (a0),d3-d5/a1/a3-a7
[00000396] 2e89                      move.l     a1,(a7)
[00000398] 7e01                      moveq.l    #1,d7
[0000039a] 4e75                      rts

_setjmp:
[0000039c] 206f 0004                 movea.l    4(a7),a0
[000003a0] 2257                      movea.l    (a7),a1
[000003a2] 48d0 fa38                 movem.l    d3-d5/a1/a3-a7,(a0)
[000003a6] 4287                      clr.l      d7
[000003a8] 4e75                      rts

_setpu1:
[000003aa] 202f 0004                 move.l     4(a7),d0
[000003ae] 4e5e                      unlk       a6
[000003b0] 2217                      move.l     (a7),d1
[000003b2] 2f0e                      move.l     a6,-(a7)
[000003b4] 4e6e                      move.l     usp,a6
[000003b6] 2f0e                      move.l     a6,-(a7)
[000003b8] 2079 0000 18d6            movea.l    _pu,a0
[000003be] 208f                      move.l     a7,(a0)
[000003c0] 43f9 0000 1766            lea.l      _u0,a1
[000003c6] 4a80                      tst.l      d0
[000003c8] 6712                      beq.s      _setpu1_1
[000003ca] 4287                      clr.l      d7
[000003cc] 3e39 0000 1a1e            move.w     _curbase,d7
[000003d2] b087                      cmp.l      d7,d0
[000003d4] 6618                      bne.s      _setpu1_2
[000003d6] 2279 0000 16f2            movea.l    __pux,a1
_setpu1_1:
[000003dc] 23c9 0000 18d6            move.l     a1,_pu
[000003e2] 2e51                      movea.l    (a1),a7
[000003e4] 2c5f                      movea.l    (a7)+,a6
[000003e6] 4e66                      move.l     a6,usp
[000003e8] 2c5f                      movea.l    (a7)+,a6
[000003ea] 2e81                      move.l     d1,(a7)
[000003ec] 4e75                      rts
_setpu1_2:
[000003ee] 2e51                      movea.l    (a1),a7
[000003f0] 48e7 c000                 movem.l    d0-d1,-(a7)
[000003f4] 4eba ff8c                 jsr        _uout(pc)
[000003f8] 4eb9 0000 0b66            jsr        _mappu
[000003fe] 4cdf 0003                 movem.l    (a7)+,d0-d1
[00000402] 33c0 0000 1a1e            move.w     d0,_curbase
[00000408] 2247                      movea.l    d7,a1
[0000040a] 23c9 0000 16f2            move.l     a1,__pux
[00000410] 2e51                      movea.l    (a1),a7
[00000412] 2c5f                      movea.l    (a7)+,a6
[00000414] 4e66                      move.l     a6,usp
[00000416] 2c5f                      movea.l    (a7)+,a6
[00000418] 2e81                      move.l     d1,(a7)
[0000041a] 4eb9 0000 0e84            jsr        __fppld
[00000420] 4ef9 0000 0c18            jmp        _setumap

_spl:
[00000426] 2c2f 0004                 move.l     4(a7),d6
[0000042a] 6006                      bra.s      _spl_1
_spl_1: ; not found: 00000432

_spl7:
[0000042c] 3c39 0000 0000            move.w     _hips,d6
[00000432] 4287                      clr.l      d7
[00000434] 40c7                      move.w     sr,d7
[00000436] 46c6                      move.w     d6,sr
[00000438] 4e75                      rts

_spl6_1:
_spl6:
[0000043a] 3c3c 2600                 move.w     #$2600,d6
[0000043e] 60f2                      bra.s      _spl6_1

_spl5_1:
_spl5:
[00000440] 3c3c 2500                 move.w     #$2500,d6
[00000444] 60ec                      bra.s      _spl5_1

_spl4_1:
_spl4:
[00000446] 3c3c 2400                 move.w     #$2400,d6
[0000044a] 60e6                      bra.s      _spl4_1

_spl3_1:
_spl3:
[0000044c] 3c3c 2300                 move.w     #$2300,d6
[00000450] 60e0                      bra.s      _spl3_1

_spl2_1:
_spl2:
[00000452] 3c3c 2200                 move.w     #$2200,d6
[00000456] 60da                      bra.s      _spl2_1

_spl1_1:
_spl1:
[00000458] 3c3c 2100                 move.w     #$2100,d6
[0000045c] 60d4                      bra.s      _spl1_1

_permit_1:
_permit:
[0000045e] 3c39 0000 0000            move.w     _lops,d6
[00000464] 60cc                      bra.s      _permit_1

_bflip:
[00000466] 206f 0004                 movea.l    4(a7),a0
[0000046a] 2e2f 0008                 move.l     8(a7),d7
[0000046e] 5387                      subq.l     #1,d7
[00000470] 7c08                      moveq.l    #8,d6
_bflip_1:
[00000472] 3010                      move.w     (a0),d0
[00000474] ec78                      ror.w      d6,d0
[00000476] 30c0                      move.w     d0,(a0)+
[00000478] 51cf fff8                 dbf        d7,_bflip_1
[0000047c] 2e2f 0004                 move.l     4(a7),d7
[00000480] 4e75                      rts

_iniword:
[00000482] 2f3c 0000 0002            move.l     #$00000002,-(a7)
[00000488] 2f2f 0008                 move.l     8(a7),-(a7)
[0000048c] 4eb9 0000 0f6c            jsr        _chkbuf
[00000492] 508f                      addq.l     #8,a7
[00000494] 4a87                      tst.l      d7
[00000496] 6604                      bne.s      _iniword_1
[00000498] 7eff                      moveq.l    #-1,d7
[0000049a] 4e75                      rts
_iniword_1:
[0000049c] 244f                      movea.l    a7,a2
[0000049e] 206f 0004                 movea.l    4(a7),a0
[000004a2] d1f9 0000 1a28            adda.l     _utxtbase,a0
[000004a8] 3e10                      move.w     (a0),d7
[000004aa] 4e75                      rts

_addlum:
[000004ac] 244f                      movea.l    a7,a2
[000004ae] 206f 0004                 movea.l    4(a7),a0
[000004b2] d1f9 0000 1a24            adda.l     _uiobase,a0
[000004b8] 2e2f 0008                 move.l     8(a7),d7
[000004bc] df90                      add.l      d7,(a0)
[000004be] 4e75                      rts

_addsum:
[000004c0] 244f                      movea.l    a7,a2
[000004c2] 206f 0004                 movea.l    4(a7),a0
[000004c6] d1f9 0000 1a24            adda.l     _uiobase,a0
[000004cc] 2e2f 0008                 move.l     8(a7),d7
[000004d0] df50                      add.w      d7,(a0)
[000004d2] 4e75                      rts

_gsbyte:
[000004d4] 244f                      movea.l    a7,a2
[000004d6] 206f 0004                 movea.l    4(a7),a0
[000004da] 4287                      clr.l      d7
[000004dc] 1e10                      move.b     (a0),d7
[000004de] 4e75                      rts

_inbyte:
[000004e0] 2f2f 0004                 move.l     4(a7),-(a7)
[000004e4] 4eb9 0000 0000            jsr        _mapbuf
[000004ea] 2047                      movea.l    d7,a0
[000004ec] 4a9f                      tst.l      (a7)+
[000004ee] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000004f4] 6602                      bne.s      _inbyte_1
[000004f6] 4e75                      rts
_inbyte_1:
[000004f8] 244f                      movea.l    a7,a2
[000004fa] 4287                      clr.l      d7
[000004fc] 1e10                      move.b     (a0),d7
[000004fe] 4e75                      rts

_inword:
[00000500] 2f2f 0004                 move.l     4(a7),-(a7)
[00000504] 4eb9 0000 0000            jsr        _mapbuf
[0000050a] 2047                      movea.l    d7,a0
[0000050c] 4a9f                      tst.l      (a7)+
[0000050e] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000514] 6602                      bne.s      _inword_1
[00000516] 4e75                      rts
_inword_1:
[00000518] 244f                      movea.l    a7,a2
[0000051a] 2e10                      move.l     (a0),d7
[0000051c] 4e75                      rts

_outbyte:
[0000051e] 2f2f 0004                 move.l     4(a7),-(a7)
[00000522] 4eb9 0000 0000            jsr        _mapbuf
[00000528] 2047                      movea.l    d7,a0
[0000052a] 4a9f                      tst.l      (a7)+
[0000052c] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000532] 6602                      bne.s      _outbyte_1
[00000534] 4e75                      rts
_outbyte_1:
[00000536] 244f                      movea.l    a7,a2
[00000538] 10af 000b                 move.b     11(a7),(a0)
[0000053c] 4287                      clr.l      d7
[0000053e] 4e75                      rts

_outword:
[00000540] 2f2f 0004                 move.l     4(a7),-(a7)
[00000544] 4eb9 0000 0000            jsr        _mapbuf
[0000054a] 2047                      movea.l    d7,a0
[0000054c] 4a9f                      tst.l      (a7)+
[0000054e] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000554] 6602                      bne.s      _outword_1
[00000556] 4e75                      rts
_outword_1:
[00000558] 244f                      movea.l    a7,a2
[0000055a] 20af 0008                 move.l     8(a7),(a0)
[0000055e] 4287                      clr.l      d7
[00000560] 4e75                      rts

_ssbyte:
[00000562] 244f                      movea.l    a7,a2
[00000564] 206f 0004                 movea.l    4(a7),a0
[00000568] 10af 000b                 move.b     11(a7),(a0)
[0000056c] 4287                      clr.l      d7
[0000056e] 4e75                      rts

_outbuf:
[00000570] 2f2f 000c                 move.l     12(a7),-(a7)
[00000574] 2f2f 000c                 move.l     12(a7),-(a7)
[00000578] 4eb9 0000 0f6c            jsr        _chkbuf
[0000057e] 508f                      addq.l     #8,a7
[00000580] 4a87                      tst.l      d7
[00000582] 6604                      bne.s      _outbuf_1
[00000584] 7eff                      moveq.l    #-1,d7
[00000586] 4e75                      rts
_outbuf_1:
[00000588] 2f2f 0008                 move.l     8(a7),-(a7)
[0000058c] 4eb9 0000 0000            jsr        _mapbuf
[00000592] 4a9f                      tst.l      (a7)+
[00000594] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[0000059a] 6602                      bne.s      _outbuf_2
[0000059c] 4e75                      rts
_outbuf_2:
[0000059e] 2f47 0008                 move.l     d7,8(a7)
[000005a2] 601a                      bra.s      __movmem

_inbuf:
[000005a4] 2f2f 0004                 move.l     4(a7),-(a7)
[000005a8] 4eb9 0000 0000            jsr        _mapbuf
[000005ae] 4a9f                      tst.l      (a7)+
[000005b0] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000005b6] 6602                      bne.s      _inbuf_1
[000005b8] 4e75                      rts
_inbuf_1:
[000005ba] 2f47 0004                 move.l     d7,4(a7)

__movmem:
[000005be] 244f                      movea.l    a7,a2
[000005c0] 226f 0004                 movea.l    4(a7),a1
[000005c4] 206f 0008                 movea.l    8(a7),a0
[000005c8] 202f 000c                 move.l     12(a7),d0
[000005cc] 4a80                      tst.l      d0
[000005ce] 673e                      beq.s      __movmem_1
[000005d0] 3208                      move.w     a0,d1
[000005d2] 3409                      move.w     a1,d2
[000005d4] b541                      eor.w      d2,d1
[000005d6] 0801 0000                 btst       #0,d1
[000005da] 670a                      beq.s      __movmem_2
[000005dc] 5380                      subq.l     #1,d0
__movmem_3:
[000005de] 10d9                      move.b     (a1)+,(a0)+
[000005e0] 51c8 fffc                 dbf        d0,__movmem_3
[000005e4] 6028                      bra.s      __movmem_1
__movmem_2:
[000005e6] 3208                      move.w     a0,d1
[000005e8] 0801 0000                 btst       #0,d1
[000005ec] 6704                      beq.s      __movmem_4
[000005ee] 10d9                      move.b     (a1)+,(a0)+
[000005f0] 5380                      subq.l     #1,d0
__movmem_4:
[000005f2] 2200                      move.l     d0,d1
[000005f4] e281                      asr.l      #1,d1
__movmem_6:
[000005f6] 5581                      subq.l     #2,d1
[000005f8] 6d04                      blt.s      __movmem_5
[000005fa] 20d9                      move.l     (a1)+,(a0)+
[000005fc] 60f8                      bra.s      __movmem_6
__movmem_5:
[000005fe] 0801 0000                 btst       #0,d1
[00000602] 6702                      beq.s      __movmem_7
[00000604] 30d9                      move.w     (a1)+,(a0)+
__movmem_7:
[00000606] 0800 0000                 btst       #0,d0
[0000060a] 6702                      beq.s      __movmem_1
[0000060c] 10d9                      move.b     (a1)+,(a0)+
__movmem_1:
[0000060e] 4287                      clr.l      d7
[00000610] 4e75                      rts

_stkchk:
[00000612] 4287                      clr.l      d7
[00000614] 202f 0008                 move.l     8(a7),d0
[00000618] d0af 0004                 add.l      4(a7),d0
[0000061c] 4e68                      move.l     usp,a0
[0000061e] b1c0                      cmpa.l     d0,a0
[00000620] 6202                      bhi.s      _stkchk_1
[00000622] 7e01                      moveq.l    #1,d7
_stkchk_1:
[00000624] 4e75                      rts

__cenb:
[00000626] 4ab9 0000 0000            tst.l      _mmupres
[0000062c] 6716                      beq.s      __cenb_1
[0000062e] 0cb9 0000 0014 0000 0000  cmpi.l     #$00000014,__cpu
[00000638] 660a                      bne.s      __cenb_1
[0000063a] 203c 0000 0009            move.l     #$00000009,d0
[00000640] 4e7b 0002                 movec      d0,cacr ; 68020+ only
__cenb_1:
[00000644] 4e75                      rts

_sav68881:
[00000646] 202f 0008                 move.l     8(a7),d0
[0000064a] 206f 0004                 movea.l    4(a7),a0
[0000064e] f320                      fsave      -(a0)
[00000650] f220 e800                 fmovem.x   d0,-(a0)
[00000654] 2e08                      move.l     a0,d7
[00000656] 4e75                      rts

_res68881:
[00000658] 202f 0008                 move.l     8(a7),d0
[0000065c] 206f 0004                 movea.l    4(a7),a0
[00000660] f218 d800                 fmovem.x   (a0)+,d0
[00000664] f358                      frestore   (a0)+
[00000666] 2e08                      move.l     a0,d7
[00000668] 4e75                      rts

_init:
[0000066a] 4e56 fffa                 link       a6,#-6
[0000066e] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000672] 2e39 0000 170e            move.l     _systop,d7
[00000678] 9eb9 0000 170a            sub.l      _sysbot,d7
[0000067e] 7c09                      moveq.l    #9,d6
[00000680] ecaf                      lsr.l      d6,d7
[00000682] 2d47 fffa                 move.l     d7,-6(a6)
[00000686] 2ebc 0000 18da            move.l     #$00002FC8,(a7)
[0000068c] 4eb9 0000 0000            jsr        _putfmt
[00000692] 2ebc 0000 1903            move.l     #$00002FF1,(a7)
[00000698] 4eb9 0000 0000            jsr        _putfmt
[0000069e] 4297                      clr.l      (a7)
[000006a0] 2f39 0000 175e            move.l     _pheap,-(a7)
[000006a6] 2f39 0000 0000            move.l     _nheap,-(a7)
[000006ac] 4eb9 0000 0000            jsr        _free
[000006b2] 508f                      addq.l     #8,a7
[000006b4] 2eb9 0000 038a            move.l     _jmpbufsz,(a7)
[000006ba] 4eb9 0000 0000            jsr        _alloc
[000006c0] 23c7 0000 176a            move.l     d7,$00002E58
[000006c6] 4eb9 0000 0000            jsr        _mapinit
[000006cc] 4a87                      tst.l      d7
[000006ce] 660c                      bne.s      _init_1
[000006d0] 2ebc 0000 1932            move.l     #$00003020,(a7)
[000006d6] 4eb9 0000 0000            jsr        _putfmt
_init_1:
[000006dc] 082e 0000 fffd            btst       #0,-3(a6)
[000006e2] 6704                      beq.s      _init_2
[000006e4] 7e05                      moveq.l    #5,d7
[000006e6] 6002                      bra.s      _init_3
_init_2:
[000006e8] 7e00                      moveq.l    #0,d7
_init_3:
[000006ea] 2e87                      move.l     d7,(a7)
[000006ec] 2e2e fffa                 move.l     -6(a6),d7
[000006f0] e28f                      lsr.l      #1,d7
[000006f2] 2f07                      move.l     d7,-(a7)
[000006f4] 2f3c 0000 1936            move.l     #$00003024,-(a7)
[000006fa] 4eb9 0000 0000            jsr        _putfmt
[00000700] 508f                      addq.l     #8,a7
[00000702] 287c 0000 171a            movea.l    #_proc0,a4
[00000708] 23cc 0000 0000            move.l     a4,_plist
[0000070e] 2e8c                      move.l     a4,(a7)
[00000710] 4eb9 0000 0000            jsr        _setpu
[00000716] 2eb9 0000 1a20            move.l     _p1size,(a7)
[0000071c] 4eb9 0000 0000            jsr        _mapsize
[00000722] deb9 0000 1a2c            add.l      _usize,d7
[00000728] 3947 000a                 move.w     d7,10(a4)
[0000072c] 197c 0002 0011            move.b     #$02,17(a4)
[00000732] 197c 000c 0010            move.b     #$0C,16(a4)
[00000738] 426c 0020                 clr.w      32(a4)
[0000073c] 197c 00fd 0013            move.b     #$FD,19(a4)
[00000742] 197c 00fd 0012            move.b     #$FD,18(a4)
[00000748] 422c 0041                 clr.b      65(a4)
[0000074c] 4878 0008                 pea.l      ($00000008).w
[00000750] 486c 0014                 pea.l      20(a4)
[00000754] 2f3c 0000 1950            move.l     #$0000303E,-(a7)
[0000075a] 4eb9 0000 0000            jsr        _movbuf
[00000760] 4fef 000c                 lea.l      12(a7),a7
[00000764] 2279 0000 18d6            movea.l    _pu,a1
[0000076a] 234c 0010                 move.l     a4,16(a1)
[0000076e] 2e8c                      move.l     a4,(a7)
[00000770] 4eb9 0000 0000            jsr        _runproc
[00000776] 2ebc 0000 0000            move.l     #_memlist,(a7)
[0000077c] 7e00                      moveq.l    #0,d7
[0000077e] 3e39 0000 16fa            move.w     _lopage,d7
[00000784] 2f07                      move.l     d7,-(a7)
[00000786] 7e00                      moveq.l    #0,d7
[00000788] 3e39 0000 16fc            move.w     _memsiz,d7
[0000078e] 2f07                      move.l     d7,-(a7)
[00000790] 4eb9 0000 0000            jsr        _sfree
[00000796] 508f                      addq.l     #8,a7
[00000798] 33f9 0000 16fc 0000 16f6  move.w     _memsiz,_contig
_init_5:
[000007a2] 4a79 0000 16f6            tst.w      _contig
[000007a8] 672c                      beq.s      _init_4
[000007aa] 2eb9 0000 1a2c            move.l     _usize,(a7)
[000007b0] 2f3c 0000 0000            move.l     #_memlist,-(a7)
[000007b6] 7e00                      moveq.l    #0,d7
[000007b8] 3e39 0000 16f6            move.w     _contig,d7
[000007be] 2f07                      move.l     d7,-(a7)
[000007c0] 4eb9 0000 0000            jsr        _memalloc
[000007c6] 508f                      addq.l     #8,a7
[000007c8] 3d47 fffe                 move.w     d7,-2(a6)
[000007cc] 6608                      bne.s      _init_4
[000007ce] 5379 0000 16f6            subq.w     #1,_contig
[000007d4] 60cc                      bra.s      _init_5
_init_4:
[000007d6] 2eb9 0000 1a2c            move.l     _usize,(a7)
[000007dc] 2f3c 0000 0000            move.l     #_memlist,-(a7)
[000007e2] 7e00                      moveq.l    #0,d7
[000007e4] 3e2e fffe                 move.w     -2(a6),d7
[000007e8] 2f07                      move.l     d7,-(a7)
[000007ea] 7e00                      moveq.l    #0,d7
[000007ec] 3e39 0000 16f6            move.w     _contig,d7
[000007f2] 2f07                      move.l     d7,-(a7)
[000007f4] 4eb9 0000 0000            jsr        _memfree
[000007fa] 4fef 000c                 lea.l      12(a7),a7
[000007fe] 0839 0000 0000 16f7       btst       #0,$00002DE5
[00000806] 6704                      beq.s      _init_6
[00000808] 7e05                      moveq.l    #5,d7
[0000080a] 6002                      bra.s      _init_7
_init_6:
[0000080c] 7e00                      moveq.l    #0,d7
_init_7:
[0000080e] 2e87                      move.l     d7,(a7)
[00000810] 7e00                      moveq.l    #0,d7
[00000812] 3e39 0000 16f6            move.w     _contig,d7
[00000818] e287                      asr.l      #1,d7
[0000081a] 6c04                      bge.s      _init_8
[0000081c] 6402                      bcc.s      _init_8
[0000081e] 5287                      addq.l     #1,d7
_init_8:
[00000820] 2f07                      move.l     d7,-(a7)
[00000822] 2f3c 0000 1957            move.l     #$00003045,-(a7)
[00000828] 4eb9 0000 0000            jsr        _putfmt
[0000082e] 508f                      addq.l     #8,a7
[00000830] 4eb9 0000 045e            jsr        _permit
[00000836] 0839 0000 0000 16fd       btst       #0,$00002DEB
[0000083e] 6704                      beq.s      _init_9
[00000840] 7e05                      moveq.l    #5,d7
[00000842] 6002                      bra.s      _init_10
_init_9:
[00000844] 7e00                      moveq.l    #0,d7
_init_10:
[00000846] 2e87                      move.l     d7,(a7)
[00000848] 7e00                      moveq.l    #0,d7
[0000084a] 3e39 0000 16fc            move.w     _memsiz,d7
[00000850] e287                      asr.l      #1,d7
[00000852] 6c04                      bge.s      _init_11
[00000854] 6402                      bcc.s      _init_11
[00000856] 5287                      addq.l     #1,d7
_init_11:
[00000858] 2f07                      move.l     d7,-(a7)
[0000085a] 2f3c 0000 1976            move.l     #$00003064,-(a7)
[00000860] 4eb9 0000 0000            jsr        _putfmt
[00000866] 508f                      addq.l     #8,a7
[00000868] 2eb9 0000 0000            move.l     _nbufs,(a7)
[0000086e] 2f3c 0000 1989            move.l     #$00003077,-(a7)
[00000874] 4eb9 0000 0000            jsr        _putfmt
[0000087a] 588f                      addq.l     #4,a7
[0000087c] 4ab9 0000 0000            tst.l      _fppres
[00000882] 670c                      beq.s      _init_12
[00000884] 2ebc 0000 199e            move.l     #$0000308C,(a7)
[0000088a] 4eb9 0000 0000            jsr        _putfmt
_init_12:
[00000890] 4297                      clr.l      (a7)
[00000892] 7e00                      moveq.l    #0,d7
[00000894] 3e39 0000 0000            move.w     _rootdev,d7
[0000089a] 2f07                      move.l     d7,-(a7)
[0000089c] 4eb9 0000 0000            jsr        _putdnm
[000008a2] 588f                      addq.l     #4,a7
[000008a4] 4ab9 0000 0000            tst.l      _rootro
[000008aa] 6708                      beq.s      _init_13
[000008ac] 2e3c 0000 19bc            move.l     #$000030AA,d7
[000008b2] 6006                      bra.s      _init_14
_init_13:
[000008b4] 2e3c 0000 19bb            move.l     #$000030A9,d7
_init_14:
[000008ba] 2e87                      move.l     d7,(a7)
[000008bc] 2f3c 0000 19ca            move.l     #$000030B8,-(a7)
[000008c2] 4eb9 0000 0000            jsr        _putfmt
[000008c8] 588f                      addq.l     #4,a7
[000008ca] 3e39 0000 0000            move.w     _swapsiz,d7
[000008d0] be79 0000 16fc            cmp.w      _memsiz,d7
[000008d6] 6206                      bhi.s      _init_15
[000008d8] 4279 0000 0000            clr.w      _swapdev
_init_15:
[000008de] 4a79 0000 0000            tst.w      _swapdev
[000008e4] 6638                      bne.s      _init_16
[000008e6] 2ebc 0000 19de            move.l     #$000030CC,(a7)
[000008ec] 4eb9 0000 0000            jsr        _putfmt
[000008f2] 2ebc 0000 0000            move.l     #_slist,(a7)
[000008f8] 7e00                      moveq.l    #0,d7
[000008fa] 3e39 0000 16fa            move.w     _lopage,d7
[00000900] 2f07                      move.l     d7,-(a7)
[00000902] 7e00                      moveq.l    #0,d7
[00000904] 3e39 0000 16fc            move.w     _memsiz,d7
[0000090a] 2f07                      move.l     d7,-(a7)
[0000090c] 4eb9 0000 0000            jsr        _sfree
[00000912] 508f                      addq.l     #8,a7
[00000914] 7001                      moveq.l    #1,d0
[00000916] 23c0 0000 16fe            move.l     d0,_noswap
[0000091c] 6054                      bra.s      _init_17
_init_16:
[0000091e] 0839 0000 0000 0001       btst       #0,_swapsiz+$00000001
[00000926] 6704                      beq.s      _init_18
[00000928] 7e05                      moveq.l    #5,d7
[0000092a] 6002                      bra.s      _init_19
_init_18:
[0000092c] 7e00                      moveq.l    #0,d7
_init_19:
[0000092e] 2e87                      move.l     d7,(a7)
[00000930] 7e00                      moveq.l    #0,d7
[00000932] 3e39 0000 0000            move.w     _swapsiz,d7
[00000938] e287                      asr.l      #1,d7
[0000093a] 6c04                      bge.s      _init_20
[0000093c] 6402                      bcc.s      _init_20
[0000093e] 5287                      addq.l     #1,d7
_init_20:
[00000940] 2f07                      move.l     d7,-(a7)
[00000942] 2f3c 0000 19eb            move.l     #$000030D9,-(a7)
[00000948] 4eb9 0000 0000            jsr        _putfmt
[0000094e] 508f                      addq.l     #8,a7
[00000950] 2ebc 0000 0000            move.l     #_slist,(a7)
[00000956] 7e00                      moveq.l    #0,d7
[00000958] 3e39 0000 0000            move.w     _swapadr,d7
[0000095e] 2f07                      move.l     d7,-(a7)
[00000960] 7e00                      moveq.l    #0,d7
[00000962] 3e39 0000 0000            move.w     _swapsiz,d7
[00000968] 2f07                      move.l     d7,-(a7)
[0000096a] 4eb9 0000 0000            jsr        _sfree
[00000970] 508f                      addq.l     #8,a7
_init_17:
[00000972] 2ebc 0000 0000            move.l     #_where,(a7)
[00000978] 2f3c 0000 19ff            move.l     #$000030ED,-(a7)
[0000097e] 4eb9 0000 0000            jsr        _putfmt
[00000984] 588f                      addq.l     #4,a7
[00000986] 4eb9 0000 0000            jsr        _blk_init
[0000098c] 4eb9 0000 0000            jsr        _chq_init
[00000992] 4eb9 0000 0000            jsr        _ino_init
[00000998] 4ab9 0000 1702            tst.l      _romsys
[0000099e] 661e                      bne.s      _init_21
[000009a0] 4297                      clr.l      (a7)
[000009a2] 2f3c 0000 0000            move.l     #_lo_init,-(a7)
[000009a8] 2e3c 0000 0000            move.l     #_hi_init,d7
[000009ae] 0487 0000 0000            subi.l     #_lo_init,d7
[000009b4] 2f07                      move.l     d7,-(a7)
[000009b6] 4eb9 0000 0000            jsr        _free
[000009bc] 508f                      addq.l     #8,a7
_init_21:
[000009be] 4878 0001                 pea.l      ($00000001).w
[000009c2] 7e00                      moveq.l    #0,d7
[000009c4] 3e39 0000 0000            move.w     _rootdev,d7
[000009ca] 2f07                      move.l     d7,-(a7)
[000009cc] 4eb9 0000 0000            jsr        _geti
[000009d2] 508f                      addq.l     #8,a7
[000009d4] 23c7 0000 1712            move.l     d7,_root
[000009da] 2eb9 0000 1712            move.l     _root,(a7)
[000009e0] 4eb9 0000 0000            jsr        _reli
[000009e6] 4878 0001                 pea.l      ($00000001).w
[000009ea] 7e00                      moveq.l    #0,d7
[000009ec] 3e39 0000 0000            move.w     _rootdev,d7
[000009f2] 2f07                      move.l     d7,-(a7)
[000009f4] 4eb9 0000 0000            jsr        _geti
[000009fa] 508f                      addq.l     #8,a7
[000009fc] 2279 0000 18d6            movea.l    _pu,a1
[00000a02] 2347 0034                 move.l     d7,52(a1)
[00000a06] 2ea9 0034                 move.l     52(a1),(a7)
[00000a0a] 4eb9 0000 0000            jsr        _reli
[00000a10] 4878 0001                 pea.l      ($00000001).w
[00000a14] 7e00                      moveq.l    #0,d7
[00000a16] 3e39 0000 0000            move.w     _rootdev,d7
[00000a1c] 2f07                      move.l     d7,-(a7)
[00000a1e] 4eb9 0000 0000            jsr        _geti
[00000a24] 508f                      addq.l     #8,a7
[00000a26] 2279 0000 18d6            movea.l    _pu,a1
[00000a2c] 2347 0038                 move.l     d7,56(a1)
[00000a30] 2ea9 0038                 move.l     56(a1),(a7)
[00000a34] 4eb9 0000 0000            jsr        _reli
[00000a3a] 2eb9 0000 176a            move.l     $00002E58,(a7)
[00000a40] 4eb9 0000 039c            jsr        _setjmp
[00000a46] 4a87                      tst.l      d7
[00000a48] 6708                      beq.s      _init_22
[00000a4a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000a4e] 4e5e                      unlk       a6
[00000a50] 4e75                      rts
_init_22:
[00000a52] 4878 0001                 pea.l      ($00000001).w
[00000a56] 4eb9 0000 0000            jsr        _makep
[00000a5c] 588f                      addq.l     #4,a7
[00000a5e] 2847                      movea.l    d7,a4
[00000a60] 2e0c                      move.l     a4,d7
[00000a62] 6722                      beq.s      _init_23
[00000a64] 2eb9 0000 1a2c            move.l     _usize,(a7)
[00000a6a] 2f3c 0000 0000            move.l     #_memlist,-(a7)
[00000a70] 7e00                      moveq.l    #0,d7
[00000a72] 3e2c 000a                 move.w     10(a4),d7
[00000a76] 2f07                      move.l     d7,-(a7)
[00000a78] 4eb9 0000 0000            jsr        _memalloc
[00000a7e] 508f                      addq.l     #8,a7
[00000a80] 3947 0008                 move.w     d7,8(a4)
[00000a84] 660c                      bne.s      _init_24
_init_23:
[00000a86] 2ebc 0000 1a03            move.l     #$000030F1,(a7)
[00000a8c] 4eb9 0000 0000            jsr        _panic
_init_24:
[00000a92] 7e00                      moveq.l    #0,d7
[00000a94] 3e2c 0008                 move.w     8(a4),d7
[00000a98] 7c00                      moveq.l    #0,d6
[00000a9a] 3c2c 000a                 move.w     10(a4),d6
[00000a9e] de86                      add.l      d6,d7
[00000aa0] 9eb9 0000 1a2c            sub.l      _usize,d7
[00000aa6] 2e87                      move.l     d7,(a7)
[00000aa8] 4eb9 0000 0b66            jsr        _mappu
[00000aae] 23c7 0000 18d6            move.l     d7,_pu
[00000ab4] 4878 0170                 pea.l      ($00000170).w
[00000ab8] 2f39 0000 18d6            move.l     _pu,-(a7)
[00000abe] 2f3c 0000 1766            move.l     #_u0,-(a7)
[00000ac4] 4eb9 0000 0000            jsr        _movbuf
[00000aca] 4fef 000c                 lea.l      12(a7),a7
[00000ace] 2279 0000 18d6            movea.l    _pu,a1
[00000ad4] 234c 0010                 move.l     a4,16(a1)
[00000ad8] 2e8c                      move.l     a4,(a7)
[00000ada] 4eb9 0000 0000            jsr        _setpu
[00000ae0] 2e39 0000 18d6            move.l     _pu,d7
[00000ae6] 0687 0000 0170            addi.l     #$00000170,d7
[00000aec] 2a47                      movea.l    d7,a5
[00000aee] 7a54                      moveq.l    #84,d5
_init_26:
[00000af0] 5385                      subq.l     #1,d5
[00000af2] 6d06                      blt.s      _init_25
[00000af4] 4215                      clr.b      (a5)
[00000af6] 528d                      addq.l     #1,a5
[00000af8] 60f6                      bra.s      _init_26
_init_25:
[00000afa] 422c 0013                 clr.b      19(a4)
[00000afe] 197c 0005 0012            move.b     #$05,18(a4)
[00000b04] 2e8c                      move.l     a4,(a7)
[00000b06] 4eb9 0000 0000            jsr        _runproc
[00000b0c] 08ac 0003 0010            bclr       #3,16(a4)
[00000b12] 4ab9 0000 1702            tst.l      _romsys
[00000b18] 661e                      bne.s      _init_27
[00000b1a] 4297                      clr.l      (a7)
[00000b1c] 2f3c 0000 066a            move.l     #_init,-(a7)
[00000b22] 2e3c 0000 0b4c            move.l     #$00000B4C,d7
[00000b28] 0487 0000 066a            subi.l     #_init,d7
[00000b2e] 2f07                      move.l     d7,-(a7)
[00000b30] 4eb9 0000 0000            jsr        _free
[00000b36] 508f                      addq.l     #8,a7
_init_27:
[00000b38] 4297                      clr.l      (a7)
[00000b3a] 42a7                      clr.l      -(a7)
[00000b3c] 4eb9 0000 0000            jsr        _syexit
[00000b42] 588f                      addq.l     #4,a7
[00000b44] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000b48] 4e5e                      unlk       a6
[00000b4a] 4e75                      rts

xb4c:
[00000b4c] 4e75                      rts

_isabs:
[00000b4e] 2279 0000 18d6            movea.l    _pu,a1
[00000b54] 2269 0010                 movea.l    16(a1),a1
[00000b58] 7e00                      moveq.l    #0,d7
[00000b5a] 1e29 0010                 move.b     16(a1),d7
[00000b5e] 7c10                      moveq.l    #16,d6
[00000b60] cc87                      and.l      d7,d6
[00000b62] 2e06                      move.l     d6,d7
[00000b64] 4e75                      rts

_mappu:
[00000b66] 4e56 fffc                 link       a6,#-4
[00000b6a] 4ab9 0000 1a3c            tst.l      $0000312A
[00000b70] 6616                      bne.s      _mappu_1
[00000b72] 2e39 0000 1a2c            move.l     _usize,d7
[00000b78] 7c09                      moveq.l    #9,d6
[00000b7a] eda7                      asl.l      d6,d7
[00000b7c] 9eb9 0000 1a34            sub.l      _uxsize,d7
[00000b82] 23c7 0000 1a3c            move.l     d7,$0000312A
_mappu_1:
[00000b88] 2e2e 0008                 move.l     8(a6),d7
[00000b8c] 7c09                      moveq.l    #9,d6
[00000b8e] eda7                      asl.l      d6,d7
[00000b90] deb9 0000 1a3c            add.l      $0000312A,d7
[00000b96] 23c7 0000 18d6            move.l     d7,_pu
[00000b9c] 4ab9 0000 0000            tst.l      _mmupres
[00000ba2] 660a                      bne.s      _mappu_2
[00000ba4] 2e39 0000 18d6            move.l     _pu,d7
[00000baa] 4e5e                      unlk       a6
[00000bac] 4e75                      rts
_mappu_2:
[00000bae] 2e2e 0008                 move.l     8(a6),d7
[00000bb2] 7c00                      moveq.l    #0,d6
[00000bb4] 3c39 0000 1a40            move.w     $0000312E,d6
[00000bba] be86                      cmp.l      d6,d7
[00000bbc] 673e                      beq.s      _mappu_3
[00000bbe] 33ee 000a 0000 1a40       move.w     10(a6),$0000312E
[00000bc6] 23fc 0000 1766 0000 18d6  move.l     #_u0,_pu
[00000bd0] 4297                      clr.l      (a7)
[00000bd2] 2e39 0000 1a2c            move.l     _usize,d7
[00000bd8] 7c09                      moveq.l    #9,d6
[00000bda] eda7                      asl.l      d6,d7
[00000bdc] 2f07                      move.l     d7,-(a7)
[00000bde] 2e2e 0008                 move.l     8(a6),d7
[00000be2] 7c09                      moveq.l    #9,d6
[00000be4] eda7                      asl.l      d6,d7
[00000be6] 2f07                      move.l     d7,-(a7)
[00000be8] 2f39 0000 1a38            move.l     _map_ux,-(a7)
[00000bee] 4878 0004                 pea.l      ($00000004).w
[00000bf2] 4eb9 0000 0000            jsr        _mapseg
[00000bf8] 4fef 0010                 lea.l      16(a7),a7
_mappu_3:
[00000bfc] 2e39 0000 1a38            move.l     _map_ux,d7
[00000c02] deb9 0000 1a3c            add.l      $0000312A,d7
[00000c08] 23c7 0000 18d6            move.l     d7,_pu
[00000c0e] 2e39 0000 18d6            move.l     _pu,d7
[00000c14] 4e5e                      unlk       a6
[00000c16] 4e75                      rts

_setumap:
[00000c18] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000c1c] 2a79 0000 18d6            movea.l    _pu,a5
[00000c22] 286d 0010                 movea.l    16(a5),a4
[00000c26] 266c 0022                 movea.l    34(a4),a3
[00000c2a] 7e00                      moveq.l    #0,d7
[00000c2c] 3e2c 0008                 move.w     8(a4),d7
[00000c30] 7c09                      moveq.l    #9,d6
[00000c32] eda7                      asl.l      d6,d7
[00000c34] 23c7 0000 1a24            move.l     d7,_uiobase
[00000c3a] 2e0b                      move.l     a3,d7
[00000c3c] 670c                      beq.s      _setumap_1
[00000c3e] 7e00                      moveq.l    #0,d7
[00000c40] 3e2b 0008                 move.w     8(a3),d7
[00000c44] 7c09                      moveq.l    #9,d6
[00000c46] eda7                      asl.l      d6,d7
[00000c48] 6006                      bra.s      _setumap_2
_setumap_1:
[00000c4a] 2e39 0000 1a24            move.l     _uiobase,d7
_setumap_2:
[00000c50] 9ead 0018                 sub.l      24(a5),d7
[00000c54] 23c7 0000 1a28            move.l     d7,_utxtbase
[00000c5a] 082c 0000 0010            btst       #0,16(a4)
[00000c60] 6706                      beq.s      _setumap_3
[00000c62] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000c66] 4e75                      rts
_setumap_3:
[00000c68] 082c 0006 0010            btst       #6,16(a4)
[00000c6e] 670e                      beq.s      _setumap_4
[00000c70] 23f9 0000 1a28 0000 1a24  move.l     _utxtbase,_uiobase
[00000c7a] 6000 0176                 bra        _setumap_5
_setumap_4:
[00000c7e] 082c 0004 0010            btst       #4,16(a4)
[00000c84] 671e                      beq.s      _setumap_6
[00000c86] 3e2c 001c                 move.w     28(a4),d7
[00000c8a] 48c7                      ext.l      d7
[00000c8c] 2e87                      move.l     d7,(a7)
[00000c8e] 4eb9 0000 0000            jsr        _mapabs
[00000c94] 42b9 0000 1a24            clr.l      _uiobase
[00000c9a] 42b9 0000 1a28            clr.l      _utxtbase
[00000ca0] 6000 0150                 bra        _setumap_5
_setumap_6:
[00000ca4] 2e0b                      move.l     a3,d7
[00000ca6] 677a                      beq.s      _setumap_7
[00000ca8] 4ab9 0000 0000            tst.l      _mmupres
[00000cae] 6764                      beq.s      _setumap_8
[00000cb0] 3e2b 001c                 move.w     28(a3),d7
[00000cb4] 48c7                      ext.l      d7
[00000cb6] 2e87                      move.l     d7,(a7)
[00000cb8] 7e00                      moveq.l    #0,d7
[00000cba] 3e2b 000e                 move.w     14(a3),d7
[00000cbe] 7c09                      moveq.l    #9,d6
[00000cc0] eda7                      asl.l      d6,d7
[00000cc2] 2f07                      move.l     d7,-(a7)
[00000cc4] 7e00                      moveq.l    #0,d7
[00000cc6] 3e2b 0008                 move.w     8(a3),d7
[00000cca] 7c09                      moveq.l    #9,d6
[00000ccc] eda7                      asl.l      d6,d7
[00000cce] 2f07                      move.l     d7,-(a7)
[00000cd0] 2f2d 0018                 move.l     24(a5),-(a7)
[00000cd4] 4878 0002                 pea.l      ($00000002).w
[00000cd8] 4eb9 0000 0000            jsr        _mapseg
[00000cde] 4fef 0010                 lea.l      16(a7),a7
[00000ce2] 3e2c 001c                 move.w     28(a4),d7
[00000ce6] 48c7                      ext.l      d7
[00000ce8] 2e87                      move.l     d7,(a7)
[00000cea] 7e00                      moveq.l    #0,d7
[00000cec] 3e2c 000a                 move.w     10(a4),d7
[00000cf0] 9eb9 0000 1a2c            sub.l      _usize,d7
[00000cf6] 7c09                      moveq.l    #9,d6
[00000cf8] eda7                      asl.l      d6,d7
[00000cfa] 2f07                      move.l     d7,-(a7)
[00000cfc] 2f39 0000 1a24            move.l     _uiobase,-(a7)
[00000d02] 2f2d 0020                 move.l     32(a5),-(a7)
[00000d06] 4878 0001                 pea.l      ($00000001).w
[00000d0a] 4eb9 0000 0000            jsr        _mapseg
[00000d10] 4fef 0010                 lea.l      16(a7),a7
_setumap_8:
[00000d14] 2e2d 0020                 move.l     32(a5),d7
[00000d18] 9fb9 0000 1a24            sub.l      d7,_uiobase
[00000d1e] 6000 00d2                 bra        _setumap_5
_setumap_7:
[00000d22] 2e2d 0018                 move.l     24(a5),d7
[00000d26] dead 001c                 add.l      28(a5),d7
[00000d2a] bead 0020                 cmp.l      32(a5),d7
[00000d2e] 6646                      bne.s      _setumap_9
[00000d30] 4ab9 0000 0000            tst.l      _mmupres
[00000d36] 6732                      beq.s      _setumap_10
[00000d38] 3e2c 001c                 move.w     28(a4),d7
[00000d3c] 48c7                      ext.l      d7
[00000d3e] 2e87                      move.l     d7,(a7)
[00000d40] 7e00                      moveq.l    #0,d7
[00000d42] 3e2c 000a                 move.w     10(a4),d7
[00000d46] 9eb9 0000 1a2c            sub.l      _usize,d7
[00000d4c] 7c09                      moveq.l    #9,d6
[00000d4e] eda7                      asl.l      d6,d7
[00000d50] 2f07                      move.l     d7,-(a7)
[00000d52] 2f39 0000 1a24            move.l     _uiobase,-(a7)
[00000d58] 2f2d 0018                 move.l     24(a5),-(a7)
[00000d5c] 4878 0003                 pea.l      ($00000003).w
[00000d60] 4eb9 0000 0000            jsr        _mapseg
[00000d66] 4fef 0010                 lea.l      16(a7),a7
_setumap_10:
[00000d6a] 2e2d 0018                 move.l     24(a5),d7
[00000d6e] 9fb9 0000 1a24            sub.l      d7,_uiobase
[00000d74] 607c                      bra.s      _setumap_5
_setumap_9:
[00000d76] 4ab9 0000 0000            tst.l      _mmupres
[00000d7c] 6766                      beq.s      _setumap_11
[00000d7e] 3e2c 001c                 move.w     28(a4),d7
[00000d82] 48c7                      ext.l      d7
[00000d84] 2e87                      move.l     d7,(a7)
[00000d86] 7e00                      moveq.l    #0,d7
[00000d88] 3e2c 000e                 move.w     14(a4),d7
[00000d8c] 7c09                      moveq.l    #9,d6
[00000d8e] eda7                      asl.l      d6,d7
[00000d90] 2f07                      move.l     d7,-(a7)
[00000d92] 2f39 0000 1a24            move.l     _uiobase,-(a7)
[00000d98] 2f2d 0018                 move.l     24(a5),-(a7)
[00000d9c] 4878 0002                 pea.l      ($00000002).w
[00000da0] 4eb9 0000 0000            jsr        _mapseg
[00000da6] 4fef 0010                 lea.l      16(a7),a7
[00000daa] 3e2c 001c                 move.w     28(a4),d7
[00000dae] 48c7                      ext.l      d7
[00000db0] 2e87                      move.l     d7,(a7)
[00000db2] 7e00                      moveq.l    #0,d7
[00000db4] 3e2c 000a                 move.w     10(a4),d7
[00000db8] 7c00                      moveq.l    #0,d6
[00000dba] 3c2c 000e                 move.w     14(a4),d6
[00000dbe] 9e86                      sub.l      d6,d7
[00000dc0] 7c09                      moveq.l    #9,d6
[00000dc2] eda7                      asl.l      d6,d7
[00000dc4] 2f07                      move.l     d7,-(a7)
[00000dc6] 2e39 0000 1a24            move.l     _uiobase,d7
[00000dcc] dead 001c                 add.l      28(a5),d7
[00000dd0] 2f07                      move.l     d7,-(a7)
[00000dd2] 2f2d 0020                 move.l     32(a5),-(a7)
[00000dd6] 4878 0001                 pea.l      ($00000001).w
[00000dda] 4eb9 0000 0000            jsr        _mapseg
[00000de0] 4fef 0010                 lea.l      16(a7),a7
_setumap_11:
[00000de4] 2e2d 001c                 move.l     28(a5),d7
[00000de8] 9ead 0020                 sub.l      32(a5),d7
[00000dec] dfb9 0000 1a24            add.l      d7,_uiobase
_setumap_5:
[00000df2] 1e2c 0010                 move.b     16(a4),d7
[00000df6] 0207 0051                 andi.b     #$51,d7
[00000dfa] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000e00] 660c                      bne.s      _setumap_12
[00000e02] 4a6d 0138                 tst.w      312(a5)
[00000e06] 6706                      beq.s      _setumap_12
[00000e08] 4eb9 0000 0000            jsr        _mapx
_setumap_12:
[00000e0e] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000e12] 4e75                      rts

_ucopy:
[00000e14] 4e56 fffc                 link       a6,#-4
[00000e18] 7e00                      moveq.l    #0,d7
[00000e1a] 3e39 0000 1a1e            move.w     _curbase,d7
[00000e20] beae 0008                 cmp.l      8(a6),d7
[00000e24] 673e                      beq.s      _ucopy_1
[00000e26] 2eb9 0000 1a34            move.l     _uxsize,(a7)
[00000e2c] 2e2e 0008                 move.l     8(a6),d7
[00000e30] deb9 0000 1a2c            add.l      _usize,d7
[00000e36] 7c09                      moveq.l    #9,d6
[00000e38] eda7                      asl.l      d6,d7
[00000e3a] 9eb9 0000 1a34            sub.l      _uxsize,d7
[00000e40] 2f07                      move.l     d7,-(a7)
[00000e42] 7e00                      moveq.l    #0,d7
[00000e44] 3e39 0000 1a1e            move.w     _curbase,d7
[00000e4a] deb9 0000 1a2c            add.l      _usize,d7
[00000e50] 7c09                      moveq.l    #9,d6
[00000e52] eda7                      asl.l      d6,d7
[00000e54] 9eb9 0000 1a34            sub.l      _uxsize,d7
[00000e5a] 2f07                      move.l     d7,-(a7)
[00000e5c] 4eb9 0000 05be            jsr        __movmem
[00000e62] 508f                      addq.l     #8,a7
_ucopy_1:
[00000e64] 4e5e                      unlk       a6
[00000e66] 4e75                      rts

__fppi:
[00000e68] 4878 0040                 pea.l      (sigfpe).w
[00000e6c] 7e00                      moveq.l    #0,d7
[00000e6e] 3e39 0000 1a1e            move.w     _curbase,d7
[00000e74] 7c09                      moveq.l    #9,d6
[00000e76] eda7                      asl.l      d6,d7
[00000e78] 2f07                      move.l     d7,-(a7)
[00000e7a] 4eb9 0000 0000            jsr        _fppinit
[00000e80] 508f                      addq.l     #8,a7
[00000e82] 4e75                      rts

__fppld:
[00000e84] 4ab9 0000 0000            tst.l      _fppres
[00000e8a] 6732                      beq.s      __fppld_1
[00000e8c] 2279 0000 18d6            movea.l    _pu,a1
[00000e92] 4aa9 0134                 tst.l      308(a1)
[00000e96] 660c                      bne.s      __fppld_2
[00000e98] 0cb9 0000 0002 0000 0000  cmpi.l     #$00000002,_fppres
[00000ea2] 661a                      bne.s      __fppld_1
__fppld_2:
[00000ea4] 4878 0040                 pea.l      (sigfpe).w
[00000ea8] 7e00                      moveq.l    #0,d7
[00000eaa] 3e39 0000 1a1e            move.w     _curbase,d7
[00000eb0] 7c09                      moveq.l    #9,d6
[00000eb2] eda7                      asl.l      d6,d7
[00000eb4] 2f07                      move.l     d7,-(a7)
[00000eb6] 4eb9 0000 0000            jsr        _fppload
[00000ebc] 508f                      addq.l     #8,a7
__fppld_1:
[00000ebe] 4e75                      rts

__fppsv:
[00000ec0] 4ab9 0000 0000            tst.l      _fppres
[00000ec6] 6732                      beq.s      __fppsv_1
[00000ec8] 2279 0000 16f2            movea.l    __pux,a1
[00000ece] 4aa9 0134                 tst.l      308(a1)
[00000ed2] 660c                      bne.s      __fppsv_2
[00000ed4] 0cb9 0000 0002 0000 0000  cmpi.l     #$00000002,_fppres
[00000ede] 661a                      bne.s      __fppsv_1
__fppsv_2:
[00000ee0] 4878 0040                 pea.l      (sigfpe).w
[00000ee4] 7e00                      moveq.l    #0,d7
[00000ee6] 3e39 0000 1a1e            move.w     _curbase,d7
[00000eec] 7c09                      moveq.l    #9,d6
[00000eee] eda7                      asl.l      d6,d7
[00000ef0] 2f07                      move.l     d7,-(a7)
[00000ef2] 4eb9 0000 0000            jsr        _fppsave
[00000ef8] 508f                      addq.l     #8,a7
__fppsv_1:
[00000efa] 4e75                      rts

_clrmem:
[00000efc] 4e56 ff00                 link       a6,#-256
[00000f00] 48e7 8c0c                 movem.l    d0/d4-d5/a4-a5,-(a7)
[00000f04] 2a6e 0008                 movea.l    8(a6),a5
[00000f08] 2a2e 000c                 move.l     12(a6),d5
[00000f0c] 2e85                      move.l     d5,(a7)
[00000f0e] 2f0d                      move.l     a5,-(a7)
[00000f10] 4eb9 0000 0f6c            jsr        _chkbuf
[00000f16] 588f                      addq.l     #4,a7
[00000f18] 4a87                      tst.l      d7
[00000f1a] 6604                      bne.s      _clrmem_1
[00000f1c] 7e01                      moveq.l    #1,d7
[00000f1e] 603a                      bra.s      _clrmem_2
_clrmem_1:
[00000f20] 43ee ff00                 lea.l      -256(a6),a1
[00000f24] 2849                      movea.l    a1,a4
[00000f26] 7840                      moveq.l    #64,d4
_clrmem_4:
[00000f28] 5384                      subq.l     #1,d4
[00000f2a] 6d04                      blt.s      _clrmem_3
[00000f2c] 429c                      clr.l      (a4)+
[00000f2e] 60f8                      bra.s      _clrmem_4
_clrmem_3:
[00000f30] 4a85                      tst.l      d5
[00000f32] 6734                      beq.s      _clrmem_5
[00000f34] 4878 0100                 pea.l      ($00000100).w
[00000f38] 2f05                      move.l     d5,-(a7)
[00000f3a] 4eb9 0000 0000            jsr        _minu
[00000f40] 508f                      addq.l     #8,a7
[00000f42] 2807                      move.l     d7,d4
[00000f44] 2e84                      move.l     d4,(a7)
[00000f46] 2f0d                      move.l     a5,-(a7)
[00000f48] 486e ff00                 pea.l      -256(a6)
[00000f4c] 4eb9 0000 0570            jsr        _outbuf
[00000f52] 508f                      addq.l     #8,a7
[00000f54] 4a87                      tst.l      d7
[00000f56] 670a                      beq.s      _clrmem_6
[00000f58] 7e01                      moveq.l    #1,d7
_clrmem_2:
[00000f5a] 4cdf 3031                 movem.l    (a7)+,d0/d4-d5/a4-a5
[00000f5e] 4e5e                      unlk       a6
[00000f60] 4e75                      rts
_clrmem_6:
[00000f62] 9a84                      sub.l      d4,d5
[00000f64] dbc4                      adda.l     d4,a5
[00000f66] 60c8                      bra.s      _clrmem_3
_clrmem_5:
[00000f68] 7e00                      moveq.l    #0,d7
[00000f6a] 60ee                      bra.s      _clrmem_2

_chkbuf:
[00000f6c] 4e56 0000                 link       a6,#0
[00000f70] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00000f74] 2e2e 0008                 move.l     8(a6),d7
[00000f78] deae 000c                 add.l      12(a6),d7
[00000f7c] 2a07                      move.l     d7,d5
[00000f7e] 2a79 0000 18d6            movea.l    _pu,a5
[00000f84] 2e2d 0020                 move.l     32(a5),d7
[00000f88] beae 0008                 cmp.l      8(a6),d7
[00000f8c] 620c                      bhi.s      _chkbuf_1
[00000f8e] 2e2d 0020                 move.l     32(a5),d7
[00000f92] dead 0024                 add.l      36(a5),d7
[00000f96] ba87                      cmp.l      d7,d5
[00000f98] 632e                      bls.s      _chkbuf_2
_chkbuf_1:
[00000f9a] 2e2d 0018                 move.l     24(a5),d7
[00000f9e] beae 0008                 cmp.l      8(a6),d7
[00000fa2] 620c                      bhi.s      _chkbuf_3
[00000fa4] 2e2d 0018                 move.l     24(a5),d7
[00000fa8] dead 001c                 add.l      28(a5),d7
[00000fac] ba87                      cmp.l      d7,d5
[00000fae] 6318                      bls.s      _chkbuf_2
_chkbuf_3:
[00000fb0] 4a6d 0138                 tst.w      312(a5)
[00000fb4] 6716                      beq.s      _chkbuf_4
[00000fb6] 2e85                      move.l     d5,(a7)
[00000fb8] 2f2e 0008                 move.l     8(a6),-(a7)
[00000fbc] 4eb9 0000 0000            jsr        _chkx
[00000fc2] 588f                      addq.l     #4,a7
[00000fc4] 4a87                      tst.l      d7
[00000fc6] 6704                      beq.s      _chkbuf_4
_chkbuf_2:
[00000fc8] 7e01                      moveq.l    #1,d7
[00000fca] 6002                      bra.s      _chkbuf_5
_chkbuf_4:
[00000fcc] 7e00                      moveq.l    #0,d7
_chkbuf_5:
[00000fce] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000fd2] 4e5e                      unlk       a6
[00000fd4] 4e75                      rts

_coreout:
[00000fd6] 4e56 fffc                 link       a6,#-4
[00000fda] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000fde] 2a6e 0010                 movea.l    16(a6),a5
[00000fe2] 2879 0000 18d6            movea.l    _pu,a4
[00000fe8] 264c                      movea.l    a4,a3
[00000fea] 276e 000c 0170            move.l     12(a6),368(a3)
[00000ff0] 276d 0024 0174            move.l     36(a5),372(a3)
[00000ff6] 276d 0004 0178            move.l     4(a5),376(a3)
[00000ffc] 276d 0008 017c            move.l     8(a5),380(a3)
[00001002] 276d 000c 018c            move.l     12(a5),396(a3)
[00001008] 276d 0010 0190            move.l     16(a5),400(a3)
[0000100e] 276d 0014 0194            move.l     20(a5),404(a3)
[00001014] 276d 0018 0198            move.l     24(a5),408(a3)
[0000101a] 276d 001c 019c            move.l     28(a5),412(a3)
[00001020] 276d 0020 01b0            move.l     32(a5),432(a3)
[00001026] 7e00                      moveq.l    #0,d7
[00001028] 3e2d 0028                 move.w     40(a5),d7
[0000102c] 2747 01b8                 move.l     d7,440(a3)
[00001030] 276d 002a 01b4            move.l     42(a5),436(a3)
[00001036] 4878 0008                 pea.l      ($00000008).w
[0000103a] 486b 01bc                 pea.l      444(a3)
[0000103e] 7e14                      moveq.l    #20,d7
[00001040] deac 0010                 add.l      16(a4),d7
[00001044] 2f07                      move.l     d7,-(a7)
[00001046] 4eb9 0000 0000            jsr        _movbuf
[0000104c] 4fef 000c                 lea.l      12(a7),a7
[00001050] 397c 9b2d 0154            move.w     #$9B2D,340(a4)
[00001056] 397c 0070 0156            move.w     #$0070,342(a4)
[0000105c] 2e2c 0018                 move.l     24(a4),d7
[00001060] deac 001c                 add.l      28(a4),d7
[00001064] beac 0020                 cmp.l      32(a4),d7
[00001068] 661c                      bne.s      _coreout_1
[0000106a] 226c 0010                 movea.l    16(a4),a1
[0000106e] 4aa9 0022                 tst.l      34(a1)
[00001072] 6612                      bne.s      _coreout_1
[00001074] 7001                      moveq.l    #1,d0
[00001076] 2d40 fffc                 move.l     d0,-4(a6)
[0000107a] 42ac 0158                 clr.l      344(a4)
[0000107e] 296c 001c 015c            move.l     28(a4),348(a4)
[00001084] 600e                      bra.s      _coreout_2
_coreout_1:
[00001086] 42ae fffc                 clr.l      -4(a6)
[0000108a] 296c 001c 0158            move.l     28(a4),344(a4)
[00001090] 42ac 015c                 clr.l      348(a4)
_coreout_2:
[00001094] 2e2c 0014                 move.l     20(a4),d7
[00001098] 9eac 0020                 sub.l      32(a4),d7
[0000109c] dfac 015c                 add.l      d7,348(a4)
[000010a0] 2e2d 0020                 move.l     32(a5),d7
[000010a4] 9eac 0014                 sub.l      20(a4),d7
[000010a8] 2947 0160                 move.l     d7,352(a4)
[000010ac] 2e2c 0020                 move.l     32(a4),d7
[000010b0] deac 0024                 add.l      36(a4),d7
[000010b4] 9ead 0020                 sub.l      32(a5),d7
[000010b8] 2947 0164                 move.l     d7,356(a4)
[000010bc] 296c 0018 0168            move.l     24(a4),360(a4)
[000010c2] 296c 0020 016c            move.l     32(a4),364(a4)
[000010c8] 42ac 0030                 clr.l      48(a4)
[000010cc] 43ec 0154                 lea.l      340(a4),a1
[000010d0] 2949 0028                 move.l     a1,40(a4)
[000010d4] 7070                      moveq.l    #112,d0
[000010d6] 2940 002c                 move.l     d0,44(a4)
[000010da] 197c 0001 0143            move.b     #$01,323(a4)
[000010e0] 2eae 0008                 move.l     8(a6),(a7)
[000010e4] 4eb9 0000 0000            jsr        _writei
[000010ea] 422c 0143                 clr.b      323(a4)
[000010ee] 4aae fffc                 tst.l      -4(a6)
[000010f2] 6706                      beq.s      _coreout_3
[000010f4] 2e2c 0018                 move.l     24(a4),d7
[000010f8] 6004                      bra.s      _coreout_4
_coreout_3:
[000010fa] 2e2c 0020                 move.l     32(a4),d7
_coreout_4:
[000010fe] 2947 0028                 move.l     d7,40(a4)
[00001102] 2e2c 015c                 move.l     348(a4),d7
[00001106] deac 0160                 add.l      352(a4),d7
[0000110a] deac 0164                 add.l      356(a4),d7
[0000110e] 2947 002c                 move.l     d7,44(a4)
[00001112] 2eae 0008                 move.l     8(a6),(a7)
[00001116] 4eb9 0000 0000            jsr        _writei
[0000111c] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00001120] 4e5e                      unlk       a6
[00001122] 4e75                      rts

_iflip:
[00001124] 4e56 0000                 link       a6,#0
[00001128] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000112c] 2a6e 0008                 movea.l    8(a6),a5
[00001130] 286e 000c                 movea.l    12(a6),a4
[00001134] 4878 0018                 pea.l      ($00000018).w
[00001138] 2f0c                      move.l     a4,-(a7)
[0000113a] 2f0d                      move.l     a5,-(a7)
[0000113c] 4eb9 0000 0000            jsr        _movbuf
[00001142] 4fef 000c                 lea.l      12(a7),a7
[00001146] 4878 000c                 pea.l      ($0000000C).w
[0000114a] 2f0c                      move.l     a4,-(a7)
[0000114c] 4eb9 0000 0466            jsr        _bflip
[00001152] 508f                      addq.l     #8,a7
[00001154] 4878 0002                 pea.l      ($00000002).w
[00001158] 486c 0002                 pea.l      2(a4)
[0000115c] 4eb9 0000 0466            jsr        _bflip
[00001162] 508f                      addq.l     #8,a7
[00001164] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001168] 4e5e                      unlk       a6
[0000116a] 4e75                      rts

_memcopy:
[0000116c] 4e56 0000                 link       a6,#0
[00001170] 48e7 8400                 movem.l    d0/d5,-(a7)
[00001174] 3a39 0000 1a1a            move.w     _xmemshft,d5
[0000117a] 48c5                      ext.l      d5
[0000117c] 2e2e 0010                 move.l     16(a6),d7
[00001180] eba7                      asl.l      d5,d7
[00001182] 2e87                      move.l     d7,(a7)
[00001184] 2e2e 000c                 move.l     12(a6),d7
[00001188] eba7                      asl.l      d5,d7
[0000118a] 2f07                      move.l     d7,-(a7)
[0000118c] 2e2e 0008                 move.l     8(a6),d7
[00001190] eba7                      asl.l      d5,d7
[00001192] 2f07                      move.l     d7,-(a7)
[00001194] 4eb9 0000 05be            jsr        __movmem
[0000119a] 508f                      addq.l     #8,a7
[0000119c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[000011a0] 4e5e                      unlk       a6
[000011a2] 4e75                      rts

_physio:
[000011a4] 4e56 fffc                 link       a6,#-4
[000011a8] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000011ac] 2a6e 000c                 movea.l    12(a6),a5
[000011b0] 2a2e 0014                 move.l     20(a6),d5
[000011b4] 2879 0000 18d6            movea.l    _pu,a4
[000011ba] 0805 000c                 btst       #12,d5
[000011be] 661c                      bne.s      _physio_1
[000011c0] 2eac 002c                 move.l     44(a4),(a7)
[000011c4] 2f2c 0028                 move.l     40(a4),-(a7)
[000011c8] 4eba fda2                 jsr        _chkbuf(pc)
[000011cc] 588f                      addq.l     #4,a7
[000011ce] 4a87                      tst.l      d7
[000011d0] 660a                      bne.s      _physio_1
[000011d2] 197c 000e 0142            move.b     #$0E,322(a4)
[000011d8] 6000 00a8                 bra        _physio_2
_physio_1:
[000011dc] 2e85                      move.l     d5,(a7)
[000011de] 2f0d                      move.l     a5,-(a7)
[000011e0] 4eb9 0000 13d4            jsr        _xbuy
[000011e6] 588f                      addq.l     #4,a7
[000011e8] 0805 000d                 btst       #13,d5
[000011ec] 6606                      bne.s      _physio_3
[000011ee] 08ed 0000 0010            bset       #0,16(a5)
_physio_3:
[000011f4] 3b6e 0012 0012            move.w     18(a6),18(a5)
[000011fa] 2b6c 002c 0024            move.l     44(a4),36(a5)
[00001200] 2eac 0028                 move.l     40(a4),(a7)
[00001204] 4eb9 0000 0000            jsr        _mapbuf
[0000120a] 2b47 0014                 move.l     d7,20(a5)
[0000120e] 2b6d 0014 0020            move.l     20(a5),32(a5)
[00001214] 2e2c 0030                 move.l     48(a4),d7
[00001218] 7c09                      moveq.l    #9,d6
[0000121a] eca7                      asr.l      d6,d7
[0000121c] 3b47 002c                 move.w     d7,44(a5)
[00001220] 2e2c 0030                 move.l     48(a4),d7
[00001224] 0287 0000 01ff            andi.l     #$000001FF,d7
[0000122a] 2b47 0028                 move.l     d7,40(a5)
[0000122e] 2b6c 0030 001c            move.l     48(a4),28(a5)
[00001234] 4878 0001                 pea.l      ($00000001).w
[00001238] 4eb9 0000 0000            jsr        _setlock
[0000123e] 588f                      addq.l     #4,a7
[00001240] 2d47 fffc                 move.l     d7,-4(a6)
[00001244] 2eae 0008                 move.l     8(a6),(a7)
[00001248] 2f0d                      move.l     a5,-(a7)
[0000124a] 4eb9 0000 144e            jsr        _xsell
[00001250] 588f                      addq.l     #4,a7
[00001252] 2eae fffc                 move.l     -4(a6),(a7)
[00001256] 4eb9 0000 0000            jsr        _setlock
[0000125c] 2e2c 002c                 move.l     44(a4),d7
[00001260] 9ead 0028                 sub.l      40(a5),d7
[00001264] dfac 0030                 add.l      d7,48(a4)
[00001268] 2e2c 002c                 move.l     44(a4),d7
[0000126c] 9ead 0028                 sub.l      40(a5),d7
[00001270] dfac 0028                 add.l      d7,40(a4)
[00001274] 296d 0028 002c            move.l     40(a5),44(a4)
[0000127a] 2e8d                      move.l     a5,(a7)
[0000127c] 4eb9 0000 0000            jsr        _errget
_physio_2:
[00001282] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001286] 4e5e                      unlk       a6
[00001288] 4e75                      rts

_swap:
[0000128a] 4e56 0000                 link       a6,#0
[0000128e] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001292] 2a7c 0000 1a42            movea.l    #_swapbuf,a5
_swap_5:
[00001298] 4aae 0010                 tst.l      16(a6)
[0000129c] 6700 00fc                 beq        _swap_1
[000012a0] 7e00                      moveq.l    #0,d7
[000012a2] 3e39 0000 0000            move.w     _smax,d7
[000012a8] 2e87                      move.l     d7,(a7)
[000012aa] 2f2e 0010                 move.l     16(a6),-(a7)
[000012ae] 4eb9 0000 0000            jsr        _minu
[000012b4] 588f                      addq.l     #4,a7
[000012b6] 2a07                      move.l     d7,d5
[000012b8] 2e85                      move.l     d5,(a7)
[000012ba] 2f2e 0008                 move.l     8(a6),-(a7)
[000012be] 7e00                      moveq.l    #0,d7
[000012c0] 3e39 0000 0000            move.w     _swapsiz,d7
[000012c6] 2f07                      move.l     d7,-(a7)
[000012c8] 7e00                      moveq.l    #0,d7
[000012ca] 3e39 0000 0000            move.w     _swapadr,d7
[000012d0] 2f07                      move.l     d7,-(a7)
[000012d2] 4eb9 0000 0000            jsr        _contain
[000012d8] 4fef 000c                 lea.l      12(a7),a7
[000012dc] 4a87                      tst.l      d7
[000012de] 6636                      bne.s      _swap_2
[000012e0] 2e85                      move.l     d5,(a7)
[000012e2] 2f2e 0008                 move.l     8(a6),-(a7)
[000012e6] 7e00                      moveq.l    #0,d7
[000012e8] 3e39 0000 0000            move.w     _swapsiz,d7
[000012ee] 2f07                      move.l     d7,-(a7)
[000012f0] 7e00                      moveq.l    #0,d7
[000012f2] 3e39 0000 0000            move.w     _swapadr,d7
[000012f8] 2f07                      move.l     d7,-(a7)
[000012fa] 2f3c 0000 1a70            move.l     #$0000315E,-(a7)
[00001300] 4eb9 0000 0000            jsr        _putfmt
[00001306] 4fef 0010                 lea.l      16(a7),a7
[0000130a] 2ebc 0000 1a94            move.l     #$00003182,(a7)
[00001310] 4eb9 0000 0000            jsr        _panic
_swap_2:
[00001316] 2eae 0014                 move.l     20(a6),(a7)
[0000131a] 2f0d                      move.l     a5,-(a7)
[0000131c] 4eb9 0000 13d4            jsr        _xbuy
[00001322] 588f                      addq.l     #4,a7
[00001324] 3b79 0000 0000 0012       move.w     _swapdev,18(a5)
[0000132c] 2e05                      move.l     d5,d7
[0000132e] 7c09                      moveq.l    #9,d6
[00001330] eda7                      asl.l      d6,d7
[00001332] 2b47 0024                 move.l     d7,36(a5)
[00001336] 2e2e 000c                 move.l     12(a6),d7
[0000133a] 7c09                      moveq.l    #9,d6
[0000133c] eda7                      asl.l      d6,d7
[0000133e] 2b47 0014                 move.l     d7,20(a5)
[00001342] 2b6d 0014 0020            move.l     20(a5),32(a5)
[00001348] 42ad 0028                 clr.l      40(a5)
[0000134c] 3b6e 000a 002c            move.w     10(a6),44(a5)
[00001352] 2e2e 0008                 move.l     8(a6),d7
[00001356] 7c09                      moveq.l    #9,d6
[00001358] eda7                      asl.l      d6,d7
[0000135a] 2b47 001c                 move.l     d7,28(a5)
[0000135e] 7e00                      moveq.l    #0,d7
[00001360] 3e39 0000 0000            move.w     _swapdev,d7
[00001366] e087                      asr.l      #8,d7
[00001368] e587                      asl.l      #2,d7
[0000136a] 2247                      movea.l    d7,a1
[0000136c] d3fc 0000 0000            adda.l     #_blkdevs,a1
[00001372] 2251                      movea.l    (a1),a1
[00001374] 2ea9 0008                 move.l     8(a1),(a7)
[00001378] 2f0d                      move.l     a5,-(a7)
[0000137a] 4eb9 0000 144e            jsr        _xsell
[00001380] 588f                      addq.l     #4,a7
[00001382] 4a87                      tst.l      d7
[00001384] 6704                      beq.s      _swap_3
[00001386] 7e01                      moveq.l    #1,d7
[00001388] 6012                      bra.s      _swap_4
_swap_3:
[0000138a] dbae 0008                 add.l      d5,8(a6)
[0000138e] dbae 000c                 add.l      d5,12(a6)
[00001392] 9bae 0010                 sub.l      d5,16(a6)
[00001396] 6000 ff00                 bra        _swap_5
_swap_1:
[0000139a] 7e00                      moveq.l    #0,d7
_swap_4:
[0000139c] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000013a0] 4e5e                      unlk       a6
[000013a2] 4e75                      rts

_tflip:
[000013a4] 4e56 fffc                 link       a6,#-4
[000013a8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000013ac] 43ee 0008                 lea.l      8(a6),a1
[000013b0] 2a49                      movea.l    a1,a5
[000013b2] 1d6d 0001 fffc            move.b     1(a5),-4(a6)
[000013b8] 1d55 fffd                 move.b     (a5),-3(a6)
[000013bc] 1d6d 0003 fffe            move.b     3(a5),-2(a6)
[000013c2] 1d6d 0002 ffff            move.b     2(a5),-1(a6)
[000013c8] 2e2e fffc                 move.l     -4(a6),d7
[000013cc] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000013d0] 4e5e                      unlk       a6
[000013d2] 4e75                      rts

_xbuy:
[000013d4] 4e56 0000                 link       a6,#0
[000013d8] 48e7 8004                 movem.l    d0/a5,-(a7)
[000013dc] 2a6e 0008                 movea.l    8(a6),a5
[000013e0] 7e00                      moveq.l    #0,d7
[000013e2] 3e39 0000 0000            move.w     _biops,d7
[000013e8] 2e87                      move.l     d7,(a7)
[000013ea] 4eb9 0000 0426            jsr        _spl
_xbuy_2:
[000013f0] 082d 0001 0011            btst       #1,17(a5)
[000013f6] 670a                      beq.s      _xbuy_1
[000013f8] 2e8d                      move.l     a5,(a7)
[000013fa] 4eb9 0000 0000            jsr        _sleepb
[00001400] 60ee                      bra.s      _xbuy_2
_xbuy_1:
[00001402] 2e2e 000c                 move.l     12(a6),d7
[00001406] 08c7 0001                 bset       #1,d7
[0000140a] 3b47 0010                 move.w     d7,16(a5)
[0000140e] 4eb9 0000 045e            jsr        _permit
[00001414] 2e0d                      move.l     a5,d7
[00001416] 4cdf 2001                 movem.l    (a7)+,d0/a5
[0000141a] 4e5e                      unlk       a6
[0000141c] 4e75                      rts

_xfetch:
[0000141e] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[00001422] 2a79 0000 18d6            movea.l    _pu,a5
[00001428] 4aad 002c                 tst.l      44(a5)
[0000142c] 6604                      bne.s      _xfetch_1
[0000142e] 7eff                      moveq.l    #-1,d7
[00001430] 6016                      bra.s      _xfetch_2
_xfetch_1:
[00001432] 2ead 0028                 move.l     40(a5),(a7)
[00001436] 4eb9 0000 04e0            jsr        _inbyte
[0000143c] 2a07                      move.l     d7,d5
[0000143e] 52ad 0028                 addq.l     #1,40(a5)
[00001442] 53ad 002c                 subq.l     #1,44(a5)
[00001446] 2e05                      move.l     d5,d7
_xfetch_2:
[00001448] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000144c] 4e75                      rts

_xsell:
[0000144e] 4e56 0000                 link       a6,#0
[00001452] 48e7 8004                 movem.l    d0/a5,-(a7)
[00001456] 2a6e 0008                 movea.l    8(a6),a5
[0000145a] 2e8d                      move.l     a5,(a7)
[0000145c] 226e 000c                 movea.l    12(a6),a1
[00001460] 4e91                      jsr        (a1)
[00001462] 7e00                      moveq.l    #0,d7
[00001464] 3e39 0000 0000            move.w     _biops,d7
[0000146a] 2e87                      move.l     d7,(a7)
[0000146c] 4eb9 0000 0426            jsr        _spl
_xsell_2:
[00001472] 082d 0006 0011            btst       #6,17(a5)
[00001478] 660a                      bne.s      _xsell_1
[0000147a] 2e8d                      move.l     a5,(a7)
[0000147c] 4eb9 0000 0000            jsr        _sleepb
[00001482] 60ee                      bra.s      _xsell_2
_xsell_1:
[00001484] 08ad 0001 0011            bclr       #1,17(a5)
[0000148a] 4eb9 0000 045e            jsr        _permit
[00001490] 2e8d                      move.l     a5,(a7)
[00001492] 4eb9 0000 0000            jsr        _wakeb
[00001498] 7e08                      moveq.l    #8,d7
[0000149a] 7c00                      moveq.l    #0,d6
[0000149c] 3c2d 0010                 move.w     16(a5),d6
[000014a0] ce86                      and.l      d6,d7
[000014a2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000014a6] 4e5e                      unlk       a6
[000014a8] 4e75                      rts

_xsetch:
[000014aa] 4e56 0000                 link       a6,#0
[000014ae] 48e7 8004                 movem.l    d0/a5,-(a7)
[000014b2] 2a79 0000 18d6            movea.l    _pu,a5
[000014b8] 4aad 002c                 tst.l      44(a5)
[000014bc] 6604                      bne.s      _xsetch_1
[000014be] 7eff                      moveq.l    #-1,d7
[000014c0] 6020                      bra.s      _xsetch_2
_xsetch_1:
[000014c2] 2eae 0008                 move.l     8(a6),(a7)
[000014c6] 2f2d 0028                 move.l     40(a5),-(a7)
[000014ca] 4eb9 0000 051e            jsr        _outbyte
[000014d0] 588f                      addq.l     #4,a7
[000014d2] 52ad 0028                 addq.l     #1,40(a5)
[000014d6] 53ad 002c                 subq.l     #1,44(a5)
[000014da] 6704                      beq.s      _xsetch_3
[000014dc] 7e00                      moveq.l    #0,d7
[000014de] 6002                      bra.s      _xsetch_2
_xsetch_3:
[000014e0] 7eff                      moveq.l    #-1,d7
_xsetch_2:
[000014e2] 4cdf 2001                 movem.l    (a7)+,d0/a5
[000014e6] 4e5e                      unlk       a6
[000014e8] 4e75                      rts

_clock:
[000014ea] 4e56 fffc                 link       a6,#-4
[000014ee] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000014f2] 43ee 002c                 lea.l      44(a6),a1
[000014f6] 2a49                      movea.l    a1,a5
[000014f8] 2879 0000 18d6            movea.l    _pu,a4
[000014fe] 082d 0005 0004            btst       #5,4(a5)
[00001504] 6604                      bne.s      _clock_1
[00001506] 7e01                      moveq.l    #1,d7
[00001508] 6002                      bra.s      _clock_2
_clock_1:
[0000150a] 7e00                      moveq.l    #0,d7
_clock_2:
[0000150c] 2d47 fffc                 move.l     d7,-4(a6)
[00001510] 2e39 0000 0000            move.l     _tinc,d7
[00001516] dfb9 0000 1c56            add.l      d7,$00003344
[0000151c] 2e39 0000 1c56            move.l     $00003344,d7
[00001522] 7c0b                      moveq.l    #11,d6
[00001524] ecaf                      lsr.l      d6,d7
[00001526] 2a07                      move.l     d7,d5
[00001528] 02b9 0000 07ff 0000 1c56  andi.l     #$000007FF,$00003344
[00001532] 4a85                      tst.l      d5
[00001534] 674a                      beq.s      _clock_3
[00001536] 4aae fffc                 tst.l      -4(a6)
[0000153a] 6722                      beq.s      _clock_4
[0000153c] 2e2c 0014                 move.l     20(a4),d7
[00001540] deb9 0000 0000            add.l      _lo_chk,d7
[00001546] 2c2e 0028                 move.l     40(a6),d6
[0000154a] bc87                      cmp.l      d7,d6
[0000154c] 6410                      bcc.s      _clock_4
[0000154e] 4878 000b                 pea.l      ($0000000B).w
[00001552] 2f2c 0010                 move.l     16(a4),-(a7)
[00001556] 4eb9 0000 0000            jsr        _sendsig
[0000155c] 508f                      addq.l     #8,a7
_clock_4:
[0000155e] 2ead 0006                 move.l     6(a5),(a7)
[00001562] 2f05                      move.l     d5,-(a7)
[00001564] 7e00                      moveq.l    #0,d7
[00001566] 3e2d 0004                 move.w     4(a5),d7
[0000156a] 0287 0000 0700            andi.l     #$00000700,d7
[00001570] 2f07                      move.l     d7,-(a7)
[00001572] 2f2e fffc                 move.l     -4(a6),-(a7)
[00001576] 4eb9 0000 0000            jsr        _tick
[0000157c] 4fef 000c                 lea.l      12(a7),a7
_clock_3:
[00001580] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001584] 4e5e                      unlk       a6
[00001586] 4e75                      rts

_sprint:
[00001588] 4e56 fffc                 link       a6,#-4
[0000158c] 2eae 0008                 move.l     8(a6),(a7)
[00001590] 2f3c 0000 1c5a            move.l     #$00003348,-(a7)
[00001596] 4eb9 0000 0000            jsr        _putfmt
[0000159c] 588f                      addq.l     #4,a7
[0000159e] 4e5e                      unlk       a6
[000015a0] 4e75                      rts

_trap:
[000015a2] 4e56 0000                 link       a6,#0
[000015a6] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[000015aa] 2a2e 0008                 move.l     8(a6),d5
[000015ae] 43ee 002c                 lea.l      44(a6),a1
[000015b2] 43e9 0004                 lea.l      4(a1),a1
[000015b6] 2a49                      movea.l    a1,a5
[000015b8] 2879 0000 18d6            movea.l    _pu,a4
[000015be] 43ec 0144                 lea.l      324(a4),a1
[000015c2] 2649                      movea.l    a1,a3
[000015c4] 0815 0005                 btst       #5,(a5)
[000015c8] 6722                      beq.s      _trap_1
[000015ca] 2e2e 0008                 move.l     8(a6),d7
[000015ce] 4487                      neg.l      d7
[000015d0] 2e87                      move.l     d7,(a7)
[000015d2] 2f3c 0000 1c73            move.l     #$00003361,-(a7)
[000015d8] 4eb9 0000 0000            jsr        _putfmt
[000015de] 588f                      addq.l     #4,a7
[000015e0] 2ebc 0000 1c7f            move.l     #$0000336D,(a7)
[000015e6] 4eb9 0000 0000            jsr        _panic
_trap_1:
[000015ec] 2e2c 0014                 move.l     20(a4),d7
[000015f0] deb9 0000 0000            add.l      _lo_chk,d7
[000015f6] 2c2e 0028                 move.l     40(a6),d6
[000015fa] bc87                      cmp.l      d7,d6
[000015fc] 6402                      bcc.s      _trap_2
[000015fe] 7af5                      moveq.l    #-11,d5
_trap_2:
[00001600] 0c85 ffff ffee            cmpi.l     #$FFFFFFEE,d5
[00001606] 6f0e                      ble.s      _trap_3
[00001608] 4a85                      tst.l      d5
[0000160a] 6c0a                      bge.s      _trap_3
[0000160c] 2e05                      move.l     d5,d7
[0000160e] 4487                      neg.l      d7
[00001610] 2807                      move.l     d7,d4
[00001612] 6000 0098                 bra        _trap_4
_trap_3:
[00001616] 0c85 0000 0058            cmpi.l     #$00000058,d5
[0000161c] 6508                      bcs.s      _trap_5
[0000161e] 197c 0023 0142            move.b     #$23,322(a4)
[00001624] 6052                      bra.s      _trap_6
_trap_5:
[00001626] 08ad 0000 0001            bclr       #0,1(a5)
[0000162c] 422c 0142                 clr.b      322(a4)
[00001630] 227c 0000 1a9e            movea.l    #_sycount,a1
[00001636] 7600                      moveq.l    #0,d3
[00001638] 1631 5800                 move.b     0(a1,d5.l),d3
[0000163c] 2e03                      move.l     d3,d7
[0000163e] e487                      asr.l      #2,d7
[00001640] 2e87                      move.l     d7,(a7)
[00001642] 2f0b                      move.l     a3,-(a7)
[00001644] 2f2e 0028                 move.l     40(a6),-(a7)
[00001648] 4eb9 0000 05a4            jsr        _inbuf
[0000164e] 508f                      addq.l     #8,a7
[00001650] 2eac 0008                 move.l     8(a4),(a7)
[00001654] 4eb9 0000 039c            jsr        _setjmp
[0000165a] 4a87                      tst.l      d7
[0000165c] 6708                      beq.s      _trap_7
[0000165e] 197c 0004 0142            move.b     #$04,322(a4)
[00001664] 6012                      bra.s      _trap_6
_trap_7:
[00001666] 2e8b                      move.l     a3,(a7)
[00001668] 2e05                      move.l     d5,d7
[0000166a] e587                      asl.l      #2,d7
[0000166c] 2247                      movea.l    d7,a1
[0000166e] d3fc 0000 1af6            adda.l     #_syfun,a1
[00001674] 2251                      movea.l    (a1),a1
[00001676] 4e91                      jsr        (a1)
_trap_6:
[00001678] 7800                      moveq.l    #0,d4
[0000167a] 4a2c 0142                 tst.b      322(a4)
[0000167e] 6716                      beq.s      _trap_8
[00001680] 08ed 0000 0001            bset       #0,1(a5)
[00001686] 1e2c 0142                 move.b     322(a4),d7
[0000168a] 4887                      ext.w      d7
[0000168c] 48c7                      ext.l      d7
[0000168e] 4487                      neg.l      d7
[00001690] 2d47 0018                 move.l     d7,24(a6)
[00001694] 6016                      bra.s      _trap_4
_trap_8:
[00001696] 7e03                      moveq.l    #3,d7
[00001698] ce03                      and.b      d3,d7
[0000169a] 0287 0000 00ff            andi.l     #$000000FF,d7
[000016a0] 6706                      beq.s      _trap_9
[000016a2] 2d53 0018                 move.l     (a3),24(a6)
[000016a6] 6004                      bra.s      _trap_4
_trap_9:
[000016a8] 42ae 0018                 clr.l      24(a6)
_trap_4:
[000016ac] 4a84                      tst.l      d4
[000016ae] 670e                      beq.s      _trap_10
[000016b0] 2e84                      move.l     d4,(a7)
[000016b2] 2f2c 0010                 move.l     16(a4),-(a7)
[000016b6] 4eb9 0000 0000            jsr        _sendsig
[000016bc] 588f                      addq.l     #4,a7
_trap_10:
[000016be] 2e2e 0028                 move.l     40(a6),d7
[000016c2] 9eac 0014                 sub.l      20(a4),d7
[000016c6] 2a07                      move.l     d7,d5
[000016c8] 43f8 0022                 lea.l      ($00000022).w,a1
[000016cc] d3ec 0010                 adda.l     16(a4),a1
[000016d0] baa9 0014                 cmp.l      20(a1),d5
[000016d4] 640c                      bcc.s      _trap_11
[000016d6] 43f8 0022                 lea.l      ($00000022).w,a1
[000016da] d3ec 0010                 adda.l     16(a4),a1
[000016de] 2345 0014                 move.l     d5,20(a1)
_trap_11:
[000016e2] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000016e6] 4e5e                      unlk       a6
[000016e8] 4e75                      rts

_xtrns:
[000016ea] 4e75                      rts

_xusrsvc:
[000016ec] 4e75                      rts

	.data
[000016ee]                           dc.b $00
[000016ef]                           dc.b $00
[000016f0]                           dc.b $00
[000016f1]                           dc.b $00
[000016f2]                           dc.b $00
[000016f3]                           dc.b $00
[000016f4]                           dc.b $00
[000016f5]                           dc.b $00
[000016f6]                           dc.b $00
[000016f7]                           dc.b $00
[000016f8]                           dc.b $00
[000016f9]                           dc.b $00
[000016fa]                           dc.b $00
[000016fb]                           dc.b $00
[000016fc]                           dc.b $00
[000016fd]                           dc.b $00
[000016fe]                           dc.b $00
[000016ff]                           dc.b $00
[00001700]                           dc.b $00
[00001701]                           dc.b $00
[00001702]                           dc.b $00
[00001703]                           dc.b $00
[00001704]                           dc.b $00
[00001705]                           dc.b $00
[00001706]                           dc.b $00
[00001707]                           dc.b $00
[00001708]                           dc.b $00
[00001709]                           dc.b $00
[0000170a]                           dc.b $00
[0000170b]                           dc.b $00
[0000170c]                           dc.b $00
[0000170d]                           dc.b $00
[0000170e]                           dc.b $00
[0000170f]                           dc.b $00
[00001710]                           dc.b $00
[00001711]                           dc.b $00
[00001712]                           dc.b $00
[00001713]                           dc.b $00
[00001714]                           dc.b $00
[00001715]                           dc.b $00
[00001716]                           dc.b $00
[00001717]                           dc.b $00
[00001718]                           dc.b $00
[00001719]                           dc.b $00
[0000171a]                           dc.b $00
[0000171b]                           dc.b $00
[0000171c]                           dc.b $00
[0000171d]                           dc.b $00
[0000171e]                           dc.b $00
[0000171f]                           dc.b $00
[00001720]                           dc.b $00
[00001721]                           dc.b $00
[00001722]                           dc.b $00
[00001723]                           dc.b $00
[00001724]                           dc.b $00
[00001725]                           dc.b $00
[00001726]                           dc.b $00
[00001727]                           dc.b $00
[00001728]                           dc.b $00
[00001729]                           dc.b $00
[0000172a]                           dc.b $00
[0000172b]                           dc.b $00
[0000172c]                           dc.b $00
[0000172d]                           dc.b $00
[0000172e]                           dc.b $00
[0000172f]                           dc.b $00
[00001730]                           dc.b $00
[00001731]                           dc.b $00
[00001732]                           dc.b $00
[00001733]                           dc.b $00
[00001734]                           dc.b $00
[00001735]                           dc.b $00
[00001736]                           dc.b $00
[00001737]                           dc.b $00
[00001738]                           dc.b $00
[00001739]                           dc.b $00
[0000173a]                           dc.b $00
[0000173b]                           dc.b $00
[0000173c]                           dc.b $00
[0000173d]                           dc.b $00
[0000173e]                           dc.b $00
[0000173f]                           dc.b $00
[00001740]                           dc.b $00
[00001741]                           dc.b $00
[00001742]                           dc.b $00
[00001743]                           dc.b $00
[00001744]                           dc.b $00
[00001745]                           dc.b $00
[00001746]                           dc.b $00
[00001747]                           dc.b $00
[00001748]                           dc.b $00
[00001749]                           dc.b $00
[0000174a]                           dc.b $00
[0000174b]                           dc.b $00
[0000174c]                           dc.b $00
[0000174d]                           dc.b $00
[0000174e]                           dc.b $00
[0000174f]                           dc.b $00
[00001750]                           dc.b $00
[00001751]                           dc.b $00
[00001752]                           dc.b $00
[00001753]                           dc.b $00
[00001754]                           dc.b $00
[00001755]                           dc.b $00
[00001756]                           dc.b $00
[00001757]                           dc.b $00
[00001758]                           dc.b $00
[00001759]                           dc.b $00
[0000175a]                           dc.b $00
[0000175b]                           dc.b $00
[0000175c]                           dc.b $00
[0000175d]                           dc.b $00
[0000175e]                           dc.b $00
[0000175f]                           dc.b $00
[00001760]                           dc.b $00
[00001761]                           dc.b $00
[00001762]                           dc.b $00
[00001763]                           dc.b $00
[00001764]                           dc.b $00
[00001765]                           dc.b $00
[00001766]                           dc.b $00
[00001767]                           dc.b $00
[00001768]                           dc.b $00
[00001769]                           dc.b $00
[0000176a]                           dc.b $00
[0000176b]                           dc.b $00
[0000176c]                           dc.b $00
[0000176d]                           dc.b $00
[0000176e]                           dc.b $00
[0000176f]                           dc.b $00
[00001770]                           dc.b $00
[00001771]                           dc.b $00
[00001772]                           dc.b $00
[00001773]                           dc.b $00
[00001774]                           dc.b $00
[00001775]                           dc.b $00
[00001776]                           dc.b $00
[00001777]                           dc.b $00
[00001778]                           dc.b $00
[00001779]                           dc.b $00
[0000177a]                           dc.b $00
[0000177b]                           dc.b $00
[0000177c]                           dc.b $00
[0000177d]                           dc.b $00
[0000177e]                           dc.b $00
[0000177f]                           dc.b $00
[00001780]                           dc.b $00
[00001781]                           dc.b $00
[00001782]                           dc.b $00
[00001783]                           dc.b $00
[00001784]                           dc.b $00
[00001785]                           dc.b $00
[00001786]                           dc.b $00
[00001787]                           dc.b $00
[00001788]                           dc.b $00
[00001789]                           dc.b $00
[0000178a]                           dc.b $00
[0000178b]                           dc.b $00
[0000178c]                           dc.b $00
[0000178d]                           dc.b $00
[0000178e]                           dc.b $00
[0000178f]                           dc.b $00
[00001790]                           dc.b $00
[00001791]                           dc.b $00
[00001792]                           dc.b $00
[00001793]                           dc.b $00
[00001794]                           dc.b $00
[00001795]                           dc.b $00
[00001796]                           dc.b $00
[00001797]                           dc.b $00
[00001798]                           dc.b $00
[00001799]                           dc.b $00
[0000179a]                           dc.b $00
[0000179b]                           dc.b $00
[0000179c]                           dc.b $00
[0000179d]                           dc.b $00
[0000179e]                           dc.b $00
[0000179f]                           dc.b $00
[000017a0]                           dc.b $00
[000017a1]                           dc.b $00
[000017a2]                           dc.b $00
[000017a3]                           dc.b $00
[000017a4]                           dc.b $00
[000017a5]                           dc.b $00
[000017a6]                           dc.b $00
[000017a7]                           dc.b $00
[000017a8]                           dc.b $00
[000017a9]                           dc.b $00
[000017aa]                           dc.b $00
[000017ab]                           dc.b $00
[000017ac]                           dc.b $00
[000017ad]                           dc.b $00
[000017ae]                           dc.b $00
[000017af]                           dc.b $00
[000017b0]                           dc.b $00
[000017b1]                           dc.b $00
[000017b2]                           dc.b $00
[000017b3]                           dc.b $00
[000017b4]                           dc.b $00
[000017b5]                           dc.b $00
[000017b6]                           dc.b $00
[000017b7]                           dc.b $00
[000017b8]                           dc.b $00
[000017b9]                           dc.b $00
[000017ba]                           dc.b $00
[000017bb]                           dc.b $00
[000017bc]                           dc.b $00
[000017bd]                           dc.b $00
[000017be]                           dc.b $00
[000017bf]                           dc.b $00
[000017c0]                           dc.b $00
[000017c1]                           dc.b $00
[000017c2]                           dc.b $00
[000017c3]                           dc.b $00
[000017c4]                           dc.b $00
[000017c5]                           dc.b $00
[000017c6]                           dc.b $00
[000017c7]                           dc.b $00
[000017c8]                           dc.b $00
[000017c9]                           dc.b $00
[000017ca]                           dc.b $00
[000017cb]                           dc.b $00
[000017cc]                           dc.b $00
[000017cd]                           dc.b $00
[000017ce]                           dc.b $00
[000017cf]                           dc.b $00
[000017d0]                           dc.b $00
[000017d1]                           dc.b $00
[000017d2]                           dc.b $00
[000017d3]                           dc.b $00
[000017d4]                           dc.b $00
[000017d5]                           dc.b $00
[000017d6]                           dc.b $00
[000017d7]                           dc.b $00
[000017d8]                           dc.b $00
[000017d9]                           dc.b $00
[000017da]                           dc.b $00
[000017db]                           dc.b $00
[000017dc]                           dc.b $00
[000017dd]                           dc.b $00
[000017de]                           dc.b $00
[000017df]                           dc.b $00
[000017e0]                           dc.b $00
[000017e1]                           dc.b $00
[000017e2]                           dc.b $00
[000017e3]                           dc.b $00
[000017e4]                           dc.b $00
[000017e5]                           dc.b $00
[000017e6]                           dc.b $00
[000017e7]                           dc.b $00
[000017e8]                           dc.b $00
[000017e9]                           dc.b $00
[000017ea]                           dc.b $00
[000017eb]                           dc.b $00
[000017ec]                           dc.b $00
[000017ed]                           dc.b $00
[000017ee]                           dc.b $00
[000017ef]                           dc.b $00
[000017f0]                           dc.b $00
[000017f1]                           dc.b $00
[000017f2]                           dc.b $00
[000017f3]                           dc.b $00
[000017f4]                           dc.b $00
[000017f5]                           dc.b $00
[000017f6]                           dc.b $00
[000017f7]                           dc.b $00
[000017f8]                           dc.b $00
[000017f9]                           dc.b $00
[000017fa]                           dc.b $00
[000017fb]                           dc.b $00
[000017fc]                           dc.b $00
[000017fd]                           dc.b $00
[000017fe]                           dc.b $00
[000017ff]                           dc.b $00
[00001800]                           dc.b $00
[00001801]                           dc.b $00
[00001802]                           dc.b $00
[00001803]                           dc.b $00
[00001804]                           dc.b $00
[00001805]                           dc.b $00
[00001806]                           dc.b $00
[00001807]                           dc.b $00
[00001808]                           dc.b $00
[00001809]                           dc.b $00
[0000180a]                           dc.b $00
[0000180b]                           dc.b $00
[0000180c]                           dc.b $00
[0000180d]                           dc.b $00
[0000180e]                           dc.b $00
[0000180f]                           dc.b $00
[00001810]                           dc.b $00
[00001811]                           dc.b $00
[00001812]                           dc.b $00
[00001813]                           dc.b $00
[00001814]                           dc.b $00
[00001815]                           dc.b $00
[00001816]                           dc.b $00
[00001817]                           dc.b $00
[00001818]                           dc.b $00
[00001819]                           dc.b $00
[0000181a]                           dc.b $00
[0000181b]                           dc.b $00
[0000181c]                           dc.b $00
[0000181d]                           dc.b $00
[0000181e]                           dc.b $00
[0000181f]                           dc.b $00
[00001820]                           dc.b $00
[00001821]                           dc.b $00
[00001822]                           dc.b $00
[00001823]                           dc.b $00
[00001824]                           dc.b $00
[00001825]                           dc.b $00
[00001826]                           dc.b $00
[00001827]                           dc.b $00
[00001828]                           dc.b $00
[00001829]                           dc.b $00
[0000182a]                           dc.b $00
[0000182b]                           dc.b $00
[0000182c]                           dc.b $00
[0000182d]                           dc.b $00
[0000182e]                           dc.b $00
[0000182f]                           dc.b $00
[00001830]                           dc.b $00
[00001831]                           dc.b $00
[00001832]                           dc.b $00
[00001833]                           dc.b $00
[00001834]                           dc.b $00
[00001835]                           dc.b $00
[00001836]                           dc.b $00
[00001837]                           dc.b $00
[00001838]                           dc.b $00
[00001839]                           dc.b $00
[0000183a]                           dc.b $00
[0000183b]                           dc.b $00
[0000183c]                           dc.b $00
[0000183d]                           dc.b $00
[0000183e]                           dc.b $00
[0000183f]                           dc.b $00
[00001840]                           dc.b $00
[00001841]                           dc.b $00
[00001842]                           dc.b $00
[00001843]                           dc.b $00
[00001844]                           dc.b $00
[00001845]                           dc.b $00
[00001846]                           dc.b $00
[00001847]                           dc.b $00
[00001848]                           dc.b $00
[00001849]                           dc.b $00
[0000184a]                           dc.b $00
[0000184b]                           dc.b $00
[0000184c]                           dc.b $00
[0000184d]                           dc.b $00
[0000184e]                           dc.b $00
[0000184f]                           dc.b $00
[00001850]                           dc.b $00
[00001851]                           dc.b $00
[00001852]                           dc.b $00
[00001853]                           dc.b $00
[00001854]                           dc.b $00
[00001855]                           dc.b $00
[00001856]                           dc.b $00
[00001857]                           dc.b $00
[00001858]                           dc.b $00
[00001859]                           dc.b $00
[0000185a]                           dc.b $00
[0000185b]                           dc.b $00
[0000185c]                           dc.b $00
[0000185d]                           dc.b $00
[0000185e]                           dc.b $00
[0000185f]                           dc.b $00
[00001860]                           dc.b $00
[00001861]                           dc.b $00
[00001862]                           dc.b $00
[00001863]                           dc.b $00
[00001864]                           dc.b $00
[00001865]                           dc.b $00
[00001866]                           dc.b $00
[00001867]                           dc.b $00
[00001868]                           dc.b $00
[00001869]                           dc.b $00
[0000186a]                           dc.b $00
[0000186b]                           dc.b $00
[0000186c]                           dc.b $00
[0000186d]                           dc.b $00
[0000186e]                           dc.b $00
[0000186f]                           dc.b $00
[00001870]                           dc.b $00
[00001871]                           dc.b $00
[00001872]                           dc.b $00
[00001873]                           dc.b $00
[00001874]                           dc.b $00
[00001875]                           dc.b $00
[00001876]                           dc.b $00
[00001877]                           dc.b $00
[00001878]                           dc.b $00
[00001879]                           dc.b $00
[0000187a]                           dc.b $00
[0000187b]                           dc.b $00
[0000187c]                           dc.b $00
[0000187d]                           dc.b $00
[0000187e]                           dc.b $00
[0000187f]                           dc.b $00
[00001880]                           dc.b $00
[00001881]                           dc.b $00
[00001882]                           dc.b $00
[00001883]                           dc.b $00
[00001884]                           dc.b $00
[00001885]                           dc.b $00
[00001886]                           dc.b $00
[00001887]                           dc.b $00
[00001888]                           dc.b $00
[00001889]                           dc.b $00
[0000188a]                           dc.b $00
[0000188b]                           dc.b $00
[0000188c]                           dc.b $00
[0000188d]                           dc.b $00
[0000188e]                           dc.b $00
[0000188f]                           dc.b $00
[00001890]                           dc.b $00
[00001891]                           dc.b $00
[00001892]                           dc.b $00
[00001893]                           dc.b $00
[00001894]                           dc.b $00
[00001895]                           dc.b $00
[00001896]                           dc.b $00
[00001897]                           dc.b $00
[00001898]                           dc.b $00
[00001899]                           dc.b $00
[0000189a]                           dc.b $00
[0000189b]                           dc.b $00
[0000189c]                           dc.b $00
[0000189d]                           dc.b $00
[0000189e]                           dc.b $00
[0000189f]                           dc.b $00
[000018a0]                           dc.b $00
[000018a1]                           dc.b $00
[000018a2]                           dc.b $00
[000018a3]                           dc.b $00
[000018a4]                           dc.b $00
[000018a5]                           dc.b $00
[000018a6]                           dc.b $00
[000018a7]                           dc.b $00
[000018a8]                           dc.b $00
[000018a9]                           dc.b $00
[000018aa]                           dc.b $00
[000018ab]                           dc.b $00
[000018ac]                           dc.b $00
[000018ad]                           dc.b $00
[000018ae]                           dc.b $00
[000018af]                           dc.b $00
[000018b0]                           dc.b $00
[000018b1]                           dc.b $00
[000018b2]                           dc.b $00
[000018b3]                           dc.b $00
[000018b4]                           dc.b $00
[000018b5]                           dc.b $00
[000018b6]                           dc.b $00
[000018b7]                           dc.b $00
[000018b8]                           dc.b $00
[000018b9]                           dc.b $00
[000018ba]                           dc.b $00
[000018bb]                           dc.b $00
[000018bc]                           dc.b $00
[000018bd]                           dc.b $00
[000018be]                           dc.b $00
[000018bf]                           dc.b $00
[000018c0]                           dc.b $00
[000018c1]                           dc.b $00
[000018c2]                           dc.b $00
[000018c3]                           dc.b $00
[000018c4]                           dc.b $00
[000018c5]                           dc.b $00
[000018c6]                           dc.b $00
[000018c7]                           dc.b $00
[000018c8]                           dc.b $00
[000018c9]                           dc.b $00
[000018ca]                           dc.b $00
[000018cb]                           dc.b $00
[000018cc]                           dc.b $00
[000018cd]                           dc.b $00
[000018ce]                           dc.b $00
[000018cf]                           dc.b $00
[000018d0]                           dc.b $00
[000018d1]                           dc.b $00
[000018d2]                           dc.b $00
[000018d3]                           dc.b $00
[000018d4]                           dc.b $00
[000018d5]                           dc.b $00
[000018d6] 00001766                  dc.l $00001766 ; no symbol found
[000018da]                           dc.b 'Idris/68K V3.12 Mon Nov 09, 1987, 16:17',$0a,0
[00001903]                           dc.b 'copyright (c) 1979, 1986 by Whitesmiths, Ltd.',$0a,0
[00001932]                           dc.b 'no ',0
[00001936]                           dc.b 'mmu, system size %i.%iKB',$0a,0
[00001950]                           dc.b '<SWAP>',0
[00001957]                           dc.b '%i.%iKB largest process size, ',0
[00001976]                           dc.b '%i.%iKB user space',0
[00001989]                           dc.b ', %i system buffers',$0a,0
[0000199e]                           dc.b 'floating point unit present',$0a,0
[000019bb]                           dc.b $00
[000019bc]                           dc.b ' is read only',0
[000019ca]                           dc.b ' root filesystem%p',$0a,0
[000019de]                           dc.b 'no swapping',$0a,0
[000019eb]                           dc.b '%i.%iKB swap space',$0a,0
[000019ff]                           dc.b '%p',$0a,0
[00001a03]                           dc.b 'no proc1',0
[00001a0c]                           dc.b $00
[00001a0d]                           dc.b $ff
[00001a0e]                           dc.w $fffc
[00001a10]                           dc.w $9800
[00001a12]                           dc.w $ff00
[00001a14]                           dc.w $9828
[00001a16]                           dc.w $fe78
[00001a18]                           dc.w $01ff
[00001a1a]                           dc.b $00
[00001a1b]                           dc.b $09
[00001a1c]                           dc.b $00
[00001a1d]                           dc.b $80
[00001a1e]                           dc.b $00
[00001a1f]                           dc.b $00
[00001a20]                           dc.b $00
[00001a21]                           dc.b $00
[00001a22]                           dc.b $00
[00001a23]                           dc.b $01
[00001a24]                           dc.b $00
[00001a25]                           dc.b $00
[00001a26]                           dc.b $00
[00001a27]                           dc.b $00
[00001a28]                           dc.b $00
[00001a29]                           dc.b $00
[00001a2a]                           dc.b $00
[00001a2b]                           dc.b $00
[00001a2c]                           dc.b $00
[00001a2d]                           dc.b $00
[00001a2e]                           dc.b $00
[00001a2f]                           dc.b $04
[00001a30]                           dc.b $00
[00001a31]                           dc.b $00
[00001a32]                           dc.w $0170
[00001a34]                           dc.b $00
[00001a35]                           dc.b $00
[00001a36]                           dc.w $01c4
[00001a38]                           dc.b $00
[00001a39]                           dc.b $81
[00001a3a]                           dc.b $00
[00001a3b]                           dc.b $00
[00001a3c]                           dc.b $00
[00001a3d]                           dc.b $00
[00001a3e]                           dc.b $00
[00001a3f]                           dc.b $00
[00001a40]                           dc.b $00
[00001a41]                           dc.b $00
[00001a42]                           dc.b $00
[00001a43]                           dc.b $00
[00001a44]                           dc.b $00
[00001a45]                           dc.b $00
[00001a46]                           dc.b $00
[00001a47]                           dc.b $00
[00001a48]                           dc.b $00
[00001a49]                           dc.b $00
[00001a4a]                           dc.b $00
[00001a4b]                           dc.b $00
[00001a4c]                           dc.b $00
[00001a4d]                           dc.b $00
[00001a4e]                           dc.b $00
[00001a4f]                           dc.b $00
[00001a50]                           dc.b $00
[00001a51]                           dc.b $00
[00001a52]                           dc.b $00
[00001a53]                           dc.b $00
[00001a54]                           dc.b $00
[00001a55]                           dc.b $00
[00001a56]                           dc.b $00
[00001a57]                           dc.b $00
[00001a58]                           dc.b $00
[00001a59]                           dc.b $00
[00001a5a]                           dc.b $00
[00001a5b]                           dc.b $00
[00001a5c]                           dc.b $00
[00001a5d]                           dc.b $00
[00001a5e]                           dc.b $00
[00001a5f]                           dc.b $00
[00001a60]                           dc.b $00
[00001a61]                           dc.b $00
[00001a62]                           dc.b $00
[00001a63]                           dc.b $00
[00001a64]                           dc.b $00
[00001a65]                           dc.b $00
[00001a66]                           dc.b $00
[00001a67]                           dc.b $00
[00001a68]                           dc.b $00
[00001a69]                           dc.b $00
[00001a6a]                           dc.b $00
[00001a6b]                           dc.b $00
[00001a6c]                           dc.b $00
[00001a6d]                           dc.b $00
[00001a6e]                           dc.b $00
[00001a6f]                           dc.b $00
[00001a70]                           dc.b 'swapadr %i swapsiz %i pbn %i n %i ',$0a,0
[00001a94]                           dc.b 'bad swap',0
[00001a9d]                           dc.b $00
[00001a9e]                           dc.b $00
[00001a9f]                           dc.b $10
[00001aa0]                           dc.w $0131
[00001aa2]                           dc.w $3131
[00001aa4]                           dc.w $1002
[00001aa6]                           dc.w $2120
[00001aa8]                           dc.w $1020
[00001aaa]                           dc.w $1002
[00001aac]                           dc.w $3020
[00001aae]                           dc.w $2011
[00001ab0]                           dc.w $2030
[00001ab2]                           dc.w $0130
[00001ab4]                           dc.w $1010
[00001ab6]                           dc.w $0120
[00001ab8]                           dc.b $00
[00001ab9]                           dc.b $11
[00001aba]                           dc.w $2000
[00001abc]                           dc.b ' !  '
[00001ac0]                           dc.w $1010
[00001ac2]                           dc.b $00
[00001ac3]                           dc.b $20
[00001ac4]                           dc.w $0111
[00001ac6]                           dc.w $3111
[00001ac8]                           dc.w $0210
[00001aca]                           dc.w $4001
[00001acc]                           dc.w $1001
[00001ace]                           dc.b '!A ',0
[00001ad2]                           dc.b $00
[00001ad3]                           dc.b $31
[00001ad4]                           dc.w $3100
[00001ad6]                           dc.b $00
[00001ad7]                           dc.b $00
[00001ad8]                           dc.b $00
[00001ad9]                           dc.b $41
[00001ada]                           dc.w $1110
[00001adc]                           dc.w $1041
[00001ade]                           dc.w $1141
[00001ae0]                           dc.w $2141
[00001ae2]                           dc.w $1041
[00001ae4]                           dc.b '! 11!'
[00001ae9]                           dc.b $11
[00001aea]                           dc.w $3120
[00001aec]                           dc.w $1150
[00001aee]                           dc.b '0@0! 0',0
[00001af5]                           dc.b $00
_syfun:
[00001af6] 00000000                  dc.l _synone
[00001afa] 00000000                  dc.l _syexit
[00001afe] 00000000                  dc.l _syfork
[00001b02] 00000000                  dc.l _syread
[00001b06] 00000000                  dc.l _sywrite
[00001b0a] 00000000                  dc.l _syopen
[00001b0e] 00000000                  dc.l _syclose
[00001b12] 00000000                  dc.l _sywait
[00001b16] 00000000                  dc.l _sycreat
[00001b1a] 00000000                  dc.l _sylink
[00001b1e] 00000000                  dc.l _syulink
[00001b22] 00000000                  dc.l _syexec
[00001b26] 00000000                  dc.l _sycd
[00001b2a] 00000000                  dc.l _sygtime
[00001b2e] 00000000                  dc.l _symknod
[00001b32] 00000000                  dc.l _sychmod
[00001b36] 00000000                  dc.l _sychown
[00001b3a] 00000000                  dc.l _sysbrk
[00001b3e] 00000000                  dc.l _systat
[00001b42] 00000000                  dc.l _syseek
[00001b46] 00000000                  dc.l _sygpid
[00001b4a] 00000000                  dc.l _symount
[00001b4e] 00000000                  dc.l _syumount
[00001b52] 00000000                  dc.l _sysuid
[00001b56] 00000000                  dc.l _syguid
[00001b5a] 00000000                  dc.l _systime
[00001b5e] 00000000                  dc.l _synone
[00001b62] 00000000                  dc.l _syalarm
[00001b66] 00000000                  dc.l _syfstat
[00001b6a] 00000000                  dc.l _sypause
[00001b6e] 00000000                  dc.l _syutime
[00001b72] 00000000                  dc.l _systty
[00001b76] 00000000                  dc.l _sygtty
[00001b7a] 00000000                  dc.l _syaccess
[00001b7e] 00000000                  dc.l _synice
[00001b82] 00000000                  dc.l _sysleep
[00001b86] 00000000                  dc.l _sync
[00001b8a] 00000000                  dc.l _sykill
[00001b8e] 00000000                  dc.l _sygcsw
[00001b92] 00000000                  dc.l _sypgrp
[00001b96] 00000000                  dc.l _sylseek
[00001b9a] 00000000                  dc.l _sydup
[00001b9e] 00000000                  dc.l _sypipe
[00001ba2] 00000000                  dc.l __sytimes
[00001ba6] 00000000                  dc.l _syprof
[00001baa] 00000000                  dc.l _sygppid
[00001bae] 00000000                  dc.l _sysgid
[00001bb2] 00000000                  dc.l _syggid
[00001bb6] 00000000                  dc.l _sysig
[00001bba] 00000000                  dc.l _sylock
[00001bbe] 00000000                  dc.l _syustat
[00001bc2] 00000000                  dc.l _synone
[00001bc6] 00000000                  dc.l _synone
[00001bca] 00000000                  dc.l _syfcntl
[00001bce] 00000000                  dc.l _syioctl
[00001bd2] 00000000                  dc.l _synone
[00001bd6] 00000000                  dc.l _synone
[00001bda] 00000000                  dc.l _sytimes
[00001bde] 00000000                  dc.l _synone
[00001be2] 00000000                  dc.l _syenv
[00001be6] 00000000                  dc.l _syumask
[00001bea] 00000000                  dc.l _sycr
[00001bee] 00000000                  dc.l _syuname
[00001bf2] 00000000                  dc.l _syuser
[00001bf6] 00000000                  dc.l _synone
[00001bfa] 00000000                  dc.l _synone
[00001bfe] 00000000                  dc.l _synone
[00001c02] 00000000                  dc.l _syenv
[00001c06] 00000000                  dc.l _symnone
[00001c0a] 00000000                  dc.l _symcreat
[00001c0e] 00000000                  dc.l _symconnect
[00001c12] 00000000                  dc.l _symdiscon
[00001c16] 00000000                  dc.l _symfree
[00001c1a] 00000000                  dc.l _symgetbuf
[00001c1e] 00000000                  dc.l _symgetprm
[00001c22] 00000000                  dc.l _symnone
[00001c26] 00000000                  dc.l _symreceive
[00001c2a] 00000000                  dc.l _symrelbuf
[00001c2e] 00000000                  dc.l _symremove
[00001c32] 00000000                  dc.l _symsend
[00001c36] 00000000                  dc.l _symsetprm
[00001c3a] 00000000                  dc.l _symtimer
[00001c3e] 00000000                  dc.l _symevclr
[00001c42] 00000000                  dc.l _symevget
[00001c46] 00000000                  dc.l _symevmon
[00001c4a] 00000000                  dc.l _symevset
[00001c4e] 00000000                  dc.l _symnone
[00001c52] 00000000                  dc.l _symnone
[00001c56]                           dc.l $00000000
[00001c5a]                           dc.b 'undefined trap: d0 = %i',$0a,0
[00001c73]                           dc.b $0a,'signal %i',$0a,0
[00001c7f]                           dc.b 'kernal trapped',0
;
         U _mmupres
         U _dounits
         U _hiproc
         U _switchp
         U _mapclr
         U _lops
         U _mapbuf
         U _onflag
         U _hips
         U _psignal
         U _ex20sz
         U __cpu
         U _prsig
         U _putfmt
         U _nbufs
         U _where
         U _ino_init
         U _putdnm
         U _sfree
         U _swapsiz
         U _fppres
         U _chq_init
         U _movbuf
         U _makep
         U _blk_init
         U _nheap
         U _panic
         U _alloc
         U _memalloc
         U _runproc
         U _rootdev
         U _memlist
         U _swapdev
         U _mapsize
         U _swapadr
         U _mapinit
         U _setpu
         U _slist
         U _lo_init
         U _reli
         U _plist
         U _geti
         U _syexit
         U _rootro
         U _hi_init
         U _free
         U _memfree
         U _mapseg
         U _mapx
         U _mapabs
         U _biops
         U _writei
         U _wakeb
         U _errget
         U _sleepb
         U _fppinit
         U _smax
         U _minu
         U _setlock
         U _fppsave
         U _chkx
         U _contain
         U _blkdevs
         U _fppload
         U _sygcsw
         U _symount
         U _syaccess
         U _sysbrk
         U _syopen
         U _syfork
         U _syustat
         U _synone
         U _sypipe
         U _sylink
         U _symrelbuf
         U _symdiscon
         U _sykill
         U _sywrite
         U _symgetbuf
         U _sylock
         U _syguid
         U _syumount
         U _syseek
         U _sysgid
         U _syexec
         U _syutime
         U _sygpid
         U _syulink
         U _sytimes
         U _syfstat
         U _systime
         U _syumask
         U _synice
         U _sychown
         U _sypause
         U _symnone
         U _syread
         U _syioctl
         U _syggid
         U _sysleep
         U _symknod
         U _symsend
         U _symconnect
         U _syfcntl
         U _syuname
         U _sygtime
         U _syclose
         U _sycr
         U _symevset
         U _sygppid
         U _sylseek
         U _systty
         U _symevmon
         U _sync
         U _symreceive
         U _symfree
         U _sycreat
         U _symtimer
         U _syalarm
         U _sychmod
         U _symevclr
         U _syenv
         U _sydup
         U _symevget
         U _symsetprm
         U _sygtty
         U _sycd
         U _lo_chk
         U _sysig
         U _tinc
         U _sendsig
         U __sytimes
         U _tick
         U _syuser
         U _symgetprm
         U _symcreat
         U _systat
         U _symremove
         U _sypgrp
         U _syprof
         U _sysuid
         U _sywait
00000000 T sigbus
0000003a T sigemt
0000003a T sigdom
00000040 T sigfpe
00000040 T sigfpt
00000046 T sigins
00000046 T sigill
00000054 T sigiot
00000054 T sigrng
0000005a T sigtrap
0000005a T sigtrc
00000060 T sigsegv
00000060 T sigseg
00000080 T sigsys
0000008e T sprint
0000009c T trapinit
000001d0 T _onentry
00000260 T _ufork
000002d6 T _uinit
00000382 T _uout
0000038a T _jmpbufsz
0000038e T _longjmp
0000039c T _setjmp
000003aa T _setpu1
00000426 T _spl
0000042c T _spl7
0000042c T _inhibit
0000043a T _spl6
00000440 T _spl5
00000446 T _spl4
0000044c T _spl3
00000452 T _spl2
00000458 T _spl1
0000045e T _permit
0000045e T _spl0
00000466 T _bflip
00000482 T acc_lo
00000482 T _iniword
000004ac T _addlum
000004c0 T _addsum
000004d4 T _gsbyte
000004e0 T _inbyte
00000500 T _inword
0000051e T _outbyte
00000540 T _outword
00000562 T _ssbyte
00000570 T _outbuf
000005a4 T _inbuf
000005be T __movmem
00000612 T _stkchk
00000612 T acc_hi
00000626 T __cenb
00000626 T __cpurge
00000646 T _sav68881
00000658 T _res68881
0000066a T _init
00000b4e T _isabs
00000b66 T _mappu
00000c18 T _setumap
00000e14 T _ucopy
00000e68 T __fppi
00000e84 T __fppld
00000ec0 T __fppsv
00000efc T _clrmem
00000f6c T _chkbuf
00000fd6 T _coreout
00001124 T _iflip
0000116c T _memcopy
000011a4 T _physio
0000128a T _swap
000013a4 T _tflip
000013d4 T _xbuy
0000141e T _xfetch
0000144e T _xsell
000014aa T _xsetch
000014ea T _clock
00001588 T _sprint
000015a2 T _trap
000016ea T _xtrns
000016ec T _xusrsvc
00002ddc D erraddr
00002de0 D __pux
00002de4 D _contig
00002de6 D _hipage
00002de8 D _lopage
00002dea D _memsiz
00002dec D _noswap
00002df0 D _romsys
00002df4 D _memtop
00002df8 D _sysbot
00002dfc D _systop
00002e00 D _root
00002e08 D _proc0
00002e4c D _pheap
00002e50 D _physbias
00002e54 D _u0
00002fc4 D _pu
000030fa D _xaspc
000030fe D _xamagic
00003100 D _xamask
00003102 D _xmagic
00003104 D _xmask
00003106 D _xmemall
00003108 D _xmemshft
0000310a D _xreloc
0000310c D _curbase
0000310e D _p1size
00003112 D _uiobase
00003116 D _utxtbase
0000311a D _usize
0000311e D _usersz
00003122 D _uxsize
00003126 D _map_ux
00003130 D _swapbuf
0000318c D _sycount
000031e4 D _syfun
;
; a.out Relocations:
00000002: 00000000 __cpu
0000000c: 000016ee
00000014: 000016ee
00000022: 00000000
0000002a: 00000000
0000004c: 00000000
00000050: 00000000
00000062: 00000000 __cpu
0000006c: 000016ee
00000074: 000016ee
00000086: 00000000
0000008a: 00000000
00000094: 00000000
00000098: 00000000
000000c2: 00000000 _onflag
000000ca: 00000000 _dounits
000000d0: 00000000 _psignal
000000da: 000016ee
000000e0: 000016ee
000000f2: 00000000 _prsig
000000f8: 00000000 _hiproc
00000100: 00000000 _switchp
00000110: 00000000
00000120: 000016ee
00000126: 00000000
00000134: 00000000
0000014a: 00000000
00000154: 00000000
00000164: 000016ee
00000176: 00000000
000001a8: 00000000 __cpu
000001c6: 00000000 _ex20sz
000001e8: 000016ee
0000021a: 00000000 __cpu
0000023c: 000016ee
0000024c: 000016ee
00000252: 000016ee
00000262: 00000000
00000278: 000016ee
00000280: 000016ee
0000028a: 00000000
00000290: 00000000
00000296: 00000000
000002a2: 000016ee
000002a8: 000016ee
000002b0: 00000000
000002d0: 000016ee
000002d8: 00000000 _mapclr
000002ec: 000016ee
000002f6: 00000000
000002fc: 00000000
00000308: 000016ee
0000030e: 000016ee
00000316: 00000000
00000342: 00000000
00000358: 000016ee
0000035e: 000016ee
00000370: 00000000
00000376: 00000000
0000037c: 000016ee
00000384: 00000000
000003ba: 000016ee
000003c2: 000016ee
000003ce: 000016ee
000003d8: 000016ee
000003de: 000016ee
000003fa: 00000000
00000404: 000016ee
0000040c: 000016ee
0000041c: 00000000
00000422: 00000000
0000042e: 00000000 _hips
00000460: 00000000 _lops
0000048e: 00000000
000004a4: 000016ee
000004b4: 000016ee
000004c8: 000016ee
000004e6: 00000000 _mapbuf
00000506: 00000000 _mapbuf
00000524: 00000000 _mapbuf
00000546: 00000000 _mapbuf
0000057a: 00000000
0000058e: 00000000 _mapbuf
000005aa: 00000000 _mapbuf
00000628: 00000000 _mmupres
00000634: 00000000 __cpu
00000674: 000016ee
0000067a: 000016ee
00000688: 000016ee
0000068e: 00000000 _putfmt
00000694: 000016ee
0000069a: 00000000 _putfmt
000006a2: 000016ee
000006a8: 00000000 _nheap
000006ae: 00000000 _free
000006b6: 00000000
000006bc: 00000000 _alloc
000006c2: 000016ee
000006c8: 00000000 _mapinit
000006d2: 000016ee
000006d8: 00000000 _putfmt
000006f6: 000016ee
000006fc: 00000000 _putfmt
00000704: 000016ee
0000070a: 00000000 _plist
00000712: 00000000 _setpu
00000718: 000016ee
0000071e: 00000000 _mapsize
00000724: 000016ee
00000756: 000016ee
0000075c: 00000000 _movbuf
00000766: 000016ee
00000772: 00000000 _runproc
00000778: 00000000 _memlist
00000780: 000016ee
0000078a: 000016ee
00000792: 00000000 _sfree
0000079a: 000016ee
0000079e: 000016ee
000007a4: 000016ee
000007ac: 000016ee
000007b2: 00000000 _memlist
000007ba: 000016ee
000007c2: 00000000 _memalloc
000007d0: 000016ee
000007d8: 000016ee
000007de: 00000000 _memlist
000007ee: 000016ee
000007f6: 00000000 _memfree
00000802: 000016ee
00000814: 000016ee
00000824: 000016ee
0000082a: 00000000 _putfmt
00000832: 00000000
0000083a: 000016ee
0000084c: 000016ee
0000085c: 000016ee
00000862: 00000000 _putfmt
0000086a: 00000000 _nbufs
00000870: 000016ee
00000876: 00000000 _putfmt
0000087e: 00000000 _fppres
00000886: 000016ee
0000088c: 00000000 _putfmt
00000896: 00000000 _rootdev
0000089e: 00000000 _putdnm
000008a6: 00000000 _rootro
000008ae: 000016ee
000008b6: 000016ee
000008be: 000016ee
000008c4: 00000000 _putfmt
000008cc: 00000000 _swapsiz
000008d2: 000016ee
000008da: 00000000 _swapdev
000008e0: 00000000 _swapdev
000008e8: 000016ee
000008ee: 00000000 _putfmt
000008f4: 00000000 _slist
000008fc: 000016ee
00000906: 000016ee
0000090e: 00000000 _sfree
00000918: 000016ee
00000922: 00000000 _swapsiz
00000934: 00000000 _swapsiz
00000944: 000016ee
0000094a: 00000000 _putfmt
00000952: 00000000 _slist
0000095a: 00000000 _swapadr
00000964: 00000000 _swapsiz
0000096c: 00000000 _sfree
00000974: 00000000 _where
0000097a: 000016ee
00000980: 00000000 _putfmt
00000988: 00000000 _blk_init
0000098e: 00000000 _chq_init
00000994: 00000000 _ino_init
0000099a: 000016ee
000009a4: 00000000 _lo_init
000009aa: 00000000 _hi_init
000009b0: 00000000 _lo_init
000009b8: 00000000 _free
000009c6: 00000000 _rootdev
000009ce: 00000000 _geti
000009d6: 000016ee
000009dc: 000016ee
000009e2: 00000000 _reli
000009ee: 00000000 _rootdev
000009f6: 00000000 _geti
000009fe: 000016ee
00000a0c: 00000000 _reli
00000a18: 00000000 _rootdev
00000a20: 00000000 _geti
00000a28: 000016ee
00000a36: 00000000 _reli
00000a3c: 000016ee
00000a42: 00000000
00000a58: 00000000 _makep
00000a66: 000016ee
00000a6c: 00000000 _memlist
00000a7a: 00000000 _memalloc
00000a88: 000016ee
00000a8e: 00000000 _panic
00000aa2: 000016ee
00000aaa: 00000000
00000ab0: 000016ee
00000aba: 000016ee
00000ac0: 000016ee
00000ac6: 00000000 _movbuf
00000ad0: 000016ee
00000adc: 00000000 _setpu
00000ae2: 000016ee
00000b08: 00000000 _runproc
00000b14: 000016ee
00000b1e: 00000000
00000b24: 00000000
00000b2a: 00000000
00000b32: 00000000 _free
00000b3e: 00000000 _syexit
00000b50: 000016ee
00000b6c: 000016ee
00000b74: 000016ee
00000b7e: 000016ee
00000b84: 000016ee
00000b92: 000016ee
00000b98: 000016ee
00000b9e: 00000000 _mmupres
00000ba6: 000016ee
00000bb6: 000016ee
00000bc2: 000016ee
00000bc8: 000016ee
00000bcc: 000016ee
00000bd4: 000016ee
00000bea: 000016ee
00000bf4: 00000000 _mapseg
00000bfe: 000016ee
00000c04: 000016ee
00000c0a: 000016ee
00000c10: 000016ee
00000c1e: 000016ee
00000c36: 000016ee
00000c4c: 000016ee
00000c56: 000016ee
00000c72: 000016ee
00000c76: 000016ee
00000c90: 00000000 _mapabs
00000c96: 000016ee
00000c9c: 000016ee
00000caa: 00000000 _mmupres
00000cda: 00000000 _mapseg
00000cf2: 000016ee
00000cfe: 000016ee
00000d0c: 00000000 _mapseg
00000d1a: 000016ee
00000d32: 00000000 _mmupres
00000d48: 000016ee
00000d54: 000016ee
00000d62: 00000000 _mapseg
00000d70: 000016ee
00000d78: 00000000 _mmupres
00000d94: 000016ee
00000da2: 00000000 _mapseg
00000dc8: 000016ee
00000ddc: 00000000 _mapseg
00000dee: 000016ee
00000e0a: 00000000 _mapx
00000e1c: 000016ee
00000e28: 000016ee
00000e32: 000016ee
00000e3c: 000016ee
00000e46: 000016ee
00000e4c: 000016ee
00000e56: 000016ee
00000e5e: 00000000
00000e70: 000016ee
00000e7c: 00000000 _fppinit
00000e86: 00000000 _fppres
00000e8e: 000016ee
00000e9e: 00000000 _fppres
00000eac: 000016ee
00000eb8: 00000000 _fppload
00000ec2: 00000000 _fppres
00000eca: 000016ee
00000eda: 00000000 _fppres
00000ee8: 000016ee
00000ef4: 00000000 _fppsave
00000f12: 00000000
00000f3c: 00000000 _minu
00000f4e: 00000000
00000f80: 000016ee
00000fbe: 00000000 _chkx
00000fe4: 000016ee
00001048: 00000000 _movbuf
000010e6: 00000000 _writei
00001118: 00000000 _writei
0000113e: 00000000 _movbuf
0000114e: 00000000
0000115e: 00000000
00001176: 000016ee
00001196: 00000000
000011b6: 000016ee
000011e2: 00000000
00001206: 00000000 _mapbuf
0000123a: 00000000 _setlock
0000124c: 00000000
00001258: 00000000 _setlock
0000127e: 00000000 _errget
00001294: 000016ee
000012a4: 00000000 _smax
000012b0: 00000000 _minu
000012c2: 00000000 _swapsiz
000012cc: 00000000 _swapadr
000012d4: 00000000 _contain
000012ea: 00000000 _swapsiz
000012f4: 00000000 _swapadr
000012fc: 000016ee
00001302: 00000000 _putfmt
0000130c: 000016ee
00001312: 00000000 _panic
0000131e: 00000000
00001326: 00000000 _swapdev
00001362: 00000000 _swapdev
0000136e: 00000000 _blkdevs
0000137c: 00000000
000013e4: 00000000 _biops
000013ec: 00000000
000013fc: 00000000 _sleepb
00001410: 00000000
00001424: 000016ee
00001438: 00000000
00001466: 00000000 _biops
0000146e: 00000000
0000147e: 00000000 _sleepb
0000148c: 00000000
00001494: 00000000 _wakeb
000014b4: 000016ee
000014cc: 00000000
000014fa: 000016ee
00001512: 00000000 _tinc
00001518: 000016ee
0000151e: 000016ee
0000152e: 000016ee
00001542: 00000000 _lo_chk
00001558: 00000000 _sendsig
00001578: 00000000 _tick
00001592: 000016ee
00001598: 00000000 _putfmt
000015ba: 000016ee
000015d4: 000016ee
000015da: 00000000 _putfmt
000015e2: 000016ee
000015e8: 00000000 _panic
000015f2: 00000000 _lo_chk
00001632: 000016ee
0000164a: 00000000
00001656: 00000000
00001670: 000016ee
000016b8: 00000000 _sendsig
000018d6: 000016ee
00001af6: 00000000 _synone
00001afa: 00000000 _syexit
00001afe: 00000000 _syfork
00001b02: 00000000 _syread
00001b06: 00000000 _sywrite
00001b0a: 00000000 _syopen
00001b0e: 00000000 _syclose
00001b12: 00000000 _sywait
00001b16: 00000000 _sycreat
00001b1a: 00000000 _sylink
00001b1e: 00000000 _syulink
00001b22: 00000000 _syexec
00001b26: 00000000 _sycd
00001b2a: 00000000 _sygtime
00001b2e: 00000000 _symknod
00001b32: 00000000 _sychmod
00001b36: 00000000 _sychown
00001b3a: 00000000 _sysbrk
00001b3e: 00000000 _systat
00001b42: 00000000 _syseek
00001b46: 00000000 _sygpid
00001b4a: 00000000 _symount
00001b4e: 00000000 _syumount
00001b52: 00000000 _sysuid
00001b56: 00000000 _syguid
00001b5a: 00000000 _systime
00001b5e: 00000000 _synone
00001b62: 00000000 _syalarm
00001b66: 00000000 _syfstat
00001b6a: 00000000 _sypause
00001b6e: 00000000 _syutime
00001b72: 00000000 _systty
00001b76: 00000000 _sygtty
00001b7a: 00000000 _syaccess
00001b7e: 00000000 _synice
00001b82: 00000000 _sysleep
00001b86: 00000000 _sync
00001b8a: 00000000 _sykill
00001b8e: 00000000 _sygcsw
00001b92: 00000000 _sypgrp
00001b96: 00000000 _sylseek
00001b9a: 00000000 _sydup
00001b9e: 00000000 _sypipe
00001ba2: 00000000 __sytimes
00001ba6: 00000000 _syprof
00001baa: 00000000 _sygppid
00001bae: 00000000 _sysgid
00001bb2: 00000000 _syggid
00001bb6: 00000000 _sysig
00001bba: 00000000 _sylock
00001bbe: 00000000 _syustat
00001bc2: 00000000 _synone
00001bc6: 00000000 _synone
00001bca: 00000000 _syfcntl
00001bce: 00000000 _syioctl
00001bd2: 00000000 _synone
00001bd6: 00000000 _synone
00001bda: 00000000 _sytimes
00001bde: 00000000 _synone
00001be2: 00000000 _syenv
00001be6: 00000000 _syumask
00001bea: 00000000 _sycr
00001bee: 00000000 _syuname
00001bf2: 00000000 _syuser
00001bf6: 00000000 _synone
00001bfa: 00000000 _synone
00001bfe: 00000000 _synone
00001c02: 00000000 _syenv
00001c06: 00000000 _symnone
00001c0a: 00000000 _symcreat
00001c0e: 00000000 _symconnect
00001c12: 00000000 _symdiscon
00001c16: 00000000 _symfree
00001c1a: 00000000 _symgetbuf
00001c1e: 00000000 _symgetprm
00001c22: 00000000 _symnone
00001c26: 00000000 _symreceive
00001c2a: 00000000 _symrelbuf
00001c2e: 00000000 _symremove
00001c32: 00000000 _symsend
00001c36: 00000000 _symsetprm
00001c3a: 00000000 _symtimer
00001c3e: 00000000 _symevclr
00001c42: 00000000 _symevget
00001c46: 00000000 _symevmon
00001c4a: 00000000 _symevset
00001c4e: 00000000 _symnone
00001c52: 00000000 _symnone
