#include "../libc/libc.h"

static const char *defenv[] = {
	"PATH=|/bin/|/usr/bin/|/etc/|/etc/bin/",
	"SHELL=/bin/sh",
	"LOGDIR=/adm/",
	"TMPDIR=/tmp/",
	"GLOB=/odd/glob",
	"TERM=vt100",
	NULL
};
const char **_defenv = defenv;
