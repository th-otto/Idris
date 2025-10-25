#define wdc *((volatile short *)0xffff8604)
#define wdl *((volatile short *)0xffff8606)
#define wdcwdl *((volatile long *)0xffff8604)

void delay_write_wdc(short val);
void write_wdl(short val);
void write_wdc(short val);
void write_wdcwdl(long val);


void delay_write_wdc(short val)
{
	int i;
	
	for (i = 0; i < 32; i++)
		;
	wdc = val;
	for (i = 0; i < 32; i++)
		;
}


void write_wdl(short val)
{
	wdl = val;
}


void write_wdc(short val)
{
	wdc = val;
}


void write_wdcwdl(long val)
{
	wdcwdl = val;
}
