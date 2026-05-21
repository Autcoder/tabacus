import math
import lexer

proc evaluateRPN*(rpnTokens: seq[Token]): float =
  var stack: seq[float] = @[]

  for token in rpnTokens:
    case token.kind
    
    # Numbers & Constants: Just push their float values
    of tkInt, tkFloat, tkConst:
      stack.add(token.num)

    # Unary Operators: Pop one value, negate it, push it back
    of tkUnaryMinus:
      if stack.len < 1:
        raise newException(ValueError, "Malformed expression: missing value for unary minus")
      let a: float = stack.pop()
      stack.add(-a)

    # Binary Operators: Pop two values, evaluate via Enum Kinds, push back
    of tkPlus, tkMinus, tkTimes, tkDiv, tkPower, tkMod:
      if stack.len < 2:
        raise newException(ValueError, "Malformed expression: missing operands for " & token.value)
      
      # The second value popped (b) was the right-side operand
      let b: float = stack.pop()
      let a: float = stack.pop()

      case token.kind
      of tkPlus:  stack.add(a + b)
      of tkMinus: stack.add(a - b)
      of tkTimes: stack.add(a * b)
      of tkDiv:   stack.add(a / b)
      of tkPower: stack.add(pow(a, b))
      of tkMod:   stack.add(a mod b)
      else: discard

    # Functions: Pop 1 or 2 values depending on the function name string
    of tkFunc:
      case token.value

      of "max", "min":
        if stack.len < 2:
          raise newException(ValueError, token.value & " requires 2 arguments")

        let b: float = stack.pop()
        let a: float = stack.pop()

        stack.add(
          if token.value == "max":
            max(a, b)
          else:
            min(a, b)
        )

      of "sin", "cos", "tan", "ln", "sqrt", "abs":
        if stack.len < 1:
          raise newException(ValueError, token.value & " requires 1 argument")

        let a: float = stack.pop()

        case token.value
        of "sin": stack.add(sin(a))
        of "cos": stack.add(cos(a))
        of "tan": stack.add(tan(a))
        of "ln": stack.add(ln(a))
        of "sqrt": stack.add(sqrt(a))
        of "abs": stack.add(abs(a))
        else: discard

      else:
        raise newException(ValueError, "Unknown function: " & token.value)

    else: discard

  # Return the value on the top of the stack
  if stack.len == 1:
    return stack[0]
  else:
    raise newException(ValueError, "Malformed expression: The stack has dangling values.")