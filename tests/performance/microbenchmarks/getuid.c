#include <stdlib.h>

int main(int argc, char** argv)
{
	int max = atoi(argv[1]);
	int i;

	for (i = 0; i < max; ++i)
		getuid();

	return 0;
}
