/*	PASSWORD FILE STRUCTURE
 *	copyright (c) 1986, 1987 by Whitesmiths, Ltd.
 */

#ifndef __PWD__
#define __PWD__ 1

#ifndef __TYPES__
#include <sys/types.h>
#endif

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

struct passwd *getpwent(void);
struct passwd *getpwuid(uid_t uid);
struct passwd *getpwgid(gid_t gid);
struct passwd *getpwnam(const char *name);
void endpwent(void);
void setpwent(void);

#endif
