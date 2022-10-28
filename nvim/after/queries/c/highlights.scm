; extends
[
  "struct"
  "enum"
  "union"
] @storageClass

[
  "typedef"
] @typedef

[
  "goto"
] @statement

[
 "default"
] @label

"#define" @define
[
 "#if"
 "#ifdef"
 "#ifndef"
 "#else"
 "#elif"
 "#endif"
 (preproc_directive)
] @preCondit
