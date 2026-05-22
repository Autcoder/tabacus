# tabacus

Terminal Calculator written in Nim.

Tabacus is a small interactive calculator written in Nim. It reads one expression at a time from standard input, evaluates it, and prints the result as a floating-point number.

## What it is

- A simple REPL-style calculator for math expressions
- Built from the Nim source in `src/`
- Intended for quick terminal calculations, not a full scripting language
- Uses the system math library for trig, logarithm, exponential, and special-function support

## Features

### Supported expression types

- Integer and floating-point literals
  - Examples: `2`, `3.5`, `0.1`
- Arithmetic operators
  - `+`, `-`, `*`, `/`, `%`, `^`
- Parentheses for grouping
- Unary minus
  - `-5`
  - `-(2 + 3)`
  - `--5`
- Implicit multiplication
  - `2(3 + 4)`
  - `2pi`
  - `3sqrt(9)`
  - `(2 + 1)(3 + 1)`
- Whitespace is ignored
- Named constants
  - `pi`, `euler`, `tau`
  - plus many additional scientific and mathematical constants
- Function calls
  - one-argument functions such as `sin`, `cos`, `tan`, `sqrt`, `ln`, `abs`, `floor`, `ceil`, `exp`, `log10`, `log2`, `sinh`, `cosh`, `tanh`, `atan`, `coth`, `csc`, `csch`, `erf`, `erfc`, `gamma`, `lgamma`, `sec`, `sech`
  - two-argument functions such as `atan2`, `log`, `max`, `min`, `hypot`, `pow`

### Syntax behavior

- Operator precedence follows the usual math rules:
  - `^` has highest precedence
  - unary minus is handled before multiplication/division
  - `*`, `/`, `%` are evaluated before `+` and `-`
- Exponentiation is right-associative, so `2 ^ 3 ^ 2` is evaluated as `2 ^ (3 ^ 2)`
- Function arguments are evaluated normally, so nested expressions work as expected
- All results are printed as `float` values, so expressions may show raw floating-point output

## Installation and build

### Prerequisites

- Nim 2.2.6 or newer

### Build from source

```sh
nimble build
```

This produces a `tabacus` executable in the project root.

### Run the calculator

```sh
./tabacus
```

You will see a prompt like:

```text
input>
```

Enter one expression at a time.

## Usage

### Basic arithmetic

```text
input> 2 + 3 * 4
14.0

input> (2 + 3) * 4
20.0

input> 10 / 4
2.5
```

### Parentheses and unary minus

```text
input> -(2 + 3)
-5.0

input> -2^2
-4.0

input> (-2)^2
4.0
```

### Constants

```text
input> pi
3.141592653589793

input> euler
2.718281828459045

input> tau
6.283185307179586
```

### Functions

```text
input> sin(1)
0.8414709848078965

input> sqrt(144)
12.0

input> ln(euler)
1.0

input> max(5, 10)
10.0

input> min(5, 10)
5.0

input> atan2(1, 0)
1.5707963267948966

input> log(8, 2)
3.0
```

Notes:

- Function names are lower-case.
- `sin`, `cos`, `tan`, and the other trig functions use radians.
- `log(x, y)` follows Nim's `math.log(x, y)` behavior, which is equivalent to $\log_y(x)$.

### Implicit multiplication

```text
input> 2(3 + 4)
14.0

input> 2pi
6.283185307179586

input> 3sqrt(9)
9.0

input> pi(2)
6.283185307179586
```

## Supported operators

| Operator | Meaning                       |
| -------- | ----------------------------- |
| `+`      | addition                      |
| `-`      | subtraction or unary negation |
| `*`      | multiplication                |
| `/`      | division                      |
| `%`      | modulo                        |
| `^`      | exponentiation                |

## Supported functions

### One-argument functions

- `sin`
- `cos`
- `tan`
- `sqrt`
- `cbrt`
- `ln`
- `abs`
- `floor`
- `ceil`
- `exp`
- `log10`
- `log2`
- `sinh`
- `cosh`
- `tanh`
- `atan`
- `coth`
- `csc`
- `csch`
- `erf`
- `erfc`
- `gamma`
- `lgamma`
- `sec`
- `sech`

### Two-argument functions

- `atan2`
- `log`
- `max`
- `min`
- `hypot`
- `pow`

## Supported Constants

Tabacus includes a large predefined constant table, including values such as:

- `pi`
- `euler`
- `tau`
- `goldenRatio`
- `speedOfLight`
- `earthMass`
- `solarLuminosity`
- `planck`

To use them in your calculations, type their names using snake_case.
For example:

```text
input> speed_of_light
299792458.0
```

The constant table is generated from the source in `src/constantsTable.nim`, so the exact set is the one defined there.

## Error handling

Tabacus reports errors directly in the REPL. Common issues include:

- Invalid tokens, such as unknown identifiers
- Mismatched parentheses
- Malformed expressions, such as trailing operators or missing operands
- Invalid numbers, such as `1.2.3`

Examples:

```text
input> banana(5)
Invalid token: banana

input> 5 +
Malformed expression: missing operands for +

input> (2 + 3
Mismatched parentheses

input> 1.2.3
Invalid number format: multiple decimal points
```

## How to exit

- Enter `quit`
- Enter `exit`
- Send end-of-file (Ctrl+D) to stop the REPL

## Examples from the test suite

The repository includes several test cases in `tests/` that demonstrate supported syntax and edge cases. These cover:

- operator precedence
- parentheses and nesting
- unary minus
- floats
- constants
- functions
- implicit multiplication
- invalid input handling

## Notes and limitations

- There is no support for variables, assignments, or scripting commands
- Expressions are evaluated one at a time
- All calculations are done in floating-point form
- Function names are case-sensitive in practice, so use lower-case names
- The calculator is currently focused on numeric evaluation rather than formatting or history

## Development

If you want to modify the parser or evaluator:

- `src/tabacus.nim` contains the REPL entrypoint
- `src/lexer.nim` tokenizes input
- `src/parser.nim` converts tokens into Reverse Polish Notation
- `src/executor.nim` evaluates the RPN expression
- `src/funcs.nim` defines the available math functions
- `src/constantsTable.nim` defines the named constants

## Quick examples

```text
input> 2 + 3 * 4
14.0

input> sqrt(144) + ln(euler^2) - min(5, 3) + max(2, 8)
19.0

input> 2pi + 3(4)
18.283185307179586
```
