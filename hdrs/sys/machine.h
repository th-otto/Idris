#ifndef _MACH
#define _MACH 1

#ifndef __ORDER_LITTLE_ENDIAN__
#define __ORDER_BIG_ENDIAN__    4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__    3412
#endif
#ifndef __BYTE_ORDER__
#define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__
#endif

/*	MC68K dependent
 */
#define _CBIT		8
#define _CMAX		255
#define _CMIN		0
#define _DDIG		16
#define _DMAXEX		308
#define _DMINEX		(-308)
#define _DRAD		2
#define _DROUND		1
#define _FDIG		6
#define _FMAXEX		38
#define _FMINEX		(-38)
#define _FRAD		2
#define _FROUND		1
#define _IMAX		2147483647
#define _IMIN		(-2147483648)
#define _LDDIG		16
#define _LDMAXEX	308
#define _LDMINEX	(-308)
#define _LDRAD		2
#define _LDROUND	1
#define _LMAX		2147483647
#define _LMIN		(-2147483648)
#define _SCMAX		127
#define _SCMIN		(-127)
#define _SMAX		32767
#define _SMIN		(-32768)
#define _UCMAX		255
#define _UIMAX		4294967295
#define _ULMAX		4294967295
#define _USMAX		65535

/*
 * Actually only 9 slots used:
 * d5/d4/d3/a5/a4/a3/a6/a7/pc
 */
#define _JMPSIZ		13

#endif
