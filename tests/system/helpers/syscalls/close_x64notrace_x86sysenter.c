#include <stdlib.h>
#include <errno.h>
#include <sys/syscall.h>
#include <unistd.h>

int main()
{
	if (syscall(__NR_close, 1) < 0)
		return errno;
	else
		return 0;
}
