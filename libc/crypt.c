#include <unistd.h>
#include <crypt.h>
#include <limits.h>
#include <string.h>

/*
 * encode block of text
 */
static void encode_asc(char *out, const char *hash)
{
	register int i;
	register int c;
	static char const alphabet[64 + 1] = "aA0bB.cC1dD/eE2fF3gG4hH5iI6jJ7kK8lL9ZzYyXxWwVvUuTtSsRrQqPpOoNnMm";

	for (i = 0; i < 11; i++)
	{
		switch (i & 3)
		{
		case 0:
			c = hash[0] & 0x3f;
			break;
		case 1:
			c = ((hash[0] >> 2) & 0x30) | (hash[1] & 0x0f);
			hash++;
			break;
		case 2:
			c = ((hash[0] >> 4) & 0x3c) | (hash[1] & 0x03);
			hash++;
			break;
		case 3:
			c = ((hash[0] >> 2) & 0x3f);
			hash++;
		}
		*out++ = alphabet[c];
	}
}


char *crypt(const char *phrase, const char *setting)
{
	char password[PASS_MAX];
	short i;
	char ks[16][PASS_MAX];
	static char ascii[12];
	char buf[PASS_MAX + 3];
	static char const passphrase[PASS_MAX + 1] = "#@~*};<m";
	
	for (i = 0; i < PASS_MAX; i++)
	{
		password[i] = *phrase != '\0' ? *phrase++ : passphrase[i];
	}
	while (*phrase != '\0')
		password[(i++) & (PASS_MAX - 1)] ^= *phrase++;
	_bldks(ks, password);
	memcpy(buf, "password", PASS_MAX);
	buf[PASS_MAX + 1] = buf[3] = setting[0];
	buf[PASS_MAX + 2] = buf[5] = setting[1];
	for (i = 0; i < 11; i++)
	{
		encrypt(buf, ks);
	}
	buf[PASS_MAX] = '\0';
	encode_asc(ascii, buf);
	ascii[11] = '\0';
#if 0
	return password; /* was bug in orginal code: returns address of local variable */
#else
	return ascii;
#endif
}
