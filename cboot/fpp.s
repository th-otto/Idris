; a_magic   = 0x9928
; a_text    = 0x000000fa
; a_data    = 0x0000007e
; a_bss     = 0x00000000
; a_syms    = 0x000000f2
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000022@0x00000286


_fppload:
[00000000] 4e56 fffe                 link       a6,#-2
[00000004] 3d6e 000e fffe            move.w     14(a6),-2(a6)
[0000000a] 4ab9 0000 007a            tst.l      _fpproc
[00000010] 672e                      beq.s      _fppload_1
[00000012] 426e fffe                 clr.w      -2(a6)
_fppload_2:
[00000016] 3e2e fffe                 move.w     -2(a6),d7
[0000001a] 48c7                      ext.l      d7
[0000001c] beae 000c                 cmp.l      12(a6),d7
[00000020] 641e                      bcc.s      _fppload_1
[00000022] 2279 0000 007a            movea.l    _fpproc,a1
[00000028] 3e2e fffe                 move.w     -2(a6),d7
[0000002c] 48c7                      ext.l      d7
[0000002e] 246e 0008                 movea.l    8(a6),a2
[00000032] 52ae 0008                 addq.l     #1,8(a6)
[00000036] 1392 7800                 move.b     (a2),0(a1,d7.l)
[0000003a] 526e fffe                 addq.w     #1,-2(a6)
[0000003e] 60d6                      bra.s      _fppload_2
_fppload_1:
[00000040] 4e5e                      unlk       a6
[00000042] 4e75                      rts

_fppinit:
[00000044] 4e56 fffe                 link       a6,#-2
[00000048] 3d6e 000e fffe            move.w     14(a6),-2(a6)
[0000004e] 4ab9 0000 007a            tst.l      _fpproc
[00000054] 6730                      beq.s      _fppinit_1
[00000056] 426e fffe                 clr.w      -2(a6)
_fppinit_2:
[0000005a] 3e2e fffe                 move.w     -2(a6),d7
[0000005e] 48c7                      ext.l      d7
[00000060] beae 000c                 cmp.l      12(a6),d7
[00000064] 6420                      bcc.s      _fppinit_1
[00000066] 2279 0000 007a            movea.l    _fpproc,a1
[0000006c] 3e2e fffe                 move.w     -2(a6),d7
[00000070] 48c7                      ext.l      d7
[00000072] 4231 7800                 clr.b      0(a1,d7.l)
[00000076] 226e 0008                 movea.l    8(a6),a1
[0000007a] 52ae 0008                 addq.l     #1,8(a6)
[0000007e] 4211                      clr.b      (a1)
[00000080] 526e fffe                 addq.w     #1,-2(a6)
[00000084] 60d4                      bra.s      _fppinit_2
_fppinit_1:
[00000086] 4e5e                      unlk       a6
[00000088] 4e75                      rts

_fppsave:
[0000008a] 4e56 fffe                 link       a6,#-2
[0000008e] 3d6e 000e fffe            move.w     14(a6),-2(a6)
[00000094] 4ab9 0000 007a            tst.l      _fpproc
[0000009a] 672e                      beq.s      _fppsave_1
[0000009c] 426e fffe                 clr.w      -2(a6)
_fppsave_2:
[000000a0] 3e2e fffe                 move.w     -2(a6),d7
[000000a4] 48c7                      ext.l      d7
[000000a6] beae 000c                 cmp.l      12(a6),d7
[000000aa] 641e                      bcc.s      _fppsave_1
[000000ac] 226e 0008                 movea.l    8(a6),a1
[000000b0] 52ae 0008                 addq.l     #1,8(a6)
[000000b4] 2479 0000 007a            movea.l    _fpproc,a2
[000000ba] 3e2e fffe                 move.w     -2(a6),d7
[000000be] 48c7                      ext.l      d7
[000000c0] 12b2 7800                 move.b     0(a2,d7.l),(a1)
[000000c4] 526e fffe                 addq.w     #1,-2(a6)
[000000c8] 60d6                      bra.s      _fppsave_2
_fppsave_1:
[000000ca] 4e5e                      unlk       a6
[000000cc] 4e75                      rts

_fppopen:
[000000ce] 2279 0000 0000            movea.l    _pu,a1
[000000d4] 4aa9 0134                 tst.l      308(a1)
[000000d8] 660c                      bne.s      _fppopen_1
[000000da] 2279 0000 0000            movea.l    _pu,a1
[000000e0] 7002                      moveq.l    #2,d0
[000000e2] 2340 0134                 move.l     d0,308(a1)
_fppopen_1:
[000000e6] 4e75                      rts

_fppclose:
[000000e8] 2279 0000 0000            movea.l    _pu,a1
[000000ee] 42a9 0134                 clr.l      308(a1)
[000000f2] 4e75                      rts

_fppread:
[000000f4] 4e75                      rts

_fppwrite:
[000000f6] 4e75                      rts

_fppsgtty:
[000000f8] 4e75                      rts

	.data
_nmfpp:
[000000fa]                           dc.b 'fpp',0
_nmrfpp:
[000000fe]                           dc.b 'rfpp',0
[00000103]                           dc.b $00
_fpptab:
[00000104]                           dc.b $00
[00000105]                           dc.b $00
[00000106]                           dc.b $00
[00000107]                           dc.b $00
[00000108]                           dc.b $00
[00000109]                           dc.b $00
[0000010a]                           dc.b $00
[0000010b]                           dc.b $00
[0000010c]                           dc.b $00
[0000010d]                           dc.b $00
[0000010e]                           dc.b $00
[0000010f]                           dc.b $00
[00000110]                           dc.b $00
[00000111]                           dc.b $00
[00000112]                           dc.b $00
[00000113]                           dc.b $00
[00000114]                           dc.b $00
[00000115]                           dc.b $00
_fppbdev:
[00000116] 000000ce                  dc.l _fppopen
[0000011a] 000000e8                  dc.l _fppclose
[0000011e] 00000000                  dc.l _nobdev
[00000122] 0000000a                  dc.l $0000000a ; no symbol found
[00000126] 00000000                  dc.l _fppload
_fppcdev:
[0000012a] 000000ce                  dc.l _fppopen
[0000012e] 000000e8                  dc.l _fppclose
[00000132] 000000f4                  dc.l _fppread
[00000136] 000000f6                  dc.l _fppwrite
[0000013a] 000000f8                  dc.l _fppsgtty
[0000013e] 00000004                  dc.l $00000004 ; no symbol found
_rfppbuf:
[00000142]                           dc.b $00
[00000143]                           dc.b $00
[00000144]                           dc.b $00
[00000145]                           dc.b $00
[00000146]                           dc.b $00
[00000147]                           dc.b $00
[00000148]                           dc.b $00
[00000149]                           dc.b $00
[0000014a]                           dc.b $00
[0000014b]                           dc.b $00
[0000014c]                           dc.b $00
[0000014d]                           dc.b $00
[0000014e]                           dc.b $00
[0000014f]                           dc.b $00
[00000150]                           dc.b $00
[00000151]                           dc.b $00
[00000152]                           dc.b $00
[00000153]                           dc.b $00
[00000154]                           dc.b $00
[00000155]                           dc.b $00
[00000156]                           dc.b $00
[00000157]                           dc.b $00
[00000158]                           dc.b $00
[00000159]                           dc.b $00
[0000015a]                           dc.b $00
[0000015b]                           dc.b $00
[0000015c]                           dc.b $00
[0000015d]                           dc.b $00
[0000015e]                           dc.b $00
[0000015f]                           dc.b $00
[00000160]                           dc.b $00
[00000161]                           dc.b $00
[00000162]                           dc.b $00
[00000163]                           dc.b $00
[00000164]                           dc.b $00
[00000165]                           dc.b $00
[00000166]                           dc.b $00
[00000167]                           dc.b $00
[00000168]                           dc.b $00
[00000169]                           dc.b $00
[0000016a]                           dc.b $00
[0000016b]                           dc.b $00
[0000016c]                           dc.b $00
[0000016d]                           dc.b $00
[0000016e]                           dc.b $00
[0000016f]                           dc.b $00
_fppnm:
[00000170]                           dc.b 'fpp',0
_fpproc:
[00000174]                           dc.b $00
[00000175]                           dc.b $00
[00000176]                           dc.b $00
[00000177]                           dc.b $00
;
         U _nobdev
         U _pu
00000000 T _fppload
00000044 T _fppinit
0000008a T _fppsave
000000ce T _fppopen
000000e8 T _fppclose
000000f4 T _fppread
000000f6 T _fppwrite
000000f8 T _fppsgtty
000000fa D _nmfpp
000000fe D _nmrfpp
00000104 D _fpptab
00000116 D _fppbdev
0000012a D _fppcdev
00000142 D _rfppbuf
00000170 D _fppnm
00000174 D _fpproc
;
; a.out Relocations:
0000000c: 000000fa
00000024: 000000fa
00000050: 000000fa
00000068: 000000fa
00000096: 000000fa
000000b6: 000000fa
000000d0: 00000000 _pu
000000dc: 00000000 _pu
000000ea: 00000000 _pu
00000116: 00000000
0000011a: 00000000
0000011e: 00000000 _nobdev
00000122: 000000fa
00000126: 000000fa
0000012a: 00000000
0000012e: 00000000
00000132: 00000000
00000136: 00000000
0000013a: 00000000
0000013e: 000000fa
