; a_magic   = 0x9928
; a_text    = 0x0000001a
; a_data    = 0x00000000
; a_bss     = 0x00000000
; a_syms    = 0x00000019
; a_heap    = 0x00000000
; a_textoff = 0x00000000
; a_dataoff = 0x00000000
; a_relocs  = 0x00000004@0x0000004f


_mkfifo:
[00000000] 4e56 fffc                 link       a6,#-4
[00000004] 4297                      clr.l      (a7)
[00000006] 4878 03b6                 pea.l      ($000003B6).w
[0000000a] 2f2e 0008                 move.l     8(a6),-(a7)
[0000000e] 4eb9 0000 0000            jsr        _mknod
[00000014] 508f                      addq.l     #8,a7
[00000016] 4e5e                      unlk       a6
[00000018] 4e75                      rts
;
         U _mknod
00000000 T _mkfifo
;
