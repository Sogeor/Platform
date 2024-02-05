#ifndef FSD_ISO9660_H
#define FSD_ISO9660_H

#include <stdint.h>
#include <string.h>

#define ISO9660_SECTOR_SIZE 2048
#define ISO9660_SYSTEM_AREA_SECTOR_NUMBER 16
#define ISO9660_SYSTEM_AREA_SIZE ISO9660_SECTOR_SIZE * ISO9660_SYSTEM_AREA_SECTOR_NUMBER

enum iso9660_ch_a
{
    // 0..32
    ISO9660_CH_A_EXCLAMATION_MARK = '!',
    ISO9660_CH_A_DOUBLE_QUOTES = '"',
    // 35..36
    ISO9660_CH_A_PROCENTTECKEN = '%',
    ISO9660_CH_A_AMPERSAND = '&',
    ISO9660_CH_A_SINGLE_QUOTE = '\'',
    ISO9660_CH_A_OPEN_PARENTHESIS = '(',
    ISO9660_CH_A_CLOSE_PARENTHESIS = ')',
    ISO9660_CH_A_ASTERISK = '*',
    ISO9660_CH_A_PLUS = '+',
    ISO9660_CH_A_COMMA = ',',
    ISO9660_CH_A_HYPHEN = '-',
    ISO9660_CH_A_FULL_STOP = '.',
    ISO9660_CH_A_SLASH = '/',
    ISO9660_CH_A_0 = '0',
    ISO9660_CH_A_1 = '1',
    ISO9660_CH_A_2 = '2',
    ISO9660_CH_A_3 = '3',
    ISO9660_CH_A_4 = '4',
    ISO9660_CH_A_5 = '5',
    ISO9660_CH_A_6 = '6',
    ISO9660_CH_A_7 = '7',
    ISO9660_CH_A_8 = '8',
    ISO9660_CH_A_9 = '9',
    ISO9660_CH_A_COLON = ':',
    ISO9660_CH_A_SEMICOLON = ';',
    ISO9660_CH_A_LESS_THAN = '<',
    ISO9660_CH_A_EQUALS = '=',
    ISO9660_CH_A_GREATER_THAN = '>',
    ISO9660_CH_A_QUESTION_MARK = '?'
    // 64
    ISO9660_CH_A_A = 'A',
    ISO9660_CH_A_B = 'B',
    ISO9660_CH_A_C = 'C',
    ISO9660_CH_A_D = 'D',
    ISO9660_CH_A_E = 'E',
    ISO9660_CH_A_F = 'F',
    ISO9660_CH_A_G = 'G',
    ISO9660_CH_A_H = 'H',
    ISO9660_CH_A_I = 'I',
    ISO9660_CH_A_J = 'J',
    ISO9660_CH_A_K = 'K',
    ISO9660_CH_A_L = 'L',
    ISO9660_CH_A_M = 'M',
    ISO9660_CH_A_N = 'N',
    ISO9660_CH_A_O = 'O',
    ISO9660_CH_A_P = 'P',
    ISO9660_CH_A_Q = 'Q',
    ISO9660_CH_A_R = 'R',
    ISO9660_CH_A_S = 'S',
    ISO9660_CH_A_T = 'T',
    ISO9660_CH_A_U = 'U',
    ISO9660_CH_A_V = 'V',
    ISO9660_CH_A_W = 'W',
    ISO9660_CH_A_X = 'X',
    ISO9660_CH_A_Y = 'Y',
    ISO9660_CH_A_Z = 'Z',
    // 91..94
    ISO9660_CH_A_UNDERSCORE = '_',
    // 96..127
};

typedef char iso9660_ch_a_t;

enum iso9660_ch_d
{
    // 0..47
    ISO9660_CH_D_0 = '0',
    ISO9660_CH_D_1 = '1',
    ISO9660_CH_D_2 = '2',
    ISO9660_CH_D_3 = '3',
    ISO9660_CH_D_4 = '4',
    ISO9660_CH_D_5 = '5',
    ISO9660_CH_D_6 = '6',
    ISO9660_CH_D_7 = '7',
    ISO9660_CH_D_8 = '8',
    ISO9660_CH_D_9 = '9',
    // 58..64
    ISO9660_CH_D_A = 'A',
    ISO9660_CH_D_B = 'B',
    ISO9660_CH_D_C = 'C',
    ISO9660_CH_D_D = 'D',
    ISO9660_CH_D_E = 'E',
    ISO9660_CH_D_F = 'F',
    ISO9660_CH_D_G = 'G',
    ISO9660_CH_D_H = 'H',
    ISO9660_CH_D_I = 'I',
    ISO9660_CH_D_J = 'J',
    ISO9660_CH_D_K = 'K',
    ISO9660_CH_D_L = 'L',
    ISO9660_CH_D_M = 'M',
    ISO9660_CH_D_N = 'N',
    ISO9660_CH_D_O = 'O',
    ISO9660_CH_D_P = 'P',
    ISO9660_CH_D_Q = 'Q',
    ISO9660_CH_D_R = 'R',
    ISO9660_CH_D_S = 'S',
    ISO9660_CH_D_T = 'T',
    ISO9660_CH_D_U = 'U',
    ISO9660_CH_D_V = 'V',
    ISO9660_CH_D_W = 'W',
    ISO9660_CH_D_X = 'X',
    ISO9660_CH_D_Y = 'Y',
    ISO9660_CH_D_Z = 'Z',
    // 91..94
    ISO9660_CH_D_UNDERSCORE = '_'
    // 96..127
};

typedef char iso9660_ch_d_t;

struct iso9660_datetime_0
{
    iso9660_ch_d_t year[4];
    iso9660_ch_d_t month[2];
    iso9660_ch_d_t day[2];
    iso9660_ch_d_t hour[2];
    iso9660_ch_d_t minute[2];
    iso9660_ch_d_t second[2];
    iso9660_ch_d_t hundredths[2];
    int8_t zone_offset;
} __attribute__((packed));

struct iso9660_datetime_1
{
    uint8_t year;
    uint8_t month;
    uint8_t day;
    uint8_t hour;
    uint8_t minute;
    uint8_t second;
    int8_t zone_offset;
} __attribute__((packed));

#define ISO9660_VOLUME_SIZE 2048

#define ISO9660_VOLUME_TYPE_BOOT 0
#define ISO9660_VOLUME_TYPE_PRIMARY 1
#define ISO9660_VOLUME_TYPE_SUPPLEMENTARY 2
#define ISO9660_VOLUME_TYPE_PARTITION 2
#define ISO9660_VOLUME_TYPE_TERMINATOR 255

#define ISO9660_VOLUME_ID "CD001"

#define ISO9660_VOLUME_DESC_VERSION 0x1

struct iso9660_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    uint8_t data[2041];
} __attribute__((packed));

struct iso9660_boot_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    iso9660_ch_a_t system_id[32];
    iso9660_ch_a_t volume_id[32];
    uint8_t system_use[1977];
} __attribute__((packed));

struct iso9660_primary_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    uint8_t unused_0;
    iso9660_ch_a_t system_id[32];
    iso9660_ch_d_t volume_id[32];
    uint8_t unused_1[8];
    uint32_t volume_space_size_lsb;
    uint32_t volume_space_size_msb;
    uint8_t unused_2[32];
    uint16_t volume_set_size_lsb;
    uint16_t volume_set_size_msb;
    uint16_t volume_sequence_number_lsb;
    uint16_t volume_sequence_number_msb;
    uint16_t logical_block_size_lsb;
    uint16_t logical_block_size_msb;
    uint32_t path_table_size_lsb;
    uint32_t path_table_size_msb;
    uint32_t path_table_location_lsb;
    uint32_t optional_path_table_location_lsb;
    uint32_t path_table_msb;
    uint32_t optional_path_table_msb;
    uint8_t root[34];
    iso9660_ch_d_t volume_set_id[128];
    iso9660_ch_a_t volume_publisher[128];
    iso9660_ch_a_t data_preparer[128];
    iso9660_ch_a_t application_id[128];
    iso9660_ch_d_t copyright_file[37];
    iso9660_ch_d_t abstract_file[37];
    iso9660_ch_d_t bibliographic_file[37];
    struct iso9660_datetime_0 creation_datetime;
    struct iso9660_datetime_0 modification_datetime;
    struct iso9660_datetime_0 expiration_datetime;
    struct iso9660_datetime_0 effective_datetime;
    uint8_t file_structure_version;
    uint8_t unused_3;
    uint8_t application_used[512];
    uint8_t reserved[653];
} __attribute__((packed));

struct iso9660_supplementary_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    uint8_t data[2041];
} __attribute__((packed));

struct iso9660_partition_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    uint8_t data[2041];
} __attribute__((packed));

struct iso9660_terminator_volume_desc
{
    uint8_t type;
    iso9660_ch_a_t id[5];
    uint8_t version;
    uint8_t unused[2041];
} __attribute__((packed));

struct iso9660_l_path_table_entry
{
    uint8_t id_size;
    uint8_t extended_attribute;
    uint32_t extent_location_lsb;
    uint32_t extent_location_msb;
    uint16_t parent_entry_id;
    iso9660_ch_d_t id[];
} __attribute__((packed));

struct iso9660_l_path_table_entry_padding
{
    uint8_t padding;
} __attribute__((packed));

struct iso9660_m_path_table_entry
{
    uint8_t id_size;
    uint8_t extended_attribute;
    uint32_t extent_location_msb;
    uint32_t extent_location_lsb;
    uint16_t parent_entry_id;
    iso9660_ch_d_t id[];
} __attribute__((packed));

struct iso9660_m_path_table_entry_padding
{
    uint8_t padding;
} __attribute__((packed));

struct iso9660_entry_desc
{
    uint8_t desc_size;
    uint8_t extended_attribute;
    uint32_t extent_location_lsb;
    uint32_t extent_location_msb;
    uint32_t extent_size_lsb;
    uint32_t extent_size_msb;
    struct iso9660_datetime_1 record_datetime;
    uint8_t flags;
    uint8_t interleave_unit_size;
    uint8_t interleave_gap_size;
    uint16_t volume_sequence_lsb;
    uint16_t volume_sequence_msb;
    uint8_t id_size;
    iso9660_ch_d_t id[];
} __attribute__((packed));

#define ISO9660_ENTRY_FLAG_HIDDEN 0x1
#define ISO9660_ENTRY_FLAG_DIRECTORY 0x2
#define ISO9660_ENTRY_FLAG_ASSOCIATED 0x4
#define ISO9660_ENTRY_FLAG_EXTENDED 0x8
#define ISO9660_ENTRY_FLAG_PERMISSIONS 0x10
#define ISO9660_ENTRY_FLAG_RESERVED_0 0x20
#define ISO9660_ENTRY_FLAG_RESERVED_1 0x40
#define ISO9660_ENTRY_FLAG_NOT_FINAL 0x80

struct iso9660_entry_desc_padding
{
    uint8_t padding;
} __attribute__((packed));

struct iso9660_entry_desc_extension
{
    uint8_t system_used[];
} __attribute__((packed));

enum iso9660_status
{
    ISO9660_STATUS_FUNCTIONING,
    ISO9660_STATUS_CORRUPTED,
    ISO9660_STATUS_UNSUPPORTED,
    ISO9660_STATUS_MISSING
};

iso9660_status iso9660_mount(uint8_t disk, uint32_t (*read_func)(uint8_t disk, uint32_t offset, uint32_t size));

uint32_t iso9660_request_volume_number(uint8_t disk, uint32_t (*read_func)(uint8_t disk, uint32_t offset, uint32_t size));

uint32_t iso9660_request_volume_desc(uint8_t disk, uint32_t (*read_func)(uint8_t disk, uint32_t offset, uint32_t size), uint32_t volume_index);

#endif //FSD_ISO9660_H
