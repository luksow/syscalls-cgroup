#include <stdlib.h>
#include <errno.h>
#include <syscall.h>
#include <unistd.h>

int main()
{
	if (syscall(__NR_setuid, 0) < 0)
		return errno;
	else
		return 0;
}
