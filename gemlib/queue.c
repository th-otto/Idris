#include <std.h>
#include "search.h"

struct qelem {
	struct qelem *q_forw;
	struct qelem *q_back;
};


void insque(void *entry, void *pred)
{
	register struct qelem *e = (struct qelem *) entry;
	register struct qelem *p = (struct qelem *) pred;
	register struct qelem *q;

	if (e)
	{
		q = p ? p->q_forw : p;
		if ((e->q_forw = q) != NULL)
			q->q_back = e;
		if ((e->q_back = p) != NULL)
			p->q_forw = e;
	}
}


void remque(void *element)
{
	register struct qelem *e = (struct qelem *) element;
	register struct qelem *q;
	
	if (e)
	{
		if ((q = e->q_back) != NULL)
			q->q_forw = e->q_forw;
		if ((q = e->q_forw) != NULL)
			q->q_back = e->q_back;
	}
}
