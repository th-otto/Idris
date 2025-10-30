/*	SWAP STRUCTURES
 *	copyright (c) 1981 by Whitesmiths, Ltd.
 */

#ifndef __SWP__
#define __SWP__ 1

/*	the clock output list
 */
#define COUT	struct cout
struct cout {
	VOID (*c_pfn)(void);
	BYTES c_arg;
	COUNT c_t;
};

/*	the swap list
 */
#define MAP		struct map
struct map {
	TEXT *next;
	BLOCK m_size;
	BLOCK m_addr;
};

#endif
