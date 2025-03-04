these are just messy notes to remind me whats going on

- literals:
  - string literals - `"hello, world"`
  - vector literals - `<0, 0, 0>`
  - number literals - `23252`, `0.12323`, `0x00`
  - import literals - `import::string.gsub`
  - table literals - `{"hello, world", <0, 0, 0>}`
  - boolean literals - `true`, `false`
  - nil literal - `nil`
  - fastcall literals - `builtin::math.atan`, `builtin::select_vararg` (fake
    literal, desugars to a number literal)

- builtin aliases: (aliases that cant be overwritten)
  - `_` = `0` (to set an operand to 0 somewhat cleanly)
  - `VAL` = `0` (for capture)
  - `REF` = `1` (for capture)
  - `UPVAL` = `2` (for capture)

- identifiers:
  - numbered = `R0`
  - aliased = `R_hello`
  - mixed = `R0_hello` (only at definition)
  - types:
    - registers = `R*`
    - constants = `K*`
    - functions = `F*`
    - external functions = `E*`
    - strings = `S*`
    - labels = `L*`

- functions
- macros
  - non-aliased registers transparently offset above all registers used in a
    function to prevent clashes
- aliases
- external functions
- attributes
