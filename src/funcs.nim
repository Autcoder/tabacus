import tables
import math

# Define a type for a standard one-argument math function pointer
type
  OneArgMathFunc* = proc(x: float): float {.noSideEffect.}
  TwoArgMathFunc* = proc(x, y: float): float {.noSideEffect.}

template f1*(fn: untyped): OneArgMathFunc =
  (
    proc(x: float): float {.noSideEffect.} =
      fn(x)
  )

template f2*(fn: untyped): TwoArgMathFunc =
  (
    proc(x, y: float): float {.noSideEffect.} =
      fn(x, y)
  )

# Explicitly wrap the ones Nim is crying about
const OneArgFuncs*: Table[string, OneArgMathFunc] = {
  # --- Standard Trig ---
  "sin": f1(math.sin),
  "cos": f1(math.cos),
  "tan": f1(math.tan),
  "sec": f1(math.sec),
  "csc": f1(math.csc),
  "cot": f1(math.cot),

  # --- Inverse Trig ---
  "asin": f1(math.arcsin),
  "arcsin": f1(math.arcsin),
  "acos": f1(math.arccos),
  "arccos": f1(math.arccos),
  "atan": f1(math.arctan),
  "arctan": f1(math.arctan),

  # --- Hyperbolic ---
  "sinh": f1(math.sinh),
  "cosh": f1(math.cosh),
  "tanh": f1(math.tanh),
  "asinh": f1(math.arcsinh),
  "arcsinh": f1(math.arcsinh),
  "acosh": f1(math.arccosh),
  "arccosh": f1(math.arccosh),
  "atanh": f1(math.arctanh),
  "arctanh": f1(math.arctanh),

  # --- Powers & Roots ---
  "sqrt": f1(math.sqrt),
  "cbrt": f1(math.cbrt),
  "exp": f1(math.exp),
  "ln": f1(math.ln),
  "log10": f1(math.log10),
  "log2": f1(math.log2),

  # --- Rounding & Utilities ---
  "abs": f1(abs),
  "floor": f1(math.floor),
  "ceil": f1(math.ceil),
  "round": f1(math.round),
  "trunc": f1(math.trunc),
  "sgn": f1(
    proc(x: float): float =
      math.sgn(x).float
  ),

  # --- Angle Conversions ---
  "rad2deg": f1(math.radToDeg),
  "deg2rad": f1(math.degToRad),

  # --- Special Functions ---
  "erf": f1(math.erf),
  "erfc": f1(math.erfc),
  "gamma": f1(math.gamma),
  "lgamma": f1(math.lgamma),
  "fac": f1(
    proc(x: float): float =
      math.fac(x.int).float
  ),
  "sinc": f1(
    proc(x: float): float =
      (if x == 0.0: 1.0 else: math.sin(math.PI * x) / (math.PI * x))
  ),
}.toTable

const TwoArgFuncs*: Table[string, TwoArgMathFunc] = {
  "atan2": f2(math.arctan2),
  "log": f2(math.log),
  "max": f2(max),
  "min": f2(min),
  "hypot": f2(math.hypot),
  "pow": f2(math.pow),
  "gcd": f2(
    proc(x, y: float): float =
      math.gcd(x.int, y.int).float
  ),
  "lcm": f2(
    proc(x, y: float): float =
      math.lcm(x.int, y.int).float
  ),
  "nCr": f2(
    proc(n, r: float): float =
      math.binom(n.int, r.int).float
  ),
  "shl": f2(
    proc(x, y: float): float =
      (x.int shl y.int).float
  ),
  "shr": f2(
    proc(x, y: float): float =
      (x.int shr y.int).float
  ),
  "xor": f2(
    proc(x, y: float): float =
      (x.int xor y.int).float
  ),
  "and": f2(
    proc(x, y: float): float =
      (x.int and y.int).float
  ),
  "or": f2(
    proc(x, y: float): float =
      (x.int or y.int).float
  ),
}.toTable
