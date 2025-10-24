#include <stdio.h>
#include <unistd.h>

/* structure for interfacing to line-a traps */
struct LINE_A
{
    short vplanes   ; /* (0x00) */
    short vwrap     ; /* (0x02) */
    short *con_trl  ; /* (0x04) */
    short *int_in   ; /* (0x08) */
    short *pts_in   ; /* (0x0c) */
    short *int_out  ; /* (0x10) */
    short *pts_out  ; /* (0x14) */
};

struct LINE_A *Ainit(void);


#ifdef __GNUC__

#define PUSH_SP(regs,size)						\
	"movml	" regs ",%%sp@-\n\t"

#define POP_SP(regs,size)						\
	"movml	%%sp@+," regs "\n\t"

struct LINE_A *Ainit(void)
{
        register struct LINE_A *__xaline __asm__ ("a0");
        register void **__xfonts __asm__ ("a1");
        register void **__xfuncs __asm__ ("a2");

        __asm__ volatile
        (
		".word 0xa000\n"
        : "=g"(__xaline), "=g"(__xfonts), "=g"(__xfuncs)  /* outputs */
        :                                                 /* inputs  */
        : __CLOBBER_RETURN("a0") __CLOBBER_RETURN("a1") __CLOBBER_RETURN("a2") "d0", "d1", "d2", "cc"       /* clobbered regs */
	  AND_MEMORY
        );
	return __xaline;
}
#endif

struct LINE_A *aptr;


int main(void)
{
	aptr = Ainit();
	
	printf("aptr: %p\n", aptr);
	printf("ptsin: %p\n", aptr->pts_in);
	printf("intin: %p\n", aptr->int_in);
	sleep(10);
	return 0;
}
