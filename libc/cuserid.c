#include <std.h>
#include <pwd.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>


/*
 * get username
 */
char *cuserid(char *string)
{
	struct passwd *pw;
	
	pw = getpwuid(geteuid());
	if (pw == NULL)
	{
		if (string != NULL)
			*string = '\0';
		return NULL;
	}
	if (string != NULL)
	{
		strcpy(string, pw->pw_name);
		return string;
	}
	return pw->pw_name;
}
