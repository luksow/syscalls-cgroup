all: x86 x64

x64:
#close
	gcc -static -m64 close_x64notrace_x86sysenter.c -o close_x64notrace
	gcc -static -m64 close_x64trace.c -o close_x64trace
# dup
	gcc -static -m64 dup_x64notrace_x86sysenter.c -o dup_x64notrace
	gcc -static -m64 dup_x64trace.c -o dup_x64trace

# fork
	gcc -static -m64 fork_x64notrace_x86sysenter.c -o fork_x64notrace
	gcc -static -m64 fork_x64trace.c -o fork_x64trace

# setuid
	gcc -static -m64 setuid_x64notrace_x86sysenter.c -o setuid_x64notrace
	gcc -static -m64 setuid_x64trace.c -o setuid_x64trace

x86:
# close
	gcc -static -m32 close_x64notrace_x86sysenter.c -o close_x86sysenter
	gcc -static -m32 close_x86int0x80.c -o close_x86int0x80
# dup
	gcc -static -m32 dup_x64notrace_x86sysenter.c -o dup_x86sysenter
	gcc -static -m32 dup_x86int0x80.c -o dup_x86int0x80
# fork
	gcc -static -m32 fork_x64notrace_x86sysenter.c -o fork_x86sysenter
	gcc -static -m32 fork_x86int0x80.c -o fork_x86int0x80
# setuid
	gcc -static -m32 setuid_x64notrace_x86sysenter.c -o setuid_x86sysenter
	gcc -static -m32 setuid_x86int0x80.c -o setuid_x86int0x80

clean:
#close
	rm -f close_x64notrace close_x64trace close_x86sysenter close_x86int0x80
# dup
	rm -f dup_x64notrace dup_x86int0x80 dup_x86sysenter dup_x64trace
#fork
	rm -f fork_x64notrace fork_x86int0x80 fork_x86sysenter fork_x64trace
# setuid
	rm -f setuid_x64notrace setuid_x86int0x80 setuid_x86sysenter setuid_x64trace