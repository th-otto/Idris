#include <std.h>
#include <string.h>

void Xfree(void *ptr);
void *Xalloc(size_t size);
void *alloca(size_t size);

struct frame {
	struct frame *next;
	char *addr;
};

#ifdef _IDRIS
static char const sccsid[] = "@(#)alloca.c\t1.1";
#endif

static char *stacktop;
static struct frame *alloca_ptr;
static int stack_direction;


static void get_stack_direction(void)
{
	char c;
	
	if (stacktop == 0)
	{
		stacktop = &c;
		get_stack_direction();
	} else
	{
		if (&c > stacktop)
			stack_direction = 1; /* stack grows up */
		else
			stack_direction = -1; /* stack grows down */
	}
}


void *alloca(size_t size)
{
	char c;
	register char *pt;
	register struct frame *ptr;
	register struct frame *next;
	
	pt = &c;
	if (stack_direction == 0)
		get_stack_direction();
	ptr = alloca_ptr;
	while (ptr != 0)
	{
		if ((stack_direction > 0 && ptr->addr > pt) ||
			(stack_direction < 0 && ptr->addr < pt))
		{
			next = ptr->next;
			Xfree(ptr);
			ptr = next;
		} else
		{
			break;
		}
	}
	alloca_ptr = ptr;
	if (size == 0)
		return NULL;
	ptr = Xalloc(size + sizeof(*ptr));
	ptr->next = alloca_ptr;
	ptr->addr = pt;
	alloca_ptr = ptr;
	return ptr + 1;
}
