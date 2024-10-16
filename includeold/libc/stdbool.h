#ifndef _STDBOOL_H
#define _STDBOOL_H

#ifdef __cplusplus
#define _Bool bool
#elif defined __STDC_VERSION__ <= 201710L
#define bool _Bool
#define true 1
#define false 0
#endif // __cplusplus
#define __bool_true_false_are_defined 1

#endif // _STDBOOL_H
