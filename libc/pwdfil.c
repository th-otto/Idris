#include <std.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>
#include <pcdecl.h>
#include "libc.h"

#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

static FILE *pwfile;
static FILE grpfile;
static struct passwd *grpent;
static struct group group;
static struct passwd passwd;
static char pwdbuffer[512];
static char grpbuffer[512];

static void parse_pwent(void);
static int has_uid(uid_t uid);
static int has_gid(gid_t gid);
static int has_name(const char *name);
static void rotate_files(FILE *fp1, FILE *fp2, FILE *fp3);
static void parse_grpent(struct passwd *grpent);
static void read_groups(register struct passwd *grpent);


struct passwd *getpwent(void)
{
	char *line;
	
	if (pwfile == NULL)
	{
		if ((pwfile = fopen(PF_PATH, "r")) == NULL)
			return NULL;
	}
	do
	{
		line = fgets(pwdbuffer, sizeof(pwdbuffer), pwfile);
	} while (line != NULL && *line == '\n');
	if (line == NULL)
		return NULL;
	parse_pwent();
	return &passwd;
}


struct passwd *getpwuid(uid_t uid)
{
	FILE *fp;
	
	fp = fopen(PF_PATH, "r");
	if (fp == NULL)
		return NULL;
	passwd.pw_name = NULL;
	for (;;)
	{
		if (fgets(pwdbuffer, sizeof(pwdbuffer), fp) == NULL)
			break;
		if (*pwdbuffer != '\n' && has_uid(uid))
		{
			parse_pwent();
			break;
		}
	}
	fclose(fp);
	return passwd.pw_name != NULL ? &passwd : NULL;
}


struct passwd *getpwgid(gid_t gid)
{
	FILE *fp;
	
	fp = fopen(PF_PATH, "r");
	if (fp == NULL)
		return NULL;
	passwd.pw_name = NULL;
	for (;;)
	{
		if (fgets(pwdbuffer, sizeof(pwdbuffer), fp) == NULL)
			break;
		if (*pwdbuffer != '\n' && has_gid(gid))
		{
			parse_pwent();
			break;
		}
	}
	fclose(fp);
	return passwd.pw_name != NULL ? &passwd : NULL;
}


struct passwd *getpwnam(const char *name)
{
	FILE *fp;
	
	fp = fopen(PF_PATH, "r");
	if (fp == NULL)
		return NULL;
	passwd.pw_name = NULL;
	for (;;)
	{
		if (fgets(pwdbuffer, sizeof(pwdbuffer), fp) == NULL)
			break;
		if (*pwdbuffer != '\n' && has_name(name))
		{
			parse_pwent();
			break;
		}
	}
	fclose(fp);
	return passwd.pw_name != NULL ? &passwd : NULL;
}


void endpwent(void)
{
	if (pwfile != NULL)
	{
		fclose(pwfile);
		pwfile->fd = -1; /* WTF */
	}
}


void setpwent(void)
{
	endpwent();
}


static void parse_pwent(void)
{
	register char *s;
	register char *p;
	char numbuf[20];

	s = pwdbuffer;
	passwd.pw_name = s;
	while (*s != '\0' && *s != '\n' && *s != ':')
		s++;
	if (*s != '\0')
		*s++ = '\0';
	passwd.pw_passwd = s;
	while (*s != '\0' && *s != '\n' && *s != ':')
		s++;
	if (*s != '\0')
		*s++ = '\0';
	p = numbuf;
	while (*s != '\0' && *s != '\n' && *s != ':')
	{
		if (p < &numbuf[sizeof(numbuf) - 1])
			*p++ = *s;
		s++;
	}
	*p = '\0';
	_btoi(numbuf, p - numbuf, &passwd.pw_uid, 10);
	if (*s != '\0')
		s++;
	p = numbuf;
	while (*s != '\0' && *s != '\n' && *s != ':')
	{
		if (p < &numbuf[sizeof(numbuf) - 1])
			*p++ = *s;
		s++;
	}
	*p = '\0';
	_btoi(numbuf, p - numbuf, &passwd.pw_gid, 10);
	if (*s != '\0')
		s++;
	passwd.pw_lname = s;
	while (*s != '\0' && *s != '\n' && *s != ':')
		s++;
	if (*s != '\0')
		*s++ = '\0';
	passwd.pw_dir = s;
	while (*s != '\0' && *s != '\n' && *s != ':')
		s++;
	if (*s != '\0')
		*s++ = '\0';
	passwd.pw_shell = s;
	while (*s != '\0' && *s > ' ' && *s < 0x7f)
		s++;
	*s = '\0';
}


static int has_uid(uid_t uid)
{
	register char *s;
	register int field;
	int val;
	
	s = pwdbuffer;
	field = 0;
	while (*s != '\0' && field < 2)
	{
		s = strchr(s, ':');
		if (s != NULL)
		{
			s++;
			field++;
		} else
		{
			return FALSE;
		}
	}
	if (_btoi(s, strcspn(s, ":"), &val, 10) == 0)
		return FALSE;
	return val == uid;
}


static int has_gid(gid_t gid)
{
	register char *s;
	register int field;
	int val;
	
	s = pwdbuffer;
	field = 0;
	while (*s != '\0' && field < 3)
	{
		s = strchr(s, ':');
		if (s != NULL)
		{
			s++;
			field++;
		} else
		{
			return FALSE;
		}
	}
	if (_btoi(s, strcspn(s, ":"), &val, 10) == 0)
		return FALSE;
	return val == gid;
}	


static int has_name(register const char *name)
{
	register char *s;
	
	s = pwdbuffer;
	while (*s != '\0' && *s != ':' && *s == *name)
	{
		s++;
		name++;
	}
	return *name == '\0' && *s == ':';
}


struct group *getgrent(void)
{
	FILE save_pwfile;
	
	/*
	 * BUG: that won't work. we only save the structure,
	 * but the buffer may change by the fseek
	 */
	rotate_files(&save_pwfile, pwfile, &grpfile);
	group.gr_name = NULL;
	if ((grpent = getpwent()) != NULL)
		parse_grpent(grpent);
	rotate_files(&grpfile, pwfile, &save_pwfile);
	return group.gr_name != NULL ? &group : NULL;
}


struct group *getgrgid(gid_t gid)
{
	FILE save_pwfile;
	
	/*
	 * BUG: that won't work. we only save the structure,
	 * but the buffer may change by the fseek
	 */
	rotate_files(&save_pwfile, pwfile, NULL);
	fseek(pwfile, 0, SEEK_SET);
	group.gr_name = NULL;
	if ((grpent = getpwgid(gid)) != NULL)
		parse_grpent(grpent);
	rotate_files(pwfile, &save_pwfile, NULL);
	return group.gr_name != NULL ? &group : NULL;
}


struct group *getgrnam(const char *name)
{
	FILE save_pwfile;
	
	/*
	 * BUG: save_pwfile was passed by value here
	 */
	rotate_files(&save_pwfile, pwfile, NULL);
	fseek(pwfile, 0, SEEK_SET);
	group.gr_name = NULL;
	if ((grpent = getpwnam(name)) != NULL)
		parse_grpent(grpent);
	rotate_files(pwfile, &save_pwfile, NULL);
	return group.gr_name != NULL ? &group : NULL;
}


void endgrent(void)
{
	fclose(&grpfile);
	grpfile.fd = 0;
}


void setgrent(void)
{
	fseek(&grpfile, 0, SEEK_SET);
}


static void parse_grpent(register struct passwd *grpent)
{
	register char *d;
	register const char *s;
	
	d = grpbuffer;
	group.gr_name = d;
	s = grpent->pw_name;
	while (*s != '\0')
		*d++ = *s++;
	*d++ = '\0';
	group.gr_passwd = d;
	s = grpent->pw_passwd;
	while (*s != '\0')
		*d++ = *s++;
	*d++ = '\0';
	group.gr_gid = grpent->pw_gid;
	read_groups(grpent);
}


static void read_groups(struct passwd *grpent)
{
	char **mem;
	struct passwd *pwent;
	FILE save_pwfile;
	int gid;
	short n;
	size_t len;
	
	UNUSED(grpent);
	gid = group.gr_gid;
	rotate_files(&save_pwfile, pwfile, NULL);
	fseek(pwfile, 0, SEEK_SET);
	n = 0;
	free(group.gr_mem);
	group.gr_mem = NULL;
	while ((pwent = getpwent()) != NULL)
	{
		if (pwent->pw_gid == gid && pwent->pw_name != NULL)
		{
			mem = malloc(n * sizeof(*mem) + 2 * sizeof(*mem));
			if (mem == NULL)
				break;
			if (n != 0)
				memcpy(mem, group.gr_mem, n * sizeof(*mem));
			len = strlen(pwent->pw_name) + 1;
			free(group.gr_mem);
			group.gr_mem = mem;
			if ((mem[n] = malloc(len)) == NULL)
				break;
			memcpy(mem[n], pwent->pw_name, len);
			mem[n + 1] = NULL;
			n++;
		}
	}
	endpwent();
	rotate_files(pwfile, &save_pwfile, NULL);
}


static void rotate_files(FILE *fp1, FILE *fp2, FILE *fp3)
{
	memcpy(fp1, fp2, sizeof(*fp1));
	if (fp3)
		memcpy(fp2, fp3, sizeof(*fp2));
}
