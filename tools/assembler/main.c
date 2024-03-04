#include "main.h"

int main(int argc, char **argv)
{
    const struct options_descriptor options = {
        argv,
        argc
    };
    const int options_validate_result = options_validate(&options);
    printf("hello world\r\n");
    return 0;
}