#include <std.h>
#include "dbm.h"

extern long bitno;
extern long maxbno;
extern long blkno;
extern long hmask;

extern char pagbuf[PBLKSIZ] ;
extern char dirbuf[DBLKSIZ] ;

extern int dirf;
extern int pagf;
extern int dbrdonly;

int cmpdatum __((datum dat1, datum dat2))
int additem __((datum dat));
