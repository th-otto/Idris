long write(int fd, const void *buf, long count);
long read(int fd, void *buf, long count);
unsigned int sleep(unsigned int seconds);
int getdtablesize(void);
int open(const char *pathname, int flags, ...);
int creat(const char *pathname, int mode);
int close(int fd);

void crash_and_burn(const char *msg);
