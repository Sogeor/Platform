#ifndef BOOT_PRINT_H
#define BOOT_PRINT_H

#define CRLF "\r\n"
#define NULL "\0"

void printc(char c);
void prints(const char *s);
void println();
void printlnc(char c);
void printlns(const char *s);

#endif // BOOT_PRINT_H
