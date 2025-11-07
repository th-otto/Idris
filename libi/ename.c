#include <dirent.h>
#include <wslxa.h>

/*
 * get pathname of an entry in a directory
 */
char *ename(char *pname, const char *dname, struct dirent *ent)
{
	register char *end;
	
	end = _cpystr(pname, dname, "/", NULL);
	_cpybuf(end, ent->d_name, sizeof(ent->d_name) - 1);
	end[sizeof(ent->d_name) - 1] = '\0';
	return pname;
}
