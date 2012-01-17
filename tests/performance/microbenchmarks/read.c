#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
	int max = atoi(argv[1]);
	int fd = open("/dev/urandom", O_RDONLY);
	char buf[32];
	int i;

	for (i = 0; i < max; ++i)
		read(fd, buf, sizeof(buf));

	close(fd);
	return 0;
}
