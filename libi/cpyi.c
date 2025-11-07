#include "libi.h"
#include <pcdecl.h>

/*
 * cpyi - copy an inode converting between native and filesystem
 */
FINODE *cpyi(register FINODE *dest, register const FINODE *src)
{
	dest->n_mode = lstou(&src->n_mode);
	dest->n_link = src->n_link;
	dest->n_uid = src->n_uid;
	dest->n_gid = src->n_gid;
	dest->n_size0 = src->n_size0;
	dest->n_size1 = lstou(&src->n_size1);
	dest->n_addr[0] = lstou(&src->n_addr[0]);
	dest->n_addr[1] = lstou(&src->n_addr[1]);
	dest->n_addr[2] = lstou(&src->n_addr[2]);
	dest->n_addr[3] = lstou(&src->n_addr[3]);
	dest->n_addr[4] = lstou(&src->n_addr[4]);
	dest->n_addr[5] = lstou(&src->n_addr[5]);
	dest->n_addr[6] = lstou(&src->n_addr[6]);
	dest->n_addr[7] = lstou(&src->n_addr[7]);
	dest->n_tmake = lstol(&src->n_tmake);
	dest->n_tdump = lstol(&src->n_tdump);
	return dest;
}
