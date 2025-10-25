; a_magic   = 0x992d
; a_text    = 0x00001968
; a_data    = 0x00000204
; a_bss     = 0x00000000
; a_syms    = 0x00000420
; a_heap    = 0x00001000
; a_textoff = 0x00000000
; a_dataoff = 0x00020000
; a_relocs  = 0x00000273@0x00001fa8

start:
[00000000] 201f                      move.l     (a7)+,d0
[00000002] 204f                      movea.l    a7,a0
[00000004] 2f08                      move.l     a0,-(a7)
[00000006] 2f08                      move.l     a0,-(a7)
[00000008] 2f00                      move.l     d0,-(a7)
[0000000a] e598                      rol.l      #2,d0
[0000000c] 5880                      addq.l     #4,d0
[0000000e] d1af 0008                 add.l      d0,8(a7)
[00000012] 23ef 0008 0002 0072       move.l     8(a7),_environ
[0000001a] 4a97                      tst.l      (a7)
[0000001c] 6726                      beq.s      $00000044
[0000001e] 206f 0004                 movea.l    4(a7),a0
[00000022] 2050                      movea.l    (a0),a0
[00000024] 23c8 0002 01fa            move.l     a0,_pname
[0000002a] 0c10 003a                 cmpi.b     #$3A,(a0)
[0000002e] 670c                      beq.s      $0000003C
[00000030] 0c10 007c                 cmpi.b     #$7C,(a0)
[00000034] 6706                      beq.s      $0000003C
[00000036] 4a18                      tst.b      (a0)+
[00000038] 66f0                      bne.s      $0000002A
[0000003a] 6008                      bra.s      $00000044
[0000003c] 4218                      clr.b      (a0)+
[0000003e] 23c8 0002 007a            move.l     a0,__paths
[00000044] 4879 0002 006c            pea.l      $000219D4
[0000004a] 4eb9 0000 0982            jsr        _getenv
[00000050] 4a9f                      tst.l      (a7)+
[00000052] 4a87                      tst.l      d7
[00000054] 6706                      beq.s      $0000005C
[00000056] 23c7 0002 007a            move.l     d7,__paths
[0000005c] 0cb9 0000 0001 0002 01e0  cmpi.l     #$00000001,__stop
[00000066] 660a                      bne.s      $00000072
[00000068] 23fc 0002 0204 0002 01e0  move.l     #$00021D70,__stop
[00000072] 4eb9 0000 00c6            jsr        _main
[00000078] 2e87                      move.l     d7,(a7)
[0000007a] 4eb9 0000 0080            jsr        _exit
_exit:
[00000080] 2e39 0002 007e            move.l     $000219E6,d7
[00000086] 0c87 0000 00aa            cmpi.l     #_onexit,d7
[0000008c] 670a                      beq.s      $00000098
[0000008e] 4a87                      tst.l      d7
[00000090] 6706                      beq.s      $00000098
[00000092] 2047                      movea.l    d7,a0
[00000094] 4e90                      jsr        (a0)
[00000096] 60ee                      bra.s      $00000086
[00000098] 4aaf 0004                 tst.l      4(a7)
[0000009c] 6604                      bne.s      $000000A2
[0000009e] 7e01                      moveq.l    #1,d7
[000000a0] 6002                      bra.s      $000000A4
[000000a2] 4287                      clr.l      d7
[000000a4] 2f07                      move.l     d7,-(a7)
[000000a6] 7e01                      moveq.l    #1,d7
[000000a8] 4e41                      trap       #1
_onexit:
[000000aa] 2e39 0002 007e            move.l     $000219E6,d7
[000000b0] 23ef 0004 0002 007e       move.l     4(a7),$000219E6
[000000b8] 4e75                      rts
seterr:
[000000ba] 4487                      neg.l      d7
[000000bc] 23c7 0002 0076            move.l     d7,_errno
[000000c2] 7eff                      moveq.l    #-1,d7
[000000c4] 4ed0                      jmp        (a0)
_main:
[000000c6] 4e56 ff98                 link       a6,#-104
[000000ca] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[000000ce] 2ebc 0002 0092            move.l     #$000219FA,(a7)
[000000d4] 2f3c 0002 008e            move.l     #$000219F6,-(a7)
[000000da] 2f3c 0002 008a            move.l     #$000219F2,-(a7)
[000000e0] 2f3c 0002 0086            move.l     #$000219EE,-(a7)
[000000e6] 2f3c 0002 0082            move.l     #$000219EA,-(a7)
[000000ec] 2f3c 0002 009b            move.l     #$00021A03,-(a7)
[000000f2] 486e 000c                 pea.l      12(a6)
[000000f6] 486e 0008                 pea.l      8(a6)
[000000fa] 4eb9 0000 0b82            jsr        _getflags
[00000100] 4fef 001c                 lea.l      28(a7),a7
[00000104] 4ab9 0002 0086            tst.l      $000219EE
[0000010a] 6722                      beq.s      $0000012E
[0000010c] 4878 0002                 pea.l      ($00000002).w
[00000110] 2f39 0002 0086            move.l     $000219EE,-(a7)
[00000116] 4eb9 0000 08ca            jsr        __open
[0000011c] 508f                      addq.l     #8,a7
[0000011e] 33c7 0002 0098            move.w     d7,$00021A00
[00000124] 6c2c                      bge.s      $00000152
[00000126] 4297                      clr.l      (a7)
[00000128] 4eb9 0000 0080            jsr        _exit
[0000012e] 4ab9 0002 0082            tst.l      $000219EA
[00000134] 6628                      bne.s      $0000015E
[00000136] 4878 0020                 pea.l      ($00000020).w
[0000013a] 3e39 0002 0098            move.w     $00021A00,d7
[00000140] 48c7                      ext.l      d7
[00000142] 2f07                      move.l     d7,-(a7)
[00000144] 4eb9 0000 0338            jsr        _smode
[0000014a] 508f                      addq.l     #8,a7
[0000014c] 3d47 fffe                 move.w     d7,-2(a6)
[00000150] 600c                      bra.s      $0000015E
[00000152] 33f9 0002 0098 0002 0096  move.w     $00021A00,$000219FE
[0000015c] 60d0                      bra.s      $0000012E
[0000015e] 4ab9 0002 008a            tst.l      $000219F2
[00000164] 6728                      beq.s      $0000018E
[00000166] 3e39 0002 0096            move.w     $000219FE,d7
[0000016c] 48c7                      ext.l      d7
[0000016e] 2e87                      move.l     d7,(a7)
[00000170] 3e39 0002 0098            move.w     $00021A00,d7
[00000176] 48c7                      ext.l      d7
[00000178] 2f07                      move.l     d7,-(a7)
[0000017a] 2f39 0002 008a            move.l     $000219F2,-(a7)
[00000180] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00000184] 4eb9 0000 05c2            jsr        _pputf
[0000018a] 4fef 000c                 lea.l      12(a7),a7
[0000018e] 4ab9 0002 0092            tst.l      $000219FA
[00000194] 660a                      bne.s      $000001A0
[00000196] 23fc 0002 009a 0002 0092  move.l     #$00021A02,$000219FA
[000001a0] 4878 0002                 pea.l      ($00000002).w
[000001a4] 4878 0002                 pea.l      ($00000002).w
[000001a8] 486e 000c                 pea.l      12(a6)
[000001ac] 486e 0008                 pea.l      8(a6)
[000001b0] 4eb9 0000 09de            jsr        _getfiles
[000001b6] 4fef 0010                 lea.l      16(a7),a7
[000001ba] 3d47 fffc                 move.w     d7,-4(a6)
[000001be] 6d42                      blt.s      $00000202
[000001c0] 3e2e fffc                 move.w     -4(a6),d7
[000001c4] 48c7                      ext.l      d7
[000001c6] 0c47 0002                 cmpi.w     #$0002,d7
[000001ca] 67d4                      beq.s      $000001A0
[000001cc] 4ab9 0002 008a            tst.l      $000219F2
[000001d2] 674c                      beq.s      $00000220
[000001d4] 3e39 0002 0096            move.w     $000219FE,d7
[000001da] 48c7                      ext.l      d7
[000001dc] 2e87                      move.l     d7,(a7)
[000001de] 3e39 0002 0098            move.w     $00021A00,d7
[000001e4] 48c7                      ext.l      d7
[000001e6] 2f07                      move.l     d7,-(a7)
[000001e8] 42a7                      clr.l      -(a7)
[000001ea] 3e2e fffc                 move.w     -4(a6),d7
[000001ee] 48c7                      ext.l      d7
[000001f0] 2f07                      move.l     d7,-(a7)
[000001f2] 4eb9 0000 05c2            jsr        _pputf
[000001f8] 4fef 000c                 lea.l      12(a7),a7
[000001fc] 4a87                      tst.l      d7
[000001fe] 6c00 00e0                 bge        $000002E0
[00000202] 4ab9 0002 008a            tst.l      $000219F2
[00000208] 6700 00e8                 beq        $000002F2
[0000020c] 3e39 0002 0098            move.w     $00021A00,d7
[00000212] 48c7                      ext.l      d7
[00000214] 2e87                      move.l     d7,(a7)
[00000216] 4eb9 0000 0526            jsr        _ppeof
[0000021c] 6000 00d4                 bra        $000002F2
[00000220] 4ab9 0002 008e            tst.l      $000219F6
[00000226] 6620                      bne.s      $00000248
[00000228] 4297                      clr.l      (a7)
[0000022a] 2f39 0002 0092            move.l     $000219FA,-(a7)
[00000230] 246e 000c                 movea.l    12(a6),a2
[00000234] 598a                      subq.l     #4,a2
[00000236] 2f12                      move.l     (a2),-(a7)
[00000238] 486e ff98                 pea.l      -104(a6)
[0000023c] 4eb9 0000 10ba            jsr        _cpystr
[00000242] 4fef 000c                 lea.l      12(a7),a7
[00000246] 6046                      bra.s      $0000028E
[00000248] 246e 000c                 movea.l    12(a6),a2
[0000024c] 598a                      subq.l     #4,a2
[0000024e] 2a52                      movea.l    (a2),a5
[00000250] 4878 002f                 pea.l      ($0000002F).w
[00000254] 2f0d                      move.l     a5,-(a7)
[00000256] 4eb9 0000 123a            jsr        _scnstr
[0000025c] 508f                      addq.l     #8,a7
[0000025e] 2a07                      move.l     d7,d5
[00000260] 2445                      movea.l    d5,a2
[00000262] d5cd                      adda.l     a5,a2
[00000264] 4a12                      tst.b      (a2)
[00000266] 6708                      beq.s      $00000270
[00000268] 2445                      movea.l    d5,a2
[0000026a] 528a                      addq.l     #1,a2
[0000026c] dbca                      adda.l     a2,a5
[0000026e] 60e0                      bra.s      $00000250
[00000270] 4297                      clr.l      (a7)
[00000272] 2f39 0002 0092            move.l     $000219FA,-(a7)
[00000278] 2f0d                      move.l     a5,-(a7)
[0000027a] 2f39 0002 008e            move.l     $000219F6,-(a7)
[00000280] 486e ff98                 pea.l      -104(a6)
[00000284] 4eb9 0000 10ba            jsr        _cpystr
[0000028a] 4fef 0010                 lea.l      16(a7),a7
[0000028e] 3e39 0002 0096            move.w     $000219FE,d7
[00000294] 48c7                      ext.l      d7
[00000296] 2e87                      move.l     d7,(a7)
[00000298] 3e39 0002 0098            move.w     $00021A00,d7
[0000029e] 48c7                      ext.l      d7
[000002a0] 2f07                      move.l     d7,-(a7)
[000002a2] 486e ff98                 pea.l      -104(a6)
[000002a6] 3e2e fffc                 move.w     -4(a6),d7
[000002aa] 48c7                      ext.l      d7
[000002ac] 2f07                      move.l     d7,-(a7)
[000002ae] 4eb9 0000 05c2            jsr        _pputf
[000002b4] 4fef 000c                 lea.l      12(a7),a7
[000002b8] 4a87                      tst.l      d7
[000002ba] 6c14                      bge.s      $000002D0
[000002bc] 3e39 0002 0098            move.w     $00021A00,d7
[000002c2] 48c7                      ext.l      d7
[000002c4] 2e87                      move.l     d7,(a7)
[000002c6] 4eb9 0000 0526            jsr        _ppeof
[000002cc] 6000 ff34                 bra        $00000202
[000002d0] 3e39 0002 0098            move.w     $00021A00,d7
[000002d6] 48c7                      ext.l      d7
[000002d8] 2e87                      move.l     d7,(a7)
[000002da] 4eb9 0000 0526            jsr        _ppeof
[000002e0] 3e2e fffc                 move.w     -4(a6),d7
[000002e4] 48c7                      ext.l      d7
[000002e6] 2e87                      move.l     d7,(a7)
[000002e8] 4eb9 0000 091a            jsr        __close
[000002ee] 6000 feb0                 bra        $000001A0
[000002f2] 3e39 0002 0098            move.w     $00021A00,d7
[000002f8] 48c7                      ext.l      d7
[000002fa] 2e87                      move.l     d7,(a7)
[000002fc] 4eb9 0000 0526            jsr        _ppeof
[00000302] 4ab9 0002 0082            tst.l      $000219EA
[00000308] 661a                      bne.s      $00000324
[0000030a] 4287                      clr.l      d7
[0000030c] 3e2e fffe                 move.w     -2(a6),d7
[00000310] 2e87                      move.l     d7,(a7)
[00000312] 3e39 0002 0098            move.w     $00021A00,d7
[00000318] 48c7                      ext.l      d7
[0000031a] 2f07                      move.l     d7,-(a7)
[0000031c] 4eb9 0000 0338            jsr        _smode
[00000322] 588f                      addq.l     #4,a7
[00000324] 4878 0001                 pea.l      ($00000001).w
[00000328] 4eb9 0000 0080            jsr        _exit
[0000032e] 588f                      addq.l     #4,a7
[00000330] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000334] 4e5e                      unlk       a6
[00000336] 4e75                      rts
_smode:
[00000338] 4e56 fff8                 link       a6,#-8
[0000033c] 486e fff8                 pea.l      -8(a6)
[00000340] 2f2e 0008                 move.l     8(a6),-(a7)
[00000344] 4eb9 0000 0f8c            jsr        _gtty
[0000034a] 508f                      addq.l     #8,a7
[0000034c] 4a87                      tst.l      d7
[0000034e] 6c06                      bge.s      $00000356
[00000350] 4287                      clr.l      d7
[00000352] 4e5e                      unlk       a6
[00000354] 4e75                      rts
[00000356] 3d6e fffc fffe            move.w     -4(a6),-2(a6)
[0000035c] 3d6e 000e fffc            move.w     14(a6),-4(a6)
[00000362] 486e fff8                 pea.l      -8(a6)
[00000366] 2f2e 0008                 move.l     8(a6),-(a7)
[0000036a] 4eb9 0000 0f94            jsr        _stty
[00000370] 508f                      addq.l     #8,a7
[00000372] 4287                      clr.l      d7
[00000374] 3e2e fffe                 move.w     -2(a6),d7
[00000378] 4e5e                      unlk       a6
[0000037a] 4e75                      rts
_tmsg:
[0000037c] 4e56 0000                 link       a6,#0
[00000380] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00000384] 2a6e 0008                 movea.l    8(a6),a5
[00000388] 286e 000c                 movea.l    12(a6),a4
[0000038c] 4ab9 0002 0082            tst.l      $000219EA
[00000392] 6618                      bne.s      $000003AC
[00000394] 4878 0002                 pea.l      ($00000002).w
[00000398] 2f3c 0002 00b4            move.l     #$00021A1C,-(a7)
[0000039e] 4878 0002                 pea.l      ($00000002).w
[000003a2] 4eb9 0000 0908            jsr        __write
[000003a8] 4fef 000c                 lea.l      12(a7),a7
[000003ac] 2e0d                      move.l     a5,d7
[000003ae] 6718                      beq.s      $000003C8
[000003b0] 2e8d                      move.l     a5,(a7)
[000003b2] 4eb9 0000 1772            jsr        _lenstr
[000003b8] 2e87                      move.l     d7,(a7)
[000003ba] 2f0d                      move.l     a5,-(a7)
[000003bc] 4878 0002                 pea.l      ($00000002).w
[000003c0] 4eb9 0000 0908            jsr        __write
[000003c6] 508f                      addq.l     #8,a7
[000003c8] 2e0c                      move.l     a4,d7
[000003ca] 6718                      beq.s      $000003E4
[000003cc] 2e8c                      move.l     a4,(a7)
[000003ce] 4eb9 0000 1772            jsr        _lenstr
[000003d4] 2e87                      move.l     d7,(a7)
[000003d6] 2f0c                      move.l     a4,-(a7)
[000003d8] 4878 0002                 pea.l      ($00000002).w
[000003dc] 4eb9 0000 0908            jsr        __write
[000003e2] 508f                      addq.l     #8,a7
[000003e4] 2e0d                      move.l     a5,d7
[000003e6] 6718                      beq.s      $00000400
[000003e8] 4878 0002                 pea.l      ($00000002).w
[000003ec] 2f3c 0002 00b6            move.l     #$00021A1E,-(a7)
[000003f2] 4878 0002                 pea.l      ($00000002).w
[000003f6] 4eb9 0000 0908            jsr        __write
[000003fc] 4fef 000c                 lea.l      12(a7),a7
[00000400] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00000404] 4e5e                      unlk       a6
[00000406] 4e75                      rts
_ackwait:
[00000408] 4e56 fffa                 link       a6,#-6
[0000040c] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00000410] 4297                      clr.l      (a7)
[00000412] 4eb9 0000 08ee            jsr        __time
[00000418] 5a87                      addq.l     #5,d7
[0000041a] 2d47 fffc                 move.l     d7,-4(a6)
[0000041e] 13ee 000f 0002 00cc       move.b     15(a6),$00021A34
[00000426] 4285                      clr.l      d5
[00000428] 2eae 0008                 move.l     8(a6),(a7)
[0000042c] 4eb9 0000 0884            jsr        _readtmo
[00000432] 2807                      move.l     d7,d4
[00000434] 6c2e                      bge.s      $00000464
[00000436] 4297                      clr.l      (a7)
[00000438] 4eb9 0000 08ee            jsr        __time
[0000043e] 2c2e fffc                 move.l     -4(a6),d6
[00000442] bc87                      cmp.l      d7,d6
[00000444] 6ee2                      bgt.s      $00000428
[00000446] 2ebc 0002 00f6            move.l     #$00021A5E,(a7)
[0000044c] 2f3c 0002 00c8            move.l     #$00021A30,-(a7)
[00000452] 4eb9 0000 037c            jsr        _tmsg
[00000458] 588f                      addq.l     #4,a7
[0000045a] 4287                      clr.l      d7
[0000045c] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[00000460] 4e5e                      unlk       a6
[00000462] 4e75                      rts
[00000464] 0c84 0000 007f            cmpi.l     #$0000007F,d4
[0000046a] 660e                      bne.s      $0000047A
[0000046c] 4878 ffff                 pea.l      ($FFFFFFFF).w
[00000470] 4eb9 0000 0962            jsr        _leave
[00000476] 588f                      addq.l     #4,a7
[00000478] 60ae                      bra.s      $00000428
[0000047a] 0c84 0000 0011            cmpi.l     #$00000011,d4
[00000480] 67a6                      beq.s      $00000428
[00000482] 0c84 0000 0013            cmpi.l     #$00000013,d4
[00000488] 679e                      beq.s      $00000428
[0000048a] 2e05                      move.l     d5,d7
[0000048c] 41f9 0002 00ce            lea.l      $00021A36,a0
[00000492] 4ef9 0000 0f9c            jmp        a.switch
[00000498] 0c84 0000 005c            cmpi.l     #$0000005C,d4
[0000049e] 6688                      bne.s      $00000428
[000004a0] 7a01                      moveq.l    #1,d5
[000004a2] 6084                      bra.s      $00000428
[000004a4] 6082                      bra.s      $00000428
[000004a6] 0c84 0000 002e            cmpi.l     #$0000002E,d4
[000004ac] 6610                      bne.s      $000004BE
[000004ae] 4878 ffff                 pea.l      ($FFFFFFFF).w
[000004b2] 4eb9 0000 0962            jsr        _leave
[000004b8] 588f                      addq.l     #4,a7
[000004ba] 6000 ff6c                 bra        $00000428
[000004be] 0c84 0000 0041            cmpi.l     #$00000041,d4
[000004c4] 6606                      bne.s      $000004CC
[000004c6] 7a02                      moveq.l    #2,d5
[000004c8] 6000 ff5e                 bra        $00000428
[000004cc] 0c84 0000 004d            cmpi.l     #$0000004D,d4
[000004d2] 6606                      bne.s      $000004DA
[000004d4] 7a03                      moveq.l    #3,d5
[000004d6] 6000 ff50                 bra        $00000428
[000004da] 4285                      clr.l      d5
[000004dc] 6000 ff4a                 bra        $00000428
[000004e0] b8ae 000c                 cmp.l      12(a6),d4
[000004e4] 6604                      bne.s      $000004EA
[000004e6] 7e01                      moveq.l    #1,d7
[000004e8] 6002                      bra.s      $000004EC
[000004ea] 4287                      clr.l      d7
[000004ec] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[000004f0] 4e5e                      unlk       a6
[000004f2] 4e75                      rts
[000004f4] 1d44 fffb                 move.b     d4,-5(a6)
[000004f8] 4878 0001                 pea.l      ($00000001).w
[000004fc] 486e fffb                 pea.l      -5(a6)
[00000500] 4878 0002                 pea.l      ($00000002).w
[00000504] 4eb9 0000 0908            jsr        __write
[0000050a] 4fef 000c                 lea.l      12(a7),a7
[0000050e] 0c84 0000 000a            cmpi.l     #$0000000A,d4
[00000514] 670a                      beq.s      $00000520
[00000516] 0c84 0000 005c            cmpi.l     #$0000005C,d4
[0000051c] 6600 ff0a                 bne        $00000428
[00000520] 4285                      clr.l      d5
[00000522] 6000 ff04                 bra        $00000428
_ppeof:
[00000526] 4e56 0000                 link       a6,#0
[0000052a] 4878 0002                 pea.l      ($00000002).w
[0000052e] 2f3c 0002 0102            move.l     #$00021A6A,-(a7)
[00000534] 2f2e 0008                 move.l     8(a6),-(a7)
[00000538] 4eb9 0000 0908            jsr        __write
[0000053e] 4fef 000c                 lea.l      12(a7),a7
[00000542] 4e5e                      unlk       a6
[00000544] 4e75                      rts
_pputc:
[00000546] 4e56 0000                 link       a6,#0
[0000054a] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000054e] 2a2e 0008                 move.l     8(a6),d5
[00000552] 2e39 0002 00c2            move.l     $00021A2A,d7
[00000558] 3c39 0002 00bc            move.w     $00021A24,d6
[0000055e] 48c6                      ext.l      d6
[00000560] de86                      add.l      d6,d7
[00000562] 2a47                      movea.l    d7,a5
[00000564] 4a79 0002 00bc            tst.w      $00021A24
[0000056a] 6618                      bne.s      $00000584
[0000056c] 1afc 005c                 move.b     #$5C,(a5)+
[00000570] 1afc 0053                 move.b     #$53,(a5)+
[00000574] 1af9 0002 00c6            move.b     $00021A2E,(a5)+
[0000057a] 13f9 0002 00c6 0002 00c7  move.b     $00021A2E,$00021A2F
[00000584] 1ac5                      move.b     d5,(a5)+
[00000586] bb39 0002 00c7            eor.b      d5,$00021A2F
[0000058c] 0c85 0000 005c            cmpi.l     #$0000005C,d5
[00000592] 6604                      bne.s      $00000598
[00000594] 1afc 005c                 move.b     #$5C,(a5)+
[00000598] 2e0d                      move.l     a5,d7
[0000059a] 9eb9 0002 00c2            sub.l      $00021A2A,d7
[000005a0] 33c7 0002 00bc            move.w     d7,$00021A24
[000005a6] 3e39 0002 00bc            move.w     $00021A24,d7
[000005ac] 48c7                      ext.l      d7
[000005ae] 0c47 00c2                 cmpi.w     #$00C2,d7
[000005b2] 6f06                      ble.s      $000005BA
[000005b4] 4eb9 0000 0746            jsr        _pputp
[000005ba] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[000005be] 4e5e                      unlk       a6
[000005c0] 4e75                      rts
_pputf:
[000005c2] 4e56 ffd4                 link       a6,#-44
[000005c6] 4ab9 0002 00c2            tst.l      $00021A2A
[000005cc] 6612                      bne.s      $000005E0
[000005ce] 2ebc 0000 00c8            move.l     #$000000C8,(a7)
[000005d4] 4eb9 0000 12d0            jsr        _alloc
[000005da] 23c7 0002 00c2            move.l     d7,$00021A2A
[000005e0] 33ee 0016 0002 00c0       move.w     22(a6),$00021A28
[000005e8] 33ee 0012 0002 00be       move.w     18(a6),$00021A26
[000005f0] 486e ffee                 pea.l      -18(a6)
[000005f4] 4878 0002                 pea.l      ($00000002).w
[000005f8] 3e39 0002 00c0            move.w     $00021A28,d7
[000005fe] 48c7                      ext.l      d7
[00000600] 2f07                      move.l     d7,-(a7)
[00000602] 4eb9 0000 08b8            jsr        __ioctl
[00000608] 4fef 000c                 lea.l      12(a7),a7
[0000060c] 4878 0012                 pea.l      ($00000012).w
[00000610] 486e ffee                 pea.l      -18(a6)
[00000614] 486e ffdc                 pea.l      -36(a6)
[00000618] 4eb9 0000 1090            jsr        _cpybuf
[0000061e] 4fef 000c                 lea.l      12(a7),a7
[00000622] 422e ffe9                 clr.b      -23(a6)
[00000626] 1d7c 000a ffea            move.b     #$0A,-22(a6)
[0000062c] 3d7c 0005 ffdc            move.w     #$0005,-36(a6)
[00000632] 426e ffde                 clr.w      -34(a6)
[00000636] 426e ffe2                 clr.w      -30(a6)
[0000063a] 486e ffdc                 pea.l      -36(a6)
[0000063e] 4878 0003                 pea.l      ($00000003).w
[00000642] 3e39 0002 00c0            move.w     $00021A28,d7
[00000648] 48c7                      ext.l      d7
[0000064a] 2f07                      move.l     d7,-(a7)
[0000064c] 4eb9 0000 08b8            jsr        __ioctl
[00000652] 4fef 000c                 lea.l      12(a7),a7
[00000656] 4aae 000c                 tst.l      12(a6)
[0000065a] 6724                      beq.s      $00000680
[0000065c] 4279 0002 00bc            clr.w      $00021A24
[00000662] 13fc 0030 0002 00c6       move.b     #$30,$00021A2E
[0000066a] 2eae 000c                 move.l     12(a6),(a7)
[0000066e] 2f3c 0000 06ec            move.l     #_pputn,-(a7)
[00000674] 4eb9 0000 092c            jsr        _enter
[0000067a] 588f                      addq.l     #4,a7
[0000067c] 2d47 ffd8                 move.l     d7,-40(a6)
[00000680] 0cae ffff ffff ffd8       cmpi.l     #$FFFFFFFF,-40(a6)
[00000688] 6716                      beq.s      $000006A0
[0000068a] 2eae 0008                 move.l     8(a6),(a7)
[0000068e] 2f3c 0000 0836            move.l     #_pputx,-(a7)
[00000694] 4eb9 0000 092c            jsr        _enter
[0000069a] 588f                      addq.l     #4,a7
[0000069c] 2d47 ffd8                 move.l     d7,-40(a6)
[000006a0] 0cae ffff ffff ffd8       cmpi.l     #$FFFFFFFF,-40(a6)
[000006a8] 660e                      bne.s      $000006B8
[000006aa] 3e39 0002 00be            move.w     $00021A26,d7
[000006b0] 48c7                      ext.l      d7
[000006b2] 2e87                      move.l     d7,(a7)
[000006b4] 4eba fe70                 jsr        _ppeof(pc)
[000006b8] 1d7c 0001 fffb            move.b     #$01,-5(a6)
[000006be] 422e fffc                 clr.b      -4(a6)
[000006c2] 08ae 0001 fff5            bclr       #1,-11(a6)
[000006c8] 486e ffee                 pea.l      -18(a6)
[000006cc] 4878 0003                 pea.l      ($00000003).w
[000006d0] 3e39 0002 00c0            move.w     $00021A28,d7
[000006d6] 48c7                      ext.l      d7
[000006d8] 2f07                      move.l     d7,-(a7)
[000006da] 4eb9 0000 08b8            jsr        __ioctl
[000006e0] 4fef 000c                 lea.l      12(a7),a7
[000006e4] 2e2e ffd8                 move.l     -40(a6),d7
[000006e8] 4e5e                      unlk       a6
[000006ea] 4e75                      rts
_pputn:
[000006ec] 4e56 0000                 link       a6,#0
[000006f0] 48e7 8004                 movem.l    d0/a5,-(a7)
[000006f4] 2a6e 0008                 movea.l    8(a6),a5
[000006f8] 4878 0002                 pea.l      ($00000002).w
[000006fc] 2f3c 0002 0104            move.l     #$00021A6C,-(a7)
[00000702] 3e39 0002 00be            move.w     $00021A26,d7
[00000708] 48c7                      ext.l      d7
[0000070a] 2f07                      move.l     d7,-(a7)
[0000070c] 4eb9 0000 0908            jsr        __write
[00000712] 4fef 000c                 lea.l      12(a7),a7
[00000716] 4a15                      tst.b      (a5)
[00000718] 670c                      beq.s      $00000726
[0000071a] 4287                      clr.l      d7
[0000071c] 1e1d                      move.b     (a5)+,d7
[0000071e] 2e87                      move.l     d7,(a7)
[00000720] 4eba fe24                 jsr        _pputc(pc)
[00000724] 60f0                      bra.s      $00000716
[00000726] 4878 000a                 pea.l      ($0000000A).w
[0000072a] 4eba fe1a                 jsr        _pputc(pc)
[0000072e] 588f                      addq.l     #4,a7
[00000730] 4eb9 0000 0746            jsr        _pputp
[00000736] 4297                      clr.l      (a7)
[00000738] 4eb9 0000 0962            jsr        _leave
[0000073e] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00000742] 4e5e                      unlk       a6
[00000744] 4e75                      rts
_pputp:
[00000746] 4e56 0000                 link       a6,#0
[0000074a] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000074e] 4a79 0002 00bc            tst.w      $00021A24
[00000754] 6608                      bne.s      $0000075E
[00000756] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[0000075a] 4e5e                      unlk       a6
[0000075c] 4e75                      rts
[0000075e] 2e39 0002 00c2            move.l     $00021A2A,d7
[00000764] 3c39 0002 00bc            move.w     $00021A24,d6
[0000076a] 48c6                      ext.l      d6
[0000076c] de86                      add.l      d6,d7
[0000076e] 2a47                      movea.l    d7,a5
[00000770] 7e30                      moveq.l    #48,d7
[00000772] 7c0f                      moveq.l    #15,d6
[00000774] 4285                      clr.l      d5
[00000776] 1a39 0002 00c7            move.b     $00021A2F,d5
[0000077c] e885                      asr.l      #4,d5
[0000077e] cc85                      and.l      d5,d6
[00000780] de86                      add.l      d6,d7
[00000782] 1ac7                      move.b     d7,(a5)+
[00000784] 7e30                      moveq.l    #48,d7
[00000786] 7c0f                      moveq.l    #15,d6
[00000788] 4285                      clr.l      d5
[0000078a] 1a39 0002 00c7            move.b     $00021A2F,d5
[00000790] cc85                      and.l      d5,d6
[00000792] de86                      add.l      d6,d7
[00000794] 1ac7                      move.b     d7,(a5)+
[00000796] 1afc 005c                 move.b     #$5C,(a5)+
[0000079a] 1afc 0045                 move.b     #$45,(a5)+
[0000079e] 2e0d                      move.l     a5,d7
[000007a0] 9eb9 0002 00c2            sub.l      $00021A2A,d7
[000007a6] 33c7 0002 00bc            move.w     d7,$00021A24
[000007ac] 3e39 0002 00bc            move.w     $00021A24,d7
[000007b2] 48c7                      ext.l      d7
[000007b4] 2e87                      move.l     d7,(a7)
[000007b6] 2f39 0002 00c2            move.l     $00021A2A,-(a7)
[000007bc] 3e39 0002 00be            move.w     $00021A26,d7
[000007c2] 48c7                      ext.l      d7
[000007c4] 2f07                      move.l     d7,-(a7)
[000007c6] 4eb9 0000 0908            jsr        __write
[000007cc] 508f                      addq.l     #8,a7
[000007ce] 3c39 0002 00bc            move.w     $00021A24,d6
[000007d4] 48c6                      ext.l      d6
[000007d6] be86                      cmp.l      d6,d7
[000007d8] 670e                      beq.s      $000007E8
[000007da] 4878 ffff                 pea.l      ($FFFFFFFF).w
[000007de] 4eb9 0000 0962            jsr        _leave
[000007e4] 588f                      addq.l     #4,a7
[000007e6] 60c4                      bra.s      $000007AC
[000007e8] 4287                      clr.l      d7
[000007ea] 1e39 0002 00c6            move.b     $00021A2E,d7
[000007f0] 2e87                      move.l     d7,(a7)
[000007f2] 3e39 0002 00c0            move.w     $00021A28,d7
[000007f8] 48c7                      ext.l      d7
[000007fa] 2f07                      move.l     d7,-(a7)
[000007fc] 4eba fc0a                 jsr        _ackwait(pc)
[00000800] 588f                      addq.l     #4,a7
[00000802] 0c87 0000 0001            cmpi.l     #$00000001,d7
[00000808] 66a2                      bne.s      $000007AC
[0000080a] 4287                      clr.l      d7
[0000080c] 1e39 0002 00c6            move.b     $00021A2E,d7
[00000812] 0c47 0039                 cmpi.w     #$0039,d7
[00000816] 660a                      bne.s      $00000822
[00000818] 13fc 0031 0002 00c6       move.b     #$31,$00021A2E
[00000820] 6006                      bra.s      $00000828
[00000822] 5239 0002 00c6            addq.b     #1,$00021A2E
[00000828] 4279 0002 00bc            clr.w      $00021A24
[0000082e] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000832] 4e5e                      unlk       a6
[00000834] 4e75                      rts
_pputx:
[00000836] 4e56 fe00                 link       a6,#-512
[0000083a] 48e7 8404                 movem.l    d0/d5/a5,-(a7)
[0000083e] 2ebc 0000 0200            move.l     #$00000200,(a7)
[00000844] 486e fe00                 pea.l      -512(a6)
[00000848] 2f2e 0008                 move.l     8(a6),-(a7)
[0000084c] 4eb9 0000 08dc            jsr        __read
[00000852] 508f                      addq.l     #8,a7
[00000854] 2a07                      move.l     d7,d5
[00000856] 6e14                      bgt.s      $0000086C
[00000858] 4eba feec                 jsr        _pputp(pc)
[0000085c] 4297                      clr.l      (a7)
[0000085e] 4eb9 0000 0962            jsr        _leave
[00000864] 4cdf 2021                 movem.l    (a7)+,d0/d5/a5
[00000868] 4e5e                      unlk       a6
[0000086a] 4e75                      rts
[0000086c] 45ee fe00                 lea.l      -512(a6),a2
[00000870] 2a4a                      movea.l    a2,a5
[00000872] 5385                      subq.l     #1,d5
[00000874] 6dc8                      blt.s      $0000083E
[00000876] 4287                      clr.l      d7
[00000878] 1e15                      move.b     (a5),d7
[0000087a] 2e87                      move.l     d7,(a7)
[0000087c] 4eba fcc8                 jsr        _pputc(pc)
[00000880] 528d                      addq.l     #1,a5
[00000882] 60ee                      bra.s      $00000872
_readtmo:
[00000884] 4e56 fffe                 link       a6,#-2
[00000888] 4878 0001                 pea.l      ($00000001).w
[0000088c] 486e ffff                 pea.l      -1(a6)
[00000890] 2f2e 0008                 move.l     8(a6),-(a7)
[00000894] 4eb9 0000 08dc            jsr        __read
[0000089a] 4fef 000c                 lea.l      12(a7),a7
[0000089e] 0c87 0000 0001            cmpi.l     #$00000001,d7
[000008a4] 6704                      beq.s      $000008AA
[000008a6] 7eff                      moveq.l    #-1,d7
[000008a8] 600a                      bra.s      $000008B4
[000008aa] 7e7f                      moveq.l    #127,d7
[000008ac] 4286                      clr.l      d6
[000008ae] 1c2e ffff                 move.b     -1(a6),d6
[000008b2] ce86                      and.l      d6,d7
[000008b4] 4e5e                      unlk       a6
[000008b6] 4e75                      rts
__ioctl:
[000008b8] 205f                      movea.l    (a7)+,a0
[000008ba] 7e36                      moveq.l    #54,d7
[000008bc] 4e41                      trap       #1
[000008be] 6400 0008                 bcc.w      $000008C8
[000008c2] 4ef9 0000 00ba            jmp        seterr
[000008c8] 4ed0                      jmp        (a0)
__open:
[000008ca] 205f                      movea.l    (a7)+,a0
[000008cc] 7e05                      moveq.l    #5,d7
[000008ce] 4e41                      trap       #1
[000008d0] 6400 0008                 bcc.w      $000008DA
[000008d4] 4ef9 0000 00ba            jmp        seterr
[000008da] 4ed0                      jmp        (a0)
__read:
[000008dc] 205f                      movea.l    (a7)+,a0
[000008de] 7e03                      moveq.l    #3,d7
[000008e0] 4e41                      trap       #1
[000008e2] 6400 0008                 bcc.w      $000008EC
[000008e6] 4ef9 0000 00ba            jmp        seterr
[000008ec] 4ed0                      jmp        (a0)
__time:
[000008ee] 205f                      movea.l    (a7)+,a0
[000008f0] 7e0d                      moveq.l    #13,d7
[000008f2] 4e41                      trap       #1
[000008f4] 6400 0008                 bcc.w      $000008FE
[000008f8] 4ef9 0000 00ba            jmp        seterr
[000008fe] 4a97                      tst.l      (a7)
[00000900] 6704                      beq.s      $00000906
[00000902] 2257                      movea.l    (a7),a1
[00000904] 2287                      move.l     d7,(a1)
[00000906] 4ed0                      jmp        (a0)
__write:
[00000908] 205f                      movea.l    (a7)+,a0
[0000090a] 7e04                      moveq.l    #4,d7
[0000090c] 4e41                      trap       #1
[0000090e] 6400 0008                 bcc.w      $00000918
[00000912] 4ef9 0000 00ba            jmp        seterr
[00000918] 4ed0                      jmp        (a0)
__close:
[0000091a] 205f                      movea.l    (a7)+,a0
[0000091c] 7e06                      moveq.l    #6,d7
[0000091e] 4e41                      trap       #1
[00000920] 6400 0008                 bcc.w      $0000092A
[00000924] 4ef9 0000 00ba            jmp        seterr
[0000092a] 4ed0                      jmp        (a0)
_enter:
[0000092c] 4e56 fffc                 link       a6,#-4
[00000930] 4297                      clr.l      (a7)
[00000932] 2f3c 0002 0106            move.l     #$00021A6E,-(a7)
[00000938] 42a7                      clr.l      -(a7)
[0000093a] 4eb9 0000 185c            jsr        __when
[00000940] 508f                      addq.l     #8,a7
[00000942] 4a87                      tst.l      d7
[00000944] 6c12                      bge.s      $00000958
[00000946] 2eae 000c                 move.l     12(a6),(a7)
[0000094a] 246e 0008                 movea.l    8(a6),a2
[0000094e] 4e92                      jsr        (a2)
[00000950] 2e87                      move.l     d7,(a7)
[00000952] 4eb9 0000 0962            jsr        _leave
[00000958] 2e39 0002 011a            move.l     $00021A82,d7
[0000095e] 4e5e                      unlk       a6
[00000960] 4e75                      rts
_leave:
[00000962] 4e56 fffc                 link       a6,#-4
[00000966] 23ee 0008 0002 011a       move.l     8(a6),$00021A82
[0000096e] 2ebc 0002 0106            move.l     #$00021A6E,(a7)
[00000974] 42a7                      clr.l      -(a7)
[00000976] 4eb9 0000 17c0            jsr        __raise
[0000097c] 588f                      addq.l     #4,a7
[0000097e] 4e5e                      unlk       a6
[00000980] 4e75                      rts
_getenv:
[00000982] 4e56 0000                 link       a6,#0
[00000986] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000098a] 2a6e 0008                 movea.l    8(a6),a5
[0000098e] 2e8d                      move.l     a5,(a7)
[00000990] 4eb9 0000 1772            jsr        _lenstr
[00000996] 2a07                      move.l     d7,d5
[00000998] 2879 0002 0072            movea.l    _environ,a4
[0000099e] 2e0c                      move.l     a4,d7
[000009a0] 672e                      beq.s      $000009D0
[000009a2] 4a94                      tst.l      (a4)
[000009a4] 672a                      beq.s      $000009D0
[000009a6] 2e85                      move.l     d5,(a7)
[000009a8] 2f14                      move.l     (a4),-(a7)
[000009aa] 2f0d                      move.l     a5,-(a7)
[000009ac] 4eb9 0000 1024            jsr        _cmpbuf
[000009b2] 508f                      addq.l     #8,a7
[000009b4] 4a87                      tst.l      d7
[000009b6] 6722                      beq.s      $000009DA
[000009b8] 2454                      movea.l    (a4),a2
[000009ba] d5c5                      adda.l     d5,a2
[000009bc] 4287                      clr.l      d7
[000009be] 1e12                      move.b     (a2),d7
[000009c0] 0c47 003d                 cmpi.w     #$003D,d7
[000009c4] 6614                      bne.s      $000009DA
[000009c6] 2e14                      move.l     (a4),d7
[000009c8] 2445                      movea.l    d5,a2
[000009ca] 528a                      addq.l     #1,a2
[000009cc] de8a                      add.l      a2,d7
[000009ce] 6002                      bra.s      $000009D2
[000009d0] 4287                      clr.l      d7
[000009d2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000009d6] 4e5e                      unlk       a6
[000009d8] 4e75                      rts
[000009da] 588c                      addq.l     #4,a4
[000009dc] 60c0                      bra.s      $0000099E
_getfiles:
[000009de] 4e56 0000                 link       a6,#0
[000009e2] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[000009e6] 2a6e 0008                 movea.l    8(a6),a5
[000009ea] 286e 000c                 movea.l    12(a6),a4
[000009ee] 4a95                      tst.l      (a5)
[000009f0] 6c04                      bge.s      $000009F6
[000009f2] 7aff                      moveq.l    #-1,d5
[000009f4] 601e                      bra.s      $00000A14
[000009f6] 4a95                      tst.l      (a5)
[000009f8] 6716                      beq.s      $00000A10
[000009fa] 2ebc 0002 011e            move.l     #$00021A86,(a7)
[00000a00] 2454                      movea.l    (a4),a2
[00000a02] 2f12                      move.l     (a2),-(a7)
[00000a04] 4eb9 0000 105a            jsr        _cmpstr
[00000a0a] 588f                      addq.l     #4,a7
[00000a0c] 4a87                      tst.l      d7
[00000a0e] 6710                      beq.s      $00000A20
[00000a10] 2a2e 0010                 move.l     16(a6),d5
[00000a14] 5894                      addq.l     #4,(a4)
[00000a16] 5395                      subq.l     #1,(a5)
[00000a18] 6e20                      bgt.s      $00000A3A
[00000a1a] 70ff                      moveq.l    #-1,d0
[00000a1c] 2a80                      move.l     d0,(a5)
[00000a1e] 601a                      bra.s      $00000A3A
[00000a20] 4297                      clr.l      (a7)
[00000a22] 42a7                      clr.l      -(a7)
[00000a24] 2454                      movea.l    (a4),a2
[00000a26] 2f12                      move.l     (a2),-(a7)
[00000a28] 4eb9 0000 11fc            jsr        _open
[00000a2e] 508f                      addq.l     #8,a7
[00000a30] 2a07                      move.l     d7,d5
[00000a32] 6ce0                      bge.s      $00000A14
[00000a34] 2a2e 0014                 move.l     20(a6),d5
[00000a38] 60da                      bra.s      $00000A14
[00000a3a] 2e05                      move.l     d5,d7
[00000a3c] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000a40] 4e5e                      unlk       a6
[00000a42] 4e75                      rts
[00000a44] 4e56 0000                 link       a6,#0
[00000a48] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00000a4c] 2a6e 0008                 movea.l    8(a6),a5
[00000a50] 286e 000c                 movea.l    12(a6),a4
[00000a54] 4297                      clr.l      (a7)
[00000a56] 4eb9 0000 0fae            jsr        _usage
[00000a5c] 2a07                      move.l     d7,d5
[00000a5e] 4a15                      tst.b      (a5)
[00000a60] 6720                      beq.s      $00000A82
[00000a62] 4287                      clr.l      d7
[00000a64] 1e15                      move.b     (a5),d7
[00000a66] 0c47 0046                 cmpi.w     #$0046,d7
[00000a6a] 673e                      beq.s      $00000AAA
[00000a6c] 2e85                      move.l     d5,(a7)
[00000a6e] 2f0d                      move.l     a5,-(a7)
[00000a70] 4878 0002                 pea.l      ($00000002).w
[00000a74] 4eb9 0000 0f22            jsr        $00000F22
[00000a7a] 508f                      addq.l     #8,a7
[00000a7c] 2a07                      move.l     d7,d5
[00000a7e] 6000 0098                 bra        $00000B18
[00000a82] 4878 0001                 pea.l      ($00000001).w
[00000a86] 2f3c 0002 0120            move.l     #$00021A88,-(a7)
[00000a8c] 4878 0002                 pea.l      ($00000002).w
[00000a90] 4eb9 0000 1960            jsr        _write
[00000a96] 4fef 000c                 lea.l      12(a7),a7
[00000a9a] 4297                      clr.l      (a7)
[00000a9c] 4eb9 0000 0080            jsr        _exit
[00000aa2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00000aa6] 4e5e                      unlk       a6
[00000aa8] 4e75                      rts
[00000aaa] 4878 0002                 pea.l      ($00000002).w
[00000aae] 2f3c 0002 012a            move.l     #$00021A92,-(a7)
[00000ab4] 4878 0002                 pea.l      ($00000002).w
[00000ab8] 4eb9 0000 1960            jsr        _write
[00000abe] 4fef 000c                 lea.l      12(a7),a7
[00000ac2] da87                      add.l      d7,d5
[00000ac4] 4287                      clr.l      d7
[00000ac6] 1e14                      move.b     (a4),d7
[00000ac8] 0c47 003a                 cmpi.w     #$003A,d7
[00000acc] 6730                      beq.s      $00000AFE
[00000ace] 4287                      clr.l      d7
[00000ad0] 1e14                      move.b     (a4),d7
[00000ad2] 0c47 002c                 cmpi.w     #$002C,d7
[00000ad6] 6646                      bne.s      $00000B1E
[00000ad8] 4287                      clr.l      d7
[00000ada] 1e2c 0001                 move.b     1(a4),d7
[00000ade] 0c47 003a                 cmpi.w     #$003A,d7
[00000ae2] 673a                      beq.s      $00000B1E
[00000ae4] 2e85                      move.l     d5,(a7)
[00000ae6] 2f3c 0002 0128            move.l     #$00021A90,-(a7)
[00000aec] 4878 0002                 pea.l      ($00000002).w
[00000af0] 4eb9 0000 0f22            jsr        $00000F22
[00000af6] 508f                      addq.l     #8,a7
[00000af8] 2a07                      move.l     d7,d5
[00000afa] 6000 0080                 bra        $00000B7C ; possibly optimized to short
[00000afe] 4878 0001                 pea.l      ($00000001).w
[00000b02] 2f3c 0002 0122            move.l     #$00021A8A,-(a7)
[00000b08] 4878 0002                 pea.l      ($00000002).w
[00000b0c] 4eb9 0000 1960            jsr        _write
[00000b12] 4fef 000c                 lea.l      12(a7),a7
[00000b16] da87                      add.l      d7,d5
[00000b18] 528d                      addq.l     #1,a5
[00000b1a] 6000 ff42                 bra        $00000A5E
[00000b1e] 4287                      clr.l      d7
[00000b20] 1e14                      move.b     (a4),d7
[00000b22] 0c47 003e                 cmpi.w     #$003E,d7
[00000b26] 663e                      bne.s      $00000B66
[00000b28] 4878 0001                 pea.l      ($00000001).w
[00000b2c] 2f3c 0002 0126            move.l     #$00021A8E,-(a7)
[00000b32] 4878 0002                 pea.l      ($00000002).w
[00000b36] 4eb9 0000 1960            jsr        _write
[00000b3c] 4fef 000c                 lea.l      12(a7),a7
[00000b40] da87                      add.l      d7,d5
[00000b42] 4287                      clr.l      d7
[00000b44] 1e2c 0001                 move.b     1(a4),d7
[00000b48] 0c47 003a                 cmpi.w     #$003A,d7
[00000b4c] 672e                      beq.s      $00000B7C
[00000b4e] 2e85                      move.l     d5,(a7)
[00000b50] 2f3c 0002 0124            move.l     #$00021A8C,-(a7)
[00000b56] 4878 0002                 pea.l      ($00000002).w
[00000b5a] 4eb9 0000 0f22            jsr        $00000F22
[00000b60] 508f                      addq.l     #8,a7
[00000b62] 2a07                      move.l     d7,d5
[00000b64] 6016                      bra.s      $00000B7C
[00000b66] 4878 0001                 pea.l      ($00000001).w
[00000b6a] 2f0c                      move.l     a4,-(a7)
[00000b6c] 4878 0002                 pea.l      ($00000002).w
[00000b70] 4eb9 0000 1960            jsr        _write
[00000b76] 4fef 000c                 lea.l      12(a7),a7
[00000b7a] da87                      add.l      d7,d5
[00000b7c] 528c                      addq.l     #1,a4
[00000b7e] 6000 ff44                 bra        $00000AC4
_getflags:
[00000b82] 4e56 ffe2                 link       a6,#-30
[00000b86] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00000b8a] 246e 000c                 movea.l    12(a6),a2
[00000b8e] 5892                      addq.l     #4,(a2)
[00000b90] 246e 0008                 movea.l    8(a6),a2
[00000b94] 4a92                      tst.l      (a2)
[00000b96] 6730                      beq.s      $00000BC8
[00000b98] 246e 0008                 movea.l    8(a6),a2
[00000b9c] 5392                      subq.l     #1,(a2)
[00000b9e] 6728                      beq.s      $00000BC8
[00000ba0] 246e 000c                 movea.l    12(a6),a2
[00000ba4] 2452                      movea.l    (a2),a2
[00000ba6] 2852                      movea.l    (a2),a4
[00000ba8] 2ebc 0002 0175            move.l     #$00021ADD,(a7)
[00000bae] 2f0c                      move.l     a4,-(a7)
[00000bb0] 4eb9 0000 105a            jsr        _cmpstr
[00000bb6] 588f                      addq.l     #4,a7
[00000bb8] 4a87                      tst.l      d7
[00000bba] 671e                      beq.s      $00000BDA
[00000bbc] 246e 0008                 movea.l    8(a6),a2
[00000bc0] 5392                      subq.l     #1,(a2)
[00000bc2] 246e 000c                 movea.l    12(a6),a2
[00000bc6] 5892                      addq.l     #4,(a2)
[00000bc8] 4287                      clr.l      d7
[00000bca] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000bce] 4e5e                      unlk       a6
[00000bd0] 4e75                      rts
[00000bd2] 246e 000c                 movea.l    12(a6),a2
[00000bd6] 5892                      addq.l     #4,(a2)
[00000bd8] 60b6                      bra.s      $00000B90
[00000bda] 2ebc 0002 0173            move.l     #$00021ADB,(a7)
[00000be0] 2f0c                      move.l     a4,-(a7)
[00000be2] 4eb9 0000 105a            jsr        _cmpstr
[00000be8] 588f                      addq.l     #4,a7
[00000bea] 4a87                      tst.l      d7
[00000bec] 66da                      bne.s      $00000BC8
[00000bee] 4287                      clr.l      d7
[00000bf0] 1e14                      move.b     (a4),d7
[00000bf2] 0c47 002d                 cmpi.w     #$002D,d7
[00000bf6] 670a                      beq.s      $00000C02
[00000bf8] 4287                      clr.l      d7
[00000bfa] 1e14                      move.b     (a4),d7
[00000bfc] 0c47 002b                 cmpi.w     #$002B,d7
[00000c00] 66c6                      bne.s      $00000BC8
[00000c02] 4287                      clr.l      d7
[00000c04] 1e14                      move.b     (a4),d7
[00000c06] 0c47 002d                 cmpi.w     #$002D,d7
[00000c0a] 6602                      bne.s      $00000C0E
[00000c0c] 528c                      addq.l     #1,a4
[00000c0e] 4878 0004                 pea.l      ($00000004).w
[00000c12] 2f0c                      move.l     a4,-(a7)
[00000c14] 2f3c 0002 016e            move.l     #$00021AD6,-(a7)
[00000c1a] 4eb9 0000 1024            jsr        _cmpbuf
[00000c20] 4fef 000c                 lea.l      12(a7),a7
[00000c24] 4a87                      tst.l      d7
[00000c26] 6736                      beq.s      $00000C5E
[00000c28] 2eae 0010                 move.l     16(a6),(a7)
[00000c2c] 4287                      clr.l      d7
[00000c2e] 1e2c 0004                 move.b     4(a4),d7
[00000c32] 0c47 003a                 cmpi.w     #$003A,d7
[00000c36] 6716                      beq.s      $00000C4E
[00000c38] 4878 003a                 pea.l      ($0000003A).w
[00000c3c] 2f2e 0010                 move.l     16(a6),-(a7)
[00000c40] 4eb9 0000 123a            jsr        _scnstr
[00000c46] 508f                      addq.l     #8,a7
[00000c48] deae 0010                 add.l      16(a6),d7
[00000c4c] 6006                      bra.s      $00000C54
[00000c4e] 2e3c 0002 0000            move.l     #$00021968,d7
[00000c54] 2f07                      move.l     d7,-(a7)
[00000c56] 5297                      addq.l     #1,(a7)
[00000c58] 4eba fdea                 jsr        $00000A44(pc)
[00000c5c] 588f                      addq.l     #4,a7
[00000c5e] 4a14                      tst.b      (a4)
[00000c60] 6700 ff70                 beq        $00000BD2
[00000c64] 42ae fff4                 clr.l      -12(a6)
[00000c68] 42ae fff8                 clr.l      -8(a6)
[00000c6c] 45ee 0014                 lea.l      20(a6),a2
[00000c70] 2d4a ffea                 move.l     a2,-22(a6)
[00000c74] 264c                      movea.l    a4,a3
[00000c76] 2a6e 0010                 movea.l    16(a6),a5
[00000c7a] 42ae fffc                 clr.l      -4(a6)
[00000c7e] 4aae fffc                 tst.l      -4(a6)
[00000c82] 66da                      bne.s      $00000C5E
[00000c84] 4287                      clr.l      d7
[00000c86] 1e15                      move.b     (a5),d7
[00000c88] 41f9 0002 012e            lea.l      $00021A96,a0
[00000c8e] 4ef9 0000 0f9c            jmp        a.switch
[00000c94] 7001                      moveq.l    #1,d0
[00000c96] 2d40 fff4                 move.l     d0,-12(a6)
[00000c9a] 4a13                      tst.b      (a3)
[00000c9c] 6704                      beq.s      $00000CA2
[00000c9e] 2e0b                      move.l     a3,d7
[00000ca0] 6016                      bra.s      $00000CB8
[00000ca2] 246e 0008                 movea.l    8(a6),a2
[00000ca6] 5392                      subq.l     #1,(a2)
[00000ca8] 670c                      beq.s      $00000CB6
[00000caa] 246e 000c                 movea.l    12(a6),a2
[00000cae] 5892                      addq.l     #4,(a2)
[00000cb0] 2452                      movea.l    (a2),a2
[00000cb2] 2e12                      move.l     (a2),d7
[00000cb4] 6002                      bra.s      $00000CB8
[00000cb6] 2e0b                      move.l     a3,d7
[00000cb8] 2d47 ffe2                 move.l     d7,-30(a6)
[00000cbc] 266e ffe2                 movea.l    -30(a6),a3
[00000cc0] 2d4b ffe6                 move.l     a3,-26(a6)
[00000cc4] 246e ffe6                 movea.l    -26(a6),a2
[00000cc8] 4a12                      tst.b      (a2)
[00000cca] 672e                      beq.s      $00000CFA
[00000ccc] 246e ffe6                 movea.l    -26(a6),a2
[00000cd0] 4287                      clr.l      d7
[00000cd2] 1e12                      move.b     (a2),d7
[00000cd4] 0c47 005c                 cmpi.w     #$005C,d7
[00000cd8] 6610                      bne.s      $00000CEA
[00000cda] 4297                      clr.l      (a7)
[00000cdc] 486e ffe6                 pea.l      -26(a6)
[00000ce0] 4eb9 0000 10ea            jsr        _doesc
[00000ce6] 588f                      addq.l     #4,a7
[00000ce8] 6008                      bra.s      $00000CF2
[00000cea] 246e ffe6                 movea.l    -26(a6),a2
[00000cee] 4287                      clr.l      d7
[00000cf0] 1e12                      move.b     (a2),d7
[00000cf2] 16c7                      move.b     d7,(a3)+
[00000cf4] 52ae ffe6                 addq.l     #1,-26(a6)
[00000cf8] 60ca                      bra.s      $00000CC4
[00000cfa] 4213                      clr.b      (a3)
[00000cfc] 528d                      addq.l     #1,a5
[00000cfe] 6000 ff7e                 bra        $00000C7E
[00000d02] 60f8                      bra.s      $00000CFC
[00000d04] 7001                      moveq.l    #1,d0
[00000d06] 2d40 fff4                 move.l     d0,-12(a6)
[00000d0a] 4287                      clr.l      d7
[00000d0c] 1e13                      move.b     (a3),d7
[00000d0e] 0c47 005c                 cmpi.w     #$005C,d7
[00000d12] 670a                      beq.s      $00000D1E
[00000d14] 4287                      clr.l      d7
[00000d16] 1e13                      move.b     (a3),d7
[00000d18] 2d47 ffe2                 move.l     d7,-30(a6)
[00000d1c] 601a                      bra.s      $00000D38
[00000d1e] 2d4b ffe6                 move.l     a3,-26(a6)
[00000d22] 4297                      clr.l      (a7)
[00000d24] 486e ffe6                 pea.l      -26(a6)
[00000d28] 4eb9 0000 10ea            jsr        _doesc
[00000d2e] 588f                      addq.l     #4,a7
[00000d30] 2d47 ffe2                 move.l     d7,-30(a6)
[00000d34] 266e ffe6                 movea.l    -26(a6),a3
[00000d38] 4a13                      tst.b      (a3)
[00000d3a] 67c0                      beq.s      $00000CFC
[00000d3c] 528b                      addq.l     #1,a3
[00000d3e] 60bc                      bra.s      $00000CFC
[00000d40] 4a13                      tst.b      (a3)
[00000d42] 6618                      bne.s      $00000D5C
[00000d44] 246e 0008                 movea.l    8(a6),a2
[00000d48] 5392                      subq.l     #1,(a2)
[00000d4a] 670c                      beq.s      $00000D58
[00000d4c] 246e 000c                 movea.l    12(a6),a2
[00000d50] 5892                      addq.l     #4,(a2)
[00000d52] 2452                      movea.l    (a2),a2
[00000d54] 2e12                      move.l     (a2),d7
[00000d56] 6002                      bra.s      $00000D5A
[00000d58] 2e0b                      move.l     a3,d7
[00000d5a] 2647                      movea.l    d7,a3
[00000d5c] 4878 0001                 pea.l      ($00000001).w
[00000d60] 486e ffee                 pea.l      -18(a6)
[00000d64] 2f0b                      move.l     a3,-(a7)
[00000d66] 4eb9 0000 1772            jsr        _lenstr
[00000d6c] 588f                      addq.l     #4,a7
[00000d6e] 2f07                      move.l     d7,-(a7)
[00000d70] 2f0b                      move.l     a3,-(a7)
[00000d72] 4eb9 0000 1502            jsr        _btol
[00000d78] 4fef 0010                 lea.l      16(a7),a7
[00000d7c] d7c7                      adda.l     d7,a3
[00000d7e] 4a13                      tst.b      (a3)
[00000d80] 6604                      bne.s      $00000D86
[00000d82] 7e01                      moveq.l    #1,d7
[00000d84] 6002                      bra.s      $00000D88
[00000d86] 4287                      clr.l      d7
[00000d88] 2d47 fff4                 move.l     d7,-12(a6)
[00000d8c] 4aae fff4                 tst.l      -12(a6)
[00000d90] 6616                      bne.s      $00000DA8
[00000d92] 4878 003a                 pea.l      ($0000003A).w
[00000d96] 2f0d                      move.l     a5,-(a7)
[00000d98] 4eb9 0000 123a            jsr        _scnstr
[00000d9e] 508f                      addq.l     #8,a7
[00000da0] 5387                      subq.l     #1,d7
[00000da2] dbc7                      adda.l     d7,a5
[00000da4] 6000 ff56                 bra        $00000CFC
[00000da8] 4287                      clr.l      d7
[00000daa] 1e2d 0001                 move.b     1(a5),d7
[00000dae] 0c47 0023                 cmpi.w     #$0023,d7
[00000db2] 660c                      bne.s      $00000DC0
[00000db4] 528d                      addq.l     #1,a5
[00000db6] 7001                      moveq.l    #1,d0
[00000db8] 2d40 fff8                 move.l     d0,-8(a6)
[00000dbc] 6000 ff3e                 bra        $00000CFC
[00000dc0] 2d6e ffee ffe2            move.l     -18(a6),-30(a6)
[00000dc6] 6000 ff34                 bra        $00000CFC
[00000dca] 4aae fff4                 tst.l      -12(a6)
[00000dce] 6712                      beq.s      $00000DE2
[00000dd0] 4aae fff8                 tst.l      -8(a6)
[00000dd4] 671a                      beq.s      $00000DF0
[00000dd6] 246e ffea                 movea.l    -22(a6),a2
[00000dda] 2452                      movea.l    (a2),a2
[00000ddc] 24ae ffee                 move.l     -18(a6),(a2)
[00000de0] 6018                      bra.s      $00000DFA
[00000de2] 4a15                      tst.b      (a5)
[00000de4] 6620                      bne.s      $00000E06
[00000de6] 2e0c                      move.l     a4,d7
[00000de8] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000dec] 4e5e                      unlk       a6
[00000dee] 4e75                      rts
[00000df0] 246e ffea                 movea.l    -22(a6),a2
[00000df4] 2452                      movea.l    (a2),a2
[00000df6] 24ae ffe2                 move.l     -30(a6),(a2)
[00000dfa] 284b                      movea.l    a3,a4
[00000dfc] 7001                      moveq.l    #1,d0
[00000dfe] 2d40 fffc                 move.l     d0,-4(a6)
[00000e02] 6000 fef8                 bra        $00000CFC
[00000e06] 4287                      clr.l      d7
[00000e08] 1e15                      move.b     (a5),d7
[00000e0a] 0c47 003a                 cmpi.w     #$003A,d7
[00000e0e] 6612                      bne.s      $00000E22
[00000e10] 2eae 0010                 move.l     16(a6),(a7)
[00000e14] 528d                      addq.l     #1,a5
[00000e16] 2f0d                      move.l     a5,-(a7)
[00000e18] 4eba fc2a                 jsr        $00000A44(pc)
[00000e1c] 588f                      addq.l     #4,a7
[00000e1e] 6000 fedc                 bra        $00000CFC
[00000e22] 58ae ffea                 addq.l     #4,-22(a6)
[00000e26] 264c                      movea.l    a4,a3
[00000e28] 6000 fed2                 bra        $00000CFC
[00000e2c] 4aae fff4                 tst.l      -12(a6)
[00000e30] 660a                      bne.s      $00000E3C
[00000e32] 58ae ffea                 addq.l     #4,-22(a6)
[00000e36] 264c                      movea.l    a4,a3
[00000e38] 6000 fec2                 bra        $00000CFC
[00000e3c] 246e ffea                 movea.l    -22(a6),a2
[00000e40] 2452                      movea.l    (a2),a2
[00000e42] 4a92                      tst.l      (a2)
[00000e44] 663c                      bne.s      $00000E82
[00000e46] 4878 003a                 pea.l      ($0000003A).w
[00000e4a] 2f0d                      move.l     a5,-(a7)
[00000e4c] 4eb9 0000 123a            jsr        _scnstr
[00000e52] 508f                      addq.l     #8,a7
[00000e54] 3d47 fff2                 move.w     d7,-14(a6)
[00000e58] 3e2e fff2                 move.w     -14(a6),d7
[00000e5c] 48c7                      ext.l      d7
[00000e5e] 2447                      movea.l    d7,a2
[00000e60] d5cd                      adda.l     a5,a2
[00000e62] 4a12                      tst.b      (a2)
[00000e64] 673e                      beq.s      $00000EA4
[00000e66] 2eae 0010                 move.l     16(a6),(a7)
[00000e6a] 3e2e fff2                 move.w     -14(a6),d7
[00000e6e] 48c7                      ext.l      d7
[00000e70] 45ed 0001                 lea.l      1(a5),a2
[00000e74] de8a                      add.l      a2,d7
[00000e76] 2f07                      move.l     d7,-(a7)
[00000e78] 4eba fbca                 jsr        $00000A44(pc)
[00000e7c] 588f                      addq.l     #4,a7
[00000e7e] 6000 fe7c                 bra        $00000CFC
[00000e82] 4aae fff8                 tst.l      -8(a6)
[00000e86] 6726                      beq.s      $00000EAE
[00000e88] 246e ffea                 movea.l    -22(a6),a2
[00000e8c] 2452                      movea.l    (a2),a2
[00000e8e] 5392                      subq.l     #1,(a2)
[00000e90] 2e12                      move.l     (a2),d7
[00000e92] e587                      asl.l      #2,d7
[00000e94] 246e ffea                 movea.l    -22(a6),a2
[00000e98] 2452                      movea.l    (a2),a2
[00000e9a] 588a                      addq.l     #4,a2
[00000e9c] d5c7                      adda.l     d7,a2
[00000e9e] 24ae ffee                 move.l     -18(a6),(a2)
[00000ea2] 6024                      bra.s      $00000EC8
[00000ea4] 2e0c                      move.l     a4,d7
[00000ea6] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[00000eaa] 4e5e                      unlk       a6
[00000eac] 4e75                      rts
[00000eae] 246e ffea                 movea.l    -22(a6),a2
[00000eb2] 2452                      movea.l    (a2),a2
[00000eb4] 5392                      subq.l     #1,(a2)
[00000eb6] 2e12                      move.l     (a2),d7
[00000eb8] e587                      asl.l      #2,d7
[00000eba] 246e ffea                 movea.l    -22(a6),a2
[00000ebe] 2452                      movea.l    (a2),a2
[00000ec0] 588a                      addq.l     #4,a2
[00000ec2] d5c7                      adda.l     d7,a2
[00000ec4] 24ae ffe2                 move.l     -30(a6),(a2)
[00000ec8] 284b                      movea.l    a3,a4
[00000eca] 7001                      moveq.l    #1,d0
[00000ecc] 2d40 fffc                 move.l     d0,-4(a6)
[00000ed0] 6000 fe2a                 bra        $00000CFC
[00000ed4] 4287                      clr.l      d7
[00000ed6] 1e15                      move.b     (a5),d7
[00000ed8] 4286                      clr.l      d6
[00000eda] 1c13                      move.b     (a3),d6
[00000edc] be86                      cmp.l      d6,d7
[00000ede] 6612                      bne.s      $00000EF2
[00000ee0] 7001                      moveq.l    #1,d0
[00000ee2] 2d40 fff4                 move.l     d0,-12(a6)
[00000ee6] 7001                      moveq.l    #1,d0
[00000ee8] 2d40 ffe2                 move.l     d0,-30(a6)
[00000eec] 528b                      addq.l     #1,a3
[00000eee] 6000 fe0c                 bra        $00000CFC
[00000ef2] 42ae fff4                 clr.l      -12(a6)
[00000ef6] 4a15                      tst.b      (a5)
[00000ef8] 6722                      beq.s      $00000F1C
[00000efa] 4287                      clr.l      d7
[00000efc] 1e15                      move.b     (a5),d7
[00000efe] 0c47 002c                 cmpi.w     #$002C,d7
[00000f02] 6718                      beq.s      $00000F1C
[00000f04] 4287                      clr.l      d7
[00000f06] 1e15                      move.b     (a5),d7
[00000f08] 0c47 003e                 cmpi.w     #$003E,d7
[00000f0c] 670e                      beq.s      $00000F1C
[00000f0e] 4287                      clr.l      d7
[00000f10] 1e15                      move.b     (a5),d7
[00000f12] 0c47 003a                 cmpi.w     #$003A,d7
[00000f16] 6704                      beq.s      $00000F1C
[00000f18] 528d                      addq.l     #1,a5
[00000f1a] 60da                      bra.s      $00000EF6
[00000f1c] 538d                      subq.l     #1,a5
[00000f1e] 6000 fddc                 bra        $00000CFC
[00000f22] 4e56 0000                 link       a6,#0
[00000f26] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000f2a] 2a2e 0008                 move.l     8(a6),d5
[00000f2e] 2a6e 000c                 movea.l    12(a6),a5
[00000f32] 282e 0010                 move.l     16(a6),d4
[00000f36] 0c84 0000 003c            cmpi.l     #$0000003C,d4
[00000f3c] 6f14                      ble.s      $00000F52
[00000f3e] 4287                      clr.l      d7
[00000f40] 1e15                      move.b     (a5),d7
[00000f42] 0c47 0020                 cmpi.w     #$0020,d7
[00000f46] 6724                      beq.s      $00000F6C
[00000f48] 4287                      clr.l      d7
[00000f4a] 1e15                      move.b     (a5),d7
[00000f4c] 0c47 0009                 cmpi.w     #$0009,d7
[00000f50] 671a                      beq.s      $00000F6C
[00000f52] 4878 0001                 pea.l      ($00000001).w
[00000f56] 2f0d                      move.l     a5,-(a7)
[00000f58] 2f05                      move.l     d5,-(a7)
[00000f5a] 4eb9 0000 1960            jsr        _write
[00000f60] 4fef 000c                 lea.l      12(a7),a7
[00000f64] 2444                      movea.l    d4,a2
[00000f66] 528a                      addq.l     #1,a2
[00000f68] 2e0a                      move.l     a2,d7
[00000f6a] 6018                      bra.s      $00000F84
[00000f6c] 4878 0002                 pea.l      ($00000002).w
[00000f70] 2f3c 0002 0178            move.l     #$00021AE0,-(a7)
[00000f76] 2f05                      move.l     d5,-(a7)
[00000f78] 4eb9 0000 1960            jsr        _write
[00000f7e] 4fef 000c                 lea.l      12(a7),a7
[00000f82] 7e04                      moveq.l    #4,d7
[00000f84] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000f88] 4e5e                      unlk       a6
[00000f8a] 4e75                      rts
_gtty:
[00000f8c] 205f                      movea.l    (a7)+,a0
[00000f8e] 7e20                      moveq.l    #32,d7
[00000f90] 4e41                      trap       #1
[00000f92] 4ed0                      jmp        (a0)
_stty:
[00000f94] 205f                      movea.l    (a7)+,a0
[00000f96] 7e1f                      moveq.l    #31,d7
[00000f98] 4e41                      trap       #1
[00000f9a] 4ed0                      jmp        (a0)
a.switch:
[00000f9c] 4a98                      tst.l      (a0)+
[00000f9e] 670a                      beq.s      $00000FAA
[00000fa0] be98                      cmp.l      (a0)+,d7
[00000fa2] 66f8                      bne.s      a.switch
[00000fa4] 2068 fff8                 movea.l    -8(a0),a0
[00000fa8] 4ed0                      jmp        (a0)
[00000faa] 2050                      movea.l    (a0),a0
[00000fac] 4ed0                      jmp        (a0)
_usage:
[00000fae] 4e56 0000                 link       a6,#0
[00000fb2] 48e7 8400                 movem.l    d0/d5,-(a7)
[00000fb6] 4285                      clr.l      d5
[00000fb8] 4297                      clr.l      (a7)
[00000fba] 2f2e 0008                 move.l     8(a6),-(a7)
[00000fbe] 2f3c 0002 017c            move.l     #$00021AE4,-(a7)
[00000fc4] 2f39 0002 01fa            move.l     _pname,-(a7)
[00000fca] 2f3c 0002 017e            move.l     #$00021AE6,-(a7)
[00000fd0] 4878 0002                 pea.l      ($00000002).w
[00000fd4] 4eb9 0000 1204            jsr        _putstr
[00000fda] 4fef 0014                 lea.l      20(a7),a7
[00000fde] 4aae 0008                 tst.l      8(a6)
[00000fe2] 6726                      beq.s      $0000100A
[00000fe4] 2eae 0008                 move.l     8(a6),(a7)
[00000fe8] 4eb9 0000 1772            jsr        _lenstr
[00000fee] 2a07                      move.l     d7,d5
[00000ff0] 2445                      movea.l    d5,a2
[00000ff2] 538a                      subq.l     #1,a2
[00000ff4] d5ee 0008                 adda.l     8(a6),a2
[00000ff8] 4287                      clr.l      d7
[00000ffa] 1e12                      move.b     (a2),d7
[00000ffc] 0c47 000a                 cmpi.w     #$000A,d7
[00001000] 6608                      bne.s      $0000100A
[00001002] 4297                      clr.l      (a7)
[00001004] 4eb9 0000 0080            jsr        _exit
[0000100a] 2eb9 0002 01fa            move.l     _pname,(a7)
[00001010] 4eb9 0000 1772            jsr        _lenstr
[00001016] 2445                      movea.l    d5,a2
[00001018] 508a                      addq.l     #8,a2
[0000101a] de8a                      add.l      a2,d7
[0000101c] 4cdf 0021                 movem.l    (a7)+,d0/d5
[00001020] 4e5e                      unlk       a6
[00001022] 4e75                      rts
_cmpbuf:
[00001024] 4e56 0000                 link       a6,#0
[00001028] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[0000102c] 2a6e 0008                 movea.l    8(a6),a5
[00001030] 286e 000c                 movea.l    12(a6),a4
[00001034] 2a2e 0010                 move.l     16(a6),d5
[00001038] 4a85                      tst.l      d5
[0000103a] 6710                      beq.s      $0000104C
[0000103c] 4287                      clr.l      d7
[0000103e] 1e1d                      move.b     (a5)+,d7
[00001040] 4286                      clr.l      d6
[00001042] 1c1c                      move.b     (a4)+,d6
[00001044] be86                      cmp.l      d6,d7
[00001046] 670e                      beq.s      $00001056
[00001048] 4287                      clr.l      d7
[0000104a] 6002                      bra.s      $0000104E
[0000104c] 7e01                      moveq.l    #1,d7
[0000104e] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[00001052] 4e5e                      unlk       a6
[00001054] 4e75                      rts
[00001056] 5385                      subq.l     #1,d5
[00001058] 60de                      bra.s      $00001038
_cmpstr:
[0000105a] 4e56 0000                 link       a6,#0
[0000105e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001062] 2a6e 0008                 movea.l    8(a6),a5
[00001066] 286e 000c                 movea.l    12(a6),a4
[0000106a] 4a14                      tst.b      (a4)
[0000106c] 6710                      beq.s      $0000107E
[0000106e] 4287                      clr.l      d7
[00001070] 1e1d                      move.b     (a5)+,d7
[00001072] 4286                      clr.l      d6
[00001074] 1c1c                      move.b     (a4)+,d6
[00001076] be86                      cmp.l      d6,d7
[00001078] 67f0                      beq.s      $0000106A
[0000107a] 4287                      clr.l      d7
[0000107c] 600a                      bra.s      $00001088
[0000107e] 4a15                      tst.b      (a5)
[00001080] 6604                      bne.s      $00001086
[00001082] 7e01                      moveq.l    #1,d7
[00001084] 6002                      bra.s      $00001088
[00001086] 4287                      clr.l      d7
[00001088] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[0000108c] 4e5e                      unlk       a6
[0000108e] 4e75                      rts
_cpybuf:
[00001090] 4e56 0000                 link       a6,#0
[00001094] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001098] 2a6e 0008                 movea.l    8(a6),a5
[0000109c] 286e 000c                 movea.l    12(a6),a4
[000010a0] 2a2e 0010                 move.l     16(a6),d5
[000010a4] 4a85                      tst.l      d5
[000010a6] 6706                      beq.s      $000010AE
[000010a8] 1adc                      move.b     (a4)+,(a5)+
[000010aa] 5385                      subq.l     #1,d5
[000010ac] 60f6                      bra.s      $000010A4
[000010ae] 2e2e 0010                 move.l     16(a6),d7
[000010b2] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[000010b6] 4e5e                      unlk       a6
[000010b8] 4e75                      rts
_cpystr:
[000010ba] 4e56 0000                 link       a6,#0
[000010be] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[000010c2] 286e 0008                 movea.l    8(a6),a4
[000010c6] 45ee 000c                 lea.l      12(a6),a2
[000010ca] 2a4a                      movea.l    a2,a5
[000010cc] 2655                      movea.l    (a5),a3
[000010ce] 2e0b                      move.l     a3,d7
[000010d0] 6708                      beq.s      $000010DA
[000010d2] 4a13                      tst.b      (a3)
[000010d4] 6710                      beq.s      $000010E6
[000010d6] 18db                      move.b     (a3)+,(a4)+
[000010d8] 60f8                      bra.s      $000010D2
[000010da] 4214                      clr.b      (a4)
[000010dc] 2e0c                      move.l     a4,d7
[000010de] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[000010e2] 4e5e                      unlk       a6
[000010e4] 4e75                      rts
[000010e6] 588d                      addq.l     #4,a5
[000010e8] 60e2                      bra.s      $000010CC
_doesc:
[000010ea] 4e56 0000                 link       a6,#0
[000010ee] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[000010f2] 246e 0008                 movea.l    8(a6),a2
[000010f6] 2e12                      move.l     (a2),d7
[000010f8] 5287                      addq.l     #1,d7
[000010fa] 2a47                      movea.l    d7,a5
[000010fc] 4a15                      tst.b      (a5)
[000010fe] 6612                      bne.s      $00001112
[00001100] 246e 0008                 movea.l    8(a6),a2
[00001104] 2452                      movea.l    (a2),a2
[00001106] 4287                      clr.l      d7
[00001108] 1e12                      move.b     (a2),d7
[0000110a] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[0000110e] 4e5e                      unlk       a6
[00001110] 4e75                      rts
[00001112] 4287                      clr.l      d7
[00001114] 1e15                      move.b     (a5),d7
[00001116] 0c47 0030                 cmpi.w     #$0030,d7
[0000111a] 6540                      bcs.s      $0000115C
[0000111c] 4287                      clr.l      d7
[0000111e] 1e15                      move.b     (a5),d7
[00001120] 0c47 0039                 cmpi.w     #$0039,d7
[00001124] 6236                      bhi.s      $0000115C
[00001126] 4285                      clr.l      d5
[00001128] 7801                      moveq.l    #1,d4
[0000112a] 4287                      clr.l      d7
[0000112c] 1e15                      move.b     (a5),d7
[0000112e] 0c47 0030                 cmpi.w     #$0030,d7
[00001132] 6578                      bcs.s      $000011AC
[00001134] 4287                      clr.l      d7
[00001136] 1e15                      move.b     (a5),d7
[00001138] 0c47 0039                 cmpi.w     #$0039,d7
[0000113c] 626e                      bhi.s      $000011AC
[0000113e] 0c84 0000 0003            cmpi.l     #$00000003,d4
[00001144] 6e66                      bgt.s      $000011AC
[00001146] 7ed0                      moveq.l    #-48,d7
[00001148] 2c05                      move.l     d5,d6
[0000114a] e786                      asl.l      #3,d6
[0000114c] 4283                      clr.l      d3
[0000114e] 1615                      move.b     (a5),d3
[00001150] dc83                      add.l      d3,d6
[00001152] de86                      add.l      d6,d7
[00001154] 2a07                      move.l     d7,d5
[00001156] 528d                      addq.l     #1,a5
[00001158] 5284                      addq.l     #1,d4
[0000115a] 60ce                      bra.s      $0000112A
[0000115c] 4287                      clr.l      d7
[0000115e] 1e15                      move.b     (a5),d7
[00001160] 0c47 0041                 cmpi.w     #$0041,d7
[00001164] 6514                      bcs.s      $0000117A
[00001166] 4287                      clr.l      d7
[00001168] 1e15                      move.b     (a5),d7
[0000116a] 0c47 005a                 cmpi.w     #$005A,d7
[0000116e] 620a                      bhi.s      $0000117A
[00001170] 7e20                      moveq.l    #32,d7
[00001172] 4286                      clr.l      d6
[00001174] 1c15                      move.b     (a5),d6
[00001176] de86                      add.l      d6,d7
[00001178] 6004                      bra.s      $0000117E
[0000117a] 4287                      clr.l      d7
[0000117c] 1e15                      move.b     (a5),d7
[0000117e] 2e87                      move.l     d7,(a7)
[00001180] 2f3c 0002 018d            move.l     #$00021AF5,-(a7)
[00001186] 4eb9 0000 123a            jsr        _scnstr
[0000118c] 588f                      addq.l     #4,a7
[0000118e] 2a07                      move.l     d7,d5
[00001190] 0c85 0000 0005            cmpi.l     #$00000005,d5
[00001196] 6c28                      bge.s      $000011C0
[00001198] 246e 0008                 movea.l    8(a6),a2
[0000119c] 248d                      move.l     a5,(a2)
[0000119e] 2445                      movea.l    d5,a2
[000011a0] d5fc 0002 0186            adda.l     #$00021AEE,a2
[000011a6] 4287                      clr.l      d7
[000011a8] 1e12                      move.b     (a2),d7
[000011aa] 600c                      bra.s      $000011B8
[000011ac] 246e 0008                 movea.l    8(a6),a2
[000011b0] 49ed ffff                 lea.l      -1(a5),a4
[000011b4] 248c                      move.l     a4,(a2)
[000011b6] 2e05                      move.l     d5,d7
[000011b8] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000011bc] 4e5e                      unlk       a6
[000011be] 4e75                      rts
[000011c0] 4aae 000c                 tst.l      12(a6)
[000011c4] 672a                      beq.s      $000011F0
[000011c6] 4287                      clr.l      d7
[000011c8] 1e15                      move.b     (a5),d7
[000011ca] 2e87                      move.l     d7,(a7)
[000011cc] 2f2e 000c                 move.l     12(a6),-(a7)
[000011d0] 4eb9 0000 123a            jsr        _scnstr
[000011d6] 588f                      addq.l     #4,a7
[000011d8] 2a07                      move.l     d7,d5
[000011da] 2445                      movea.l    d5,a2
[000011dc] d5ee 000c                 adda.l     12(a6),a2
[000011e0] 4a12                      tst.b      (a2)
[000011e2] 670c                      beq.s      $000011F0
[000011e4] 246e 0008                 movea.l    8(a6),a2
[000011e8] 248d                      move.l     a5,(a2)
[000011ea] 7eff                      moveq.l    #-1,d7
[000011ec] 9e85                      sub.l      d5,d7
[000011ee] 60c8                      bra.s      $000011B8
[000011f0] 246e 0008                 movea.l    8(a6),a2
[000011f4] 248d                      move.l     a5,(a2)
[000011f6] 4287                      clr.l      d7
[000011f8] 1e15                      move.b     (a5),d7
[000011fa] 60bc                      bra.s      $000011B8
_open:
[000011fc] 205f                      movea.l    (a7)+,a0
[000011fe] 7e05                      moveq.l    #5,d7
[00001200] 4e41                      trap       #1
[00001202] 4ed0                      jmp        (a0)
_putstr:
[00001204] 4e56 0000                 link       a6,#0
[00001208] 48e7 8004                 movem.l    d0/a5,-(a7)
[0000120c] 45ee 000c                 lea.l      12(a6),a2
[00001210] 2a4a                      movea.l    a2,a5
[00001212] 4a95                      tst.l      (a5)
[00001214] 671c                      beq.s      $00001232
[00001216] 2e95                      move.l     (a5),(a7)
[00001218] 4eb9 0000 1772            jsr        _lenstr
[0000121e] 2e87                      move.l     d7,(a7)
[00001220] 2f15                      move.l     (a5),-(a7)
[00001222] 2f2e 0008                 move.l     8(a6),-(a7)
[00001226] 4eb9 0000 1738            jsr        _fwrite
[0000122c] 508f                      addq.l     #8,a7
[0000122e] 588d                      addq.l     #4,a5
[00001230] 60e0                      bra.s      $00001212
[00001232] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001236] 4e5e                      unlk       a6
[00001238] 4e75                      rts
_scnstr:
[0000123a] 4e56 fffe                 link       a6,#-2
[0000123e] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[00001242] 2a6e 0008                 movea.l    8(a6),a5
[00001246] 1d6e 000f ffff            move.b     15(a6),-1(a6)
[0000124c] 284d                      movea.l    a5,a4
[0000124e] 4a14                      tst.b      (a4)
[00001250] 670e                      beq.s      $00001260
[00001252] 4287                      clr.l      d7
[00001254] 1e14                      move.b     (a4),d7
[00001256] 4286                      clr.l      d6
[00001258] 1c2e ffff                 move.b     -1(a6),d6
[0000125c] be86                      cmp.l      d6,d7
[0000125e] 660c                      bne.s      $0000126C
[00001260] 2e0c                      move.l     a4,d7
[00001262] 9e8d                      sub.l      a5,d7
[00001264] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001268] 4e5e                      unlk       a6
[0000126a] 4e75                      rts
[0000126c] 528c                      addq.l     #1,a4
[0000126e] 60de                      bra.s      $0000124E
[00001270] 4e56 0000                 link       a6,#0
[00001274] 48e7 840c                 movem.l    d0/d5/a4-a5,-(a7)
[00001278] 2a6e 0008                 movea.l    8(a6),a5
[0000127c] 2a2e 000c                 move.l     12(a6),d5
[00001280] 2e0d                      move.l     a5,d7
[00001282] de85                      add.l      d5,d7
[00001284] 2847                      movea.l    d7,a4
[00001286] 2e15                      move.l     (a5),d7
[00001288] 9e85                      sub.l      d5,d7
[0000128a] 2887                      move.l     d7,(a4)
[0000128c] 296d 0004 0004            move.l     4(a5),4(a4)
[00001292] 2445                      movea.l    d5,a2
[00001294] 518a                      subq.l     #8,a2
[00001296] 2a8a                      move.l     a2,(a5)
[00001298] 2e0c                      move.l     a4,d7
[0000129a] 4cdf 3021                 movem.l    (a7)+,d0/d5/a4-a5
[0000129e] 4e5e                      unlk       a6
[000012a0] 4e75                      rts
[000012a2] 4e56 0000                 link       a6,#0
[000012a6] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000012aa] 2a6e 0008                 movea.l    8(a6),a5
[000012ae] 286d 0004                 movea.l    4(a5),a4
[000012b2] 2e0d                      move.l     a5,d7
[000012b4] de95                      add.l      (a5),d7
[000012b6] 5087                      addq.l     #8,d7
[000012b8] be8c                      cmp.l      a4,d7
[000012ba] 660c                      bne.s      $000012C8
[000012bc] 2e14                      move.l     (a4),d7
[000012be] 5087                      addq.l     #8,d7
[000012c0] df95                      add.l      d7,(a5)
[000012c2] 2b6c 0004 0004            move.l     4(a4),4(a5)
[000012c8] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[000012cc] 4e5e                      unlk       a6
[000012ce] 4e75                      rts
_alloc:
[000012d0] 4e56 0000                 link       a6,#0
[000012d4] 48e7 8004                 movem.l    d0/a5,-(a7)
[000012d8] 2eae 000c                 move.l     12(a6),(a7)
[000012dc] 2f2e 0008                 move.l     8(a6),-(a7)
[000012e0] 4eb9 0000 130a            jsr        _nalloc
[000012e6] 588f                      addq.l     #4,a7
[000012e8] 2a47                      movea.l    d7,a5
[000012ea] 2e0d                      move.l     a5,d7
[000012ec] 6704                      beq.s      $000012F2
[000012ee] 2e0d                      move.l     a5,d7
[000012f0] 6010                      bra.s      $00001302
[000012f2] 2ebc 0002 01b2            move.l     #$00021B1A,(a7)
[000012f8] 42a7                      clr.l      -(a7)
[000012fa] 4eb9 0000 17c0            jsr        __raise
[00001300] 588f                      addq.l     #4,a7
[00001302] 4cdf 2001                 movem.l    (a7)+,d0/a5
[00001306] 4e5e                      unlk       a6
[00001308] 4e75                      rts
_nalloc:
[0000130a] 4e56 fffc                 link       a6,#-4
[0000130e] 48e7 841c                 movem.l    d0/d5/a3-a5,-(a7)
[00001312] 2a2e 0008                 move.l     8(a6),d5
[00001316] 0c85 0000 0004            cmpi.l     #$00000004,d5
[0000131c] 6404                      bcc.s      $00001322
[0000131e] 7e04                      moveq.l    #4,d7
[00001320] 6002                      bra.s      $00001324
[00001322] 2e05                      move.l     d5,d7
[00001324] 5687                      addq.l     #3,d7
[00001326] 7cfc                      moveq.l    #-4,d6
[00001328] cc87                      and.l      d7,d6
[0000132a] 2e06                      move.l     d6,d7
[0000132c] 5887                      addq.l     #4,d7
[0000132e] 2a07                      move.l     d7,d5
[00001330] 2a7c 0002 0198            movea.l    #$00021B00,a5
[00001336] 2855                      movea.l    (a5),a4
[00001338] 2e0c                      move.l     a4,d7
[0000133a] 6714                      beq.s      $00001350
[0000133c] 2e14                      move.l     (a4),d7
[0000133e] 5087                      addq.l     #8,d7
[00001340] ba87                      cmp.l      d7,d5
[00001342] 6220                      bhi.s      $00001364
[00001344] 2e14                      move.l     (a4),d7
[00001346] be85                      cmp.l      d5,d7
[00001348] 6422                      bcc.s      $0000136C
[0000134a] 2aac 0004                 move.l     4(a4),(a5)
[0000134e] 6028                      bra.s      $00001378
[00001350] 4ab9 0002 0194            tst.l      $00021AFC
[00001356] 662e                      bne.s      $00001386
[00001358] 23fc 0000 0200 0002 0194  move.l     #$00000200,$00021AFC
[00001362] 603c                      bra.s      $000013A0
[00001364] 45ec 0004                 lea.l      4(a4),a2
[00001368] 2a4a                      movea.l    a2,a5
[0000136a] 60ca                      bra.s      $00001336
[0000136c] 2e85                      move.l     d5,(a7)
[0000136e] 2f0c                      move.l     a4,-(a7)
[00001370] 4eba fefe                 jsr        $00001270(pc)
[00001374] 588f                      addq.l     #4,a7
[00001376] 2a87                      move.l     d7,(a5)
[00001378] 296e 000c 0004            move.l     12(a6),4(a4)
[0000137e] 45ec 0004                 lea.l      4(a4),a2
[00001382] 2e0a                      move.l     a2,d7
[00001384] 6066                      bra.s      $000013EC
[00001386] 0cb9 0000 0200 0002 0194  cmpi.l     #$00000200,$00021AFC
[00001390] 670e                      beq.s      $000013A0
[00001392] 2e39 0002 0194            move.l     $00021AFC,d7
[00001398] e28f                      lsr.l      #1,d7
[0000139a] 23c7 0002 0194            move.l     d7,$00021AFC
[000013a0] 97cb                      suba.l     a3,a3
[000013a2] bab9 0002 0194            cmp.l      $00021AFC,d5
[000013a8] 6228                      bhi.s      $000013D2
[000013aa] 2d79 0002 0194 fffc       move.l     $00021AFC,-4(a6)
[000013b2] 2eae fffc                 move.l     -4(a6),(a7)
[000013b6] 4eb9 0000 18a2            jsr        _sbreak
[000013bc] 2647                      movea.l    d7,a3
[000013be] 2e0b                      move.l     a3,d7
[000013c0] 6610                      bne.s      $000013D2
[000013c2] 2e39 0002 0194            move.l     $00021AFC,d7
[000013c8] e28f                      lsr.l      #1,d7
[000013ca] 23c7 0002 0194            move.l     d7,$00021AFC
[000013d0] 60d0                      bra.s      $000013A2
[000013d2] 2e0b                      move.l     a3,d7
[000013d4] 6610                      bne.s      $000013E6
[000013d6] 2d45 fffc                 move.l     d5,-4(a6)
[000013da] 2eae fffc                 move.l     -4(a6),(a7)
[000013de] 4eb9 0000 18a2            jsr        _sbreak
[000013e4] 2647                      movea.l    d7,a3
[000013e6] 2e0b                      move.l     a3,d7
[000013e8] 660a                      bne.s      $000013F4
[000013ea] 4287                      clr.l      d7
[000013ec] 4cdf 3821                 movem.l    (a7)+,d0/d5/a3-a5
[000013f0] 4e5e                      unlk       a6
[000013f2] 4e75                      rts
[000013f4] 2e2e fffc                 move.l     -4(a6),d7
[000013f8] 5187                      subq.l     #8,d7
[000013fa] 2687                      move.l     d7,(a3)
[000013fc] 4ab9 0002 019c            tst.l      $00021B04
[00001402] 6708                      beq.s      $0000140C
[00001404] b7f9 0002 019c            cmpa.l     $00021B04,a3
[0000140a] 6406                      bcc.s      $00001412
[0000140c] 23cb 0002 019c            move.l     a3,$00021B04
[00001412] 2e39 0002 01a0            move.l     $00021B08,d7
[00001418] 2c0b                      move.l     a3,d6
[0000141a] dcae fffc                 add.l      -4(a6),d6
[0000141e] be86                      cmp.l      d6,d7
[00001420] 640c                      bcc.s      $0000142E
[00001422] 2e0b                      move.l     a3,d7
[00001424] deae fffc                 add.l      -4(a6),d7
[00001428] 23c7 0002 01a0            move.l     d7,$00021B08
[0000142e] 4297                      clr.l      (a7)
[00001430] 486b 0004                 pea.l      4(a3)
[00001434] 4eb9 0000 1440            jsr        _free
[0000143a] 588f                      addq.l     #4,a7
[0000143c] 6000 fef2                 bra        $00001330
_free:
[00001440] 4e56 0000                 link       a6,#0
[00001444] 48e7 801c                 movem.l    d0/a3-a5,-(a7)
[00001448] 2e2e 0008                 move.l     8(a6),d7
[0000144c] 5987                      subq.l     #4,d7
[0000144e] 2a47                      movea.l    d7,a5
[00001450] 4aae 0008                 tst.l      8(a6)
[00001454] 672c                      beq.s      $00001482
[00001456] bbf9 0002 019c            cmpa.l     $00021B04,a5
[0000145c] 650a                      bcs.s      $00001468
[0000145e] 2e39 0002 01a0            move.l     $00021B08,d7
[00001464] be8d                      cmp.l      a5,d7
[00001466] 6226                      bhi.s      $0000148E
[00001468] 23fc 0002 01a4 0002 01b2  move.l     #$00021B0C,$00021B1A
[00001472] 2ebc 0002 01b2            move.l     #$00021B1A,(a7)
[00001478] 42a7                      clr.l      -(a7)
[0000147a] 4eb9 0000 17c0            jsr        __raise
[00001480] 588f                      addq.l     #4,a7
[00001482] 2e2e 000c                 move.l     12(a6),d7
[00001486] 4cdf 3801                 movem.l    (a7)+,d0/a3-a5
[0000148a] 4e5e                      unlk       a6
[0000148c] 4e75                      rts
[0000148e] 4ab9 0002 0198            tst.l      $00021B00
[00001494] 660c                      bne.s      $000014A2
[00001496] 42ad 0004                 clr.l      4(a5)
[0000149a] 23cd 0002 0198            move.l     a5,$00021B00
[000014a0] 60e0                      bra.s      $00001482
[000014a2] bbf9 0002 0198            cmpa.l     $00021B00,a5
[000014a8] 6416                      bcc.s      $000014C0
[000014aa] 2b79 0002 0198 0004       move.l     $00021B00,4(a5)
[000014b2] 23cd 0002 0198            move.l     a5,$00021B00
[000014b8] 2e8d                      move.l     a5,(a7)
[000014ba] 4eba fde6                 jsr        $000012A2(pc)
[000014be] 60c2                      bra.s      $00001482
[000014c0] 2879 0002 0198            movea.l    $00021B00,a4
[000014c6] 266c 0004                 movea.l    4(a4),a3
[000014ca] 2e0b                      move.l     a3,d7
[000014cc] 6708                      beq.s      $000014D6
[000014ce] b7cd                      cmpa.l     a5,a3
[000014d0] 6404                      bcc.s      $000014D6
[000014d2] 284b                      movea.l    a3,a4
[000014d4] 60f0                      bra.s      $000014C6
[000014d6] 2e0b                      move.l     a3,d7
[000014d8] 6716                      beq.s      $000014F0
[000014da] 2b4b 0004                 move.l     a3,4(a5)
[000014de] 294d 0004                 move.l     a5,4(a4)
[000014e2] 2e8d                      move.l     a5,(a7)
[000014e4] 4eba fdbc                 jsr        $000012A2(pc)
[000014e8] 2e8c                      move.l     a4,(a7)
[000014ea] 4eba fdb6                 jsr        $000012A2(pc)
[000014ee] 6092                      bra.s      $00001482
[000014f0] 42ad 0004                 clr.l      4(a5)
[000014f4] 294d 0004                 move.l     a5,4(a4)
[000014f8] 2e8c                      move.l     a4,(a7)
[000014fa] 4eba fda6                 jsr        $000012A2(pc)
[000014fe] 6000 ff82                 bra.w      $00001482
_btol:
[00001502] 4e56 fff4                 link       a6,#-12
[00001506] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[0000150a] 2a6e 0008                 movea.l    8(a6),a5
[0000150e] 2a2e 000c                 move.l     12(a6),d5
[00001512] 42ae fff8                 clr.l      -8(a6)
[00001516] 2d4d fff4                 move.l     a5,-12(a6)
[0000151a] 42ae fffc                 clr.l      -4(a6)
[0000151e] 4a85                      tst.l      d5
[00001520] 6714                      beq.s      $00001536
[00001522] 4287                      clr.l      d7
[00001524] 1e15                      move.b     (a5),d7
[00001526] 0c47 0020                 cmpi.w     #$0020,d7
[0000152a] 6324                      bls.s      $00001550
[0000152c] 4287                      clr.l      d7
[0000152e] 1e15                      move.b     (a5),d7
[00001530] 0c47 007f                 cmpi.w     #$007F,d7
[00001534] 641a                      bcc.s      $00001550
[00001536] 4a85                      tst.l      d5
[00001538] 671c                      beq.s      $00001556
[0000153a] 4287                      clr.l      d7
[0000153c] 1e15                      move.b     (a5),d7
[0000153e] 0c47 002d                 cmpi.w     #$002D,d7
[00001542] 661a                      bne.s      $0000155E
[00001544] 7001                      moveq.l    #1,d0
[00001546] 2d40 fffc                 move.l     d0,-4(a6)
[0000154a] 528d                      addq.l     #1,a5
[0000154c] 5385                      subq.l     #1,d5
[0000154e] 6006                      bra.s      $00001556
[00001550] 5385                      subq.l     #1,d5
[00001552] 528d                      addq.l     #1,a5
[00001554] 60c8                      bra.s      $0000151E
[00001556] 4a85                      tst.l      d5
[00001558] 6614                      bne.s      $0000156E
[0000155a] 6000 00d6                 bra        $00001632
[0000155e] 4287                      clr.l      d7
[00001560] 1e15                      move.b     (a5),d7
[00001562] 0c47 002b                 cmpi.w     #$002B,d7
[00001566] 66ee                      bne.s      $00001556
[00001568] 528d                      addq.l     #1,a5
[0000156a] 5385                      subq.l     #1,d5
[0000156c] 60e8                      bra.s      $00001556
[0000156e] 0cae 0000 0001 0014       cmpi.l     #$00000001,20(a6)
[00001576] 6614                      bne.s      $0000158C
[00001578] 4287                      clr.l      d7
[0000157a] 1e15                      move.b     (a5),d7
[0000157c] 0c47 0030                 cmpi.w     #$0030,d7
[00001580] 6764                      beq.s      $000015E6
[00001582] 700a                      moveq.l    #10,d0
[00001584] 2d40 0014                 move.l     d0,20(a6)
[00001588] 6000 00a8                 bra        $00001632
[0000158c] 0cae 0000 0010 0014       cmpi.l     #$00000010,20(a6)
[00001594] 6600 009c                 bne        $00001632
[00001598] 0c85 0000 0002            cmpi.l     #$00000002,d5
[0000159e] 6500 0092                 bcs        $00001632
[000015a2] 4287                      clr.l      d7
[000015a4] 1e15                      move.b     (a5),d7
[000015a6] 0c47 0030                 cmpi.w     #$0030,d7
[000015aa] 6600 0086                 bne        $00001632
[000015ae] 4287                      clr.l      d7
[000015b0] 1e2d 0001                 move.b     1(a5),d7
[000015b4] 0c47 0041                 cmpi.w     #$0041,d7
[000015b8] 6518                      bcs.s      $000015D2
[000015ba] 4287                      clr.l      d7
[000015bc] 1e2d 0001                 move.b     1(a5),d7
[000015c0] 0c47 005a                 cmpi.w     #$005A,d7
[000015c4] 620c                      bhi.s      $000015D2
[000015c6] 7e20                      moveq.l    #32,d7
[000015c8] 4286                      clr.l      d6
[000015ca] 1c2d 0001                 move.b     1(a5),d6
[000015ce] de86                      add.l      d6,d7
[000015d0] 6006                      bra.s      $000015D8
[000015d2] 4287                      clr.l      d7
[000015d4] 1e2d 0001                 move.b     1(a5),d7
[000015d8] 0c87 0000 0078            cmpi.l     #$00000078,d7
[000015de] 6652                      bne.s      $00001632
[000015e0] 548d                      addq.l     #2,a5
[000015e2] 5585                      subq.l     #2,d5
[000015e4] 604c                      bra.s      $00001632
[000015e6] 0c85 0000 0001            cmpi.l     #$00000001,d5
[000015ec] 633e                      bls.s      $0000162C
[000015ee] 4287                      clr.l      d7
[000015f0] 1e2d 0001                 move.b     1(a5),d7
[000015f4] 0c47 0041                 cmpi.w     #$0041,d7
[000015f8] 6518                      bcs.s      $00001612
[000015fa] 4287                      clr.l      d7
[000015fc] 1e2d 0001                 move.b     1(a5),d7
[00001600] 0c47 005a                 cmpi.w     #$005A,d7
[00001604] 620c                      bhi.s      $00001612
[00001606] 7e20                      moveq.l    #32,d7
[00001608] 4286                      clr.l      d6
[0000160a] 1c2d 0001                 move.b     1(a5),d6
[0000160e] de86                      add.l      d6,d7
[00001610] 6006                      bra.s      $00001618
[00001612] 4287                      clr.l      d7
[00001614] 1e2d 0001                 move.b     1(a5),d7
[00001618] 0c87 0000 0078            cmpi.l     #$00000078,d7
[0000161e] 660c                      bne.s      $0000162C
[00001620] 7010                      moveq.l    #16,d0
[00001622] 2d40 0014                 move.l     d0,20(a6)
[00001626] 548d                      addq.l     #2,a5
[00001628] 5585                      subq.l     #2,d5
[0000162a] 6006                      bra.s      $00001632
[0000162c] 7008                      moveq.l    #8,d0
[0000162e] 2d40 0014                 move.l     d0,20(a6)
[00001632] 4a85                      tst.l      d5
[00001634] 6720                      beq.s      $00001656
[00001636] 4287                      clr.l      d7
[00001638] 1e15                      move.b     (a5),d7
[0000163a] 0c47 0030                 cmpi.w     #$0030,d7
[0000163e] 656a                      bcs.s      $000016AA
[00001640] 4287                      clr.l      d7
[00001642] 1e15                      move.b     (a5),d7
[00001644] 0c47 0039                 cmpi.w     #$0039,d7
[00001648] 6260                      bhi.s      $000016AA
[0000164a] 7ed0                      moveq.l    #-48,d7
[0000164c] 4286                      clr.l      d6
[0000164e] 1c15                      move.b     (a5),d6
[00001650] de86                      add.l      d6,d7
[00001652] 2807                      move.l     d7,d4
[00001654] 606a                      bra.s      $000016C0
[00001656] 246e 0010                 movea.l    16(a6),a2
[0000165a] 2e8a                      move.l     a2,(a7)
[0000165c] 4aae fffc                 tst.l      -4(a6)
[00001660] 6708                      beq.s      $0000166A
[00001662] 2e2e fff8                 move.l     -8(a6),d7
[00001666] 4487                      neg.l      d7
[00001668] 6004                      bra.s      $0000166E
[0000166a] 2e2e fff8                 move.l     -8(a6),d7
[0000166e] 2257                      movea.l    (a7),a1
[00001670] 2287                      move.l     d7,(a1)
[00001672] 4a85                      tst.l      d5
[00001674] 6700 00b4                 beq        $0000172A
[00001678] 4287                      clr.l      d7
[0000167a] 1e15                      move.b     (a5),d7
[0000167c] 0c47 0041                 cmpi.w     #$0041,d7
[00001680] 6514                      bcs.s      $00001696
[00001682] 4287                      clr.l      d7
[00001684] 1e15                      move.b     (a5),d7
[00001686] 0c47 005a                 cmpi.w     #$005A,d7
[0000168a] 620a                      bhi.s      $00001696
[0000168c] 7e20                      moveq.l    #32,d7
[0000168e] 4286                      clr.l      d6
[00001690] 1c15                      move.b     (a5),d6
[00001692] de86                      add.l      d6,d7
[00001694] 6004                      bra.s      $0000169A
[00001696] 4287                      clr.l      d7
[00001698] 1e15                      move.b     (a5),d7
[0000169a] 0c87 0000 006c            cmpi.l     #$0000006C,d7
[000016a0] 6600 0088                 bne        $0000172A
[000016a4] 528d                      addq.l     #1,a5
[000016a6] 6000 0082                 bra        $0000172A
[000016aa] 4287                      clr.l      d7
[000016ac] 1e15                      move.b     (a5),d7
[000016ae] 0c47 0061                 cmpi.w     #$0061,d7
[000016b2] 652a                      bcs.s      $000016DE
[000016b4] 4287                      clr.l      d7
[000016b6] 1e15                      move.b     (a5),d7
[000016b8] 0c47 007a                 cmpi.w     #$007A,d7
[000016bc] 6338                      bls.s      $000016F6
[000016be] 601e                      bra.s      $000016DE
[000016c0] 2eae fff8                 move.l     -8(a6),(a7)
[000016c4] 2f2e 0014                 move.l     20(a6),-(a7)
[000016c8] 4eb9 0000 1794            jsr        a.lmul
[000016ce] 2e17                      move.l     (a7),d7
[000016d0] de84                      add.l      d4,d7
[000016d2] 2d47 fff8                 move.l     d7,-8(a6)
[000016d6] 5385                      subq.l     #1,d5
[000016d8] 528d                      addq.l     #1,a5
[000016da] 6000 ff56                 bra        $00001632
[000016de] 4287                      clr.l      d7
[000016e0] 1e15                      move.b     (a5),d7
[000016e2] 0c47 0041                 cmpi.w     #$0041,d7
[000016e6] 6500 ff6e                 bcs        $00001656
[000016ea] 4287                      clr.l      d7
[000016ec] 1e15                      move.b     (a5),d7
[000016ee] 0c47 005a                 cmpi.w     #$005A,d7
[000016f2] 6200 ff62                 bhi        $00001656
[000016f6] 4287                      clr.l      d7
[000016f8] 1e15                      move.b     (a5),d7
[000016fa] 0c47 0041                 cmpi.w     #$0041,d7
[000016fe] 6514                      bcs.s      $00001714
[00001700] 4287                      clr.l      d7
[00001702] 1e15                      move.b     (a5),d7
[00001704] 0c47 005a                 cmpi.w     #$005A,d7
[00001708] 620a                      bhi.s      $00001714
[0000170a] 7e20                      moveq.l    #32,d7
[0000170c] 4286                      clr.l      d6
[0000170e] 1c15                      move.b     (a5),d6
[00001710] de86                      add.l      d6,d7
[00001712] 6004                      bra.s      $00001718
[00001714] 4287                      clr.l      d7
[00001716] 1e15                      move.b     (a5),d7
[00001718] 7ca9                      moveq.l    #-87,d6
[0000171a] dc87                      add.l      d7,d6
[0000171c] 2806                      move.l     d6,d4
[0000171e] 2e2e 0014                 move.l     20(a6),d7
[00001722] be84                      cmp.l      d4,d7
[00001724] 6e9a                      bgt.s      $000016C0
[00001726] 6000 ff2e                 bra        $00001656
[0000172a] 2e0d                      move.l     a5,d7
[0000172c] 9eae fff4                 sub.l      -12(a6),d7
[00001730] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00001734] 4e5e                      unlk       a6
[00001736] 4e75                      rts
_fwrite:
[00001738] 4e56 0000                 link       a6,#0
[0000173c] 48e7 8c00                 movem.l    d0/d4-d5,-(a7)
[00001740] 2eae 0010                 move.l     16(a6),(a7)
[00001744] 2f2e 000c                 move.l     12(a6),-(a7)
[00001748] 2f2e 0008                 move.l     8(a6),-(a7)
[0000174c] 4eb9 0000 1960            jsr        _write
[00001752] 508f                      addq.l     #8,a7
[00001754] beae 0010                 cmp.l      16(a6),d7
[00001758] 6710                      beq.s      $0000176A
[0000175a] 2ebc 0002 01e4            move.l     #$00021B4C,(a7)
[00001760] 42a7                      clr.l      -(a7)
[00001762] 4eb9 0000 17c0            jsr        __raise
[00001768] 588f                      addq.l     #4,a7
[0000176a] 4cdf 0031                 movem.l    (a7)+,d0/d4-d5
[0000176e] 4e5e                      unlk       a6
[00001770] 4e75                      rts
_lenstr:
[00001772] 4e56 0000                 link       a6,#0
[00001776] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[0000177a] 2a6e 0008                 movea.l    8(a6),a5
[0000177e] 284d                      movea.l    a5,a4
[00001780] 4a14                      tst.b      (a4)
[00001782] 6704                      beq.s      $00001788
[00001784] 528c                      addq.l     #1,a4
[00001786] 60f8                      bra.s      $00001780
[00001788] 2e0c                      move.l     a4,d7
[0000178a] 9e8d                      sub.l      a5,d7
[0000178c] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001790] 4e5e                      unlk       a6
[00001792] 4e75                      rts
a.lmul:
[00001794] 302f 0008                 move.w     8(a7),d0
[00001798] c0ef 0006                 mulu.w     6(a7),d0
[0000179c] 3f40 0008                 move.w     d0,8(a7)
[000017a0] 302f 000a                 move.w     10(a7),d0
[000017a4] c0ef 0004                 mulu.w     4(a7),d0
[000017a8] d16f 0008                 add.w      d0,8(a7)
[000017ac] 302f 000a                 move.w     10(a7),d0
[000017b0] c0ef 0006                 mulu.w     6(a7),d0
[000017b4] 426f 000a                 clr.w      10(a7)
[000017b8] 2e9f                      move.l     (a7)+,(a7)
[000017ba] d1af 0004                 add.l      d0,4(a7)
[000017be] 4e75                      rts
__raise:
[000017c0] 246f 0004                 movea.l    4(a7),a2
[000017c4] 262f 0008                 move.l     8(a7),d3
[000017c8] 2803                      move.l     d3,d4
[000017ca] 670c                      beq.s      $000017D8
[000017cc] 280a                      move.l     a2,d4
[000017ce] 0c83 ffff ffff            cmpi.l     #$FFFFFFFF,d3
[000017d4] 6602                      bne.s      $000017D8
[000017d6] 4283                      clr.l      d3
[000017d8] 200a                      move.l     a2,d0
[000017da] 6708                      beq.s      $000017E4
[000017dc] b5fc ffff ffff            cmpa.l     #$FFFFFFFF,a2
[000017e2] 660a                      bne.s      $000017EE
[000017e4] 2479 0002 01c0            movea.l    $00021B28,a2
[000017ea] 200a                      move.l     a2,d0
[000017ec] 674e                      beq.s      $0000183C
[000017ee] 4a83                      tst.l      d3
[000017f0] 6626                      bne.s      $00001818
[000017f2] 4287                      clr.l      d7
[000017f4] 2e4a                      movea.l    a2,a7
[000017f6] 4a84                      tst.l      d4
[000017f8] 6600 0096                 bne        $00001890
[000017fc] 202a 0028                 move.l     40(a2),d0
[00001800] 6704                      beq.s      $00001806
[00001802] 2040                      movea.l    d0,a0
[00001804] 2083                      move.l     d3,(a0)
[00001806] 23df 0002 01c0            move.l     (a7)+,$00021B28
[0000180c] 4cdf 783a                 movem.l    (a7)+,d1/d3-d5/a3-a6
[00001810] 4e75                      rts
[00001812] 2452                      movea.l    (a2),a2
[00001814] 200a                      move.l     a2,d0
[00001816] 6724                      beq.s      $0000183C
[00001818] 41ea 002c                 lea.l      44(a2),a0
[0000181c] 2e08                      move.l     a0,d7
[0000181e] 0c90 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)
[00001824] 67ec                      beq.s      $00001812
[00001826] 4a98                      tst.l      (a0)+
[00001828] 6604                      bne.s      $0000182E
[0000182a] 4284                      clr.l      d4
[0000182c] 6006                      bra.s      $00001834
[0000182e] b6a8 fffc                 cmp.l      -4(a0),d3
[00001832] 66ea                      bne.s      $0000181E
[00001834] 9e88                      sub.l      a0,d7
[00001836] 4487                      neg.l      d7
[00001838] e487                      asr.l      #2,d7
[0000183a] 60b8                      bra.s      $000017F4
[0000183c] 42a7                      clr.l      -(a7)
[0000183e] 4a83                      tst.l      d3
[00001840] 6706                      beq.s      $00001848
[00001842] 0803 0000                 btst       #0,d3
[00001846] 6706                      beq.s      $0000184E
[00001848] 263c 0002 01c4            move.l     #$00021B2C,d3
[0000184e] 2043                      movea.l    d3,a0
[00001850] 2f10                      move.l     (a0),-(a7)
[00001852] 4eb9 0000 1922            jsr        _error
[00001858] 4e71                      nop
[0000185a] 60fc                      bra.s      $00001858
__when:
[0000185c] 2039 0002 01c0            move.l     $00021B28,d0
[00001862] 720c                      moveq.l    #12,d1
[00001864] 48e7 dc1e                 movem.l    d0-d1/d3-d5/a3-a6,-(a7)
[00001868] 244f                      movea.l    a7,a2
[0000186a] 202a 0028                 move.l     40(a2),d0
[0000186e] 6704                      beq.s      $00001874
[00001870] 2040                      movea.l    d0,a0
[00001872] 208a                      move.l     a2,(a0)
[00001874] 41ea 002c                 lea.l      44(a2),a0
[00001878] 4a90                      tst.l      (a0)
[0000187a] 6712                      beq.s      $0000188E
[0000187c] 0c98 ffff ffff            cmpi.l     #$FFFFFFFF,(a0)+
[00001882] 670a                      beq.s      $0000188E
[00001884] 06aa 0000 0004 0004       addi.l     #$00000004,4(a2)
[0000188c] 60ea                      bra.s      $00001878
[0000188e] 7eff                      moveq.l    #-1,d7
[00001890] 23ca 0002 01c0            move.l     a2,$00021B28
[00001896] 206a 0024                 movea.l    36(a2),a0
[0000189a] 4cd2 783b                 movem.l    (a2),d0-d1/d3-d5/a3-a6
[0000189e] 9fc1                      suba.l     d1,a7
[000018a0] 4ed0                      jmp        (a0)
_sbreak:
[000018a2] 205f                      movea.l    (a7)+,a0
[000018a4] 2e17                      move.l     (a7),d7
[000018a6] 5287                      addq.l     #1,d7
[000018a8] 0887 0000                 bclr       #0,d7
[000018ac] deb9 0002 01dc            add.l      $00021B44,d7
[000018b2] 2f07                      move.l     d7,-(a7)
[000018b4] 7e11                      moveq.l    #17,d7
[000018b6] 4e41                      trap       #1
[000018b8] 0c87 ffff ffff            cmpi.l     #$FFFFFFFF,d7
[000018be] 6606                      bne.s      $000018C6
[000018c0] 4a9f                      tst.l      (a7)+
[000018c2] 4287                      clr.l      d7
[000018c4] 4ed0                      jmp        (a0)
[000018c6] 2e39 0002 01dc            move.l     $00021B44,d7
[000018cc] 23df 0002 01dc            move.l     (a7)+,$00021B44
[000018d2] 4ab9 0002 01e0            tst.l      __stop
[000018d8] 670a                      beq.s      $000018E4
[000018da] 23f9 0002 01dc 0002 01e0  move.l     $00021B44,__stop
[000018e4] 4ed0                      jmp        (a0)
[000018e6] 4e56 0000                 link       a6,#0
[000018ea] 48e7 800c                 movem.l    d0/a4-a5,-(a7)
[000018ee] 2a6e 0008                 movea.l    8(a6),a5
[000018f2] 2e0d                      move.l     a5,d7
[000018f4] 670e                      beq.s      $00001904
[000018f6] 4a15                      tst.b      (a5)
[000018f8] 670a                      beq.s      $00001904
[000018fa] 284d                      movea.l    a5,a4
[000018fc] 4a14                      tst.b      (a4)
[000018fe] 670c                      beq.s      $0000190C
[00001900] 528c                      addq.l     #1,a4
[00001902] 60f8                      bra.s      $000018FC
[00001904] 4cdf 3001                 movem.l    (a7)+,d0/a4-a5
[00001908] 4e5e                      unlk       a6
[0000190a] 4e75                      rts
[0000190c] 2e0c                      move.l     a4,d7
[0000190e] 9e8d                      sub.l      a5,d7
[00001910] 2e87                      move.l     d7,(a7)
[00001912] 2f0d                      move.l     a5,-(a7)
[00001914] 4878 0002                 pea.l      ($00000002).w
[00001918] 4eb9 0000 1960            jsr        _write
[0000191e] 508f                      addq.l     #8,a7
[00001920] 60e2                      bra.s      $00001904
_error:
[00001922] 4e56 fffc                 link       a6,#-4
[00001926] 2eb9 0002 01fa            move.l     _pname,(a7)
[0000192c] 4eba ffb8                 jsr        $000018E6(pc)
[00001930] 2ebc 0002 01f6            move.l     #$00021B5E,(a7)
[00001936] 4eba ffae                 jsr        $000018E6(pc)
[0000193a] 2eae 0008                 move.l     8(a6),(a7)
[0000193e] 4eba ffa6                 jsr        $000018E6(pc)
[00001942] 2eae 000c                 move.l     12(a6),(a7)
[00001946] 4eba ff9e                 jsr        $000018E6(pc)
[0000194a] 2ebc 0002 01f4            move.l     #$00021B5C,(a7)
[00001950] 4eba ff94                 jsr        $000018E6(pc)
[00001954] 4297                      clr.l      (a7)
[00001956] 4eb9 0000 0080            jsr        _exit
[0000195c] 4e5e                      unlk       a6
[0000195e] 4e75                      rts
_write:
[00001960] 205f                      movea.l    (a7)+,a0
[00001962] 7e04                      moveq.l    #4,d7
[00001964] 4e41                      trap       #1
[00001966] 4ed0                      jmp        (a0)

	.data
__data:
[00020000]                           dc.b $00
[00020001]                           dc.b 'idr68k Edition 3.0: Copyright (c) 1981,1983,1985 by Whitesmiths, Ltd. all rights reserved',0
[0002005b]                           dc.b '|/bin/|/usr/bin/',0
[0002006c]                           dc.b 'PATH',0
[00020071]                           dc.b $00
_environ:
[00020072]                           dc.b $00
[00020073]                           dc.b $00
[00020074]                           dc.b $00
[00020075]                           dc.b $00
_errno:
[00020076]                           dc.b $00
[00020077]                           dc.b $00
[00020078]                           dc.b $00
[00020079]                           dc.b $00
__paths:
[0002007a] 0002005b                  dc.l $0002005b
[0002007e] 000000aa                  dc.l _onexit
_up:
[00020082]                           dc.b $00
[00020083]                           dc.b $00
[00020084]                           dc.b $00
[00020085]                           dc.b $00
__link:
[00020086]                           dc.b $00
[00020087]                           dc.b $00
[00020088]                           dc.b $00
[00020089]                           dc.b $00
_ofile:
[0002008a]                           dc.b $00
[0002008b]                           dc.b $00
[0002008c]                           dc.b $00
[0002008d]                           dc.b $00
_pstr:
[0002008e]                           dc.b $00
[0002008f]                           dc.b $00
[00020090]                           dc.b $00
[00020091]                           dc.b $00
_astr:
[00020092]                           dc.b $00
[00020093]                           dc.b $00
[00020094]                           dc.b $00
[00020095]                           dc.b $00
_ackfd:
[00020096]                           dc.b $00
[00020097]                           dc.b $00
_linkfd:
[00020098]                           dc.b $00
[00020099]                           dc.b $01
[0002009a]                           dc.b $00
[0002009b]                           dc.b 'u,l*,o*,p*,a*:F <files>',0
[000200b3]                           dc.b $00
[000200b4]                           dc.b '\M',$0d,$0a,0
[000200b9]                           dc.b $00
[000200ba]                           dc.b $00
[000200bb]                           dc.b $00
[000200bc]                           dc.b $00
[000200bd]                           dc.b $00
[000200be]                           dc.b $00
[000200bf]                           dc.b $00
[000200c0]                           dc.b $00
[000200c1]                           dc.b $00
[000200c2]                           dc.b $00
[000200c3]                           dc.b $00
[000200c4]                           dc.b $00
[000200c5]                           dc.b $00
[000200c6]                           dc.w $3000
[000200c8]                           dc.b 'seq x',0
[000200ce] 000004f4                  dc.l $000004f4
[000200d2]                           dc.b $00
[000200d3]                           dc.b $00
[000200d4]                           dc.b $00
[000200d5]                           dc.b $03
[000200d6] 000004e0                  dc.l $000004e0
[000200da]                           dc.b $00
[000200db]                           dc.b $00
[000200dc]                           dc.b $00
[000200dd]                           dc.b $02
[000200de] 000004a6                  dc.l $000004a6
[000200e2]                           dc.b $00
[000200e3]                           dc.b $00
[000200e4]                           dc.b $00
[000200e5]                           dc.b $01
[000200e6] 00000498                  dc.l $00000498
[000200ea]                           dc.b $00
[000200eb]                           dc.b $00
[000200ec]                           dc.b $00
[000200ed]                           dc.b $00
[000200ee]                           dc.b $00
[000200ef]                           dc.b $00
[000200f0]                           dc.b $00
[000200f1]                           dc.b $00
[000200f2] 000004a4                  dc.l $000004a4
[000200f6]                           dc.b ' timed out',0
[00020101]                           dc.b $00
[00020102]                           dc.b '\.\S',0
[00020107]                           dc.b $02
[00020108]                           dc.w $010a
[0002010a]                           dc.b 'bad leave call',0
[00020119]                           dc.b $00
[0002011a]                           dc.b $00
[0002011b]                           dc.b $00
[0002011c]                           dc.b $00
[0002011d]                           dc.b $00
[0002011e]                           dc.w $2d00
[00020120]                           dc.w $0a00
[00020122]                           dc.w $5d00
[00020124]                           dc.w $2000
[00020126]                           dc.w $5e00
[00020128]                           dc.w $2000
[0002012a]                           dc.w $2d5b
[0002012c]                           dc.b $00
[0002012d]                           dc.b $00
[0002012e] 00000e2c                  dc.l $00000e2c
[00020132]                           dc.b $00
[00020133]                           dc.b $00
[00020134]                           dc.b $00
[00020135]                           dc.b $3e
[00020136] 00000dca                  dc.l $00000dca
[0002013a]                           dc.b $00
[0002013b]                           dc.b $00
[0002013c]                           dc.b $00
[0002013d]                           dc.b $00
[0002013e] 00000dca                  dc.l $00000dca
[00020142]                           dc.b $00
[00020143]                           dc.b $00
[00020144]                           dc.b $00
[00020145]                           dc.b $3a
[00020146] 00000dca                  dc.l $00000dca
[0002014a]                           dc.b $00
[0002014b]                           dc.b $00
[0002014c]                           dc.b $00
[0002014d]                           dc.b $2c
[0002014e] 00000d40                  dc.l $00000d40
[00020152]                           dc.b $00
[00020153]                           dc.b $00
[00020154]                           dc.b $00
[00020155]                           dc.b $23
[00020156] 00000d04                  dc.l $00000d04
[0002015a]                           dc.b $00
[0002015b]                           dc.b $00
[0002015c]                           dc.b $00
[0002015d]                           dc.b $3f
[0002015e] 00000c94                  dc.l $00000c94
[00020162]                           dc.b $00
[00020163]                           dc.b $00
[00020164]                           dc.b $00
[00020165]                           dc.b $2a
[00020166]                           dc.b $00
[00020167]                           dc.b $00
[00020168]                           dc.b $00
[00020169]                           dc.b $00
[0002016a] 00000ed4                  dc.l $00000ed4
[0002016e]                           dc.b 'help',0
[00020173]                           dc.b $2d
[00020174]                           dc.b $00
[00020175]                           dc.b $2d
[00020176]                           dc.w $2d00
[00020178]                           dc.w $0a09
[0002017a]                           dc.b $00
[0002017b]                           dc.b $00
[0002017c]                           dc.w $2000
[0002017e]                           dc.b 'usage: ',0
[00020186]                           dc.w $080c
[00020188]                           dc.w $0a0d
[0002018a]                           dc.w $090b
[0002018c]                           dc.b $00
[0002018d]                           dc.b 'bfnrtv',0
[00020194]                           dc.b $00
[00020195]                           dc.b $00
[00020196]                           dc.b $00
[00020197]                           dc.b $00
[00020198]                           dc.b $00
[00020199]                           dc.b $00
[0002019a]                           dc.b $00
[0002019b]                           dc.b $00
[0002019c]                           dc.b $00
[0002019d]                           dc.b $00
[0002019e]                           dc.b $00
[0002019f]                           dc.b $00
[000201a0]                           dc.b $00
[000201a1]                           dc.b $00
[000201a2]                           dc.b $00
[000201a3]                           dc.b $00
[000201a4]                           dc.b 'bad free call',0
__memerr:
[000201b2] 000201b6                  dc.l $000201b6
[000201b6]                           dc.b 'no memory',0
[000201c0]                           dc.b $00
[000201c1]                           dc.b $00
[000201c2]                           dc.b $00
[000201c3]                           dc.b $00
[000201c4] 000201c8                  dc.l $000201c8
[000201c8]                           dc.b 'unchecked condition',0
[000201dc] 00020204                  dc.l _end
__stop:
[000201e0]                           dc.b $00
[000201e1]                           dc.b $00
[000201e2]                           dc.b $00
[000201e3]                           dc.b $01
_writerr:
[000201e4] 000201e8                  dc.l $000201e8
[000201e8]                           dc.b 'write error',0
[000201f4]                           dc.w $0a00
[000201f6]                           dc.w $3a20
[000201f8]                           dc.b $00
[000201f9]                           dc.b $00
__pname:
[000201fa] 000201fe                  dc.l $000201fe
[000201fe]                           dc.b 'error',0
;
00000000 T start
00000080 T _exit
000000aa T _onexit
000000ba T seterr
000000c6 T _main
00000338 T _smode
0000037c T _tmsg
00000408 T _ackwait
00000526 T _ppeof
00000546 T _pputc
000005c2 T _pputf
000006ec T _pputn
00000746 T _pputp
00000836 T _pputx
00000884 T _readtmo
000008b8 T __ioctl
000008ca T __open
000008dc T __read
000008ee T __time
00000908 T __write
0000091a T __close
0000092c T _enter
00000962 T _leave
00000982 T _getenv
000009de T _getfiles
00000b82 T _getflags
00000f8c T _gtty
00000f94 T _stty
00000f9c T a.switch
00000fae T _usage
00001024 T _cmpbuf
0000105a T _cmpstr
00001090 T _cpybuf
000010ba T _cpystr
000010ea T _doesc
000011fc T _open
00001204 T _putstr
0000123a T _scnstr
000012d0 T _alloc
0000130a T _nalloc
00001440 T _free
00001502 T _btol
00001738 T _fwrite
00001772 T _lenstr
00001794 T a.lmul
000017c0 T __raise
0000185c T __when
000018a2 T _sbreak
00001922 T _error
00001960 T _write
00001968 D __data
000019da D _environ
000019de D _errno
000019e2 D __paths
000019ea D _up
000019ee D __link
000019f2 D _ofile
000019f6 D _pstr
000019fa D _astr
000019fe D _ackfd
00001a00 D _linkfd
00001b1a D __memerr
00001b48 D __stop
00001b4c D _writerr
00001b62 D __pname
00020204 B _end
;
