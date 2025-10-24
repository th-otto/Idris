/*
 * internal header file only, for implementation of VDI calls
 */
#include <std.h>
#include "gembind.h"

#define V_OPCODE  contrl[0]
#define V_NPTSIN  contrl[1]
#define V_NPTSOUT contrl[2]
#define V_NINTIN  contrl[3]
#define V_NINTOUT contrl[4]
#define V_SUBCODE contrl[5]
#define V_HANDLE  contrl[6]

extern VDIPB vdipb;

void vdi(void);
void i_lptr1(void *);
void i_lptr2(void *);
void m_lptr2(void **);

#ifdef __GNUC__
#define i_lptr1(p) __extension__({ void **pp = (void **)&contrl[7]; *pp = p; })
#define i_lptr2(p) __extension__({ void **pp = (void **)&contrl[9]; *pp = p; })

#define m_lptr2(p) __extension__({ void **pp = (void **)&contrl[9]; *p = *pp; })
#else
#define i_lptr1(p) *((void **)&contrl[7]) = p
#define i_lptr2(p) *((void **)&contrl[9]) = p

#define m_lptr2(pp) *((void **)pp) = *((void **)&contrl[9])
#endif
