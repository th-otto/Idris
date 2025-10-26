/*	SET FILE MODIFICATION TIME
 *	copyright (c) 1986 by Whitesmiths, Ltd.
 */
struct utimbuf {
	unsigned long modtime;
	unsigned long actime;
};

int utime(const char *filename, const struct utimbuf *times);
