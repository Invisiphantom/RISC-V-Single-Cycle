/* Script for -z combreloc */
/* Copyright (C) 2014-2023 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
SECTIONS
{
  . = 0x00000 + SIZEOF_HEADERS;
  .text :
  {
  }

  . = DATA_SEGMENT_ALIGN (CONSTANT (MAXPAGESIZE), CONSTANT (COMMONPAGESIZE));
  . = DATA_SEGMENT_RELRO_END (0, .);
  .data           :
  {
    __DATA_BEGIN__ = .;
  }
    __global_pointer$ = MIN(. + 0x800,  MAX(__DATA_BEGIN__ + 0x800, . - 0x800));
  . = DATA_SEGMENT_END (.);
}