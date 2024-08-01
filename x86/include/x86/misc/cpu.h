#ifndef PLATFORM_X86_MISC_CPU_H
#define PLATFORM_X86_MISC_CPU_H

#include <x86/misc/types.h>

void cpu_pause();

umx cpu_flags();

#define CPU_FLAGS_MASK_CF 1
#define CPU_FLAGS_MASK_PF 1 << 2
#define CPU_FLAGS_MASK_AF 1 << 4
#define CPU_FLAGS_MASK_ZF 1 << 6
#define CPU_FLAGS_MASK_SF 1 << 7
#define CPU_FLAGS_MASK_TF 1 << 8
#define CPU_FLAGS_MASK_IF 1 << 9
#define CPU_FLAGS_MASK_DF 1 << 10
#define CPU_FLAGS_MASK_OF 1 << 11
#define CPU_FLAGS_MASK_IOPL 3 << 12
#define CPU_FLAGS_MASK_NF 1 << 14
#define CPU_FLAGS_MASK_RF 1 << 16
#define CPU_FLAGS_MASK_VM 1 << 17
#define CPU_FLAGS_MASK_AC 1 << 18
#define CPU_FLAGS_MASK_VIF 1 << 19
#define CPU_FLAGS_MASK_VIP 1 << 20
#define CPU_FLAGS_MASK_ID 1 << 21

#define CPU_FLAGS_CF cpu_flags() & CPU_FLAGS_MASK_CF
#define CPU_FLAGS_PF cpu_flags() & CPU_FLAGS_MASK_PF
#define CPU_FLAGS_AF cpu_flags() & CPU_FLAGS_MASK_AF
#define CPU_FLAGS_ZF cpu_flags() & CPU_FLAGS_MASK_ZF
#define CPU_FLAGS_SF cpu_flags() & CPU_FLAGS_MASK_SF
#define CPU_FLAGS_TF cpu_flags() & CPU_FLAGS_MASK_TF
#define CPU_FLAGS_IF cpu_flags() & CPU_FLAGS_MASK_IF
#define CPU_FLAGS_DF cpu_flags() & CPU_FLAGS_MASK_DF
#define CPU_FLAGS_OF cpu_flags() & CPU_FLAGS_MASK_OF
#define CPU_FLAGS_IOPL cpu_flags() & CPU_FLAGS_MASK_IOPL
#define CPU_FLAGS_NF cpu_flags() & CPU_FLAGS_MASK_NF
#define CPU_FLAGS_RF cpu_flags() & CPU_FLAGS_MASK_RF
#define CPU_FLAGS_VM cpu_flags() & CPU_FLAGS_MASK_VM
#define CPU_FLAGS_AC cpu_flags() & CPU_FLAGS_MASK_AC
#define CPU_FLAGS_VIF cpu_flags() & CPU_FLAGS_MASK_VIF
#define CPU_FLAGS_VIP cpu_flags() & CPU_FLAGS_MASK_VIP
#define CPU_FLAGS_ID cpu_flags() & CPU_FLAGS_MASK_ID

#define CPU_FLAGS_IOPL_NORMALIZED cpu_flags() & CPU_FLAGS_MASK_IOPL >> 12

void cpu_set_flags(umx value);

#define CPU_SET_FLAGS_CF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_CF)
#define CPU_SET_FLAGS_PF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_PF)
#define CPU_SET_FLAGS_AF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_AF)
#define CPU_SET_FLAGS_ZF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_ZF)
#define CPU_SET_FLAGS_SF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_SF)
#define CPU_SET_FLAGS_TF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_TF)
#define CPU_SET_FLAGS_IF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_IF)
#define CPU_SET_FLAGS_DF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_DF)
#define CPU_SET_FLAGS_OF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_OF)
#define CPU_SET_FLAGS_IOPL cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_IOPL)
#define CPU_SET_FLAGS_NF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_NF)
#define CPU_SET_FLAGS_RF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_RF)
#define CPU_SET_FLAGS_VM cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_VM)
#define CPU_SET_FLAGS_AC cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_AC)
#define CPU_SET_FLAGS_VIF cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_VIF)
#define CPU_SET_FLAGS_VIP cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_VIP)
#define CPU_SET_FLAGS_ID cpu_set_flags(cpu_flags() | CPU_FLAGS_MASK_ID)

#define CPU_UNSET_FLAGS_CF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_CF))
#define CPU_UNSET_FLAGS_PF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_PF))
#define CPU_UNSET_FLAGS_AF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_AF))
#define CPU_UNSET_FLAGS_ZF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_ZF))
#define CPU_UNSET_FLAGS_SF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_SF))
#define CPU_UNSET_FLAGS_TF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_TF))
#define CPU_UNSET_FLAGS_IF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_IF))
#define CPU_UNSET_FLAGS_DF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_DF))
#define CPU_UNSET_FLAGS_OF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_OF))
#define CPU_UNSET_FLAGS_IOPL cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_IOPL))
#define CPU_UNSET_FLAGS_NF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_NF))
#define CPU_UNSET_FLAGS_RF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_RF))
#define CPU_UNSET_FLAGS_VM cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_VM))
#define CPU_UNSET_FLAGS_AC cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_AC))
#define CPU_UNSET_FLAGS_VIF cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_VIF))
#define CPU_UNSET_FLAGS_VIP cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_VIP))
#define CPU_UNSET_FLAGS_ID cpu_set_flags(cpu_flags() & ~((umx) CPU_FLAGS_MASK_ID))

umx cpu_cr0();

#define CPU_CR0_MASK_PE 1
#define CPU_CR0_MASK_MP 1 << 1
#define CPU_CR0_MASK_EM 1 << 2
#define CPU_CR0_MASK_TS 1 << 3
#define CPU_CR0_MASK_ET 1 << 4
#define CPU_CR0_MASK_NE 1 << 5
#define CPU_CR0_MASK_WP 1 << 16
#define CPU_CR0_MASK_AM 1 << 18
#define CPU_CR0_MASK_NW 1 << 29
#define CPU_CR0_MASK_CD 1 << 30
#define CPU_CR0_MASK_PG 1 << 31

#define CPU_CR0_PE cpu_cr0() & CPU_CR0_MASK_PE
#define CPU_CR0_MP cpu_cr0() & CPU_CR0_MASK_MP
#define CPU_CR0_EM cpu_cr0() & CPU_CR0_MASK_EM
#define CPU_CR0_TS cpu_cr0() & CPU_CR0_MASK_TS
#define CPU_CR0_ET cpu_cr0() & CPU_CR0_MASK_ET
#define CPU_CR0_NE cpu_cr0() & CPU_CR0_MASK_NE
#define CPU_CR0_WP cpu_cr0() & CPU_CR0_MASK_WP
#define CPU_CR0_AM cpu_cr0() & CPU_CR0_MASK_AM
#define CPU_CR0_NW cpu_cr0() & CPU_CR0_MASK_NW
#define CPU_CR0_CD cpu_cr0() & CPU_CR0_MASK_CD
#define CPU_CR0_PG cpu_cr0() & CPU_CR0_MASK_PG

void cpu_set_cr0(umx value);

#define CPU_SET_CR0_PE cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_PE)
#define CPU_SET_CR0_MP cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_MP)
#define CPU_SET_CR0_EM cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_EM)
#define CPU_SET_CR0_TS cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_TS)
#define CPU_SET_CR0_ET cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_ET)
#define CPU_SET_CR0_NE cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_NE)
#define CPU_SET_CR0_WP cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_WP)
#define CPU_SET_CR0_AM cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_AM)
#define CPU_SET_CR0_NW cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_NW)
#define CPU_SET_CR0_CD cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_CD)
#define CPU_SET_CR0_PG cpu_set_cr0(cpu_cr0() | CPU_CR0_MASK_PG)

#define CPU_UNSET_CR0_PE cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_PE))
#define CPU_UNSET_CR0_MP cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_MP))
#define CPU_UNSET_CR0_EM cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_EM))
#define CPU_UNSET_CR0_TS cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_TS))
#define CPU_UNSET_CR0_ET cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_ET))
#define CPU_UNSET_CR0_NE cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_NE))
#define CPU_UNSET_CR0_WP cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_WP))
#define CPU_UNSET_CR0_AM cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_AM))
#define CPU_UNSET_CR0_NW cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_NW))
#define CPU_UNSET_CR0_CD cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_CD))
#define CPU_UNSET_CR0_PG cpu_set_cr0(cpu_cr0() & ~((umx) CPU_CR0_MASK_PG))

umx cpu_cr2();

void cpu_set_cr2(umx value);

#endif // PLATFORM_X86_MISC_CPU_H
