#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/resource.h>

int main(int argc, char** argv)
{
	int max = atoi(argv[1]);
	int i;

	for (i = 0; i < max; ++i)
		setuid(0);

	return 0;
}
