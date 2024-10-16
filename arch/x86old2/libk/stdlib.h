#ifndef _STDLIB_H
#define _STDLIB_H 1

#ifdef __cplusplus
extern "C" {
#endif

__attribute((noreturn))
void abort(void);

__attribute((noreturn))
void exit(int exit_code);

__attribute((noreturn))
void _Exit(int exit_code);

int atexit(void (*func)(void));

#ifdef __cplusplus
}
#endif

#endif // _STDLIB_H
