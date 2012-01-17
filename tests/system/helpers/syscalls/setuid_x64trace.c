#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <syscall.h>
#include <unistd.h>

int main()
{
	pid_t childpid;
	int status;

	if ((childpid = fork()) > 0) {
		wait(&status);
		while (!WIFEXITED(status)) {
			ptrace(PTRACE_SYSCALL, childpid, 0, 0);
			wait(&status);
		}

		return WEXITSTATUS(status);
	} else
	{
		ptrace(PTRACE_TRACEME, 0, 0, 0);
		kill(getpid(), SIGTRAP);

		if (syscall(__NR_setuid, 0) < 0)
			return errno;
		else
			return 0;
	}
}
