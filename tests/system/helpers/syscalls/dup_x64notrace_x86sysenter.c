#include <stdlib.h>
#include <errno.h>
#include <sys/syscall.h>
#include <unistd.h>

int main()
{
	if (syscall(__NR_dup, 0) < 0)
		return errno;
	else
		return 0;
}
