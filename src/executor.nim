import math
import lexer
import tables
import funcs

# Add `vars` as a second parameter
proc evaluateRPN*(rpnTokens: seq[Token], vars: Table[string, float]): float =
  var stack: seq[float] = @[]

  for token in rpnTokens:
    case token.kind

    # Numbers & Constants
    of tkInt, tkFloat, tkConst:
      stack.add(token.num)

    # Variables lookup
    of tkVar:
      if token.value in vars:
        try:
          stack.add(vars[token.value])
        except KeyError:
          raise newException(ValueError, "Undefined variable: " & token.value)
      else:
        raise newException(ValueError, "Undefined variable: " & token.value)

    # Unary Operators: Pop one value, negate it, push it back
    of tkUnaryMinus:
      if stack.len < 1:
        raise newException(
          ValueError, "Malformed expression: missing value for unary minus"
        )
      let a: float = stack.pop()
      stack.add(-a)

    # Binary Operators: Pop two values, evaluate via Enum Kinds, push back
    of tkPlus, tkMinus, tkTimes, tkDiv, tkPower, tkMod:
      if stack.len < 2:
        raise newException(
          ValueError, "Malformed expression: missing operands for " & token.value
        )

      # The second value popped (b) was the right-side operand
      let b: float = stack.pop()
      let a: float = stack.pop()

      case token.kind
      of tkPlus:
        stack.add(a + b)
      of tkMinus:
        stack.add(a - b)
      of tkTimes:
        stack.add(a * b)
      of tkDiv:
        stack.add(a / b)
      of tkPower:
        stack.add(pow(a, b))
      of tkMod:
        stack.add(a mod b)
      else:
        discard

    # Functions: Pop 1 or 2 values depending on the function name string
    of tkFunc:
      if token.value in TwoArgFuncs:
        if stack.len < 2:
          raise newException(ValueError, token.value & " requires 2 arguments")

        let b: float = stack.pop()
        let a: float = stack.pop()
        var nativeFunc: TwoArgMathFunc
        nativeFunc = TwoArgFuncs[token.value]
        stack.add(nativeFunc(a, b))
      elif token.value in OneArgFuncs:
        if stack.len < 1:
          raise newException(ValueError, token.value & " requires an argument")
        let arg: float = stack.pop()
        var nativeFunc: OneArgMathFunc
        nativeFunc = OneArgFuncs[token.value]
        stack.add(nativeFunc(arg))
    else:
      discard

  # Return the value on the top of the stack
  if stack.len == 1:
    return stack[0]
  else:
    raise
      newException(ValueError, "Malformed expression: The stack has dangling values.")
