; extends
[
  "mutable"
  "struct"
  "enum"
  "union"
] @storageClass

[
  "class"
  "typename"
  "template"
  "namespace"
] @structure

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

[
  (auto)
] @type

[
  "public"
  "private"
  "protected"
] @access
