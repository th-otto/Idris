; a_magic   = 0x9928
; a_text    = 0x00000d50
; a_data    = 0x000002e4
; a_bss     = 0x00000000
; a_syms    = 0x00000104
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000158@0x00001154


x0:
[00000000] 4eb9 0000 05f6            jsr        $000005F6
[00000006] 4a87                      tst.l      d7
[00000008] 670c                      beq.s      x0_1
[0000000a] 4878 000b                 pea.l      ($0000000B).w
[0000000e] 4eb9 0000 0000            jsr        _uerror
[00000014] 588f                      addq.l     #4,a7
x0_1:
[00000016] 4e75                      rts

x18:
[00000018] 4e75                      rts

x1a:
[0000001a] 4e56 0000                 link       a6,#0
[0000001e] 4878 0010                 pea.l      ($00000010).w
[00000022] 7e00                      moveq.l    #0,d7
[00000024] 3e2e 000a                 move.w     10(a6),d7
[00000028] 2f07                      move.l     d7,-(a7)
[0000002a] 2f3c 0000 0000            move.l     #$00000D50,-(a7)
[00000030] 2f3c 0000 0074            move.l     #$00000074,-(a7)
[00000036] 4eb9 0000 0000            jsr        _physio
[0000003c] 4fef 0010                 lea.l      16(a7),a7
[00000040] 4e5e                      unlk       a6
[00000042] 4e75                      rts

x44:
[00000044] 4e56 fffc                 link       a6,#-4
[00000048] 4297                      clr.l      (a7)
[0000004a] 7e00                      moveq.l    #0,d7
[0000004c] 3e2e 000a                 move.w     10(a6),d7
[00000050] 2f07                      move.l     d7,-(a7)
[00000052] 2f3c 0000 0000            move.l     #$00000D50,-(a7)
[00000058] 2f3c 0000 0074            move.l     #$00000074,-(a7)
[0000005e] 4eb9 0000 0000            jsr        _physio
[00000064] 4fef 000c                 lea.l      12(a7),a7
[00000068] 4e5e                      unlk       a6
[0000006a] 4e75                      rts

x6c:
[0000006c] 4eb9 0000 0000            jsr        _nodev
[00000072] 4e75                      rts

x74:
[00000074] 4e56 fffc                 link       a6,#-4
[00000078] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000007c] 2a6e 0008                 movea.l    8(a6),a5
[00000080] 7e00                      moveq.l    #0,d7
[00000082] 3e2d 0012                 move.w     18(a5),d7
[00000086] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000008c] 1d47 ffff                 move.b     d7,-1(a6)
[00000090] 7e07                      moveq.l    #7,d7
[00000092] 7c00                      moveq.l    #0,d6
[00000094] 1c2e ffff                 move.b     -1(a6),d6
[00000098] ce86                      and.l      d6,d7
[0000009a] 1d47 fffe                 move.b     d7,-2(a6)
[0000009e] 082e 0007 ffff            btst       #7,-1(a6)
[000000a4] 6724                      beq.s      x74_1
[000000a6] 0c2e 0003 fffe            cmpi.b     #$03,-2(a6)
[000000ac] 651c                      bcs.s      x74_1
[000000ae] 0c2e 0006 fffe            cmpi.b     #$06,-2(a6)
[000000b4] 6214                      bhi.s      x74_1
[000000b6] 7e00                      moveq.l    #0,d7
[000000b8] 1e2e fffe                 move.b     -2(a6),d7
[000000bc] e987                      asl.l      #4,d7
[000000be] 2247                      movea.l    d7,a1
[000000c0] d3fc 0000 00c8            adda.l     #$00000E18,a1
[000000c6] 2a11                      move.l     (a1),d5
[000000c8] 6012                      bra.s      x74_2
x74_1:
[000000ca] 7e00                      moveq.l    #0,d7
[000000cc] 1e2e fffe                 move.b     -2(a6),d7
[000000d0] e987                      asl.l      #4,d7
[000000d2] 2247                      movea.l    d7,a1
[000000d4] d3fc 0000 00d0            adda.l     #$00000E20,a1
[000000da] 2a11                      move.l     (a1),d5
x74_2:
[000000dc] 2e2d 0020                 move.l     32(a5),d7
[000000e0] 0807 0000                 btst       #0,d7
[000000e4] 6606                      bne.s      x74_3
[000000e6] 4aad 0028                 tst.l      40(a5)
[000000ea] 671c                      beq.s      x74_4
x74_3:
[000000ec] 2b6d 0024 0028            move.l     36(a5),40(a5)
[000000f2] 08ed 0003 0011            bset       #3,17(a5)
[000000f8] 2e8d                      move.l     a5,(a7)
[000000fa] 4eb9 0000 0000            jsr        _iodone
x74_6:
[00000100] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000104] 4e5e                      unlk       a6
[00000106] 4e75                      rts
x74_4:
[00000108] 7e00                      moveq.l    #0,d7
[0000010a] 3e2d 002c                 move.w     44(a5),d7
[0000010e] ba87                      cmp.l      d7,d5
[00000110] 6210                      bhi.s      x74_5
[00000112] 08ed 0003 0011            bset       #3,17(a5)
[00000118] 2e8d                      move.l     a5,(a7)
[0000011a] 4eb9 0000 0000            jsr        _iodone
[00000120] 60de                      bra.s      x74_6
x74_5:
[00000122] 7e00                      moveq.l    #0,d7
[00000124] 3e39 0000 0000            move.w     _biops,d7
[0000012a] 2e87                      move.l     d7,(a7)
[0000012c] 4eb9 0000 0000            jsr        _spl
[00000132] 3d47 fffc                 move.w     d7,-4(a6)
[00000136] 5279 0000 0000            addq.w     #1,_clk_flg
[0000013c] 2e8d                      move.l     a5,(a7)
[0000013e] 2f3c 0000 0086            move.l     #$00000DD6,-(a7)
[00000144] 4eb9 0000 0000            jsr        _enq
[0000014a] 588f                      addq.l     #4,a7
[0000014c] 4a39 0000 0096            tst.b      $00000DE6
[00000152] 6606                      bne.s      x74_7
[00000154] 4eb9 0000 0170            jsr        $00000170
x74_7:
[0000015a] 5379 0000 0000            subq.w     #1,_clk_flg
[00000160] 7e00                      moveq.l    #0,d7
[00000162] 3e2e fffc                 move.w     -4(a6),d7
[00000166] 2e87                      move.l     d7,(a7)
[00000168] 4eb9 0000 0000            jsr        _spl
[0000016e] 6090                      bra.s      x74_6
[00000170] 4e56 fffc                 link       a6,#-4
[00000174] 48e7 9c04                 movem.l    d0/d3-d5/a5,-(a7)
[00000178] 2a79 0000 0086            movea.l    $00000DD6,a5
[0000017e] 2e0d                      move.l     a5,d7
[00000180] 6700 01a4                 beq        x74_8
[00000184] 13fc 0001 0000 0096       move.b     #$01,$00000DE6
[0000018c] 0cb9 0000 0200 0000 0148  cmpi.l     #$00000200,$00000E98
[00000196] 6400 0092                 bcc        x74_9
[0000019a] 7e00                      moveq.l    #0,d7
[0000019c] 3e2d 0012                 move.w     18(a5),d7
[000001a0] 0287 0000 00ff            andi.l     #$000000FF,d7
[000001a6] 1d47 ffff                 move.b     d7,-1(a6)
[000001aa] 7e07                      moveq.l    #7,d7
[000001ac] 7c00                      moveq.l    #0,d6
[000001ae] 1c2e ffff                 move.b     -1(a6),d6
[000001b2] ce86                      and.l      d6,d7
[000001b4] 1d47 fffe                 move.b     d7,-2(a6)
[000001b8] 082e 0007 ffff            btst       #7,-1(a6)
[000001be] 6732                      beq.s      x74_10
[000001c0] 0c2e 0003 fffe            cmpi.b     #$03,-2(a6)
[000001c6] 652a                      bcs.s      x74_10
[000001c8] 0c2e 0006 fffe            cmpi.b     #$06,-2(a6)
[000001ce] 6222                      bhi.s      x74_10
[000001d0] 7e00                      moveq.l    #0,d7
[000001d2] 1e2e fffe                 move.b     -2(a6),d7
[000001d6] e987                      asl.l      #4,d7
[000001d8] 2247                      movea.l    d7,a1
[000001da] d3fc 0000 00c4            adda.l     #$00000E14,a1
[000001e0] 2e11                      move.l     (a1),d7
[000001e2] 7c00                      moveq.l    #0,d6
[000001e4] 3c2d 002c                 move.w     44(a5),d6
[000001e8] de86                      add.l      d6,d7
[000001ea] 23c7 0000 0150            move.l     d7,$00000EA0
[000001f0] 6020                      bra.s      x74_11
x74_10:
[000001f2] 7e00                      moveq.l    #0,d7
[000001f4] 1e2e fffe                 move.b     -2(a6),d7
[000001f8] e987                      asl.l      #4,d7
[000001fa] 2247                      movea.l    d7,a1
[000001fc] d3fc 0000 00cc            adda.l     #$00000E1C,a1
[00000202] 2e11                      move.l     (a1),d7
[00000204] 7c00                      moveq.l    #0,d6
[00000206] 3c2d 002c                 move.w     44(a5),d6
[0000020a] de86                      add.l      d6,d7
[0000020c] 23c7 0000 0150            move.l     d7,$00000EA0
x74_11:
[00000212] 23ed 0020 0000 0144       move.l     32(a5),$00000E94
[0000021a] 23ed 0024 0000 0148       move.l     36(a5),$00000E98
[00000222] 23ed 0024 0000 014c       move.l     36(a5),$00000E9C
x74_9:
[0000022a] 082d 0004 0011            btst       #4,17(a5)
[00000230] 6706                      beq.s      x74_12
[00000232] 7a08                      moveq.l    #8,d5
[00000234] 7800                      moveq.l    #0,d4
[00000236] 6008                      bra.s      x74_13
x74_12:
[00000238] 7a0a                      moveq.l    #10,d5
[0000023a] 383c 0100                 move.w     #$0100,d4
[0000023e] 48c4                      ext.l      d4
x74_13:
[00000240] 4a78 043e                 tst.w      ($0000043E).w
[00000244] 671e                      beq.s      x74_14
[00000246] 5379 0000 0000            subq.w     #1,_clk_flg
[0000024c] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00000250] 4878 043e                 pea.l      ($0000043E).w
[00000254] 4eb9 0000 0000            jsr        _sleep
[0000025a] 508f                      addq.l     #8,a7
[0000025c] 5279 0000 0000            addq.w     #1,_clk_flg
[00000262] 60dc                      bra.s      x74_13
x74_14:
[00000264] 31fc 0001 043e            move.w     #$0001,($0000043E).w
[0000026a] 2e39 0000 0148            move.l     $00000E98,d7
[00000270] 7c09                      moveq.l    #9,d6
[00000272] ecaf                      lsr.l      d6,d7
[00000274] 23c7 0000 0154            move.l     d7,$00000EA4
[0000027a] 0cb9 0000 00ff 0000 0154  cmpi.l     #$000000FF,$00000EA4
[00000284] 630a                      bls.s      x74_15
[00000286] 23fc 0000 00ff 0000 0154  move.l     #$000000FF,$00000EA4
x74_15:
[00000290] 4eb9 0000 0000            jsr        _spl5
[00000296] 3d47 fffc                 move.w     d7,-4(a6)
[0000029a] 4878 0001                 pea.l      ($00000001).w
[0000029e] 2f04                      move.l     d4,-(a7)
[000002a0] 2f39 0000 0154            move.l     $00000EA4,-(a7)
[000002a6] 2e39 0000 0144            move.l     $00000E94,d7
[000002ac] 2f07                      move.l     d7,-(a7)
[000002ae] 42a7                      clr.l      -(a7)
[000002b0] 42a7                      clr.l      -(a7)
[000002b2] 42a7                      clr.l      -(a7)
[000002b4] 42a7                      clr.l      -(a7)
[000002b6] 2f39 0000 0154            move.l     $00000EA4,-(a7)
[000002bc] 2e39 0000 0150            move.l     $00000EA0,d7
[000002c2] 0287 0000 00ff            andi.l     #$000000FF,d7
[000002c8] 2f07                      move.l     d7,-(a7)
[000002ca] 2e39 0000 0150            move.l     $00000EA0,d7
[000002d0] e08f                      lsr.l      #8,d7
[000002d2] 0287 0000 00ff            andi.l     #$000000FF,d7
[000002d8] 2f07                      move.l     d7,-(a7)
[000002da] 2e39 0000 0150            move.l     $00000EA0,d7
[000002e0] 7c10                      moveq.l    #16,d6
[000002e2] ecaf                      lsr.l      d6,d7
[000002e4] 0287 0000 00ff            andi.l     #$000000FF,d7
[000002ea] 2f07                      move.l     d7,-(a7)
[000002ec] 2f05                      move.l     d5,-(a7)
[000002ee] 4eb9 0000 083a            jsr        $0000083A
[000002f4] 4fef 0034                 lea.l      52(a7),a7
[000002f8] 2607                      move.l     d7,d3
[000002fa] 7e00                      moveq.l    #0,d7
[000002fc] 3e2e fffc                 move.w     -4(a6),d7
[00000300] 2e87                      move.l     d7,(a7)
[00000302] 4eb9 0000 0000            jsr        _spl
[00000308] 4a83                      tst.l      d3
[0000030a] 670c                      beq.s      x74_16
[0000030c] 2ebc 0000 0158            move.l     #$00000EA8,(a7)
[00000312] 4eb9 0000 0000            jsr        _panic
x74_16:
[00000318] 4878 0001                 pea.l      ($00000001).w
[0000031c] 4eb9 0000 0cae            jsr        $00000CAE
[00000322] 588f                      addq.l     #4,a7
[00000324] 6006                      bra.s      x74_17
x74_8:
[00000326] 4239 0000 0096            clr.b      $00000DE6
x74_17:
[0000032c] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[00000330] 4e5e                      unlk       a6
[00000332] 4e75                      rts

_hd_intr:
[00000334] 4e56 fffe                 link       a6,#-2
[00000338] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[0000033c] 7e00                      moveq.l    #0,d7
[0000033e] 3e39 0000 0000            move.w     _biops,d7
[00000344] 2e87                      move.l     d7,(a7)
[00000346] 4eb9 0000 0000            jsr        _spl
[0000034c] 3d47 fffe                 move.w     d7,-2(a6)
[00000350] 5279 0000 0000            addq.w     #1,_clk_flg
[00000356] 08b8 0007 fa09            bclr       #7,($FFFFFA09).w
[0000035c] 4878 0002                 pea.l      ($00000002).w
[00000360] 4eb9 0000 0cae            jsr        $00000CAE
[00000366] 588f                      addq.l     #4,a7
[00000368] 4a39 0000 0096            tst.b      $00000DE6
[0000036e] 6628                      bne.s      _hd_intr_1
[00000370] 2ebc 0000 0174            move.l     #$00000EC4,(a7)
[00000376] 4eb9 0000 0000            jsr        _putfmt
[0000037c] 5379 0000 0000            subq.w     #1,_clk_flg
[00000382] 7e00                      moveq.l    #0,d7
[00000384] 3e2e fffe                 move.w     -2(a6),d7
[00000388] 2e87                      move.l     d7,(a7)
[0000038a] 4eb9 0000 0000            jsr        _spl
[00000390] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00000394] 4e5e                      unlk       a6
[00000396] 4e75                      rts
_hd_intr_1:
[00000398] 2a79 0000 0086            movea.l    $00000DD6,a5
[0000039e] 082d 0004 0011            btst       #4,17(a5)
[000003a4] 6706                      beq.s      _hd_intr_2
[000003a6] 7a08                      moveq.l    #8,d5
[000003a8] 7800                      moveq.l    #0,d4
[000003aa] 6008                      bra.s      _hd_intr_3
_hd_intr_2:
[000003ac] 7a0a                      moveq.l    #10,d5
[000003ae] 383c 0100                 move.w     #$0100,d4
[000003b2] 48c4                      ext.l      d4
_hd_intr_3:
[000003b4] 2e84                      move.l     d4,(a7)
[000003b6] 42a7                      clr.l      -(a7)
[000003b8] 42a7                      clr.l      -(a7)
[000003ba] 42a7                      clr.l      -(a7)
[000003bc] 2f05                      move.l     d5,-(a7)
[000003be] 4eb9 0000 0ab6            jsr        $00000AB6
[000003c4] 4fef 0010                 lea.l      16(a7),a7
[000003c8] 2607                      move.l     d7,d3
[000003ca] 4278 043e                 clr.w      ($0000043E).w
[000003ce] 4878 043e                 pea.l      ($0000043E).w
[000003d2] 4eb9 0000 0000            jsr        _wakeup
[000003d8] 588f                      addq.l     #4,a7
[000003da] 4a83                      tst.l      d3
[000003dc] 6638                      bne.s      _hd_intr_4
[000003de] 4239 0000 0097            clr.b      $00000DE7
[000003e4] 2e39 0000 0154            move.l     $00000EA4,d7
[000003ea] 7c09                      moveq.l    #9,d6
[000003ec] eda7                      asl.l      d6,d7
[000003ee] 2847                      movea.l    d7,a4
[000003f0] 2e0c                      move.l     a4,d7
[000003f2] 9fb9 0000 0148            sub.l      d7,$00000E98
[000003f8] 2e0c                      move.l     a4,d7
[000003fa] 9fb9 0000 014c            sub.l      d7,$00000E9C
[00000400] 2e39 0000 0154            move.l     $00000EA4,d7
[00000406] dfb9 0000 0150            add.l      d7,$00000EA0
[0000040c] 2e0c                      move.l     a4,d7
[0000040e] dfb9 0000 0144            add.l      d7,$00000E94
[00000414] 6036                      bra.s      _hd_intr_5
_hd_intr_4:
[00000416] 2e83                      move.l     d3,(a7)
[00000418] 7e00                      moveq.l    #0,d7
[0000041a] 3e2d 0012                 move.w     18(a5),d7
[0000041e] 2f07                      move.l     d7,-(a7)
[00000420] 2f0d                      move.l     a5,-(a7)
[00000422] 4eb9 0000 0000            jsr        _ioerror
[00000428] 508f                      addq.l     #8,a7
[0000042a] 5239 0000 0097            addq.b     #1,$00000DE7
[00000430] 0c39 0005 0000 0097       cmpi.b     #$05,$00000DE7
[00000438] 6d3c                      blt.s      _hd_intr_6
[0000043a] 4239 0000 0097            clr.b      $00000DE7
[00000440] 42b9 0000 0148            clr.l      $00000E98
[00000446] 08ed 0003 0011            bset       #3,17(a5)
_hd_intr_5:
[0000044c] 0cb9 0000 0200 0000 0148  cmpi.l     #$00000200,$00000E98
[00000456] 6438                      bcc.s      _hd_intr_7
[00000458] 2b79 0000 014c 0028       move.l     $00000E9C,40(a5)
[00000460] 2ebc 0000 0086            move.l     #$00000DD6,(a7)
[00000466] 4eb9 0000 0000            jsr        _deq
[0000046c] 2e87                      move.l     d7,(a7)
[0000046e] 4eb9 0000 0000            jsr        _iodone
[00000474] 601a                      bra.s      _hd_intr_7
_hd_intr_6:
[00000476] 4eba fcf8                 jsr        $00000170(pc)
[0000047a] 5379 0000 0000            subq.w     #1,_clk_flg
[00000480] 7e00                      moveq.l    #0,d7
[00000482] 3e2e fffe                 move.w     -2(a6),d7
[00000486] 2e87                      move.l     d7,(a7)
[00000488] 4eb9 0000 0000            jsr        _spl
[0000048e] 6018                      bra.s      _hd_intr_8
_hd_intr_7:
[00000490] 4eba fcde                 jsr        $00000170(pc)
[00000494] 5379 0000 0000            subq.w     #1,_clk_flg
[0000049a] 7e00                      moveq.l    #0,d7
[0000049c] 3e2e fffe                 move.w     -2(a6),d7
[000004a0] 2e87                      move.l     d7,(a7)
[000004a2] 4eb9 0000 0000            jsr        _spl
_hd_intr_8:
[000004a8] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000004ac] 4e5e                      unlk       a6
[000004ae] 4e75                      rts

x4b0:
[000004b0] 4e56 fffa                 link       a6,#-6
[000004b4] 4eb9 0000 0000            jsr        _spl7
[000004ba] 3d47 fffe                 move.w     d7,-2(a6)
x4b0_2:
[000004be] 4a78 043e                 tst.w      ($0000043E).w
[000004c2] 6712                      beq.s      x4b0_1
[000004c4] 4878 ffff                 pea.l      ($FFFFFFFF).w
[000004c8] 4878 043e                 pea.l      ($0000043E).w
[000004cc] 4eb9 0000 0000            jsr        _sleep
[000004d2] 508f                      addq.l     #8,a7
[000004d4] 60e8                      bra.s      x4b0_2
x4b0_1:
[000004d6] 31fc 0001 043e            move.w     #$0001,($0000043E).w
[000004dc] 7e00                      moveq.l    #0,d7
[000004de] 3e2e fffe                 move.w     -2(a6),d7
[000004e2] 2e87                      move.l     d7,(a7)
[000004e4] 4eb9 0000 0000            jsr        _spl
[000004ea] 4297                      clr.l      (a7)
[000004ec] 42a7                      clr.l      -(a7)
[000004ee] 4878 0001                 pea.l      ($00000001).w
[000004f2] 2f2e 000c                 move.l     12(a6),-(a7)
[000004f6] 42a7                      clr.l      -(a7)
[000004f8] 42a7                      clr.l      -(a7)
[000004fa] 42a7                      clr.l      -(a7)
[000004fc] 42a7                      clr.l      -(a7)
[000004fe] 4878 0001                 pea.l      ($00000001).w
[00000502] 2e2e 0008                 move.l     8(a6),d7
[00000506] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000050c] 2f07                      move.l     d7,-(a7)
[0000050e] 2e2e 0008                 move.l     8(a6),d7
[00000512] e087                      asr.l      #8,d7
[00000514] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000051a] 2f07                      move.l     d7,-(a7)
[0000051c] 2e2e 0008                 move.l     8(a6),d7
[00000520] 7c10                      moveq.l    #16,d6
[00000522] eca7                      asr.l      d6,d7
[00000524] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000052a] 2f07                      move.l     d7,-(a7)
[0000052c] 4878 0008                 pea.l      ($00000008).w
[00000530] 4eb9 0000 083a            jsr        $0000083A
[00000536] 4fef 0030                 lea.l      48(a7),a7
[0000053a] 4a87                      tst.l      d7
[0000053c] 6c28                      bge.s      x4b0_3
[0000053e] 4278 043e                 clr.w      ($0000043E).w
[00000542] 4878 043e                 pea.l      ($0000043E).w
[00000546] 4eb9 0000 0000            jsr        _wakeup
[0000054c] 588f                      addq.l     #4,a7
[0000054e] 2eae 0008                 move.l     8(a6),(a7)
[00000552] 2f3c 0000 0194            move.l     #$00000EE4,-(a7)
[00000558] 4eb9 0000 0000            jsr        _putfmt
[0000055e] 588f                      addq.l     #4,a7
[00000560] 7eff                      moveq.l    #-1,d7
[00000562] 4e5e                      unlk       a6
[00000564] 4e75                      rts
x4b0_3:
[00000566] 4278 043e                 clr.w      ($0000043E).w
[0000056a] 4878 043e                 pea.l      ($0000043E).w
[0000056e] 4eb9 0000 0000            jsr        _wakeup
[00000574] 588f                      addq.l     #4,a7
[00000576] 7e00                      moveq.l    #0,d7
[00000578] 4e5e                      unlk       a6
[0000057a] 4e75                      rts

x57c:
[0000057c] 4e56 0000                 link       a6,#0
[00000580] 226e 0008                 movea.l    8(a6),a1
[00000584] 7e00                      moveq.l    #0,d7
[00000586] 1e11                      move.b     (a1),d7
[00000588] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000058e] 226e 0008                 movea.l    8(a6),a1
[00000592] 7c00                      moveq.l    #0,d6
[00000594] 1c29 0001                 move.b     1(a1),d6
[00000598] e186                      asl.l      #8,d6
[0000059a] 0286 0000 ff00            andi.l     #$0000FF00,d6
[000005a0] 8e86                      or.l       d6,d7
[000005a2] 4e5e                      unlk       a6
[000005a4] 4e75                      rts

x5a6:
[000005a6] 4e56 0000                 link       a6,#0
[000005aa] 2e2e 0008                 move.l     8(a6),d7
[000005ae] e987                      asl.l      #4,d7
[000005b0] 2247                      movea.l    d7,a1
[000005b2] d3fc 0000 00c4            adda.l     #$00000E14,a1
[000005b8] 22ae 000c                 move.l     12(a6),(a1)
[000005bc] 2e2e 0008                 move.l     8(a6),d7
[000005c0] e987                      asl.l      #4,d7
[000005c2] 2247                      movea.l    d7,a1
[000005c4] d3fc 0000 00c8            adda.l     #$00000E18,a1
[000005ca] 22ae 0010                 move.l     16(a6),(a1)
[000005ce] 2e2e 0008                 move.l     8(a6),d7
[000005d2] e987                      asl.l      #4,d7
[000005d4] 2247                      movea.l    d7,a1
[000005d6] d3fc 0000 00cc            adda.l     #$00000E1C,a1
[000005dc] 22ae 0014                 move.l     20(a6),(a1)
[000005e0] 2e2e 0008                 move.l     8(a6),d7
[000005e4] e987                      asl.l      #4,d7
[000005e6] 2247                      movea.l    d7,a1
[000005e8] d3fc 0000 00d0            adda.l     #$00000E20,a1
[000005ee] 22ae 0018                 move.l     24(a6),(a1)
[000005f2] 4e5e                      unlk       a6
[000005f4] 4e75                      rts

x5f6:
[000005f6] 4e56 fdf8                 link       a6,#-520
[000005fa] 4a79 0000 01ba            tst.w      $00000F0A
[00000600] 6706                      beq.s      x5f6_1
[00000602] 7e00                      moveq.l    #0,d7
[00000604] 4e5e                      unlk       a6
[00000606] 4e75                      rts
x5f6_1:
[00000608] 5279 0000 01ba            addq.w     #1,$00000F0A
[0000060e] 43ee fe00                 lea.l      -512(a6),a1
[00000612] 2e89                      move.l     a1,(a7)
[00000614] 42a7                      clr.l      -(a7)
[00000616] 4eba fe98                 jsr        $000004B0(pc)
[0000061a] 588f                      addq.l     #4,a7
[0000061c] 4a87                      tst.l      d7
[0000061e] 6c06                      bge.s      x5f6_2
[00000620] 7eff                      moveq.l    #-1,d7
[00000622] 4e5e                      unlk       a6
[00000624] 4e75                      rts
x5f6_2:
[00000626] 2d6e ffc2 fdfc            move.l     -62(a6),-516(a6)
[0000062c] 2eae fdfc                 move.l     -516(a6),(a7)
[00000630] 42a7                      clr.l      -(a7)
[00000632] 2f2e fdfc                 move.l     -516(a6),-(a7)
[00000636] 42a7                      clr.l      -(a7)
[00000638] 4878 0007                 pea.l      ($00000007).w
[0000063c] 4eba ff68                 jsr        $000005A6(pc)
[00000640] 4fef 0010                 lea.l      16(a7),a7
[00000644] 4878 0003                 pea.l      ($00000003).w
[00000648] 486e ffc6                 pea.l      -58(a6)
[0000064c] 4eb9 0000 068a            jsr        $0000068A
[00000652] 508f                      addq.l     #8,a7
[00000654] 4878 0004                 pea.l      ($00000004).w
[00000658] 486e ffd2                 pea.l      -46(a6)
[0000065c] 4eb9 0000 068a            jsr        $0000068A
[00000662] 508f                      addq.l     #8,a7
[00000664] 4878 0005                 pea.l      ($00000005).w
[00000668] 486e ffde                 pea.l      -34(a6)
[0000066c] 4eb9 0000 068a            jsr        $0000068A
[00000672] 508f                      addq.l     #8,a7
[00000674] 4878 0006                 pea.l      ($00000006).w
[00000678] 486e ffea                 pea.l      -22(a6)
[0000067c] 4eb9 0000 068a            jsr        $0000068A
[00000682] 508f                      addq.l     #8,a7
[00000684] 7e00                      moveq.l    #0,d7
[00000686] 4e5e                      unlk       a6
[00000688] 4e75                      rts

x68a:
[0000068a] 4e56 fdce                 link       a6,#-562
[0000068e] 2d6e 0008 ffda            move.l     8(a6),-38(a6)
[00000694] 43ee fffb                 lea.l      -5(a6),a1
[00000698] 2d49 ffd6                 move.l     a1,-42(a6)
[0000069c] 226e ffda                 movea.l    -38(a6),a1
[000006a0] 52ae ffda                 addq.l     #1,-38(a6)
[000006a4] 1d51 ffff                 move.b     (a1),-1(a6)
[000006a8] 226e ffd6                 movea.l    -42(a6),a1
[000006ac] 52ae ffd6                 addq.l     #1,-42(a6)
[000006b0] 246e ffda                 movea.l    -38(a6),a2
[000006b4] 52ae ffda                 addq.l     #1,-38(a6)
[000006b8] 1292                      move.b     (a2),(a1)
[000006ba] 226e ffd6                 movea.l    -42(a6),a1
[000006be] 52ae ffd6                 addq.l     #1,-42(a6)
[000006c2] 246e ffda                 movea.l    -38(a6),a2
[000006c6] 52ae ffda                 addq.l     #1,-38(a6)
[000006ca] 1292                      move.b     (a2),(a1)
[000006cc] 226e ffd6                 movea.l    -42(a6),a1
[000006d0] 52ae ffd6                 addq.l     #1,-42(a6)
[000006d4] 246e ffda                 movea.l    -38(a6),a2
[000006d8] 52ae ffda                 addq.l     #1,-38(a6)
[000006dc] 1292                      move.b     (a2),(a1)
[000006de] 226e ffd6                 movea.l    -42(a6),a1
[000006e2] 4211                      clr.b      (a1)
[000006e4] 2d6e ffda ffd2            move.l     -38(a6),-46(a6)
[000006ea] 226e ffd2                 movea.l    -46(a6),a1
[000006ee] 58ae ffd2                 addq.l     #4,-46(a6)
[000006f2] 2d51 fff6                 move.l     (a1),-10(a6)
[000006f6] 226e ffd2                 movea.l    -46(a6),a1
[000006fa] 2d51 fff2                 move.l     (a1),-14(a6)
[000006fe] 4a2e ffff                 tst.b      -1(a6)
[00000702] 6736                      beq.s      x68a_1
[00000704] 43ee fdd2                 lea.l      -558(a6),a1
[00000708] 2e89                      move.l     a1,(a7)
[0000070a] 2f2e fff6                 move.l     -10(a6),-(a7)
[0000070e] 4eba fda0                 jsr        $000004B0(pc)
[00000712] 588f                      addq.l     #4,a7
[00000714] 4a87                      tst.l      d7
[00000716] 6d22                      blt.s      x68a_1
[00000718] 486e fddd                 pea.l      -547(a6)
[0000071c] 4eba fe5e                 jsr        $0000057C(pc)
[00000720] 588f                      addq.l     #4,a7
[00000722] 0c87 0000 0200            cmpi.l     #$00000200,d7
[00000728] 6610                      bne.s      x68a_1
[0000072a] 486e fde0                 pea.l      -544(a6)
[0000072e] 4eba fe4c                 jsr        $0000057C(pc)
[00000732] 588f                      addq.l     #4,a7
[00000734] 2d47 ffde                 move.l     d7,-34(a6)
[00000738] 6010                      bra.s      x68a_2
x68a_1:
[0000073a] 42ae fff6                 clr.l      -10(a6)
[0000073e] 42ae fff2                 clr.l      -14(a6)
[00000742] 42ae ffde                 clr.l      -34(a6)
[00000746] 422e fffb                 clr.b      -5(a6)
x68a_2:
[0000074a] 2e2e fff6                 move.l     -10(a6),d7
[0000074e] deae ffde                 add.l      -34(a6),d7
[00000752] 2d47 ffee                 move.l     d7,-18(a6)
[00000756] 2e2e fff2                 move.l     -14(a6),d7
[0000075a] 9eae ffde                 sub.l      -34(a6),d7
[0000075e] 2d47 ffea                 move.l     d7,-22(a6)
[00000762] 2eae ffea                 move.l     -22(a6),(a7)
[00000766] 2f2e ffee                 move.l     -18(a6),-(a7)
[0000076a] 2f2e fff2                 move.l     -14(a6),-(a7)
[0000076e] 2f2e fff6                 move.l     -10(a6),-(a7)
[00000772] 2f2e 000c                 move.l     12(a6),-(a7)
[00000776] 4eba fe2e                 jsr        $000005A6(pc)
[0000077a] 4fef 0010                 lea.l      16(a7),a7
[0000077e] 4a79 0000 01bc            tst.w      $00000F0C
[00000784] 6600 00b0                 bne        x68a_3
[00000788] 2ebc 0000 01be            move.l     #$00000F0E,(a7)
[0000078e] 486e fffb                 pea.l      -5(a6)
[00000792] 4eb9 0000 0000            jsr        _cmpstr
[00000798] 588f                      addq.l     #4,a7
[0000079a] 0c87 0000 0001            cmpi.l     #$00000001,d7
[000007a0] 6600 0094                 bne        x68a_3
[000007a4] 5279 0000 01bc            addq.w     #1,$00000F0C
[000007aa] 0cae 0000 00c8 ffea       cmpi.l     #$000000C8,-22(a6)
[000007b2] 6300 0082                 bls        x68a_3
[000007b6] 0cae 0000 0045 ffde       cmpi.l     #$00000045,-34(a6)
[000007be] 6376                      bls.s      x68a_3
[000007c0] 2e2e fff6                 move.l     -10(a6),d7
[000007c4] 5287                      addq.l     #1,d7
[000007c6] 2d47 ffe6                 move.l     d7,-26(a6)
[000007ca] 7044                      moveq.l    #68,d0
[000007cc] 2d40 ffe2                 move.l     d0,-30(a6)
[000007d0] 2eae ffe2                 move.l     -30(a6),(a7)
[000007d4] 2f2e ffe6                 move.l     -26(a6),-(a7)
[000007d8] 2f2e ffe2                 move.l     -30(a6),-(a7)
[000007dc] 2f2e ffe6                 move.l     -26(a6),-(a7)
[000007e0] 42a7                      clr.l      -(a7)
[000007e2] 4eba fdc2                 jsr        $000005A6(pc)
[000007e6] 4fef 0010                 lea.l      16(a7),a7
[000007ea] 7e45                      moveq.l    #69,d7
[000007ec] deae fff6                 add.l      -10(a6),d7
[000007f0] 2d47 ffe6                 move.l     d7,-26(a6)
[000007f4] 7ebb                      moveq.l    #-69,d7
[000007f6] deae ffde                 add.l      -34(a6),d7
[000007fa] 2d47 ffe2                 move.l     d7,-30(a6)
[000007fe] 2eae ffe2                 move.l     -30(a6),(a7)
[00000802] 2f2e ffe6                 move.l     -26(a6),-(a7)
[00000806] 2f2e ffe2                 move.l     -30(a6),-(a7)
[0000080a] 2f2e ffe6                 move.l     -26(a6),-(a7)
[0000080e] 4878 0001                 pea.l      ($00000001).w
[00000812] 4eba fd92                 jsr        $000005A6(pc)
[00000816] 4fef 0010                 lea.l      16(a7),a7
[0000081a] 2eae ffea                 move.l     -22(a6),(a7)
[0000081e] 2f2e ffee                 move.l     -18(a6),-(a7)
[00000822] 2f2e ffea                 move.l     -22(a6),-(a7)
[00000826] 2f2e ffee                 move.l     -18(a6),-(a7)
[0000082a] 4878 0002                 pea.l      ($00000002).w
[0000082e] 4eba fd76                 jsr        $000005A6(pc)
[00000832] 4fef 0010                 lea.l      16(a7),a7
x68a_3:
[00000836] 4e5e                      unlk       a6
[00000838] 4e75                      rts

x83a:
[0000083a] 4e56 fffc                 link       a6,#-4
[0000083e] 082e 0000 002f            btst       #0,47(a6)
[00000844] 6712                      beq.s      x83a_1
[00000846] 2ebc 0000 01c2            move.l     #$00000F12,(a7)
[0000084c] 4eb9 0000 0000            jsr        _putfmt
[00000852] 7eff                      moveq.l    #-1,d7
[00000854] 4e5e                      unlk       a6
[00000856] 4e75                      rts
x83a_1:
[00000858] 4aae 002c                 tst.l      44(a6)
[0000085c] 6736                      beq.s      x83a_2
[0000085e] 2e2e 002c                 move.l     44(a6),d7
[00000862] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000868] 13c7 00ff 860d            move.b     d7,$00FF860D
[0000086e] 2e2e 002c                 move.l     44(a6),d7
[00000872] e087                      asr.l      #8,d7
[00000874] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000087a] 13c7 00ff 860b            move.b     d7,$00FF860B
[00000880] 2e2e 002c                 move.l     44(a6),d7
[00000884] 7c10                      moveq.l    #16,d6
[00000886] eca7                      asr.l      d6,d7
[00000888] 0287 0000 00ff            andi.l     #$000000FF,d7
[0000088e] 13c7 00ff 8609            move.b     d7,$00FF8609
x83a_2:
[00000894] 33fc 0088 00ff 8606       move.w     #$0088,$00FF8606
[0000089c] 2e2e 0020                 move.l     32(a6),d7
[000008a0] eb87                      asl.l      #5,d7
[000008a2] 0287 0000 00e0            andi.l     #$000000E0,d7
[000008a8] 7c1f                      moveq.l    #31,d6
[000008aa] ccae 0008                 and.l      8(a6),d6
[000008ae] 8e86                      or.l       d6,d7
[000008b0] 7c10                      moveq.l    #16,d6
[000008b2] eda7                      asl.l      d6,d7
[000008b4] 0087 0000 008a            ori.l      #$0000008A,d7
[000008ba] 23c7 00ff 8604            move.l     d7,$00FF8604
[000008c0] 33fc 008a 00ff 8606       move.w     #$008A,$00FF8606
[000008c8] 4878 0001                 pea.l      ($00000001).w
[000008cc] 4eb9 0000 0c54            jsr        $00000C54
[000008d2] 588f                      addq.l     #4,a7
[000008d4] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000008da] 660c                      bne.s      x83a_3
[000008dc] 4eb9 0000 0c90            jsr        $00000C90
[000008e2] 7eff                      moveq.l    #-1,d7
[000008e4] 4e5e                      unlk       a6
[000008e6] 4e75                      rts
x83a_3:
[000008e8] 2e2e 0028                 move.l     40(a6),d7
[000008ec] e987                      asl.l      #4,d7
[000008ee] 7c10                      moveq.l    #16,d6
[000008f0] cc87                      and.l      d7,d6
[000008f2] 8dae 000c                 or.l       d6,12(a6)
[000008f6] 2e2e 0024                 move.l     36(a6),d7
[000008fa] eb87                      asl.l      #5,d7
[000008fc] 0287 0000 00e0            andi.l     #$000000E0,d7
[00000902] 7c1f                      moveq.l    #31,d6
[00000904] ccae 000c                 and.l      12(a6),d6
[00000908] 8e86                      or.l       d6,d7
[0000090a] 7c10                      moveq.l    #16,d6
[0000090c] eda7                      asl.l      d6,d7
[0000090e] 0087 0000 008a            ori.l      #$0000008A,d7
[00000914] 23c7 00ff 8604            move.l     d7,$00FF8604
[0000091a] 4878 0002                 pea.l      ($00000002).w
[0000091e] 4eb9 0000 0c54            jsr        $00000C54
[00000924] 588f                      addq.l     #4,a7
[00000926] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[0000092c] 660c                      bne.s      x83a_4
[0000092e] 4eb9 0000 0c90            jsr        $00000C90
[00000934] 7eff                      moveq.l    #-1,d7
[00000936] 4e5e                      unlk       a6
[00000938] 4e75                      rts
x83a_4:
[0000093a] 2e2e 0010                 move.l     16(a6),d7
[0000093e] 7c10                      moveq.l    #16,d6
[00000940] eda7                      asl.l      d6,d7
[00000942] 0287 00ff 0000            andi.l     #$00FF0000,d7
[00000948] 0087 0000 008a            ori.l      #$0000008A,d7
[0000094e] 23c7 00ff 8604            move.l     d7,$00FF8604
[00000954] 4878 0003                 pea.l      ($00000003).w
[00000958] 4eb9 0000 0c54            jsr        $00000C54
[0000095e] 588f                      addq.l     #4,a7
[00000960] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000966] 660c                      bne.s      x83a_5
[00000968] 4eb9 0000 0c90            jsr        $00000C90
[0000096e] 7eff                      moveq.l    #-1,d7
[00000970] 4e5e                      unlk       a6
[00000972] 4e75                      rts
x83a_5:
[00000974] 2e2e 0014                 move.l     20(a6),d7
[00000978] 7c10                      moveq.l    #16,d6
[0000097a] eda7                      asl.l      d6,d7
[0000097c] 0287 00ff 0000            andi.l     #$00FF0000,d7
[00000982] 0087 0000 008a            ori.l      #$0000008A,d7
[00000988] 23c7 00ff 8604            move.l     d7,$00FF8604
[0000098e] 4878 0004                 pea.l      ($00000004).w
[00000992] 4eb9 0000 0c54            jsr        $00000C54
[00000998] 588f                      addq.l     #4,a7
[0000099a] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000009a0] 660c                      bne.s      x83a_6
[000009a2] 4eb9 0000 0c90            jsr        $00000C90
[000009a8] 7eff                      moveq.l    #-1,d7
[000009aa] 4e5e                      unlk       a6
[000009ac] 4e75                      rts
x83a_6:
[000009ae] 2e2e 0018                 move.l     24(a6),d7
[000009b2] 7c10                      moveq.l    #16,d6
[000009b4] eda7                      asl.l      d6,d7
[000009b6] 0287 00ff 0000            andi.l     #$00FF0000,d7
[000009bc] 0087 0000 008a            ori.l      #$0000008A,d7
[000009c2] 23c7 00ff 8604            move.l     d7,$00FF8604
[000009c8] 4878 0005                 pea.l      ($00000005).w
[000009cc] 4eb9 0000 0c54            jsr        $00000C54
[000009d2] 588f                      addq.l     #4,a7
[000009d4] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000009da] 660c                      bne.s      x83a_7
[000009dc] 4eb9 0000 0c90            jsr        $00000C90
[000009e2] 7eff                      moveq.l    #-1,d7
[000009e4] 4e5e                      unlk       a6
[000009e6] 4e75                      rts
x83a_7:
[000009e8] 4aae 002c                 tst.l      44(a6)
[000009ec] 6750                      beq.s      x83a_8
[000009ee] 2e2e 0034                 move.l     52(a6),d7
[000009f2] 0a87 0000 0190            eori.l     #$00000190,d7
[000009f8] 33c7 00ff 8606            move.w     d7,$00FF8606
[000009fe] 4eb9 0000 0cac            jsr        $00000CAC
[00000a04] 2e2e 0034                 move.l     52(a6),d7
[00000a08] 0087 0000 0090            ori.l      #$00000090,d7
[00000a0e] 33c7 00ff 8606            move.w     d7,$00FF8606
[00000a14] 4eb9 0000 0cac            jsr        $00000CAC
[00000a1a] 33ee 0032 00ff 8604       move.w     50(a6),$00FF8604
[00000a22] 4eb9 0000 0cac            jsr        $00000CAC
[00000a28] 2e2e 0034                 move.l     52(a6),d7
[00000a2c] 0087 0000 008a            ori.l      #$0000008A,d7
[00000a32] 33c7 00ff 8606            move.w     d7,$00FF8606
[00000a38] 4eb9 0000 0cac            jsr        $00000CAC
x83a_8:
[00000a3e] 2e2e 001c                 move.l     28(a6),d7
[00000a42] 7c10                      moveq.l    #16,d6
[00000a44] eda7                      asl.l      d6,d7
[00000a46] 0287 00ff 0000            andi.l     #$00FF0000,d7
[00000a4c] 8eae 0034                 or.l       52(a6),d7
[00000a50] 23c7 00ff 8604            move.l     d7,$00FF8604
[00000a56] 4aae 0038                 tst.l      56(a6)
[00000a5a] 6718                      beq.s      x83a_9
[00000a5c] 08b8 0007 fa0d            bclr       #7,($FFFFFA0D).w
[00000a62] 08b8 0007 fa11            bclr       #7,($FFFFFA11).w
[00000a68] 08f8 0007 fa09            bset       #7,($FFFFFA09).w
[00000a6e] 7e00                      moveq.l    #0,d7
[00000a70] 4e5e                      unlk       a6
[00000a72] 4e75                      rts
x83a_9:
[00000a74] 4878 0006                 pea.l      ($00000006).w
[00000a78] 4eb9 0000 0c54            jsr        $00000C54
[00000a7e] 588f                      addq.l     #4,a7
[00000a80] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000a86] 660c                      bne.s      x83a_10
[00000a88] 4eb9 0000 0c90            jsr        $00000C90
[00000a8e] 7eff                      moveq.l    #-1,d7
[00000a90] 4e5e                      unlk       a6
[00000a92] 4e75                      rts
x83a_10:
[00000a94] 2eae 0034                 move.l     52(a6),(a7)
[00000a98] 2f2e 0028                 move.l     40(a6),-(a7)
[00000a9c] 2f2e 0024                 move.l     36(a6),-(a7)
[00000aa0] 2f2e 0020                 move.l     32(a6),-(a7)
[00000aa4] 2f2e 0008                 move.l     8(a6),-(a7)
[00000aa8] 4eb9 0000 0ab6            jsr        $00000AB6
[00000aae] 4fef 0010                 lea.l      16(a7),a7
[00000ab2] 4e5e                      unlk       a6
[00000ab4] 4e75                      rts

xab6:
[00000ab6] 4e56 ffc0                 link       a6,#-64
[00000aba] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00000abe] 0839 0005 00ff fa01       btst       #5,$00FFFA01
[00000ac6] 672a                      beq.s      xab6_1
[00000ac8] 2ebc 0000 01e1            move.l     #$00000F31,(a7)
[00000ace] 4eb9 0000 0000            jsr        _putfmt
[00000ad4] 4878 0007                 pea.l      ($00000007).w
[00000ad8] 4eb9 0000 0c54            jsr        $00000C54
[00000ade] 588f                      addq.l     #4,a7
[00000ae0] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[00000ae6] 660a                      bne.s      xab6_1
[00000ae8] 4eb9 0000 0c90            jsr        $00000C90
[00000aee] 7eff                      moveq.l    #-1,d7
[00000af0] 6046                      bra.s      xab6_2
xab6_1:
[00000af2] 2e2e 0018                 move.l     24(a6),d7
[00000af6] 0087 0000 008a            ori.l      #$0000008A,d7
[00000afc] 33c7 00ff 8606            move.w     d7,$00FF8606
[00000b02] 4eb9 0000 0cac            jsr        $00000CAC
[00000b08] 7a03                      moveq.l    #3,d5
[00000b0a] 3e39 00ff 8604            move.w     $00FF8604,d7
[00000b10] 48c7                      ext.l      d7
[00000b12] ca87                      and.l      d7,d5
[00000b14] 4eb9 0000 0c90            jsr        $00000C90
[00000b1a] 4a85                      tst.l      d5
[00000b1c] 6700 0132                 beq        xab6_3
[00000b20] 0cae 0000 0003 0008       cmpi.l     #$00000003,8(a6)
[00000b28] 6616                      bne.s      xab6_4
[00000b2a] 2ebc 0000 0200            move.l     #$00000F50,(a7)
[00000b30] 4eb9 0000 0000            jsr        _putfmt
[00000b36] 7eff                      moveq.l    #-1,d7
xab6_2:
[00000b38] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00000b3c] 4e5e                      unlk       a6
[00000b3e] 4e75                      rts
xab6_4:
[00000b40] 2eae 0008                 move.l     8(a6),(a7)
[00000b44] 2f3c 0000 0227            move.l     #$00000F77,-(a7)
[00000b4a] 4eb9 0000 0000            jsr        _putfmt
[00000b50] 588f                      addq.l     #4,a7
[00000b52] 4297                      clr.l      (a7)
[00000b54] 4878 0010                 pea.l      ($00000010).w
[00000b58] 4878 0001                 pea.l      ($00000001).w
[00000b5c] 486e ffc0                 pea.l      -64(a6)
[00000b60] 2f2e 0014                 move.l     20(a6),-(a7)
[00000b64] 2f2e 0010                 move.l     16(a6),-(a7)
[00000b68] 2f2e 000c                 move.l     12(a6),-(a7)
[00000b6c] 42a7                      clr.l      -(a7)
[00000b6e] 42a7                      clr.l      -(a7)
[00000b70] 42a7                      clr.l      -(a7)
[00000b72] 42a7                      clr.l      -(a7)
[00000b74] 42a7                      clr.l      -(a7)
[00000b76] 4878 0003                 pea.l      ($00000003).w
[00000b7a] 4eba fcbe                 jsr        $0000083A(pc)
[00000b7e] 4fef 0030                 lea.l      48(a7),a7
[00000b82] 4a87                      tst.l      d7
[00000b84] 6704                      beq.s      xab6_5
[00000b86] 7eff                      moveq.l    #-1,d7
[00000b88] 60ae                      bra.s      xab6_2
xab6_5:
[00000b8a] 7800                      moveq.l    #0,d4
[00000b8c] 1839 00ff 860d            move.b     $00FF860D,d4
[00000b92] 0284 0000 00ff            andi.l     #$000000FF,d4
[00000b98] 7e00                      moveq.l    #0,d7
[00000b9a] 1e39 00ff 860b            move.b     $00FF860B,d7
[00000ba0] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000ba6] e187                      asl.l      #8,d7
[00000ba8] 8887                      or.l       d7,d4
[00000baa] 7e00                      moveq.l    #0,d7
[00000bac] 1e39 00ff 8609            move.b     $00FF8609,d7
[00000bb2] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bb8] 7c10                      moveq.l    #16,d6
[00000bba] eda7                      asl.l      d6,d7
[00000bbc] 8887                      or.l       d7,d4
[00000bbe] 43ee ffc0                 lea.l      -64(a6),a1
[00000bc2] b3c4                      cmpa.l     d4,a1
[00000bc4] 674c                      beq.s      xab6_6
[00000bc6] 7e00                      moveq.l    #0,d7
[00000bc8] 1e2e ffc3                 move.b     -61(a6),d7
[00000bcc] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bd2] 2e87                      move.l     d7,(a7)
[00000bd4] 7e00                      moveq.l    #0,d7
[00000bd6] 1e2e ffc2                 move.b     -62(a6),d7
[00000bda] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000be0] 2f07                      move.l     d7,-(a7)
[00000be2] 7e00                      moveq.l    #0,d7
[00000be4] 1e2e ffc1                 move.b     -63(a6),d7
[00000be8] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bee] 2f07                      move.l     d7,-(a7)
[00000bf0] 7e00                      moveq.l    #0,d7
[00000bf2] 1e2e ffc0                 move.b     -64(a6),d7
[00000bf6] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000bfc] 2f07                      move.l     d7,-(a7)
[00000bfe] 2f3c 0000 024b            move.l     #$00000F9B,-(a7)
[00000c04] 4eb9 0000 0000            jsr        _putfmt
[00000c0a] 4fef 0010                 lea.l      16(a7),a7
[00000c0e] 7eff                      moveq.l    #-1,d7
[00000c10] 6036                      bra.s      xab6_7
xab6_6:
[00000c12] 4297                      clr.l      (a7)
[00000c14] 4878 0010                 pea.l      ($00000010).w
[00000c18] 4878 0001                 pea.l      ($00000001).w
[00000c1c] 42a7                      clr.l      -(a7)
[00000c1e] 2f2e 0014                 move.l     20(a6),-(a7)
[00000c22] 2f2e 0010                 move.l     16(a6),-(a7)
[00000c26] 2f2e 000c                 move.l     12(a6),-(a7)
[00000c2a] 42a7                      clr.l      -(a7)
[00000c2c] 42a7                      clr.l      -(a7)
[00000c2e] 42a7                      clr.l      -(a7)
[00000c30] 42a7                      clr.l      -(a7)
[00000c32] 42a7                      clr.l      -(a7)
[00000c34] 4878 0003                 pea.l      ($00000003).w
[00000c38] 4eba fc00                 jsr        $0000083A(pc)
[00000c3c] 4fef 0030                 lea.l      48(a7),a7
[00000c40] 4a87                      tst.l      d7
[00000c42] 6700 ff46                 beq        xab6_5
[00000c46] 7eff                      moveq.l    #-1,d7
xab6_7:
[00000c48] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00000c4c] 4e5e                      unlk       a6
[00000c4e] 4e75                      rts
xab6_3:
[00000c50] 7e00                      moveq.l    #0,d7
[00000c52] 60f4                      bra.s      xab6_7
[00000c54] 4e56 0000                 link       a6,#0
[00000c58] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000c5c] 2a3c 0010 0000            move.l     #$00100000,d5
xab6_10:
[00000c62] 0839 0005 00ff fa01       btst       #5,$00FFFA01
[00000c6a] 6604                      bne.s      xab6_8
[00000c6c] 7e00                      moveq.l    #0,d7
[00000c6e] 6018                      bra.s      xab6_9
xab6_8:
[00000c70] 5385                      subq.l     #1,d5
[00000c72] 6eee                      bgt.s      xab6_10
[00000c74] 2eae 0008                 move.l     8(a6),(a7)
[00000c78] 2f3c 0000 0284            move.l     #$00000FD4,-(a7)
[00000c7e] 4eb9 0000 0000            jsr        _putfmt
[00000c84] 588f                      addq.l     #4,a7
[00000c86] 7eff                      moveq.l    #-1,d7
xab6_9:
[00000c88] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00000c8c] 4e5e                      unlk       a6
[00000c8e] 4e75                      rts

xc90:
[00000c90] 2f05                      move.l     d5,-(a7)
[00000c92] 33fc 0080 00ff 8606       move.w     #$0080,$00FF8606
[00000c9a] 4eb9 0000 0cac            jsr        $00000CAC
[00000ca0] 3a39 00ff 8604            move.w     $00FF8604,d5
[00000ca6] 48c5                      ext.l      d5
[00000ca8] 2a1f                      move.l     (a7)+,d5
[00000caa] 4e75                      rts

xcac:
[00000cac] 4e75                      rts

xcae:
[00000cae] 4e56 fffc                 link       a6,#-4
[00000cb2] 0cae 0000 0002 0008       cmpi.l     #$00000002,8(a6)
[00000cba] 660a                      bne.s      xcae_1
[00000cbc] 42b9 0000 02ae            clr.l      $00000FFE
[00000cc2] 4e5e                      unlk       a6
[00000cc4] 4e75                      rts
xcae_1:
[00000cc6] 0cae 0000 0001 0008       cmpi.l     #$00000001,8(a6)
[00000cce] 661c                      bne.s      xcae_2
[00000cd0] 7001                      moveq.l    #1,d0
[00000cd2] 23c0 0000 02ae            move.l     d0,$00000FFE
[00000cd8] 7005                      moveq.l    #5,d0
[00000cda] 23c0 0000 02b6            move.l     d0,$00001006
[00000ce0] 4ab9 0000 02b2            tst.l      $00001002
[00000ce6] 6704                      beq.s      xcae_2
[00000ce8] 4e5e                      unlk       a6
[00000cea] 4e75                      rts
xcae_2:
[00000cec] 4ab9 0000 02ae            tst.l      $00000FFE
[00000cf2] 660a                      bne.s      xcae_3
[00000cf4] 42b9 0000 02b2            clr.l      $00001002
[00000cfa] 4e5e                      unlk       a6
[00000cfc] 4e75                      rts
xcae_3:
[00000cfe] 2279 0000 02b6            movea.l    $00001006,a1
[00000d04] 53b9 0000 02b6            subq.l     #1,$00001006
[00000d0a] 2e09                      move.l     a1,d7
[00000d0c] 6e20                      bgt.s      xcae_4
[00000d0e] 42b9 0000 02ae            clr.l      $00000FFE
[00000d14] 42b9 0000 02b2            clr.l      $00001002
[00000d1a] 2ebc 0000 02ba            move.l     #$0000100A,(a7)
[00000d20] 4eb9 0000 0000            jsr        _putfmt
[00000d26] 4eba f60c                 jsr        _hd_intr(pc)
[00000d2a] 4e5e                      unlk       a6
[00000d2c] 4e75                      rts
xcae_4:
[00000d2e] 7001                      moveq.l    #1,d0
[00000d30] 23c0 0000 02b2            move.l     d0,$00001002
[00000d36] 4878 00b4                 pea.l      ($000000B4).w
[00000d3a] 42a7                      clr.l      -(a7)
[00000d3c] 2f3c 0000 0cae            move.l     #$00000CAE,-(a7)
[00000d42] 4eb9 0000 0000            jsr        _timeout
[00000d48] 4fef 000c                 lea.l      12(a7),a7
[00000d4c] 4e5e                      unlk       a6
[00000d4e] 4e75                      rts

	.data
[00000d50]                           dc.b $00
[00000d51]                           dc.b $00
[00000d52]                           dc.b $00
[00000d53]                           dc.b $00
[00000d54]                           dc.b $00
[00000d55]                           dc.b $00
[00000d56]                           dc.b $00
[00000d57]                           dc.b $00
[00000d58]                           dc.b $00
[00000d59]                           dc.b $00
[00000d5a]                           dc.b $00
[00000d5b]                           dc.b $00
[00000d5c]                           dc.b $00
[00000d5d]                           dc.b $00
[00000d5e]                           dc.b $00
[00000d5f]                           dc.b $00
[00000d60]                           dc.b $00
[00000d61]                           dc.b $00
[00000d62]                           dc.b $00
[00000d63]                           dc.b $00
[00000d64]                           dc.b $00
[00000d65]                           dc.b $00
[00000d66]                           dc.b $00
[00000d67]                           dc.b $00
[00000d68]                           dc.b $00
[00000d69]                           dc.b $00
[00000d6a]                           dc.b $00
[00000d6b]                           dc.b $00
[00000d6c]                           dc.b $00
[00000d6d]                           dc.b $00
[00000d6e]                           dc.b $00
[00000d6f]                           dc.b $00
[00000d70]                           dc.b $00
[00000d71]                           dc.b $00
[00000d72]                           dc.b $00
[00000d73]                           dc.b $00
[00000d74]                           dc.b $00
[00000d75]                           dc.b $00
[00000d76]                           dc.b $00
[00000d77]                           dc.b $00
[00000d78]                           dc.b $00
[00000d79]                           dc.b $00
[00000d7a]                           dc.b $00
[00000d7b]                           dc.b $00
[00000d7c]                           dc.b $00
[00000d7d]                           dc.b $00
[00000d7e]                           dc.b 'hdp0 hdp1 hdp2 hdp3 hdp4 hdp5 hdp6 hdp7',0
[00000da6]                           dc.b 'rhdp0 rhdp1 rhdp2 rhdp3 rhdp4 rhdp5 rhdp6 rhdp7',0
[00000dd6]                           dc.b $00
[00000dd7]                           dc.b $00
[00000dd8]                           dc.b $00
[00000dd9]                           dc.b $00
[00000dda]                           dc.b $00
[00000ddb]                           dc.b $00
[00000ddc]                           dc.b $00
[00000ddd]                           dc.b $00
[00000dde]                           dc.b $00
[00000ddf]                           dc.b $00
[00000de0]                           dc.b $00
[00000de1]                           dc.b $00
[00000de2]                           dc.b $00
[00000de3]                           dc.b $00
[00000de4]                           dc.b $00
[00000de5]                           dc.b $00
[00000de6]                           dc.b $00
[00000de7]                           dc.b $00
_hdbdev:
[00000de8] 00000000                  dc.l $00000000 ; no symbol found
[00000dec] 00000018                  dc.l $00000018 ; no symbol found
[00000df0] 00000074                  dc.l $00000074 ; no symbol found
[00000df4] 00000086                  dc.l $00000086 ; no symbol found
[00000df8] 0000002e                  dc.l $0000002e ; no symbol found
_hdcdev:
[00000dfc] 00000000                  dc.l $00000000 ; no symbol found
[00000e00] 00000018                  dc.l $00000018 ; no symbol found
[00000e04] 0000001a                  dc.l $0000001a ; no symbol found
[00000e08] 00000044                  dc.l $00000044 ; no symbol found
[00000e0c] 0000006c                  dc.l $0000006c ; no symbol found
[00000e10] 00000056                  dc.l $00000056 ; no symbol found
[00000e14]                           dc.b $00
[00000e15]                           dc.b $00
[00000e16]                           dc.b $00
[00000e17]                           dc.b $00
[00000e18]                           dc.b $00
[00000e19]                           dc.b $00
[00000e1a]                           dc.b $00
[00000e1b]                           dc.b $00
[00000e1c]                           dc.b $00
[00000e1d]                           dc.b $00
[00000e1e]                           dc.b $00
[00000e1f]                           dc.b $00
[00000e20]                           dc.b $00
[00000e21]                           dc.b $00
[00000e22]                           dc.b $00
[00000e23]                           dc.b $00
[00000e24]                           dc.b $00
[00000e25]                           dc.b $00
[00000e26]                           dc.b $00
[00000e27]                           dc.b $00
[00000e28]                           dc.b $00
[00000e29]                           dc.b $00
[00000e2a]                           dc.b $00
[00000e2b]                           dc.b $00
[00000e2c]                           dc.b $00
[00000e2d]                           dc.b $00
[00000e2e]                           dc.b $00
[00000e2f]                           dc.b $00
[00000e30]                           dc.b $00
[00000e31]                           dc.b $00
[00000e32]                           dc.b $00
[00000e33]                           dc.b $00
[00000e34]                           dc.b $00
[00000e35]                           dc.b $00
[00000e36]                           dc.b $00
[00000e37]                           dc.b $00
[00000e38]                           dc.b $00
[00000e39]                           dc.b $00
[00000e3a]                           dc.b $00
[00000e3b]                           dc.b $00
[00000e3c]                           dc.b $00
[00000e3d]                           dc.b $00
[00000e3e]                           dc.b $00
[00000e3f]                           dc.b $00
[00000e40]                           dc.b $00
[00000e41]                           dc.b $00
[00000e42]                           dc.b $00
[00000e43]                           dc.b $00
[00000e44]                           dc.b $00
[00000e45]                           dc.b $00
[00000e46]                           dc.b $00
[00000e47]                           dc.b $00
[00000e48]                           dc.b $00
[00000e49]                           dc.b $00
[00000e4a]                           dc.b $00
[00000e4b]                           dc.b $00
[00000e4c]                           dc.b $00
[00000e4d]                           dc.b $00
[00000e4e]                           dc.b $00
[00000e4f]                           dc.b $00
[00000e50]                           dc.b $00
[00000e51]                           dc.b $00
[00000e52]                           dc.b $00
[00000e53]                           dc.b $00
[00000e54]                           dc.b $00
[00000e55]                           dc.b $00
[00000e56]                           dc.b $00
[00000e57]                           dc.b $00
[00000e58]                           dc.b $00
[00000e59]                           dc.b $00
[00000e5a]                           dc.b $00
[00000e5b]                           dc.b $00
[00000e5c]                           dc.b $00
[00000e5d]                           dc.b $00
[00000e5e]                           dc.b $00
[00000e5f]                           dc.b $00
[00000e60]                           dc.b $00
[00000e61]                           dc.b $00
[00000e62]                           dc.b $00
[00000e63]                           dc.b $00
[00000e64]                           dc.b $00
[00000e65]                           dc.b $00
[00000e66]                           dc.b $00
[00000e67]                           dc.b $00
[00000e68]                           dc.b $00
[00000e69]                           dc.b $00
[00000e6a]                           dc.b $00
[00000e6b]                           dc.b $00
[00000e6c]                           dc.b $00
[00000e6d]                           dc.b $00
[00000e6e]                           dc.b $00
[00000e6f]                           dc.b $00
[00000e70]                           dc.b $00
[00000e71]                           dc.b $00
[00000e72]                           dc.b $00
[00000e73]                           dc.b $00
[00000e74]                           dc.b $00
[00000e75]                           dc.b $00
[00000e76]                           dc.b $00
[00000e77]                           dc.b $00
[00000e78]                           dc.b $00
[00000e79]                           dc.b $00
[00000e7a]                           dc.b $00
[00000e7b]                           dc.b $00
[00000e7c]                           dc.b $00
[00000e7d]                           dc.b $00
[00000e7e]                           dc.b $00
[00000e7f]                           dc.b $00
[00000e80]                           dc.b $00
[00000e81]                           dc.b $00
[00000e82]                           dc.b $00
[00000e83]                           dc.b $00
[00000e84]                           dc.b $00
[00000e85]                           dc.b $00
[00000e86]                           dc.b $00
[00000e87]                           dc.b $00
[00000e88]                           dc.b $00
[00000e89]                           dc.b $00
[00000e8a]                           dc.b $00
[00000e8b]                           dc.b $00
[00000e8c]                           dc.b $00
[00000e8d]                           dc.b $00
[00000e8e]                           dc.b $00
[00000e8f]                           dc.b $00
[00000e90]                           dc.b $00
[00000e91]                           dc.b $00
[00000e92]                           dc.b $00
[00000e93]                           dc.b $00
[00000e94]                           dc.b $00
[00000e95]                           dc.b $00
[00000e96]                           dc.b $00
[00000e97]                           dc.b $00
[00000e98]                           dc.b $00
[00000e99]                           dc.b $00
[00000e9a]                           dc.b $00
[00000e9b]                           dc.b $00
[00000e9c]                           dc.b $00
[00000e9d]                           dc.b $00
[00000e9e]                           dc.b $00
[00000e9f]                           dc.b $00
[00000ea0]                           dc.b $00
[00000ea1]                           dc.b $00
[00000ea2]                           dc.b $00
[00000ea3]                           dc.b $00
[00000ea4]                           dc.b $00
[00000ea5]                           dc.b $00
[00000ea6]                           dc.b $00
[00000ea7]                           dc.b $00
[00000ea8]                           dc.b 'error sending SCSI command!',0
[00000ec4]                           dc.b '<<SCSI - spurious interrupt!>>',$0a,0
[00000ee4]                           dc.b '<<SCSI - error reading block-(%i)!>>',$0a,0
[00000f0a]                           dc.b $00
[00000f0b]                           dc.b $00
[00000f0c]                           dc.b $00
[00000f0d]                           dc.b $00
[00000f0e]                           dc.b 'IDR',0
[00000f12]                           dc.b '<<SCSI - odd address error!>>',$0a,0
[00000f31]                           dc.b '<<SCSI - done called early!>>',$0a,0
[00000f50]                           dc.b '<<SCSI - error during a ',$27,'getsense',$27,'!>>',$0a,0
[00000f77]                           dc.b '<<SCSI - error for command (%i)!>>',$0a,0
[00000f9b]                           dc.b '<<SCSI - error codes are <0x%h>,<0x%h>,<0x%h>,<0x%h>!>>',$0a,0
[00000fd4]                           dc.b '<<SCSI - ',$27,'wait_irq',$27,' timeout, flag (%i)>>',$0a,0
[00000ffe]                           dc.b $00
[00000fff]                           dc.b $00
[00001000]                           dc.b $00
[00001001]                           dc.b $00
[00001002]                           dc.b $00
[00001003]                           dc.b $00
[00001004]                           dc.b $00
[00001005]                           dc.b $00
[00001006]                           dc.b $00
[00001007]                           dc.b $00
[00001008]                           dc.b $00
[00001009]                           dc.b $00
[0000100a]                           dc.w $0a07
[0000100c]                           dc.b '<<SCSI - interrupt scanner timeout!>>',$0a,0
[00001033]                           dc.b $00
;
         U _putfmt
         U _uerror
         U _biops
         U _nodev
         U _physio
         U _cmpstr
         U _sleep
         U _clk_flg
         U _spl
         U _wakeup
         U _panic
         U _timeout
         U _spl7
         U _spl5
         U _enq
         U _ioerror
         U _iodone
         U _deq
00000334 T _hd_intr
00000de8 D _hdbdev
00000dfc D _hdcdev
;
; a.out Relocations:
00000002: 00000000
00000010: 00000000 _uerror
0000002c: 00000d50
00000032: 00000000
00000038: 00000000 _physio
00000054: 00000d50
0000005a: 00000000
00000060: 00000000 _physio
0000006e: 00000000 _nodev
000000c2: 00000d50
000000d6: 00000d50
000000fc: 00000000 _iodone
0000011c: 00000000 _iodone
00000126: 00000000 _biops
0000012e: 00000000 _spl
00000138: 00000000 _clk_flg
00000140: 00000d50
00000146: 00000000 _enq
0000014e: 00000d50
00000156: 00000000
0000015c: 00000000 _clk_flg
0000016a: 00000000 _spl
0000017a: 00000d50
00000188: 00000d50
00000192: 00000d50
000001dc: 00000d50
000001ec: 00000d50
000001fe: 00000d50
0000020e: 00000d50
00000216: 00000d50
0000021e: 00000d50
00000226: 00000d50
00000248: 00000000 _clk_flg
00000256: 00000000 _sleep
0000025e: 00000000 _clk_flg
0000026c: 00000d50
00000276: 00000d50
00000280: 00000d50
0000028c: 00000d50
00000292: 00000000 _spl5
000002a2: 00000d50
000002a8: 00000d50
000002b8: 00000d50
000002be: 00000d50
000002cc: 00000d50
000002dc: 00000d50
000002f0: 00000000
00000304: 00000000 _spl
0000030e: 00000d50
00000314: 00000000 _panic
0000031e: 00000000
00000328: 00000d50
00000340: 00000000 _biops
00000348: 00000000 _spl
00000352: 00000000 _clk_flg
00000362: 00000000
0000036a: 00000d50
00000372: 00000d50
00000378: 00000000 _putfmt
0000037e: 00000000 _clk_flg
0000038c: 00000000 _spl
0000039a: 00000d50
000003c0: 00000000
000003d4: 00000000 _wakeup
000003e0: 00000d50
000003e6: 00000d50
000003f4: 00000d50
000003fc: 00000d50
00000402: 00000d50
00000408: 00000d50
00000410: 00000d50
00000424: 00000000 _ioerror
0000042c: 00000d50
00000434: 00000d50
0000043c: 00000d50
00000442: 00000d50
00000452: 00000d50
0000045a: 00000d50
00000462: 00000d50
00000468: 00000000 _deq
00000470: 00000000 _iodone
0000047c: 00000000 _clk_flg
0000048a: 00000000 _spl
00000496: 00000000 _clk_flg
000004a4: 00000000 _spl
000004b6: 00000000 _spl7
000004ce: 00000000 _sleep
000004e6: 00000000 _spl
00000532: 00000000
00000548: 00000000 _wakeup
00000554: 00000d50
0000055a: 00000000 _putfmt
00000570: 00000000 _wakeup
000005b4: 00000d50
000005c6: 00000d50
000005d8: 00000d50
000005ea: 00000d50
000005fc: 00000d50
0000060a: 00000d50
0000064e: 00000000
0000065e: 00000000
0000066e: 00000000
0000067e: 00000000
00000780: 00000d50
0000078a: 00000d50
00000794: 00000000 _cmpstr
000007a6: 00000d50
00000848: 00000d50
0000084e: 00000000 _putfmt
000008ce: 00000000
000008de: 00000000
00000920: 00000000
00000930: 00000000
0000095a: 00000000
0000096a: 00000000
00000994: 00000000
000009a4: 00000000
000009ce: 00000000
000009de: 00000000
00000a00: 00000000
00000a16: 00000000
00000a24: 00000000
00000a3a: 00000000
00000a7a: 00000000
00000a8a: 00000000
00000aaa: 00000000
00000aca: 00000d50
00000ad0: 00000000 _putfmt
00000ada: 00000000
00000aea: 00000000
00000b04: 00000000
00000b16: 00000000
00000b2c: 00000d50
00000b32: 00000000 _putfmt
00000b46: 00000d50
00000b4c: 00000000 _putfmt
00000c00: 00000d50
00000c06: 00000000 _putfmt
00000c7a: 00000d50
00000c80: 00000000 _putfmt
00000c9c: 00000000
00000cbe: 00000d50
00000cd4: 00000d50
00000cdc: 00000d50
00000ce2: 00000d50
00000cee: 00000d50
00000cf6: 00000d50
00000d00: 00000d50
00000d06: 00000d50
00000d10: 00000d50
00000d16: 00000d50
00000d1c: 00000d50
00000d22: 00000000 _putfmt
00000d32: 00000d50
00000d3e: 00000000
00000d44: 00000000 _timeout
00000de8: 00000000
00000dec: 00000000
00000df0: 00000000
00000df4: 00000d50
00000df8: 00000d50
00000dfc: 00000000
00000e00: 00000000
00000e04: 00000000
00000e08: 00000000
00000e0c: 00000000
00000e10: 00000d50
