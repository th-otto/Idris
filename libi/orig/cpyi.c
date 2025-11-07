#include "libi.h"
#include <pcdecl.h>

/*
 * cpyi - copy an inode converting between native and filesystem
 */
FINODE *cpyi(register FINODE *dest, register const FINODE *src)
{
	register short i;
	register BLOCK *bdst;
	register const BLOCK *bsrc;
	
	dest->n_mode = lstou(&src->n_mode);
	_cpybuf(&dest->n_link, &src->n_link, sizeof(dest->n_link) + sizeof(dest->n_uid) + sizeof(dest->n_gid) + sizeof(dest->n_size0));
	dest->n_size1 = lstou(&src->n_size1);
	bsrc = src->n_addr;
	bdst = dest->n_addr;
	for (i = 8; --i >= 0; )
	{
		*bdst = lstou(bsrc);
		bdst++;
		bsrc++;
	}
	dest->n_tmake = lstol(&src->n_tmake);
	dest->n_tdump = lstol(&src->n_tdump);
	return dest;
}
