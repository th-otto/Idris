/*	PASSWORD FILE STRUCTURE
 *	copyright (c) 1986, 1987 by Whitesmiths, Ltd.
 */

#ifndef __PWD__
#define __PWD__ 1

struct pwd {	/* obsolete */
	char *pw_name;
	char *pw_passwd;
	int  pw_uid;
	int  pw_gid;
	char *pw_lname;
	char *pw_dir;
	char *pw_shell;
};

struct passwd {
	char *pw_name;
	char *pw_passwd;
	int  pw_uid;
	int  pw_gid;
	char *pw_lname;
	char *pw_dir;
	char *pw_shell;
};

#endif
