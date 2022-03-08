
CHAR_LITERAL :
   ' ( ~[' \ \n \r \t] | QUOTE_ESCAPE | ASCII_ESCAPE | UNICODE_ESCAPE ) '

QUOTE_ESCAPE :
   \' | \"

ASCII_ESCAPE :
      \x OCT_DIGIT HEX_DIGIT
   | \n | \r | \t | \\ | \0

UNICODE_ESCAPE :
   \u{ ( HEX_DIGIT _* )1..6 }

STRING_LITERAL :
   " (
      ~[" \ IsolatedCR]
      | QUOTE_ESCAPE
      | ASCII_ESCAPE
      | UNICODE_ESCAPE
      | STRING_CONTINUE
   )* "

STRING_CONTINUE :
   \ followed by \n


RAW_STRING_LITERAL :
   r RAW_STRING_CONTENT

RAW_STRING_CONTENT :
      " ( ~ IsolatedCR )* (non-greedy) "
   | # RAW_STRING_CONTENT #


BYTE_LITERAL :
   b' ( ASCII_FOR_CHAR | BYTE_ESCAPE ) '

ASCII_FOR_CHAR :
   any ASCII (i.e. 0x00 to 0x7F), except ', \, \n, \r or \t

BYTE_ESCAPE :
      \x HEX_DIGIT HEX_DIGIT
   | \n | \r | \t | \\ | \0 | \' | \"


BYTE_STRING_LITERAL :
   b" ( ASCII_FOR_STRING | BYTE_ESCAPE | STRING_CONTINUE )* "

ASCII_FOR_STRING :
   any ASCII (i.e 0x00 to 0x7F), except ", \ and IsolatedCR


RAW_BYTE_STRING_LITERAL :
   br RAW_BYTE_STRING_CONTENT

RAW_BYTE_STRING_CONTENT :
      " ASCII* (non-greedy) "
   | # RAW_BYTE_STRING_CONTENT #

ASCII :
   any ASCII (i.e. 0x00 to 0x7F)

INTEGER_LITERAL :
   ( DEC_LITERAL | BIN_LITERAL | OCT_LITERAL | HEX_LITERAL ) INTEGER_SUFFIX?

DEC_LITERAL :
   DEC_DIGIT (DEC_DIGIT|_)*

BIN_LITERAL :
   0b (BIN_DIGIT|_)* BIN_DIGIT (BIN_DIGIT|_)*

OCT_LITERAL :
   0o (OCT_DIGIT|_)* OCT_DIGIT (OCT_DIGIT|_)*

HEX_LITERAL :
   0x (HEX_DIGIT|_)* HEX_DIGIT (HEX_DIGIT|_)*

BIN_DIGIT : [0-1]

OCT_DIGIT : [0-7]

DEC_DIGIT : [0-9]

HEX_DIGIT : [0-9 a-f A-F]

INTEGER_SUFFIX :
      u8 | u16 | u32 | u64 | u128 | usize
   | i8 | i16 | i32 | i64 | i128 | isize

TUPLE_INDEX:
   INTEGER_LITERAL

FLOAT_LITERAL :
      DEC_LITERAL . (not immediately followed by ., _ or an identifier)
   | DEC_LITERAL FLOAT_EXPONENT
   | DEC_LITERAL . DEC_LITERAL FLOAT_EXPONENT?
   | DEC_LITERAL (. DEC_LITERAL)? FLOAT_EXPONENT? FLOAT_SUFFIX

FLOAT_EXPONENT :
   (e|E) (+|-)? (DEC_DIGIT|_)* DEC_DIGIT (DEC_DIGIT|_)*

FLOAT_SUFFIX :
   f32 | f64

BOOLEAN_LITERAL :
      true
   | false


LIFETIME_TOKEN :
      ' IDENTIFIER_OR_KEYWORD
   | '_

LIFETIME_OR_LABEL :
      ' NON_KEYWORD_IDENTIFIER
