#ifndef __PLOT__
#define __PLOT__ 1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

void InitGraf __((void));
void SetIndex __((int index));
void MoveTo __((int x, int y));
void LineTo __((int x, int y));
void ClrScreen __((void));

#endif /* __PLOT__ */
