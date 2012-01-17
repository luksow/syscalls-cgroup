#include <errno.h>
#include <sys/syscall.h>
#include <unistd.h>

int main()
{
	int ret;
	__asm__ volatile("movl %0, %%eax;"
	                 :
	                 : "g" (__NR_close)
	                 :
		);
	__asm__ volatile("movl $1, %%ebx\n\t"
	                 "int $0x80\n\t"
	                 : "=a" (ret)
	                 :
	                 :
		);

	if (ret < 0)
		return -1 * ret;
	else
		return 0;
}
