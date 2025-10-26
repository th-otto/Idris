/* GROUP FILE STRUCTURE
 * copyright (c) 1986 by Whitesmiths, Ltd.
 */

#ifndef __GRP__
#define __GRP__ 1

struct group {
	char *gr_name;
	char *gr_passwd;
	int  gr_gid;
	char **gr_mem;
};

#endif
