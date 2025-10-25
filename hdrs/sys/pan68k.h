/*	MC68000 PANEL FOR IDRIS SYSTEM
 *	copyright (c) 1981, 1984 by Whitesmiths, Ltd.
 */

#ifndef __PAN68__
#define __PAN68__ 1

#define MAXPN 8
typedef struct {
	ULONG pa_sig;	/* UCOUNT? */
	ULONG pa_d0, pa_d1, pa_d2, pa_d3, pa_d4, pa_d5, pa_d6, pa_d7;
	ULONG pa_a0, pa_a1, pa_a2, pa_a3, pa_a4, pa_a5, pa_a6, pa_a7;
	ULONG pa_pc;
	ULONG pa_sr;
	TEXT pa_pname[MAXPN];
} PANEL;

#endif
