#include <stdlib.h>
#include <errno.h>
#include <sys/syscall.h>
#include <unistd.h>

int main()
{
	if (syscall(__NR_fork) < 0)
		return errno;
	else
		return 0;
}
