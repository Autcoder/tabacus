import tables
import math

# Define a type for a standard one-argument math function pointer
type OneArgMathFunc* = proc(x: float): float {.noSideEffect.}
type TwoArgMathFunc* = proc(x, y: float): float {.noSideEffect.}

# Explicitly wrap the ones Nim is crying about
const OneArgFuncs*: Table[string, OneArgMathFunc] = {
  "sin": OneArgMathFunc(
    (
      proc(x: float): float =
        math.sin(x)
    )
  ),
  "cos": OneArgMathFunc(
    (
      proc(x: float): float =
        math.cos(x)
    )
  ),
  "tan": OneArgMathFunc(
    (
      proc(x: float): float =
        math.tan(x)
    )
  ),
  "sqrt": OneArgMathFunc(
    (
      proc(x: float): float =
        math.sqrt(x)
    )
  ),
  "cbrt": OneArgMathFunc(
    (
      proc(x: float): float =
        math.cbrt(x)
    )
  ),
  "ln": OneArgMathFunc(
    (
      proc(x: float): float =
        math.ln(x)
    )
  ),
  "abs": OneArgMathFunc(
    (
      proc(x: float): float =
        abs(x)
    )
  ),
  "floor": OneArgMathFunc(
    (
      proc(x: float): float =
        math.floor(x)
    )
  ),
  "ceil": OneArgMathFunc(
    (
      proc(x: float): float =
        math.ceil(x)
    )
  ),
  "exp": OneArgMathFunc(
    (
      proc(x: float): float =
        math.exp(x)
    )
  ),
  "log10": OneArgMathFunc(
    (
      proc(x: float): float =
        math.log10(x)
    )
  ),
  "log2": OneArgMathFunc(
    (
      proc(x: float): float =
        math.log2(x)
    )
  ),
  "sinh": OneArgMathFunc(
    (
      proc(x: float): float =
        math.sinh(x)
    )
  ),
  "cosh": OneArgMathFunc(
    (
      proc(x: float): float =
        math.cosh(x)
    )
  ),
  "tanh": OneArgMathFunc(
    (
      proc(x: float): float =
        math.tanh(x)
    )
  ),
  "atan": OneArgMathFunc(
    (
      proc(x: float): float =
        math.arctan(x)
    )
  ),
  "coth": OneArgMathFunc(
    (
      proc(x: float): float =
        math.coth(x)
    )
  ),
  "csc": OneArgMathFunc(
    (
      proc(x: float): float =
        math.csc(x)
    )
  ),
  "csch": OneArgMathFunc(
    (
      proc(x: float): float =
        math.csch(x)
    )
  ),
  "erf": OneArgMathFunc(
    (
      proc(x: float): float =
        math.erf(x)
    )
  ),
  "erfc": OneArgMathFunc(
    (
      proc(x: float): float =
        math.erfc(x)
    )
  ),
  "gamma": OneArgMathFunc(
    (
      proc(x: float): float =
        math.gamma(x)
    )
  ),
  "lgamma": OneArgMathFunc(
    (
      proc(x: float): float =
        math.lgamma(x)
    )
  ),
  "sec": OneArgMathFunc(
    (
      proc(x: float): float =
        math.sec(x)
    )
  ),
  "sech": OneArgMathFunc(
    (
      proc(x: float): float =
        math.sech(x)
    )
  ),
}.toTable

const TwoArgFuncs*: Table[system.string, TwoArgMathFunc] = {
  "atan2": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        math.arctan2(x, y)
    )
  ),
  "log": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        math.log(x, y)
    )
  ),
  "max": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        max(x, y)
    )
  ),
  "min": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        min(x, y)
    )
  ),
  "hypot": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        math.hypot(x, y)
    )
  ),
  "pow": TwoArgMathFunc(
    (
      proc(x, y: float): float =
        math.pow(x, y)
    )
  ),
}.toTable
