/*	PRODUCE PRINTABLE STRING OF ANY CHARACTER - UNISCREEN
 *	NOTE: This macro is ASCII dependant
 * copyright (c) 1985 by Whitesmiths, Ltd.
 */
extern char _unctrl[];

#define unctrl(c) \
	(_unctrl[1] = (c)&0x7f, \
		((c) < ' ') ? (_unctrl[1] |= 0x40, &_unctrl[0]) : &_unctrl[1])
