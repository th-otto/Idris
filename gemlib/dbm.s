; a_magic   = 0x9928
; a_text    = 0x00000d7e
; a_data    = 0x000001b8
; a_bss     = 0x0000141c
; a_syms    = 0x00000239
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000174@0x0000118b


_dbminit:
[00000000] 4e56 ffdc                 link       a6,#-36
[00000004] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[00000008] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[0000000e] 287c 0000 0000            movea.l    #_open,a4
[00000014] 266e 0008                 movea.l    8(a6),a3
[00000018] 2a3c 0000 01c0            move.l     #_dirf,d5
[0000001e] 283c 0000 01bc            move.l     #_pagf,d4
[00000024] 2245                      movea.l    d5,a1
[00000026] 2e11                      move.l     (a1),d7
[00000028] 2244                      movea.l    d4,a1
[0000002a] be91                      cmp.l      (a1),d7
[0000002c] 6600 00bc                 bne        _dbminit_1
[00000030] 42b9 0000 01b8            clr.l      _dbrdonly
[00000036] 2e8b                      move.l     a3,(a7)
[00000038] 2f0d                      move.l     a5,-(a7)
[0000003a] 4eb9 0000 0000            jsr        _strcpy
[00000040] 588f                      addq.l     #4,a7
[00000042] 2ebc 0000 0000            move.l     #$00000D7E,(a7) ".pag"
[00000048] 2f0d                      move.l     a5,-(a7)
[0000004a] 4eb9 0000 0000            jsr        _strcat
[00000050] 588f                      addq.l     #4,a7
[00000052] 4878 01b6                 pea.l      ($000001B6).w
[00000056] 4878 0102                 pea.l      ($00000102).w
[0000005a] 2f0d                      move.l     a5,-(a7)
[0000005c] 4e94                      jsr        (a4)
[0000005e] 4fef 000c                 lea.l      12(a7),a7
[00000062] 2244                      movea.l    d4,a1
[00000064] 2287                      move.l     d7,(a1)
[00000066] 2244                      movea.l    d4,a1
[00000068] 4a91                      tst.l      (a1)
[0000006a] 6c14                      bge.s      _dbminit_2
[0000006c] 4297                      clr.l      (a7)
[0000006e] 2f0d                      move.l     a5,-(a7)
[00000070] 4e94                      jsr        (a4)
[00000072] 588f                      addq.l     #4,a7
[00000074] 2244                      movea.l    d4,a1
[00000076] 2287                      move.l     d7,(a1)
[00000078] 7001                      moveq.l    #1,d0
[0000007a] 23c0 0000 01b8            move.l     d0,_dbrdonly
_dbminit_2:
[00000080] 2e8b                      move.l     a3,(a7)
[00000082] 2f0d                      move.l     a5,-(a7)
[00000084] 4eb9 0000 0000            jsr        _strcpy
[0000008a] 588f                      addq.l     #4,a7
[0000008c] 2ebc 0000 0005            move.l     #$00000D83,(a7) ".dir"
[00000092] 2f0d                      move.l     a5,-(a7)
[00000094] 4eb9 0000 0000            jsr        _strcat
[0000009a] 588f                      addq.l     #4,a7
[0000009c] 4878 01b6                 pea.l      ($000001B6).w
[000000a0] 4878 0102                 pea.l      ($00000102).w
[000000a4] 2f0d                      move.l     a5,-(a7)
[000000a6] 4e94                      jsr        (a4)
[000000a8] 4fef 000c                 lea.l      12(a7),a7
[000000ac] 2245                      movea.l    d5,a1
[000000ae] 2287                      move.l     d7,(a1)
[000000b0] 2245                      movea.l    d5,a1
[000000b2] 4a91                      tst.l      (a1)
[000000b4] 6c14                      bge.s      _dbminit_3
[000000b6] 4297                      clr.l      (a7)
[000000b8] 2f0d                      move.l     a5,-(a7)
[000000ba] 4e94                      jsr        (a4)
[000000bc] 588f                      addq.l     #4,a7
[000000be] 2245                      movea.l    d5,a1
[000000c0] 2287                      move.l     d7,(a1)
[000000c2] 7001                      moveq.l    #1,d0
[000000c4] 23c0 0000 01b8            move.l     d0,_dbrdonly
_dbminit_3:
[000000ca] 2244                      movea.l    d4,a1
[000000cc] 4a91                      tst.l      (a1)
[000000ce] 6d06                      blt.s      _dbminit_4
[000000d0] 2245                      movea.l    d5,a1
[000000d2] 4a91                      tst.l      (a1)
[000000d4] 6c14                      bge.s      _dbminit_1
_dbminit_4:
[000000d6] 2e8b                      move.l     a3,(a7)
[000000d8] 2f3c 0000 000a            move.l     #$00000D88,-(a7) "cannot open database %s\n"
[000000de] 4eb9 0000 0000            jsr        _printf
[000000e4] 588f                      addq.l     #4,a7
[000000e6] 7eff                      moveq.l    #-1,d7
[000000e8] 6020                      bra.s      _dbminit_5
_dbminit_1:
[000000ea] 486e ffdc                 pea.l      -36(a6)
[000000ee] 2245                      movea.l    d5,a1
[000000f0] 2f11                      move.l     (a1),-(a7)
[000000f2] 4eb9 0000 0000            jsr        _fstat
[000000f8] 508f                      addq.l     #8,a7
[000000fa] 2e2e ffec                 move.l     -20(a6),d7
[000000fe] e787                      asl.l      #3,d7
[00000100] 5387                      subq.l     #1,d7
[00000102] 23c7 0000 15cc            move.l     d7,_maxbno
[00000108] 7e00                      moveq.l    #0,d7
_dbminit_5:
[0000010a] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[0000010e] 4e5e                      unlk       a6
[00000110] 4e75                      rts

_forder:
[00000112] 4e56 fffc                 link       a6,#-4
[00000116] 48e7 0c1c                 movem.l    d4-d5/a3-a5,-(a7)
[0000011a] 2a7c 0000 08c0            movea.l    #_getbit,a5
[00000120] 287c 0000 15c4            movea.l    #_hmask,a4
[00000126] 267c 0000 15c8            movea.l    #_blkno,a3
[0000012c] 283c 0000 15d0            move.l     #_bitno,d4
[00000132] 518f                      subq.l     #8,a7
[00000134] 486e 0008                 pea.l      8(a6)
[00000138] 203c 0000 0008            move.l     #$00000008,d0
[0000013e] 4eb9 0000 0000            jsr        a~pushstr
[00000144] 4eb9 0000 0b88            jsr        _calchash
[0000014a] 508f                      addq.l     #8,a7
[0000014c] 2a07                      move.l     d7,d5
[0000014e] 4294                      clr.l      (a4)
_forder_2:
[00000150] 2e05                      move.l     d5,d7
[00000152] ce94                      and.l      (a4),d7
[00000154] 2687                      move.l     d7,(a3)
[00000156] 2244                      movea.l    d4,a1
[00000158] 2e13                      move.l     (a3),d7
[0000015a] de94                      add.l      (a4),d7
[0000015c] 2287                      move.l     d7,(a1)
[0000015e] 4e95                      jsr        (a5)
[00000160] 4a87                      tst.l      d7
[00000162] 660a                      bne.s      _forder_1
[00000164] 2e13                      move.l     (a3),d7
[00000166] 4cdf 3830                 movem.l    (a7)+,d4-d5/a3-a5
[0000016a] 4e5e                      unlk       a6
[0000016c] 4e75                      rts
_forder_1:
[0000016e] 2e14                      move.l     (a4),d7
[00000170] e387                      asl.l      #1,d7
[00000172] 5287                      addq.l     #1,d7
[00000174] 2887                      move.l     d7,(a4)
[00000176] 60d8                      bra.s      _forder_2

w_fetch:
[00000178] 4e56 ffe8                 link       a6,#-24
[0000017c] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[00000180] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[00000186] 287c 0000 0b00            movea.l    #_cmpdatum,a4
[0000018c] 267c 0000 0a74            movea.l    #w_makdatum,a3
[00000192] 283c 0000 0000            move.l     #_printf,d4
[00000198] 518f                      subq.l     #8,a7
[0000019a] 486e 000c                 pea.l      12(a6)
[0000019e] 203c 0000 0008            move.l     #$00000008,d0
[000001a4] 4eb9 0000 0000            jsr        a~pushstr
[000001aa] 4eb9 0000 0b88            jsr        _calchash
[000001b0] 508f                      addq.l     #8,a7
[000001b2] 2e87                      move.l     d7,(a7)
[000001b4] 4eb9 0000 080c            jsr        _dbm_access
[000001ba] 7a00                      moveq.l    #0,d5
w_fetch_3:
[000001bc] 2e85                      move.l     d5,(a7)
[000001be] 2f0d                      move.l     a5,-(a7)
[000001c0] 486e fff8                 pea.l      -8(a6)
[000001c4] 4e93                      jsr        (a3)
[000001c6] 508f                      addq.l     #8,a7
[000001c8] 4aae fff8                 tst.l      -8(a6)
[000001cc] 6618                      bne.s      w_fetch_1
[000001ce] 2e2e 0008                 move.l     8(a6),d7
[000001d2] 486e fff8                 pea.l      -8(a6)
[000001d6] 2f07                      move.l     d7,-(a7)
[000001d8] 7008                      moveq.l    #8,d0
[000001da] 4eb9 0000 0000            jsr        a~movestr
[000001e0] 6064                      bra.s      w_fetch_2
w_fetch_4:
[000001e2] 5485                      addq.l     #2,d5
[000001e4] 60d6                      bra.s      w_fetch_3
w_fetch_1:
[000001e6] 518f                      subq.l     #8,a7
[000001e8] 486e fff8                 pea.l      -8(a6)
[000001ec] 203c 0000 0008            move.l     #$00000008,d0
[000001f2] 4eb9 0000 0000            jsr        a~pushstr
[000001f8] 518f                      subq.l     #8,a7
[000001fa] 486e 000c                 pea.l      12(a6)
[000001fe] 203c 0000 0008            move.l     #$00000008,d0
[00000204] 4eb9 0000 0000            jsr        a~pushstr
[0000020a] 4e94                      jsr        (a4)
[0000020c] 4fef 0010                 lea.l      16(a7),a7
[00000210] 4a87                      tst.l      d7
[00000212] 66ce                      bne.s      w_fetch_4
[00000214] 2f05                      move.l     d5,-(a7)
[00000216] 5297                      addq.l     #1,(a7)
[00000218] 2f0d                      move.l     a5,-(a7)
[0000021a] 486e fff8                 pea.l      -8(a6)
[0000021e] 4e93                      jsr        (a3)
[00000220] 4fef 000c                 lea.l      12(a7),a7
[00000224] 4aae fff8                 tst.l      -8(a6)
[00000228] 660a                      bne.s      w_fetch_5
[0000022a] 2ebc 0000 0023            move.l     #$00000DA1,(a7) "items not in pairs\n"
[00000230] 2244                      movea.l    d4,a1
[00000232] 4e91                      jsr        (a1)
w_fetch_5:
[00000234] 2e2e 0008                 move.l     8(a6),d7
[00000238] 486e fff8                 pea.l      -8(a6)
[0000023c] 2f07                      move.l     d7,-(a7)
[0000023e] 7008                      moveq.l    #8,d0
[00000240] 4eb9 0000 0000            jsr        a~movestr
w_fetch_2:
[00000246] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[0000024a] 4e5e                      unlk       a6
[0000024c] 4e75                      rts

_delete:
[0000024e] 4e56 fff0                 link       a6,#-16
[00000252] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[00000256] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[0000025c] 287c 0000 0bec            movea.l    #_delitem,a4
[00000262] 267c 0000 0a74            movea.l    #w_makdatum,a3
[00000268] 283c 0000 0b00            move.l     #_cmpdatum,d4
[0000026e] 4ab9 0000 01b8            tst.l      _dbrdonly
[00000274] 6704                      beq.s      _delete_1
[00000276] 7eff                      moveq.l    #-1,d7
[00000278] 6038                      bra.s      _delete_2
_delete_1:
[0000027a] 518f                      subq.l     #8,a7
[0000027c] 486e 0008                 pea.l      8(a6)
[00000280] 203c 0000 0008            move.l     #$00000008,d0
[00000286] 4eb9 0000 0000            jsr        a~pushstr
[0000028c] 4eb9 0000 0b88            jsr        _calchash
[00000292] 508f                      addq.l     #8,a7
[00000294] 2e87                      move.l     d7,(a7)
[00000296] 4eb9 0000 080c            jsr        _dbm_access
[0000029c] 7a00                      moveq.l    #0,d5
_delete_4:
[0000029e] 2e85                      move.l     d5,(a7)
[000002a0] 2f0d                      move.l     a5,-(a7)
[000002a2] 486e fff8                 pea.l      -8(a6)
[000002a6] 4e93                      jsr        (a3)
[000002a8] 508f                      addq.l     #8,a7
[000002aa] 4aae fff8                 tst.l      -8(a6)
[000002ae] 660e                      bne.s      _delete_3
[000002b0] 7eff                      moveq.l    #-1,d7
_delete_2:
[000002b2] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[000002b6] 4e5e                      unlk       a6
[000002b8] 4e75                      rts
_delete_5:
[000002ba] 5485                      addq.l     #2,d5
[000002bc] 60e0                      bra.s      _delete_4
_delete_3:
[000002be] 518f                      subq.l     #8,a7
[000002c0] 486e fff8                 pea.l      -8(a6)
[000002c4] 203c 0000 0008            move.l     #$00000008,d0
[000002ca] 4eb9 0000 0000            jsr        a~pushstr
[000002d0] 518f                      subq.l     #8,a7
[000002d2] 486e 0008                 pea.l      8(a6)
[000002d6] 203c 0000 0008            move.l     #$00000008,d0
[000002dc] 4eb9 0000 0000            jsr        a~pushstr
[000002e2] 2244                      movea.l    d4,a1
[000002e4] 4e91                      jsr        (a1)
[000002e6] 4fef 0010                 lea.l      16(a7),a7
[000002ea] 4a87                      tst.l      d7
[000002ec] 66cc                      bne.s      _delete_5
[000002ee] 2e85                      move.l     d5,(a7)
[000002f0] 2f0d                      move.l     a5,-(a7)
[000002f2] 4e94                      jsr        (a4)
[000002f4] 588f                      addq.l     #4,a7
[000002f6] 2e85                      move.l     d5,(a7)
[000002f8] 2f0d                      move.l     a5,-(a7)
[000002fa] 4e94                      jsr        (a4)
[000002fc] 588f                      addq.l     #4,a7
[000002fe] 4297                      clr.l      (a7)
[00000300] 2e39 0000 15c8            move.l     _blkno,d7
[00000306] 203c 0000 000a            move.l     #$0000000A,d0
[0000030c] e1a7                      asl.l      d0,d7
[0000030e] 2f07                      move.l     d7,-(a7)
[00000310] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000316] 4eb9 0000 0000            jsr        _lseek
[0000031c] 508f                      addq.l     #8,a7
[0000031e] 4878 0400                 pea.l      ($00000400).w
[00000322] 2f0d                      move.l     a5,-(a7)
[00000324] 2f39 0000 01bc            move.l     _pagf,-(a7)
[0000032a] 4eb9 0000 0000            jsr        _write
[00000330] 4fef 000c                 lea.l      12(a7),a7
[00000334] 7e00                      moveq.l    #0,d7
[00000336] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[0000033a] 4e5e                      unlk       a6
[0000033c] 4e75                      rts

_store:
[0000033e] 4e56 fbe0                 link       a6,#-1056
[00000342] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000346] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[0000034c] 287c 0000 0ca6            movea.l    #_additem,a4
[00000352] 267c 0000 0b00            movea.l    #_cmpdatum,a3
[00000358] 283c 0000 0000            move.l     #_printf,d4
[0000035e] 263c 0000 0b88            move.l     #_calchash,d3
[00000364] 4ab9 0000 01b8            tst.l      _dbrdonly
[0000036a] 670a                      beq.s      _store_1
[0000036c] 7eff                      moveq.l    #-1,d7
[0000036e] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000372] 4e5e                      unlk       a6
[00000374] 4e75                      rts
_store_1:
[00000376] 518f                      subq.l     #8,a7
[00000378] 486e 0008                 pea.l      8(a6)
[0000037c] 203c 0000 0008            move.l     #$00000008,d0
[00000382] 4eb9 0000 0000            jsr        a~pushstr
[00000388] 2243                      movea.l    d3,a1
[0000038a] 4e91                      jsr        (a1)
[0000038c] 508f                      addq.l     #8,a7
[0000038e] 2e87                      move.l     d7,(a7)
[00000390] 4eb9 0000 080c            jsr        _dbm_access
[00000396] 7a00                      moveq.l    #0,d5
_store_4:
[00000398] 2e85                      move.l     d5,(a7)
[0000039a] 2f0d                      move.l     a5,-(a7)
[0000039c] 486e fff8                 pea.l      -8(a6)
[000003a0] 4eb9 0000 0a74            jsr        w_makdatum
[000003a6] 508f                      addq.l     #8,a7
[000003a8] 4aae fff8                 tst.l      -8(a6)
[000003ac] 6606                      bne.s      _store_2
[000003ae] 604a                      bra.s      _store_3
_store_5:
[000003b0] 5485                      addq.l     #2,d5
[000003b2] 60e4                      bra.s      _store_4
_store_2:
[000003b4] 518f                      subq.l     #8,a7
[000003b6] 486e fff8                 pea.l      -8(a6)
[000003ba] 203c 0000 0008            move.l     #$00000008,d0
[000003c0] 4eb9 0000 0000            jsr        a~pushstr
[000003c6] 518f                      subq.l     #8,a7
[000003c8] 486e 0008                 pea.l      8(a6)
[000003cc] 203c 0000 0008            move.l     #$00000008,d0
[000003d2] 4eb9 0000 0000            jsr        a~pushstr
[000003d8] 4e93                      jsr        (a3)
[000003da] 4fef 0010                 lea.l      16(a7),a7
[000003de] 4a87                      tst.l      d7
[000003e0] 66ce                      bne.s      _store_5
[000003e2] 2e85                      move.l     d5,(a7)
[000003e4] 2f0d                      move.l     a5,-(a7)
[000003e6] 4eb9 0000 0bec            jsr        _delitem
[000003ec] 588f                      addq.l     #4,a7
[000003ee] 2e85                      move.l     d5,(a7)
[000003f0] 2f0d                      move.l     a5,-(a7)
[000003f2] 4eb9 0000 0bec            jsr        _delitem
[000003f8] 588f                      addq.l     #4,a7
_store_3:
[000003fa] 518f                      subq.l     #8,a7
[000003fc] 486e 0008                 pea.l      8(a6)
[00000400] 203c 0000 0008            move.l     #$00000008,d0
[00000406] 4eb9 0000 0000            jsr        a~pushstr
[0000040c] 2f0d                      move.l     a5,-(a7)
[0000040e] 4e94                      jsr        (a4)
[00000410] 4fef 000c                 lea.l      12(a7),a7
[00000414] 2a07                      move.l     d7,d5
[00000416] 4a85                      tst.l      d5
[00000418] 6d2a                      blt.s      _store_6
[0000041a] 518f                      subq.l     #8,a7
[0000041c] 486e 0010                 pea.l      16(a6)
[00000420] 203c 0000 0008            move.l     #$00000008,d0
[00000426] 4eb9 0000 0000            jsr        a~pushstr
[0000042c] 2f0d                      move.l     a5,-(a7)
[0000042e] 4e94                      jsr        (a4)
[00000430] 4fef 000c                 lea.l      12(a7),a7
[00000434] 4a87                      tst.l      d7
[00000436] 6c2c                      bge.s      _store_7
[00000438] 2e85                      move.l     d5,(a7)
[0000043a] 2f0d                      move.l     a5,-(a7)
[0000043c] 4eb9 0000 0bec            jsr        _delitem
[00000442] 588f                      addq.l     #4,a7
_store_6:
[00000444] 2e2e 000c                 move.l     12(a6),d7
[00000448] deae 0014                 add.l      20(a6),d7
[0000044c] 5887                      addq.l     #4,d7
[0000044e] 0c87 0000 0400            cmpi.l     #$00000400,d7
[00000454] 6d4e                      blt.s      _store_8
[00000456] 2ebc 0000 0037            move.l     #$00000DB5,(a7) "entry too big\n"
[0000045c] 2244                      movea.l    d4,a1
[0000045e] 4e91                      jsr        (a1)
[00000460] 7eff                      moveq.l    #-1,d7
[00000462] 6038                      bra.s      _store_9
_store_7:
[00000464] 4297                      clr.l      (a7)
[00000466] 2e39 0000 15c8            move.l     _blkno,d7
[0000046c] 203c 0000 000a            move.l     #$0000000A,d0
[00000472] e1a7                      asl.l      d0,d7
[00000474] 2f07                      move.l     d7,-(a7)
[00000476] 2f39 0000 01bc            move.l     _pagf,-(a7)
[0000047c] 4eb9 0000 0000            jsr        _lseek
[00000482] 508f                      addq.l     #8,a7
[00000484] 4878 0400                 pea.l      ($00000400).w
[00000488] 2f0d                      move.l     a5,-(a7)
[0000048a] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000490] 4eb9 0000 0000            jsr        _write
[00000496] 4fef 000c                 lea.l      12(a7),a7
[0000049a] 7e00                      moveq.l    #0,d7
_store_9:
[0000049c] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000004a0] 4e5e                      unlk       a6
[000004a2] 4e75                      rts
_store_8:
[000004a4] 4878 0400                 pea.l      ($00000400).w
[000004a8] 486e fbf8                 pea.l      -1032(a6)
[000004ac] 4eb9 0000 0a56            jsr        _clrbuf
[000004b2] 508f                      addq.l     #8,a7
[000004b4] 7a00                      moveq.l    #0,d5
_store_13:
[000004b6] 2e85                      move.l     d5,(a7)
[000004b8] 2f0d                      move.l     a5,-(a7)
[000004ba] 486e fff8                 pea.l      -8(a6)
[000004be] 4eb9 0000 0a74            jsr        w_makdatum
[000004c4] 508f                      addq.l     #8,a7
[000004c6] 4aae fff8                 tst.l      -8(a6)
[000004ca] 6770                      beq.s      _store_10
[000004cc] 518f                      subq.l     #8,a7
[000004ce] 486e fff8                 pea.l      -8(a6)
[000004d2] 203c 0000 0008            move.l     #$00000008,d0
[000004d8] 4eb9 0000 0000            jsr        a~pushstr
[000004de] 2243                      movea.l    d3,a1
[000004e0] 4e91                      jsr        (a1)
[000004e2] 508f                      addq.l     #8,a7
[000004e4] 2c39 0000 15c4            move.l     _hmask,d6
[000004ea] 5286                      addq.l     #1,d6
[000004ec] ce86                      and.l      d6,d7
[000004ee] 6700 00fc                 beq        _store_11
[000004f2] 518f                      subq.l     #8,a7
[000004f4] 486e fff8                 pea.l      -8(a6)
[000004f8] 203c 0000 0008            move.l     #$00000008,d0
[000004fe] 4eb9 0000 0000            jsr        a~pushstr
[00000504] 486e fbf8                 pea.l      -1032(a6)
[00000508] 4e94                      jsr        (a4)
[0000050a] 4fef 000c                 lea.l      12(a7),a7
[0000050e] 2e85                      move.l     d5,(a7)
[00000510] 2f0d                      move.l     a5,-(a7)
[00000512] 4eb9 0000 0bec            jsr        _delitem
[00000518] 588f                      addq.l     #4,a7
[0000051a] 2e85                      move.l     d5,(a7)
[0000051c] 2f0d                      move.l     a5,-(a7)
[0000051e] 486e fff8                 pea.l      -8(a6)
[00000522] 4eb9 0000 0a74            jsr        w_makdatum
[00000528] 508f                      addq.l     #8,a7
[0000052a] 4aae fff8                 tst.l      -8(a6)
[0000052e] 6600 0090                 bne        _store_12
[00000532] 2ebc 0000 0046            move.l     #$00000DC4,(a7) "split not paired\n"
[00000538] 2244                      movea.l    d4,a1
[0000053a] 4e91                      jsr        (a1)
_store_10:
[0000053c] 4297                      clr.l      (a7)
[0000053e] 2e39 0000 15c8            move.l     _blkno,d7
[00000544] 203c 0000 000a            move.l     #$0000000A,d0
[0000054a] e1a7                      asl.l      d0,d7
[0000054c] 2f07                      move.l     d7,-(a7)
[0000054e] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000554] 4eb9 0000 0000            jsr        _lseek
[0000055a] 508f                      addq.l     #8,a7
[0000055c] 4878 0400                 pea.l      ($00000400).w
[00000560] 2f0d                      move.l     a5,-(a7)
[00000562] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000568] 4eb9 0000 0000            jsr        _write
[0000056e] 4fef 000c                 lea.l      12(a7),a7
[00000572] 4297                      clr.l      (a7)
[00000574] 2e39 0000 15c8            move.l     _blkno,d7
[0000057a] deb9 0000 15c4            add.l      _hmask,d7
[00000580] 203c 0000 000a            move.l     #$0000000A,d0
[00000586] e1a7                      asl.l      d0,d7
[00000588] 2f07                      move.l     d7,-(a7)
[0000058a] 0697 0000 0400            addi.l     #$00000400,(a7)
[00000590] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000596] 4eb9 0000 0000            jsr        _lseek
[0000059c] 508f                      addq.l     #8,a7
[0000059e] 4878 0400                 pea.l      ($00000400).w
[000005a2] 486e fbf8                 pea.l      -1032(a6)
[000005a6] 2f39 0000 01bc            move.l     _pagf,-(a7)
[000005ac] 4eb9 0000 0000            jsr        _write
[000005b2] 4fef 000c                 lea.l      12(a7),a7
[000005b6] 4eb9 0000 0994            jsr        _setbit
[000005bc] 6000 fdb8                 bra        _store_1
_store_12:
[000005c0] 518f                      subq.l     #8,a7
[000005c2] 486e fff8                 pea.l      -8(a6)
[000005c6] 203c 0000 0008            move.l     #$00000008,d0
[000005cc] 4eb9 0000 0000            jsr        a~pushstr
[000005d2] 486e fbf8                 pea.l      -1032(a6)
[000005d6] 4e94                      jsr        (a4)
[000005d8] 4fef 000c                 lea.l      12(a7),a7
[000005dc] 2e85                      move.l     d5,(a7)
[000005de] 2f0d                      move.l     a5,-(a7)
[000005e0] 4eb9 0000 0bec            jsr        _delitem
[000005e6] 588f                      addq.l     #4,a7
[000005e8] 6000 fecc                 bra        _store_13
_store_11:
[000005ec] 5485                      addq.l     #2,d5
[000005ee] 6000 fec6                 bra        _store_13

w_firstkey:
[000005f2] 4e56 fff4                 link       a6,#-12
[000005f6] 4297                      clr.l      (a7)
[000005f8] 2f2e 0008                 move.l     8(a6),-(a7)
[000005fc] 4eb9 0000 0732            jsr        w_firsthash
[00000602] 588f                      addq.l     #4,a7
[00000604] 4e5e                      unlk       a6
[00000606] 4e75                      rts

w_nextkey:
[00000608] 4e56 ffd8                 link       a6,#-40
[0000060c] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000610] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[00000616] 287c 0000 0a74            movea.l    #w_makdatum,a4
[0000061c] 267c 0000 0b00            movea.l    #_cmpdatum,a3
[00000622] 518f                      subq.l     #8,a7
[00000624] 486e 000c                 pea.l      12(a6)
[00000628] 203c 0000 0008            move.l     #$00000008,d0
[0000062e] 4eb9 0000 0000            jsr        a~pushstr
[00000634] 4eb9 0000 0b88            jsr        _calchash
[0000063a] 508f                      addq.l     #8,a7
[0000063c] 2607                      move.l     d7,d3
[0000063e] 2e83                      move.l     d3,(a7)
[00000640] 4eb9 0000 080c            jsr        _dbm_access
[00000646] 7801                      moveq.l    #1,d4
[00000648] 7a00                      moveq.l    #0,d5
w_nextkey_5:
[0000064a] 2e85                      move.l     d5,(a7)
[0000064c] 2f0d                      move.l     a5,-(a7)
[0000064e] 486e fff8                 pea.l      -8(a6)
[00000652] 4e94                      jsr        (a4)
[00000654] 508f                      addq.l     #8,a7
[00000656] 4aae fff8                 tst.l      -8(a6)
[0000065a] 6620                      bne.s      w_nextkey_1
[0000065c] 4a84                      tst.l      d4
[0000065e] 6600 009a                 bne        w_nextkey_2
[00000662] 2e2e 0008                 move.l     8(a6),d7
[00000666] 486e fff0                 pea.l      -16(a6)
[0000066a] 2f07                      move.l     d7,-(a7)
[0000066c] 7008                      moveq.l    #8,d0
[0000066e] 4eb9 0000 0000            jsr        a~movestr
[00000674] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000678] 4e5e                      unlk       a6
[0000067a] 4e75                      rts
w_nextkey_1:
[0000067c] 518f                      subq.l     #8,a7
[0000067e] 486e fff8                 pea.l      -8(a6)
[00000682] 203c 0000 0008            move.l     #$00000008,d0
[00000688] 4eb9 0000 0000            jsr        a~pushstr
[0000068e] 518f                      subq.l     #8,a7
[00000690] 486e 000c                 pea.l      12(a6)
[00000694] 203c 0000 0008            move.l     #$00000008,d0
[0000069a] 4eb9 0000 0000            jsr        a~pushstr
[000006a0] 4e93                      jsr        (a3)
[000006a2] 4fef 0010                 lea.l      16(a7),a7
[000006a6] 4a87                      tst.l      d7
[000006a8] 6f4a                      ble.s      w_nextkey_3
[000006aa] 4a84                      tst.l      d4
[000006ac] 662e                      bne.s      w_nextkey_4
[000006ae] 518f                      subq.l     #8,a7
[000006b0] 486e fff8                 pea.l      -8(a6)
[000006b4] 203c 0000 0008            move.l     #$00000008,d0
[000006ba] 4eb9 0000 0000            jsr        a~pushstr
[000006c0] 518f                      subq.l     #8,a7
[000006c2] 486e fff0                 pea.l      -16(a6)
[000006c6] 203c 0000 0008            move.l     #$00000008,d0
[000006cc] 4eb9 0000 0000            jsr        a~pushstr
[000006d2] 4e93                      jsr        (a3)
[000006d4] 4fef 0010                 lea.l      16(a7),a7
[000006d8] 4a87                      tst.l      d7
[000006da] 6c18                      bge.s      w_nextkey_3
w_nextkey_4:
[000006dc] 2e0e                      move.l     a6,d7
[000006de] 0687 ffff fff0            addi.l     #$FFFFFFF0,d7
[000006e4] 486e fff8                 pea.l      -8(a6)
[000006e8] 2f07                      move.l     d7,-(a7)
[000006ea] 7008                      moveq.l    #8,d0
[000006ec] 4eb9 0000 0000            jsr        a~movestr
[000006f2] 7800                      moveq.l    #0,d4
w_nextkey_3:
[000006f4] 5485                      addq.l     #2,d5
[000006f6] 6000 ff52                 bra        w_nextkey_5
w_nextkey_2:
[000006fa] 2e83                      move.l     d3,(a7)
[000006fc] 4eb9 0000 0b4a            jsr        _hashinc
[00000702] 2607                      move.l     d7,d3
[00000704] 4a83                      tst.l      d3
[00000706] 6614                      bne.s      w_nextkey_6
[00000708] 2e2e 0008                 move.l     8(a6),d7
[0000070c] 486e fff8                 pea.l      -8(a6)
[00000710] 2f07                      move.l     d7,-(a7)
[00000712] 7008                      moveq.l    #8,d0
[00000714] 4eb9 0000 0000            jsr        a~movestr
[0000071a] 600e                      bra.s      w_nextkey_7
w_nextkey_6:
[0000071c] 2e83                      move.l     d3,(a7)
[0000071e] 2f2e 0008                 move.l     8(a6),-(a7)
[00000722] 4eb9 0000 0732            jsr        w_firsthash
[00000728] 588f                      addq.l     #4,a7
w_nextkey_7:
[0000072a] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[0000072e] 4e5e                      unlk       a6
[00000730] 4e75                      rts

w_firsthash:
[00000732] 4e56 ffe0                 link       a6,#-32
[00000736] 48e7 8c1c                 movem.l    d0/d4-d5/a3-a5,-(a7)
[0000073a] 2a7c 0000 11c4            movea.l    #_pagbuf,a5
[00000740] 287c 0000 0b00            movea.l    #_cmpdatum,a4
[00000746] 267c 0000 0a74            movea.l    #w_makdatum,a3
[0000074c] 282e 000c                 move.l     12(a6),d4
w_firsthash_5:
[00000750] 2e84                      move.l     d4,(a7)
[00000752] 4eb9 0000 080c            jsr        _dbm_access
[00000758] 4297                      clr.l      (a7)
[0000075a] 2f0d                      move.l     a5,-(a7)
[0000075c] 486e fff0                 pea.l      -16(a6)
[00000760] 4e93                      jsr        (a3)
[00000762] 508f                      addq.l     #8,a7
[00000764] 7a02                      moveq.l    #2,d5
w_firsthash_3:
[00000766] 2e85                      move.l     d5,(a7)
[00000768] 2f0d                      move.l     a5,-(a7)
[0000076a] 486e fff8                 pea.l      -8(a6)
[0000076e] 4e93                      jsr        (a3)
[00000770] 508f                      addq.l     #8,a7
[00000772] 4aae fff8                 tst.l      -8(a6)
[00000776] 6624                      bne.s      w_firsthash_1
[00000778] 4aae fff0                 tst.l      -16(a6)
[0000077c] 6764                      beq.s      w_firsthash_2
[0000077e] 2e2e 0008                 move.l     8(a6),d7
[00000782] 486e fff0                 pea.l      -16(a6)
[00000786] 2f07                      move.l     d7,-(a7)
[00000788] 7008                      moveq.l    #8,d0
[0000078a] 4eb9 0000 0000            jsr        a~movestr
[00000790] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00000794] 4e5e                      unlk       a6
[00000796] 4e75                      rts
w_firsthash_4:
[00000798] 5485                      addq.l     #2,d5
[0000079a] 60ca                      bra.s      w_firsthash_3
w_firsthash_1:
[0000079c] 518f                      subq.l     #8,a7
[0000079e] 486e fff8                 pea.l      -8(a6)
[000007a2] 203c 0000 0008            move.l     #$00000008,d0
[000007a8] 4eb9 0000 0000            jsr        a~pushstr
[000007ae] 518f                      subq.l     #8,a7
[000007b0] 486e fff0                 pea.l      -16(a6)
[000007b4] 203c 0000 0008            move.l     #$00000008,d0
[000007ba] 4eb9 0000 0000            jsr        a~pushstr
[000007c0] 4e94                      jsr        (a4)
[000007c2] 4fef 0010                 lea.l      16(a7),a7
[000007c6] 4a87                      tst.l      d7
[000007c8] 6cce                      bge.s      w_firsthash_4
[000007ca] 2e0e                      move.l     a6,d7
[000007cc] 0687 ffff fff0            addi.l     #$FFFFFFF0,d7
[000007d2] 486e fff8                 pea.l      -8(a6)
[000007d6] 2f07                      move.l     d7,-(a7)
[000007d8] 7008                      moveq.l    #8,d0
[000007da] 4eb9 0000 0000            jsr        a~movestr
[000007e0] 60b6                      bra.s      w_firsthash_4
w_firsthash_2:
[000007e2] 2e84                      move.l     d4,(a7)
[000007e4] 4eb9 0000 0b4a            jsr        _hashinc
[000007ea] 2807                      move.l     d7,d4
[000007ec] 4a84                      tst.l      d4
[000007ee] 6600 ff60                 bne        w_firsthash_5
[000007f2] 2e2e 0008                 move.l     8(a6),d7
[000007f6] 486e fff8                 pea.l      -8(a6)
[000007fa] 2f07                      move.l     d7,-(a7)
[000007fc] 7008                      moveq.l    #8,d0
[000007fe] 4eb9 0000 0000            jsr        a~movestr
[00000804] 4cdf 3831                 movem.l    (a7)+,d0/d4-d5/a3-a5
[00000808] 4e5e                      unlk       a6
[0000080a] 4e75                      rts

_dbm_access:
[0000080c] 4e56 0000                 link       a6,#0
[00000810] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000814] 2a7c 0000 08c0            movea.l    #_getbit,a5
[0000081a] 2a2e 0008                 move.l     8(a6),d5
[0000081e] 287c 0000 15d0            movea.l    #_bitno,a4
[00000824] 267c 0000 15c4            movea.l    #_hmask,a3
[0000082a] 283c 0000 15c8            move.l     #_blkno,d4
[00000830] 263c 0000 11c4            move.l     #_pagbuf,d3
[00000836] 4293                      clr.l      (a3)
_dbm_access_3:
[00000838] 2244                      movea.l    d4,a1
[0000083a] 2e05                      move.l     d5,d7
[0000083c] ce93                      and.l      (a3),d7
[0000083e] 2287                      move.l     d7,(a1)
[00000840] 2244                      movea.l    d4,a1
[00000842] 2e11                      move.l     (a1),d7
[00000844] de93                      add.l      (a3),d7
[00000846] 2887                      move.l     d7,(a4)
[00000848] 4e95                      jsr        (a5)
[0000084a] 4a87                      tst.l      d7
[0000084c] 6660                      bne.s      _dbm_access_1
[0000084e] 2244                      movea.l    d4,a1
[00000850] 2e11                      move.l     (a1),d7
[00000852] beb9 0000 0058            cmp.l      $00000DD6,d7
[00000858] 675e                      beq.s      _dbm_access_2
[0000085a] 4878 0400                 pea.l      ($00000400).w
[0000085e] 2f03                      move.l     d3,-(a7)
[00000860] 4eb9 0000 0a56            jsr        _clrbuf
[00000866] 508f                      addq.l     #8,a7
[00000868] 4297                      clr.l      (a7)
[0000086a] 2244                      movea.l    d4,a1
[0000086c] 2e11                      move.l     (a1),d7
[0000086e] 203c 0000 000a            move.l     #$0000000A,d0
[00000874] e1a7                      asl.l      d0,d7
[00000876] 2f07                      move.l     d7,-(a7)
[00000878] 2f39 0000 01bc            move.l     _pagf,-(a7)
[0000087e] 4eb9 0000 0000            jsr        _lseek
[00000884] 508f                      addq.l     #8,a7
[00000886] 4878 0400                 pea.l      ($00000400).w
[0000088a] 2f03                      move.l     d3,-(a7)
[0000088c] 2f39 0000 01bc            move.l     _pagf,-(a7)
[00000892] 4eb9 0000 0000            jsr        _read
[00000898] 4fef 000c                 lea.l      12(a7),a7
[0000089c] 2e83                      move.l     d3,(a7)
[0000089e] 4eb9 0000 0d12            jsr        _chkblk
[000008a4] 2244                      movea.l    d4,a1
[000008a6] 23d1 0000 0058            move.l     (a1),$00000DD6
[000008ac] 600a                      bra.s      _dbm_access_2
_dbm_access_1:
[000008ae] 2e13                      move.l     (a3),d7
[000008b0] e387                      asl.l      #1,d7
[000008b2] 5287                      addq.l     #1,d7
[000008b4] 2687                      move.l     d7,(a3)
[000008b6] 6080                      bra.s      _dbm_access_3
_dbm_access_2:
[000008b8] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[000008bc] 4e5e                      unlk       a6
[000008be] 4e75                      rts

_getbit:
[000008c0] 4e56 fffc                 link       a6,#-4
[000008c4] 48e7 9c0c                 movem.l    d0/d3-d5/a4-a5,-(a7)
[000008c8] 287c 0000 01c4            movea.l    #_dirbuf,a4
[000008ce] 2e39 0000 15d0            move.l     _bitno,d7
[000008d4] beb9 0000 15cc            cmp.l      _maxbno,d7
[000008da] 6f0a                      ble.s      _getbit_1
[000008dc] 7e00                      moveq.l    #0,d7
[000008de] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[000008e2] 4e5e                      unlk       a6
[000008e4] 4e75                      rts
_getbit_1:
[000008e6] 2eb9 0000 15d0            move.l     _bitno,(a7)
[000008ec] 4878 0008                 pea.l      ($00000008).w
[000008f0] 4eb9 0000 0000            jsr        a~lmod
[000008f6] 2617                      move.l     (a7),d3
[000008f8] 2eb9 0000 15d0            move.l     _bitno,(a7)
[000008fe] 4878 0008                 pea.l      ($00000008).w
[00000902] 4eb9 0000 0000            jsr        a~ldiv
[00000908] 2a57                      movea.l    (a7),a5
[0000090a] 2e8d                      move.l     a5,(a7)
[0000090c] 4878 1000                 pea.l      ($00001000).w
[00000910] 4eb9 0000 0000            jsr        a~lmod
[00000916] 2817                      move.l     (a7),d4
[00000918] 2e8d                      move.l     a5,(a7)
[0000091a] 4878 1000                 pea.l      ($00001000).w
[0000091e] 4eb9 0000 0000            jsr        a~ldiv
[00000924] 2a17                      move.l     (a7),d5
[00000926] bab9 0000 005c            cmp.l      $00000DDA,d5
[0000092c] 6746                      beq.s      _getbit_2
[0000092e] 4878 1000                 pea.l      ($00001000).w
[00000932] 2f0c                      move.l     a4,-(a7)
[00000934] 4eb9 0000 0a56            jsr        _clrbuf
[0000093a] 508f                      addq.l     #8,a7
[0000093c] 4297                      clr.l      (a7)
[0000093e] 2e05                      move.l     d5,d7
[00000940] 203c 0000 000c            move.l     #$0000000C,d0
[00000946] e1a7                      asl.l      d0,d7
[00000948] 2f07                      move.l     d7,-(a7)
[0000094a] 2f39 0000 01c0            move.l     _dirf,-(a7)
[00000950] 4eb9 0000 0000            jsr        _lseek
[00000956] 508f                      addq.l     #8,a7
[00000958] 4878 1000                 pea.l      ($00001000).w
[0000095c] 2f0c                      move.l     a4,-(a7)
[0000095e] 2f39 0000 01c0            move.l     _dirf,-(a7)
[00000964] 4eb9 0000 0000            jsr        _read
[0000096a] 4fef 000c                 lea.l      12(a7),a7
[0000096e] 23c5 0000 005c            move.l     d5,$00000DDA
_getbit_2:
[00000974] 1e34 4800                 move.b     0(a4,d4.l),d7
[00000978] 7c01                      moveq.l    #1,d6
[0000097a] e7a6                      asl.l      d3,d6
[0000097c] ce06                      and.b      d6,d7
[0000097e] 0287 0000 00ff            andi.l     #$000000FF,d7
[00000984] 6704                      beq.s      _getbit_3
[00000986] 7e01                      moveq.l    #1,d7
[00000988] 6002                      bra.s      _getbit_4
_getbit_3:
[0000098a] 7e00                      moveq.l    #0,d7
_getbit_4:
[0000098c] 4cdf 3039                 movem.l    (a7)+,d0/d3-d5/a4-a5
[00000990] 4e5e                      unlk       a6
[00000992] 4e75                      rts

_setbit:
[00000994] 4e56 fffc                 link       a6,#-4
[00000998] 48e7 9c04                 movem.l    d0/d3-d5/a5,-(a7)
[0000099c] 4ab9 0000 01b8            tst.l      _dbrdonly
[000009a2] 670a                      beq.s      _setbit_1
[000009a4] 7eff                      moveq.l    #-1,d7
[000009a6] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[000009aa] 4e5e                      unlk       a6
[000009ac] 4e75                      rts
_setbit_1:
[000009ae] 2e39 0000 15d0            move.l     _bitno,d7
[000009b4] beb9 0000 15cc            cmp.l      _maxbno,d7
[000009ba] 6f0e                      ble.s      _setbit_2
[000009bc] 23f9 0000 15d0 0000 15cc  move.l     _bitno,_maxbno
[000009c6] 4eba fef8                 jsr        _getbit(pc)
_setbit_2:
[000009ca] 2eb9 0000 15d0            move.l     _bitno,(a7)
[000009d0] 4878 0008                 pea.l      ($00000008).w
[000009d4] 4eb9 0000 0000            jsr        a~lmod
[000009da] 2817                      move.l     (a7),d4
[000009dc] 2eb9 0000 15d0            move.l     _bitno,(a7)
[000009e2] 4878 0008                 pea.l      ($00000008).w
[000009e6] 4eb9 0000 0000            jsr        a~ldiv
[000009ec] 2a57                      movea.l    (a7),a5
[000009ee] 2e8d                      move.l     a5,(a7)
[000009f0] 4878 1000                 pea.l      ($00001000).w
[000009f4] 4eb9 0000 0000            jsr        a~lmod
[000009fa] 2a17                      move.l     (a7),d5
[000009fc] 2e8d                      move.l     a5,(a7)
[000009fe] 4878 1000                 pea.l      ($00001000).w
[00000a02] 4eb9 0000 0000            jsr        a~ldiv
[00000a08] 2617                      move.l     (a7),d3
[00000a0a] 2245                      movea.l    d5,a1
[00000a0c] d3fc 0000 01c4            adda.l     #_dirbuf,a1
[00000a12] 7e01                      moveq.l    #1,d7
[00000a14] e9a7                      asl.l      d4,d7
[00000a16] 8f11                      or.b       d7,(a1)
[00000a18] 4297                      clr.l      (a7)
[00000a1a] 2e03                      move.l     d3,d7
[00000a1c] 203c 0000 000c            move.l     #$0000000C,d0
[00000a22] e1a7                      asl.l      d0,d7
[00000a24] 2f07                      move.l     d7,-(a7)
[00000a26] 2f39 0000 01c0            move.l     _dirf,-(a7)
[00000a2c] 4eb9 0000 0000            jsr        _lseek
[00000a32] 508f                      addq.l     #8,a7
[00000a34] 4878 1000                 pea.l      ($00001000).w
[00000a38] 2f3c 0000 01c4            move.l     #_dirbuf,-(a7)
[00000a3e] 2f39 0000 01c0            move.l     _dirf,-(a7)
[00000a44] 4eb9 0000 0000            jsr        _write
[00000a4a] 4fef 000c                 lea.l      12(a7),a7
[00000a4e] 4cdf 2039                 movem.l    (a7)+,d0/d3-d5/a5
[00000a52] 4e5e                      unlk       a6
[00000a54] 4e75                      rts

_clrbuf:
[00000a56] 4e56 0000                 link       a6,#0
[00000a5a] 48e7 0404                 movem.l    d5/a5,-(a7)
[00000a5e] 2a6e 0008                 movea.l    8(a6),a5
[00000a62] 2a2e 000c                 move.l     12(a6),d5
_clrbuf_1:
[00000a66] 421d                      clr.b      (a5)+
[00000a68] 5385                      subq.l     #1,d5
[00000a6a] 66fa                      bne.s      _clrbuf_1
[00000a6c] 4cdf 2020                 movem.l    (a7)+,d5/a5
[00000a70] 4e5e                      unlk       a6
[00000a72] 4e75                      rts

w_makdatum:
[00000a74] 4e56 fff8                 link       a6,#-8
[00000a78] 48e7 0c04                 movem.l    d4-d5/a5,-(a7)
[00000a7c] 282e 0010                 move.l     16(a6),d4
[00000a80] 2a6e 000c                 movea.l    12(a6),a5
[00000a84] 4a84                      tst.l      d4
[00000a86] 6d56                      blt.s      w_makdatum_1
[00000a88] 3e15                      move.w     (a5),d7
[00000a8a] 48c7                      ext.l      d7
[00000a8c] b887                      cmp.l      d7,d4
[00000a8e] 6c4e                      bge.s      w_makdatum_1
[00000a90] 3a3c 0400                 move.w     #$0400,d5
[00000a94] 48c5                      ext.l      d5
[00000a96] 4a84                      tst.l      d4
[00000a98] 6f0c                      ble.s      w_makdatum_2
[00000a9a] 2a04                      move.l     d4,d5
[00000a9c] 5285                      addq.l     #1,d5
[00000a9e] da85                      add.l      d5,d5
[00000aa0] 3a35 58fe                 move.w     -2(a5,d5.l),d5
[00000aa4] 48c5                      ext.l      d5
w_makdatum_2:
[00000aa6] 2e04                      move.l     d4,d7
[00000aa8] de87                      add.l      d7,d7
[00000aaa] 3e35 7802                 move.w     2(a5,d7.l),d7
[00000aae] 48c7                      ext.l      d7
[00000ab0] deae 000c                 add.l      12(a6),d7
[00000ab4] 2d47 fff8                 move.l     d7,-8(a6)
[00000ab8] 2e04                      move.l     d4,d7
[00000aba] de87                      add.l      d7,d7
[00000abc] 3e35 7802                 move.w     2(a5,d7.l),d7
[00000ac0] 48c7                      ext.l      d7
[00000ac2] 2c05                      move.l     d5,d6
[00000ac4] 9c87                      sub.l      d7,d6
[00000ac6] 2d46 fffc                 move.l     d6,-4(a6)
[00000aca] 2e2e 0008                 move.l     8(a6),d7
[00000ace] 486e fff8                 pea.l      -8(a6)
[00000ad2] 2f07                      move.l     d7,-(a7)
[00000ad4] 7008                      moveq.l    #8,d0
[00000ad6] 4eb9 0000 0000            jsr        a~movestr
[00000adc] 601a                      bra.s      w_makdatum_3
w_makdatum_1:
[00000ade] 42ae fff8                 clr.l      -8(a6)
[00000ae2] 42ae fffc                 clr.l      -4(a6)
[00000ae6] 2e2e 0008                 move.l     8(a6),d7
[00000aea] 486e fff8                 pea.l      -8(a6)
[00000aee] 2f07                      move.l     d7,-(a7)
[00000af0] 7008                      moveq.l    #8,d0
[00000af2] 4eb9 0000 0000            jsr        a~movestr
w_makdatum_3:
[00000af8] 4cdf 2030                 movem.l    (a7)+,d4-d5/a5
[00000afc] 4e5e                      unlk       a6
[00000afe] 4e75                      rts

_cmpdatum:
[00000b00] 4e56 0000                 link       a6,#0
[00000b04] 48e7 040c                 movem.l    d5/a4-a5,-(a7)
[00000b08] 2a2e 000c                 move.l     12(a6),d5
[00000b0c] baae 0014                 cmp.l      20(a6),d5
[00000b10] 6708                      beq.s      _cmpdatum_1
[00000b12] 2e05                      move.l     d5,d7
[00000b14] 9eae 0014                 sub.l      20(a6),d7
[00000b18] 6006                      bra.s      _cmpdatum_2
_cmpdatum_1:
[00000b1a] 4a85                      tst.l      d5
[00000b1c] 660a                      bne.s      _cmpdatum_3
[00000b1e] 7e00                      moveq.l    #0,d7
_cmpdatum_2:
[00000b20] 4cdf 3020                 movem.l    (a7)+,d5/a4-a5
[00000b24] 4e5e                      unlk       a6
[00000b26] 4e75                      rts
_cmpdatum_3:
[00000b28] 2a6e 0008                 movea.l    8(a6),a5
[00000b2c] 286e 0010                 movea.l    16(a6),a4
_cmpdatum_5:
[00000b30] 1e1d                      move.b     (a5)+,d7
[00000b32] be1c                      cmp.b      (a4)+,d7
[00000b34] 670c                      beq.s      _cmpdatum_4
[00000b36] 7e00                      moveq.l    #0,d7
[00000b38] 1e25                      move.b     -(a5),d7
[00000b3a] 7c00                      moveq.l    #0,d6
[00000b3c] 1c24                      move.b     -(a4),d6
[00000b3e] 9e86                      sub.l      d6,d7
[00000b40] 60de                      bra.s      _cmpdatum_2
_cmpdatum_4:
[00000b42] 5385                      subq.l     #1,d5
[00000b44] 66ea                      bne.s      _cmpdatum_5
[00000b46] 7e00                      moveq.l    #0,d7
[00000b48] 60d6                      bra.s      _cmpdatum_2

_hashinc:
[00000b4a] 4e56 fffc                 link       a6,#-4
[00000b4e] 48e7 0c00                 movem.l    d4-d5,-(a7)
[00000b52] 282e 0008                 move.l     8(a6),d4
[00000b56] c8b9 0000 15c4            and.l      _hmask,d4
[00000b5c] 2a39 0000 15c4            move.l     _hmask,d5
[00000b62] 5285                      addq.l     #1,d5
_hashinc_4:
[00000b64] e285                      asr.l      #1,d5
[00000b66] 4a85                      tst.l      d5
[00000b68] 6604                      bne.s      _hashinc_1
[00000b6a] 7e00                      moveq.l    #0,d7
[00000b6c] 600a                      bra.s      _hashinc_2
_hashinc_1:
[00000b6e] 2e04                      move.l     d4,d7
[00000b70] ce85                      and.l      d5,d7
[00000b72] 660c                      bne.s      _hashinc_3
[00000b74] 2e04                      move.l     d4,d7
[00000b76] 8e85                      or.l       d5,d7
_hashinc_2:
[00000b78] 4cdf 0030                 movem.l    (a7)+,d4-d5
[00000b7c] 4e5e                      unlk       a6
[00000b7e] 4e75                      rts
_hashinc_3:
[00000b80] 2e05                      move.l     d5,d7
[00000b82] 4687                      not.l      d7
[00000b84] c887                      and.l      d7,d4
[00000b86] 60dc                      bra.s      _hashinc_4

_calchash:
[00000b88] 4e56 fff8                 link       a6,#-8
[00000b8c] 48e7 1c1c                 movem.l    d3-d5/a3-a5,-(a7)
[00000b90] 2a7c 0000 0060            movea.l    #_hitab,a5
[00000b96] 287c 0000 00a0            movea.l    #_hltab,a4
[00000b9c] 97cb                      suba.l     a3,a3
[00000b9e] 42ae fff8                 clr.l      -8(a6)
[00000ba2] 7a00                      moveq.l    #0,d5
_calchash_4:
[00000ba4] baae 000c                 cmp.l      12(a6),d5
[00000ba8] 6c38                      bge.s      _calchash_1
[00000baa] 226e 0008                 movea.l    8(a6),a1
[00000bae] 7600                      moveq.l    #0,d3
[00000bb0] 1631 5800                 move.b     0(a1,d5.l),d3
[00000bb4] 7800                      moveq.l    #0,d4
_calchash_3:
[00000bb6] 0c84 0000 0008            cmpi.l     #$00000008,d4
[00000bbc] 6c20                      bge.s      _calchash_2
[00000bbe] 7e0f                      moveq.l    #15,d7
[00000bc0] ce83                      and.l      d3,d7
[00000bc2] e587                      asl.l      #2,d7
[00000bc4] 2e35 7800                 move.l     0(a5,d7.l),d7
[00000bc8] dfae fff8                 add.l      d7,-8(a6)
[00000bcc] 7e3f                      moveq.l    #63,d7
[00000bce] ceae fff8                 and.l      -8(a6),d7
[00000bd2] e587                      asl.l      #2,d7
[00000bd4] d7f4 7800                 adda.l     0(a4,d7.l),a3
[00000bd8] e883                      asr.l      #4,d3
[00000bda] 5884                      addq.l     #4,d4
[00000bdc] 60d8                      bra.s      _calchash_3
_calchash_2:
[00000bde] 5285                      addq.l     #1,d5
[00000be0] 60c2                      bra.s      _calchash_4
_calchash_1:
[00000be2] 2e0b                      move.l     a3,d7
[00000be4] 4cdf 3838                 movem.l    (a7)+,d3-d5/a3-a5
[00000be8] 4e5e                      unlk       a6
[00000bea] 4e75                      rts

_delitem:
[00000bec] 4e56 0000                 link       a6,#0
[00000bf0] 48e7 9c1c                 movem.l    d0/d3-d5/a3-a5,-(a7)
[00000bf4] 286e 0008                 movea.l    8(a6),a4
[00000bf8] 266e 000c                 movea.l    12(a6),a3
[00000bfc] 2a4c                      movea.l    a4,a5
[00000bfe] 2e0b                      move.l     a3,d7
[00000c00] 6d00 008a                 blt        _delitem_1
[00000c04] 3e15                      move.w     (a5),d7
[00000c06] 48c7                      ext.l      d7
[00000c08] b7c7                      cmpa.l     d7,a3
[00000c0a] 6c00 0080                 bge        _delitem_1 ; possibly optimized to short
[00000c0e] 2a0b                      move.l     a3,d5
[00000c10] da85                      add.l      d5,d5
[00000c12] 3a35 5802                 move.w     2(a5,d5.l),d5
[00000c16] 48c5                      ext.l      d5
[00000c18] 383c 0400                 move.w     #$0400,d4
[00000c1c] 48c4                      ext.l      d4
[00000c1e] 2e0b                      move.l     a3,d7
[00000c20] 6f0c                      ble.s      _delitem_2
[00000c22] 280b                      move.l     a3,d4
[00000c24] 5284                      addq.l     #1,d4
[00000c26] d884                      add.l      d4,d4
[00000c28] 3835 48fe                 move.w     -2(a5,d4.l),d4
[00000c2c] 48c4                      ext.l      d4
_delitem_2:
[00000c2e] 3615                      move.w     (a5),d3
[00000c30] 48c3                      ext.l      d3
[00000c32] 5283                      addq.l     #1,d3
[00000c34] d683                      add.l      d3,d3
[00000c36] 3635 38fe                 move.w     -2(a5,d3.l),d3
[00000c3a] 48c3                      ext.l      d3
[00000c3c] b885                      cmp.l      d5,d4
[00000c3e] 6f14                      ble.s      _delitem_3
_delitem_4:
[00000c40] ba83                      cmp.l      d3,d5
[00000c42] 6f10                      ble.s      _delitem_3
[00000c44] 5385                      subq.l     #1,d5
[00000c46] 5384                      subq.l     #1,d4
[00000c48] 19b4 5800 4800            move.b     0(a4,d5.l),0(a4,d4.l)
[00000c4e] 4234 5800                 clr.b      0(a4,d5.l)
[00000c52] 60ec                      bra.s      _delitem_4
_delitem_3:
[00000c54] 9885                      sub.l      d5,d4
[00000c56] 43eb 0001                 lea.l      1(a3),a1
[00000c5a] 2a09                      move.l     a1,d5
_delitem_6:
[00000c5c] 3e15                      move.w     (a5),d7
[00000c5e] 48c7                      ext.l      d7
[00000c60] ba87                      cmp.l      d7,d5
[00000c62] 6c1a                      bge.s      _delitem_5
[00000c64] 2e05                      move.l     d5,d7
[00000c66] 5287                      addq.l     #1,d7
[00000c68] de87                      add.l      d7,d7
[00000c6a] 2c05                      move.l     d5,d6
[00000c6c] dc86                      add.l      d6,d6
[00000c6e] 3c35 6802                 move.w     2(a5,d6.l),d6
[00000c72] 48c6                      ext.l      d6
[00000c74] dc84                      add.l      d4,d6
[00000c76] 3b86 78fe                 move.w     d6,-2(a5,d7.l)
[00000c7a] 5285                      addq.l     #1,d5
[00000c7c] 60de                      bra.s      _delitem_6
_delitem_5:
[00000c7e] 5355                      subq.w     #1,(a5)
[00000c80] 3e15                      move.w     (a5),d7
[00000c82] 48c7                      ext.l      d7
[00000c84] de87                      add.l      d7,d7
[00000c86] 4275 7802                 clr.w      2(a5,d7.l)
[00000c8a] 6012                      bra.s      _delitem_7
_delitem_1:
[00000c8c] 2ebc 0000 01a0            move.l     #$00000F1E,(a7)
[00000c92] 4eb9 0000 0000            jsr        _printf
[00000c98] 4eb9 0000 0000            jsr        _abort
_delitem_7:
[00000c9e] 4cdf 3839                 movem.l    (a7)+,d0/d3-d5/a3-a5
[00000ca2] 4e5e                      unlk       a6
[00000ca4] 4e75                      rts

_additem:
[00000ca6] 4e56 0000                 link       a6,#0
[00000caa] 48e7 0c0c                 movem.l    d4-d5/a4-a5,-(a7)
[00000cae] 286e 0008                 movea.l    8(a6),a4
[00000cb2] 2a4c                      movea.l    a4,a5
[00000cb4] 3a3c 0400                 move.w     #$0400,d5
[00000cb8] 48c5                      ext.l      d5
[00000cba] 4a55                      tst.w      (a5)
[00000cbc] 6f0e                      ble.s      _additem_1
[00000cbe] 3a15                      move.w     (a5),d5
[00000cc0] 48c5                      ext.l      d5
[00000cc2] 5285                      addq.l     #1,d5
[00000cc4] da85                      add.l      d5,d5
[00000cc6] 3a35 58fe                 move.w     -2(a5,d5.l),d5
[00000cca] 48c5                      ext.l      d5
_additem_1:
[00000ccc] 9aae 0010                 sub.l      16(a6),d5
[00000cd0] 3815                      move.w     (a5),d4
[00000cd2] 48c4                      ext.l      d4
[00000cd4] d884                      add.l      d4,d4
[00000cd6] 5884                      addq.l     #4,d4
[00000cd8] ba84                      cmp.l      d4,d5
[00000cda] 6e04                      bgt.s      _additem_2
[00000cdc] 7eff                      moveq.l    #-1,d7
[00000cde] 602a                      bra.s      _additem_3
_additem_2:
[00000ce0] 3e15                      move.w     (a5),d7
[00000ce2] 48c7                      ext.l      d7
[00000ce4] de87                      add.l      d7,d7
[00000ce6] 3b85 7802                 move.w     d5,2(a5,d7.l)
[00000cea] 7800                      moveq.l    #0,d4
_additem_5:
[00000cec] b8ae 0010                 cmp.l      16(a6),d4
[00000cf0] 6c10                      bge.s      _additem_4
[00000cf2] 226e 000c                 movea.l    12(a6),a1
[00000cf6] 19b1 4800 5800            move.b     0(a1,d4.l),0(a4,d5.l)
[00000cfc] 5285                      addq.l     #1,d5
[00000cfe] 5284                      addq.l     #1,d4
[00000d00] 60ea                      bra.s      _additem_5
_additem_4:
[00000d02] 5255                      addq.w     #1,(a5)
[00000d04] 3e15                      move.w     (a5),d7
[00000d06] 48c7                      ext.l      d7
[00000d08] 5387                      subq.l     #1,d7
_additem_3:
[00000d0a] 4cdf 3030                 movem.l    (a7)+,d4-d5/a4-a5
[00000d0e] 4e5e                      unlk       a6
[00000d10] 4e75                      rts

_chkblk:
[00000d12] 4e56 0000                 link       a6,#0
[00000d16] 48e7 8c04                 movem.l    d0/d4-d5/a5,-(a7)
[00000d1a] 2a6e 0008                 movea.l    8(a6),a5
[00000d1e] 3a3c 0400                 move.w     #$0400,d5
[00000d22] 48c5                      ext.l      d5
[00000d24] 7800                      moveq.l    #0,d4
_chkblk_3:
[00000d26] 3e15                      move.w     (a5),d7
[00000d28] 48c7                      ext.l      d7
[00000d2a] b887                      cmp.l      d7,d4
[00000d2c] 6c1c                      bge.s      _chkblk_1
[00000d2e] 2e04                      move.l     d4,d7
[00000d30] de87                      add.l      d7,d7
[00000d32] 3e35 7802                 move.w     2(a5,d7.l),d7
[00000d36] 48c7                      ext.l      d7
[00000d38] be85                      cmp.l      d5,d7
[00000d3a] 6e1a                      bgt.s      _chkblk_2
[00000d3c] 2a04                      move.l     d4,d5
[00000d3e] da85                      add.l      d5,d5
[00000d40] 3a35 5802                 move.w     2(a5,d5.l),d5
[00000d44] 48c5                      ext.l      d5
[00000d46] 5284                      addq.l     #1,d4
[00000d48] 60dc                      bra.s      _chkblk_3
_chkblk_1:
[00000d4a] 3e15                      move.w     (a5),d7
[00000d4c] 48c7                      ext.l      d7
[00000d4e] de87                      add.l      d7,d7
[00000d50] 5487                      addq.l     #2,d7
[00000d52] ba87                      cmp.l      d7,d5
[00000d54] 6c20                      bge.s      _chkblk_4
_chkblk_2:
[00000d56] 2ebc 0000 01ad            move.l     #$00000F2B,(a7)
[00000d5c] 4eb9 0000 0000            jsr        _printf
[00000d62] 4eb9 0000 0000            jsr        _abort
[00000d68] 4878 0400                 pea.l      ($00000400).w
[00000d6c] 2f2e 0008                 move.l     8(a6),-(a7)
[00000d70] 4eba fce4                 jsr        _clrbuf(pc)
[00000d74] 508f                      addq.l     #8,a7
_chkblk_4:
[00000d76] 4cdf 2031                 movem.l    (a7)+,d0/d4-d5/a5
[00000d7a] 4e5e                      unlk       a6
[00000d7c] 4e75                      rts

	.data
[00000d7e]                           dc.b '.pag',0
[00000d83]                           dc.b '.dir',0
[00000d88]                           dc.b 'cannot open database %s',$0a,0
[00000da1]                           dc.b 'items not in pairs',$0a,0
[00000db5]                           dc.b 'entry too big',$0a,0
[00000dc4]                           dc.b 'split not paired',$0a,0
[00000dd6]                           dc.l $ffffffff
[00000dda]                           dc.l $ffffffff
_hitab:
[00000dde]                           dc.b $00
[00000ddf]                           dc.b $00
[00000de0]                           dc.b $00
[00000de1]                           dc.b $3d
[00000de2]                           dc.b $00
[00000de3]                           dc.b $00
[00000de4]                           dc.b $00
[00000de5]                           dc.b $39
[00000de6]                           dc.b $00
[00000de7]                           dc.b $00
[00000de8]                           dc.b $00
[00000de9]                           dc.b $35
[00000dea]                           dc.b $00
[00000deb]                           dc.b $00
[00000dec]                           dc.b $00
[00000ded]                           dc.b $31
[00000dee]                           dc.b $00
[00000def]                           dc.b $00
[00000df0]                           dc.b $00
[00000df1]                           dc.b $2d
[00000df2]                           dc.b $00
[00000df3]                           dc.b $00
[00000df4]                           dc.b $00
[00000df5]                           dc.b $29
[00000df6]                           dc.b $00
[00000df7]                           dc.b $00
[00000df8]                           dc.b $00
[00000df9]                           dc.b $25
[00000dfa]                           dc.b $00
[00000dfb]                           dc.b $00
[00000dfc]                           dc.b $00
[00000dfd]                           dc.b $21
[00000dfe]                           dc.b $00
[00000dff]                           dc.b $00
[00000e00]                           dc.b $00
[00000e01]                           dc.b $1d
[00000e02]                           dc.b $00
[00000e03]                           dc.b $00
[00000e04]                           dc.b $00
[00000e05]                           dc.b $19
[00000e06]                           dc.b $00
[00000e07]                           dc.b $00
[00000e08]                           dc.b $00
[00000e09]                           dc.b $15
[00000e0a]                           dc.b $00
[00000e0b]                           dc.b $00
[00000e0c]                           dc.b $00
[00000e0d]                           dc.b $11
[00000e0e]                           dc.b $00
[00000e0f]                           dc.b $00
[00000e10]                           dc.b $00
[00000e11]                           dc.b $0d
[00000e12]                           dc.b $00
[00000e13]                           dc.b $00
[00000e14]                           dc.b $00
[00000e15]                           dc.b $09
[00000e16]                           dc.b $00
[00000e17]                           dc.b $00
[00000e18]                           dc.b $00
[00000e19]                           dc.b $05
[00000e1a]                           dc.b $00
[00000e1b]                           dc.b $00
[00000e1c]                           dc.b $00
[00000e1d]                           dc.b $01
_hltab:
[00000e1e]                           dc.w $3100
[00000e20]                           dc.w $d2bf
[00000e22]                           dc.w $3118
[00000e24]                           dc.w $e3de
[00000e26]                           dc.w $34ab
[00000e28]                           dc.w $1372
[00000e2a]                           dc.w $2807
[00000e2c]                           dc.w $a847
[00000e2e]                           dc.w $1633
[00000e30]                           dc.w $f566
[00000e32]                           dc.w $2143
[00000e34]                           dc.w $b359
[00000e36]                           dc.w $26d5
[00000e38]                           dc.w $6488
[00000e3a]                           dc.w $3b9e
[00000e3c]                           dc.b 'oY7uVV0'
[00000e43]                           dc.b $89
[00000e44]                           dc.w $ca7b
[00000e46]                           dc.w $18e9
[00000e48]                           dc.w $2d85
[00000e4a]                           dc.w $0cd0
[00000e4c]                           dc.w $e9d8
[00000e4e]                           dc.w $1a9e
[00000e50]                           dc.w $3b54
[00000e52]                           dc.w $3eaa
[00000e54]                           dc.w $902f
[00000e56]                           dc.w $0d9b
[00000e58]                           dc.w $faae
[00000e5a]                           dc.w $2f32
[00000e5c]                           dc.w $b45b
[00000e5e]                           dc.w $31ed
[00000e60]                           dc.w $6102
[00000e62]                           dc.w $3d3c
[00000e64]                           dc.w $8398
[00000e66]                           dc.w $1466
[00000e68]                           dc.w $60e3
[00000e6a]                           dc.w $0f8d
[00000e6c]                           dc.w $4b76
[00000e6e]                           dc.w $02c7
[00000e70]                           dc.w $7a5f
[00000e72]                           dc.w $146c
[00000e74]                           dc.w $8799
[00000e76]                           dc.w $1c47
[00000e78]                           dc.w $f51f
[00000e7a]                           dc.w $249f
[00000e7c]                           dc.w $8f36
[00000e7e]                           dc.b '$w C'
[00000e82]                           dc.w $1fbc
[00000e84]                           dc.w $1e4d
[00000e86]                           dc.w $1e86
[00000e88]                           dc.w $b3fa
[00000e8a]                           dc.w $37df
[00000e8c]                           dc.w $36a6
[00000e8e]                           dc.w $16ed
[00000e90]                           dc.w $30e4
[00000e92]                           dc.w $02c3
[00000e94]                           dc.w $148e
[00000e96]                           dc.b '!nY)'
[00000e9a]                           dc.w $0636
[00000e9c]                           dc.w $b34e
[00000e9e]                           dc.w $317f
[00000ea0]                           dc.w $9f56
[00000ea2]                           dc.w $15f0
[00000ea4]                           dc.w $9d70
[00000ea6]                           dc.w $1310
[00000ea8]                           dc.w $26fb
[00000eaa]                           dc.w $38c7
[00000eac]                           dc.w $84b1
[00000eae]                           dc.w $29ac
[00000eb0]                           dc.w $3305
[00000eb2]                           dc.w $2b48
[00000eb4]                           dc.w $5dc5
[00000eb6]                           dc.w $3c04
[00000eb8]                           dc.w $9ddc
[00000eba]                           dc.w $35a9
[00000ebc]                           dc.w $fbcd
[00000ebe]                           dc.w $31d5
[00000ec0]                           dc.b '7;+$g'
[00000ec5]                           dc.b $99
[00000ec6]                           dc.w $0a29
[00000ec8]                           dc.w $23d3
[00000eca]                           dc.w $08a9
[00000ecc]                           dc.w $6e9d
[00000ece]                           dc.w $3003
[00000ed0]                           dc.w $1a9f
[00000ed2]                           dc.w $08f5
[00000ed4]                           dc.w $25b5
[00000ed6]                           dc.w $3361
[00000ed8]                           dc.w $1c06
[00000eda]                           dc.w $2409
[00000edc]                           dc.w $db98
[00000ede]                           dc.w $0ca4
[00000ee0]                           dc.w $feb2
[00000ee2]                           dc.w $1000
[00000ee4]                           dc.w $b71e
[00000ee6]                           dc.b '0Vn29D}1'
[00000eee]                           dc.w $194e
[00000ef0]                           dc.w $3752
[00000ef2]                           dc.w $0823
[00000ef4]                           dc.w $3a95
[00000ef6]                           dc.w $0f38
[00000ef8]                           dc.w $fe36
[00000efa]                           dc.w $29c7
[00000efc]                           dc.w $cd57
[00000efe]                           dc.w $0f7b
[00000f00]                           dc.w $3a39
[00000f02]                           dc.w $328e
[00000f04]                           dc.w $8a16
[00000f06]                           dc.w $1e7d
[00000f08]                           dc.w $1388
[00000f0a]                           dc.w $0fba
[00000f0c]                           dc.w $78f5
[00000f0e]                           dc.b $27,'L~|'
[00000f12]                           dc.w $1e8b
[00000f14]                           dc.w $e65c
[00000f16]                           dc.w $2fa0
[00000f18]                           dc.w $b0bb
[00000f1a]                           dc.w $1eb6
[00000f1c]                           dc.w $c371
[00000f1e]                           dc.b 'bad delitem',$0a,0
[00000f2b]                           dc.b 'bad block',$0a,0
;
         U _read
         U a~pushstr
         U _abort
         U _lseek
         U _printf
         U _strcat
         U a~movestr
         U _open
         U a~ldiv
         U a~lmod
         U _write
         U _strcpy
         U _fstat
00000000 T _dbminit
00000112 T _forder
00000178 T w_fetch
0000024e T _delete
0000033e T _store
000005f2 T w_firstkey
00000608 T w_nextkey
00000732 T w_firsthash
0000080c T _dbm_access
000008c0 T _getbit
00000994 T _setbit
00000a56 T _clrbuf
00000a74 T w_makdatum
00000b00 T _cmpdatum
00000b4a T _hashinc
00000b88 T _calchash
00000bec T _delitem
00000ca6 T _additem
00000d12 T _chkblk
00000dde D _hitab
00000e1e D _hltab
000001b8 B _dbrdonly 00000f36
000001bc B _pagf     00000f3a
000001c0 B _dirf     00000f3e
000001c4 B _dirbuf   00000f42
000011c4 B _pagbuf   00001f42
000015c4 B _hmask    00002342
000015c8 B _blkno    00002346
000015cc B _maxbno   0000234a
000015d0 B _bitno    0000234e
;
; a.out Relocations:
0000000a: 00000d7e
00000010: 00000000 _open
0000001a: 00000d7e
00000020: 00000d7e
00000032: 00000d7e
0000003c: 00000000 _strcpy
00000044: 00000d7e
0000004c: 00000000 _strcat
0000007c: 00000d7e
00000086: 00000000 _strcpy
0000008e: 00000d7e
00000096: 00000000 _strcat
000000c6: 00000d7e
000000da: 00000d7e
000000e0: 00000000 _printf
000000f4: 00000000 _fstat
00000104: 00000d7e
0000011c: 00000000
00000122: 00000d7e
00000128: 00000d7e
0000012e: 00000d7e
00000140: 00000000 a~pushstr
00000146: 00000000
00000182: 00000d7e
00000188: 00000000
0000018e: 00000000
00000194: 00000000 _printf
000001a6: 00000000 a~pushstr
000001ac: 00000000
000001b6: 00000000
000001dc: 00000000 a~movestr
000001f4: 00000000 a~pushstr
00000206: 00000000 a~pushstr
0000022c: 00000d7e
00000242: 00000000 a~movestr
00000258: 00000d7e
0000025e: 00000000
00000264: 00000000
0000026a: 00000000
00000270: 00000d7e
00000288: 00000000 a~pushstr
0000028e: 00000000
00000298: 00000000
000002cc: 00000000 a~pushstr
000002de: 00000000 a~pushstr
00000302: 00000d7e
00000312: 00000d7e
00000318: 00000000 _lseek
00000326: 00000d7e
0000032c: 00000000 _write
00000348: 00000d7e
0000034e: 00000000
00000354: 00000000
0000035a: 00000000 _printf
00000360: 00000000
00000366: 00000d7e
00000384: 00000000 a~pushstr
00000392: 00000000
000003a2: 00000000
000003c2: 00000000 a~pushstr
000003d4: 00000000 a~pushstr
000003e8: 00000000
000003f4: 00000000
00000408: 00000000 a~pushstr
00000428: 00000000 a~pushstr
0000043e: 00000000
00000458: 00000d7e
00000468: 00000d7e
00000478: 00000d7e
0000047e: 00000000 _lseek
0000048c: 00000d7e
00000492: 00000000 _write
000004ae: 00000000
000004c0: 00000000
000004da: 00000000 a~pushstr
000004e6: 00000d7e
00000500: 00000000 a~pushstr
00000514: 00000000
00000524: 00000000
00000534: 00000d7e
00000540: 00000d7e
00000550: 00000d7e
00000556: 00000000 _lseek
00000564: 00000d7e
0000056a: 00000000 _write
00000576: 00000d7e
0000057c: 00000d7e
00000592: 00000d7e
00000598: 00000000 _lseek
000005a8: 00000d7e
000005ae: 00000000 _write
000005b8: 00000000
000005ce: 00000000 a~pushstr
000005e2: 00000000
000005fe: 00000000
00000612: 00000d7e
00000618: 00000000
0000061e: 00000000
00000630: 00000000 a~pushstr
00000636: 00000000
00000642: 00000000
00000670: 00000000 a~movestr
0000068a: 00000000 a~pushstr
0000069c: 00000000 a~pushstr
000006bc: 00000000 a~pushstr
000006ce: 00000000 a~pushstr
000006ee: 00000000 a~movestr
000006fe: 00000000
00000716: 00000000 a~movestr
00000724: 00000000
0000073c: 00000d7e
00000742: 00000000
00000748: 00000000
00000754: 00000000
0000078c: 00000000 a~movestr
000007aa: 00000000 a~pushstr
000007bc: 00000000 a~pushstr
000007dc: 00000000 a~movestr
000007e6: 00000000
00000800: 00000000 a~movestr
00000816: 00000000
00000820: 00000d7e
00000826: 00000d7e
0000082c: 00000d7e
00000832: 00000d7e
00000854: 00000d7e
00000862: 00000000
0000087a: 00000d7e
00000880: 00000000 _lseek
0000088e: 00000d7e
00000894: 00000000 _read
000008a0: 00000000
000008a8: 00000d7e
000008ca: 00000d7e
000008d0: 00000d7e
000008d6: 00000d7e
000008e8: 00000d7e
000008f2: 00000000 a~lmod
000008fa: 00000d7e
00000904: 00000000 a~ldiv
00000912: 00000000 a~lmod
00000920: 00000000 a~ldiv
00000928: 00000d7e
00000936: 00000000
0000094c: 00000d7e
00000952: 00000000 _lseek
00000960: 00000d7e
00000966: 00000000 _read
00000970: 00000d7e
0000099e: 00000d7e
000009b0: 00000d7e
000009b6: 00000d7e
000009be: 00000d7e
000009c2: 00000d7e
000009cc: 00000d7e
000009d6: 00000000 a~lmod
000009de: 00000d7e
000009e8: 00000000 a~ldiv
000009f6: 00000000 a~lmod
00000a04: 00000000 a~ldiv
00000a0e: 00000d7e
00000a28: 00000d7e
00000a2e: 00000000 _lseek
00000a3a: 00000d7e
00000a40: 00000d7e
00000a46: 00000000 _write
00000ad8: 00000000 a~movestr
00000af4: 00000000 a~movestr
00000b58: 00000d7e
00000b5e: 00000d7e
00000b92: 00000d7e
00000b98: 00000d7e
00000c8e: 00000d7e
00000c94: 00000000 _printf
00000c9a: 00000000 _abort
00000d58: 00000d7e
00000d5e: 00000000 _printf
00000d64: 00000000 _abort
