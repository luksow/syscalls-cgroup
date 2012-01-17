#include <stdlib.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
	int max = atoi(argv[1]);
	int i;

	for (i = 0; i < max; ++i)
		chdir("/usr/src/linux");

	return 0;
}
