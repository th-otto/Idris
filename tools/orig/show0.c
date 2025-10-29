#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

#undef IDRIS_VERSION
#define IDRIS_VERSION 312

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

#define SECSIZE 512
#define NUM_PARTITIONS 4
#define NUM_HARDDRIVES 4

/* Original FAT12 bootsector */
struct bs {
  /*   0 */  uint8_t bra[2];
  /*   2 */  uint8_t loader[6];
  /*   8 */  uint8_t serial[3];
  /*   b */  uint8_t bps[2];    /* bytes per sector */
  /*   d */  uint8_t spc;       /* sectors per cluster */
  /*   e */  uint8_t res[2];    /* number of reserved sectors */
  /*  10 */  uint8_t fat;       /* number of FATs */
  /*  11 */  uint8_t dir[2];    /* number of DIR root entries */
  /*  13 */  uint8_t sec[2];    /* total number of sectors */
  /*  15 */  uint8_t media;     /* media descriptor */
  /*  16 */  uint8_t spf[2];    /* sectors per FAT */
  /*  18 */  uint8_t spt[2];    /* sectors per track */
  /*  1a */  uint8_t sides[2];  /* number of sides */
  /*  1c */  uint8_t hid[2];    /* number of hidden sectors */
  /*  1e */  uint8_t data[0x1e0];
  /* 1fe */  uint8_t cksum[2];
};

struct partition_info
{
	uint8_t flg;                  /* bit 0: active; bit 7: bootable */
	char id[3];                   /* "GEM", "BGM", "XGM", or other */
	uint8_t start[4];             /* start of partition */
	uint8_t size[4];              /* length of partition */
};

struct rootsector
{
	/*   0 */ char unused[0x156];                   /* room for boot code */
	/* 156 */ struct partition_info icdpart[8];     /* info for ICD-partitions 5..12 */
	/* 1b6 */ uint8_t cylinders[2];
	/* 1b8 */ uint8_t heads[1];
	/* 1b9 */ uint8_t unused1[1];
	/* 1ba */ uint8_t reduced_write[2];
	/* 1bc */ uint8_t write_precomp[2];
	/* 1be */ uint8_t landing_zone[1];
	/* 1bf */ uint8_t seek_rate[1];
	/* 1c0 */ uint8_t interleave[1];
	/* 1c1 */ uint8_t secs_per_track[1];
	/* 1c2 */ uint8_t hd_siz[4];                    /* size of disk in blocks */
	/* 1c6 */ struct partition_info part[4];
	/* 1f6 */ uint8_t bsl_st[4];                    /* start of bad sector list */
	/* 1fa */ uint8_t bsl_cnt[4];                   /* length of bad sector list */
	/* 1fe */ uint8_t checksum[2];                  /* checksum for bootable disks */
};

struct rootsector_has_wrong_size { unsigned int dummy: sizeof(struct rootsector) == SECSIZE ? 1 : -1; };
struct bs_has_wrong_size { unsigned int dummy: sizeof(struct rootsector) == SECSIZE ? 1 : -1; };

#if IDRIS_VERSION >= 314
const char *version_str1 = "<<show0.c: Version 1.01 March 20, 1988>>";
const char *version_str2 = "<<Copyright (C) 1986-1988 by Computer Tools International Inc.>>";
const char *version_str3 = "    show0: Version 1.01  |\n";
const char *date_str = "       March 20, 1988    |\n";
#else
const char *version_str1 = "<<show0.c: Version 1.00 December 4, 1987>>";
const char *version_str2 = "<<Copyright (C) 1986-1987 by Computer Tools International Inc.>>";
const char *version_str3 = "    show0: Version 1.00  |\n";
const char *date_str = "     December 4, 1987    |\n";
#endif
const char *copyright_str = "  Copyright (C) 1987 by  |\n";
const char *cti_str1 = "   (C)omputer            |\n";
const char *cti_str2 = "     (T)ools             |\n";
const char *cti_str3 = "       (I)nternational   |\n";
const char *reboot_msg = "<<-- the system must be rebooted for the changes to have any effect! -->>\n";

#if IDRIS_VERSION >= 314
static char partition_name0[] = "/dev/hdisk/hd003_all";
static char partition_name1[] = "/dev/hdisk/hd004_all";
static char partition_name2[] = "/dev/hdisk/hd005_all";
static char partition_name3[] = "/dev/hdisk/hd006_all";
static char root_device[] = "/dev/hdisk/hd007";
static const char *partition_names[NUM_PARTITIONS] = {
	partition_name0,
	partition_name1,
	partition_name2,
	partition_name3
};
static char partition_header[] = "| Partition number  | (hd003)  0 | (hd004)  1 | (hd005)  2 | (hd006)  3 |\n";
#else
static const char *partition_names[NUM_PARTITIONS] = {
	"/dev/hdp3_all",
	"/dev/hdp4_all",
	"/dev/hdp5_all",
	"/dev/hdp6_all"
};
static const char *root_device = "/dev/hdp7";
#endif

static unsigned int active_flag[NUM_PARTITIONS];
static uint32_t start_sec[NUM_PARTITIONS];
static uint32_t part_size[NUM_PARTITIONS];

/*
 * forward declarations
 */
static void show_info(struct rootsector *sector);
static void print_str(const char *str);
static char *ltoa(long val);
static char *ltoa_r(long val, char *buf);
static void read_block0(const char *devname, void *buffer);
static void write_block0(const char *devname, const void *buffer);
static long myatol(const char *s);
static unsigned int fetch_uint8(const uint8_t *p);
static uint32_t fetch_uint32(const uint8_t *p);
static void set_partid(int part_num, const char *name, struct rootsector *rootsec);
static void set_reserved_sectors(const char *device_name, unsigned int count);
static void print_uint16(const char *prefix, const uint8_t *val);
static void print_uint8(const char *prefix, const uint8_t *val);
static void print_uint32(const char *prefix, const uint8_t *val);
static void print_val(const char *prefix, uint32_t val);
static void print_id(const char *prefix, const char *id);
static unsigned int print_reserved(const char *prefix, unsigned active, const char *device_name);
static void print_mkfs(const char *prefix, unsigned int active, uint32_t size, unsigned int reserved);


int main(int argc, char **argv)
{
	register int error;
	register int part_num;
	register int i;
	register long reserved;
	register const char *name;
	register struct partition_info *p;
	struct rootsector rootsec;

#ifdef __GNUC__
	/* silence compiler */
	part_num = 0;
	name = 0;
	reserved = 0;
#endif

#if IDRIS_VERSION < 314
	print_str("\n");
#endif
	if (argc != 1 && argc != 3 && argc != 4)
	{
		print_str("usage: ");
		print_str(argv[0]);
		print_str(" [partition name [reserved]]\n");
		exit(1);
	}
	error = 0;
	if (argc >= 3)
	{
		if (strlen(argv[1]) != 1)
		{
			error++;
		} else
		{
			if (argv[1][0] < '0' || argv[1][0] > '0' + NUM_PARTITIONS - 1)
				error++;
		}
		if (strlen(argv[2]) != 3)
		{
			error++;
		} else
		{
			if (argv[2][0] < 'A' || argv[2][0] > 'Z')
				error++;
			if (argv[2][1] < 'A' || argv[2][1] > 'Z')
				error++;
			if (argv[2][2] < 'A' || argv[2][2] > 'Z')
				error++;
		}
		part_num = argv[1][0] - '0';
		name = argv[2];
		if (argc == 4)
		{
			reserved = myatol(argv[3]);
			if (reserved < 1)
				error++;
		}
		if (error)
		{
			print_str("invalid arguments specified!\n");
			exit(1);
		}
	}

#if IDRIS_VERSION >= 314
	{
		const char *harddrive = getenv("HARDDRIVE");
		char hd[2];
		
		if (harddrive != NULL)
		{
			if (harddrive[0] < '0' || harddrive[0] > '0' + NUM_HARDDRIVES - 1 ||
				harddrive[1] < '0' || harddrive[1] > '1' ||
				harddrive[2] != '\0')
			{
				print_str("Invalid 'HARDDRIVE' in environment!\n");
				exit(1);
			}
			hd[0] = harddrive[0];
			hd[1] = harddrive[1];
			partition_name0[13] = hd[0];
			partition_name0[14] = hd[1];
			partition_name1[13] = hd[0];
			partition_name1[14] = hd[1];
			partition_name2[13] = hd[0];
			partition_name2[14] = hd[1];
			partition_name3[13] = hd[0];
			partition_name3[14] = hd[1];
			root_device[13] = hd[0];
			root_device[14] = hd[1];
			partition_header[25] = hd[0];
			partition_header[26] = hd[1];
			partition_header[38] = hd[0];
			partition_header[39] = hd[1];
			partition_header[51] = hd[0];
			partition_header[52] = hd[1];
			partition_header[64] = hd[0];
			partition_header[65] = hd[1];
		}
		print_str("\n");
	}
#endif

	read_block0(root_device, &rootsec);
	for (i = 0; i < NUM_PARTITIONS; i++)
	{
		p = &rootsec.part[i];
		active_flag[i] = fetch_uint8(&p->flg);
		start_sec[i] = fetch_uint32(p->start);
		part_size[i] = fetch_uint32(p->size);
	}
	
	if (argc >= 3)
	{
		if (active_flag[part_num] == 0)
		{
			print_str("inactive partition specified!\n");
			exit(1);
		}
		if (argc == 4)
		{
			if (reserved >= part_size[part_num])
			{
				print_str("specified offset too large!\n");
				exit(1);
			}
		}
		set_partid(part_num, name, &rootsec);
		if (argc == 4)
			set_reserved_sectors(partition_names[part_num], reserved);
	}
	
	show_info(&rootsec);
	if (argc >= 3)
		print_str(reboot_msg);
	
	exit(0);
}


static void read_block0(const char *devname, void *buffer)
{
#ifdef __GNUC__
	/*
	 * fake rootsector for testing under linux
	 */
	static uint8_t const dummy_rootsec[SECSIZE] = {
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6c, 0x51, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x02, 0x71, 0x00, 0x01, 0x42, 0x47, 0x4d, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00,
		0x7a, 0x11, 0x01, 0x49, 0x44, 0x52, 0x00, 0x00, 0x7a, 0x13, 0x00, 0x00, 0xfb, 0xf4, 0x01, 0x49,
		0x44, 0x52, 0x00, 0x01, 0x76, 0x08, 0x00, 0x00, 0xfa, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
	};
	static uint8_t const dummy_bssec[SECSIZE] = {
		0xeb, 0x3c, 0x90, 0x4d, 0x53, 0x44, 0x4f, 0x53, 0x35, 0x2e, 0x30, 0x00, 0x02, 0x02, 0x46, 0x08,
		0x02, 0x00, 0x02, 0xf4, 0xfb, 0xf8, 0x7e, 0x00, 0x20, 0x00, 0x40, 0x00, 0x13, 0x7a, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x29, 0xc0, 0x42, 0x5c, 0x5b, 0x4e, 0x4f, 0x20, 0x4e, 0x41,
		0x4d, 0x45, 0x20, 0x20, 0x20, 0x20, 0x46, 0x41, 0x54, 0x31, 0x36, 0x20, 0x20, 0x20, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x36, 0x7d
	};
	if (strcmp(devname, root_device) == 0)
		memcpy(buffer, dummy_rootsec, SECSIZE);
	else if (strcmp(devname, partition_names[1]) == 0)
		memcpy(buffer, dummy_bssec, SECSIZE);
	else {
		memset(buffer, 0, SECSIZE);
		if (strcmp(devname, partition_names[0]) == 0)
			((uint8_t *)buffer)[14] = 2;
		else if (strcmp(devname, partition_names[2]) == 0)
			((uint8_t *)buffer)[14] = 1;
	}
#else
	int fd;
	
	if ((fd = open(devname, O_RDONLY)) < 0)
	{
		print_str("Unable to open <");
		print_str(devname);
		print_str("> for reading!\n");
		exit(1);
	}
	if (read(fd, buffer, SECSIZE) != SECSIZE)
	{
		print_str("Error reading block <0> of <");
		print_str(devname);
		print_str(">!\n");
		exit(1);
	}
	close(fd);
#endif
}


static void write_block0(const char *devname, const void *buffer)
{
#ifdef __GNUC__
	(void)devname;
	(void)buffer;
#else
	int fd;
	
	if ((fd = open(devname, O_RDWR)) < 0)
	{
		print_str("Unable to open <");
		print_str(devname);
		print_str("> for writing!\n");
		exit(1);
	}
	if (write(fd, buffer, SECSIZE) != SECSIZE)
	{
		print_str("Error reading block <0> of <");
		print_str(devname);
		print_str(">!\n");
		exit(1);
	}
	close(fd);
#endif
}


static void show_info(struct rootsector *sector)
{
	unsigned int reserved[NUM_PARTITIONS];
	static const char *header_line = "+-------------------+------------+------------+------------+------------+\n";
	
	print_str("\n+--------------------------------+------------+-------------------------+\n");
	print_uint16("*Number of cylinders", sector->cylinders);
	print_uint8("+Number of heads", sector->heads);
	print_str(version_str3);
	print_uint8("*(unused)", sector->unused1);
	print_uint16("+Reduced write current cylinder", sector->reduced_write);
	print_str(date_str);
	print_uint16("*Write-precompensation cylinder", sector->reduced_write);
	print_uint8("+Landing zone", sector->landing_zone);
	print_str(copyright_str);
	print_uint8("*Seek rate code", sector->seek_rate);
	print_uint8("+Interleave factor", sector->interleave);
	print_str(cti_str1);
	print_uint8("*Number of sectors per track", sector->secs_per_track);
	print_uint32("+Total 512-byte blocks", sector->hd_siz);
	print_str(cti_str2);
	print_uint32("*Start of bad-sector list", sector->bsl_st);
	print_uint32("+Number of bad-sectors", sector->bsl_cnt);
	print_str(cti_str3);
	print_uint16("*Block checksum", sector->checksum);
	print_str(header_line);
#if IDRIS_VERSION >= 314
	print_str(partition_header);
#else
	print_str("| Partition number  |  (hdp3)  0 |  (hdp4)  1 |  (hdp5)  2 |  (hdp6)  3 |\n");
#endif
	print_str("| Flag byte         |");
	print_val(" ", active_flag[0]);
	print_val(" | ", active_flag[1]);
	print_val(" | ", active_flag[2]);
	print_val(" | ", active_flag[3]);
	print_str(" |\n");
	
	print_str("| Id string         |");
	print_id(" ", sector->part[0].id);
	print_id(" | ", sector->part[1].id);
	print_id(" | ", sector->part[2].id);
	print_id(" | ", sector->part[3].id);
	print_str(" |\n");
	
	print_str("| Starting block    |");
	print_val(" ", start_sec[0]);
	print_val(" | ", start_sec[1]);
	print_val(" | ", start_sec[2]);
	print_val(" | ", start_sec[3]);
	print_str(" |\n");
	
	print_str("| Partition size    |");
	print_val(" ", part_size[0]);
	print_val(" | ", part_size[1]);
	print_val(" | ", part_size[2]);
	print_val(" | ", part_size[3]);
	print_str(" |\n");
	
	print_str("| Reserved blocks   |");
	reserved[0] = print_reserved(" ", active_flag[0], partition_names[0]);
	reserved[1] = print_reserved(" | ", active_flag[1], partition_names[1]);
	reserved[2] = print_reserved(" | ", active_flag[2], partition_names[2]);
	reserved[3] = print_reserved(" | ", active_flag[3], partition_names[3]);
	print_str(" |\n");
	
	print_str("| Size for 'mkfs'   |");
	print_mkfs(" ", active_flag[0], part_size[0], reserved[0]);
	print_mkfs(" | ", active_flag[1], part_size[1], reserved[1]);
	print_mkfs(" | ", active_flag[2], part_size[2], reserved[2]);
	print_mkfs(" | ", active_flag[3], part_size[3], reserved[3]);
	print_str(" |\n");

	print_str(header_line);
}


static void set_partid(int part_num, const char *name, struct rootsector *rootsec)
{
	register char *id;
	
	id = rootsec->part[part_num].id;
	*id++ = *name++;
	*id++ = *name++;
	*id = *name;
	write_block0(root_device, rootsec);
}


static void set_reserved_sectors(const char *device_name, unsigned int count)
{
	struct bs bs;
	
	read_block0(device_name, &bs);
	/* in little-endian order */
	bs.res[0] = count & 0xff;
	bs.res[1] = (count >> 8) & 0xff;
	write_block0(device_name, &bs);
}


static unsigned int fetch_uint8(const uint8_t *p)
{
	return *p;
}


static uint32_t fetch_uint32(const uint8_t *p)
{
	uint32_t val;
	
	val = *p++;
	val = (val << 8) | *p++;
	val = (val << 8) | *p++;
	val = (val << 8) | *p;
	return val;
}


static unsigned int print_reserved(const char *prefix, unsigned active, const char *device_name)
{
	struct bs bs;
	unsigned int reserved;
	
	if (!active)
	{
		reserved = 0;
	} else
	{
		read_block0(device_name, &bs);
		/* in little-endian order */
		reserved = bs.res[0] | (bs.res[1] << 8);
	}
	print_val(prefix, reserved);
	return reserved;
}


static void print_mkfs(const char *prefix, unsigned int active, uint32_t size, unsigned int reserved)
{
	uint32_t val;
	
	if (!active)
	{
		val = 0;
	} else
	{
		val = size - reserved;
	}
	print_val(prefix, val);
}


static void print_uint8(const char *prefix, const uint8_t *p)
{
	uint32_t val;
	
	val = *p++;
	val = (val << 8) | *p;
	print_val(prefix, val);
}


static void print_uint16(const char *prefix, const uint8_t *val)
{
	print_val(prefix, fetch_uint8(val));
}


static void print_uint32(const char *prefix, const uint8_t *val)
{
	print_val(prefix, fetch_uint32(val));
}


static void print_val(const char *prefix, uint32_t val)
{
	char buf2[128];
	char buf[128];
	static const char *spaces = "                                       ";
	const char *valstr;

	valstr = ltoa(val);
	strcpy(buf, spaces);
	strcpy(&buf[10 - strlen(valstr)], valstr);
	if (*prefix == '*' || *prefix == '+')
	{
		strcpy(buf2, prefix + 1);
		strcat(buf2, spaces);
		buf2[31] = '\0';
		print_str("| ");
		print_str(buf2);
		print_str( "| ");
		print_str(buf);
		print_str(" |");
		if (*prefix == '*')
			print_str("                         |\n");
	} else
	{
		print_str(prefix);
		print_str(buf);
	}
}


static void print_id(const char *prefix, const char *id)
{
	char buf[3];
	char buf2[4];
	
	print_str(prefix);
	buf[0] = *id++ & 0x7f;
	if (buf[0] < ' ' || buf[0] == 0x7f)
		buf[0] = ' ';
	buf[1] = *id++ & 0x7f;
	if (buf[1] < ' ' || buf[1] == 0x7f)
		buf[1] = ' ';
	buf[2] = *id & 0x7f;
	if (buf[2] < ' ' || buf[2] == 0x7f)
		buf[2] = ' ';
	if (buf[0] == ' ' && buf[1] && buf[2] == ' ')
	{
		print_str("    (none)");
	} else
	{
		/* FIXME: no need to copy again */
		buf2[0] = buf[0];
		buf2[1] = buf[1];
		buf2[2] = buf[2];
		buf2[3] = '\0';
		print_str("       "); 
		print_str(buf2);
	}	
}


static void print_str(const char *str)
{
	write(1, str, strlen(str));
}


static char *ltoa(long val)
{
	static char buf[30];
	ltoa_r(val, buf);
	return buf;
}


/* FIXME: should be unsigned */
static char *ltoa_r(long val, char *buf)
{
	long remain;
	
	if ((remain = val / 10) != 0)
		buf = ltoa_r(remain, buf);
	*buf++ = (val % 10) + '0';
	*buf = '\0';
	return buf;
}


static long myatol(const char *s)
{
	long val = 0;
	
	while (*s != '\0')
	{
		if (*s < '0' || *s > '9')
			return -1;
		val = val * 10 + (*s++ - '0');
	}
	return val;
}
