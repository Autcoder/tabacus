import math
import lexer

proc evaluateRPN*(rpnTokens: seq[Token]): float =
  var stack: seq[float] = @[]

  for token in rpnTokens:
    case token.kind
    # 1. Numbers & Constants: Just push their float values
    of tkInt, tkFloat, tkConst:
      stack.add(token.num)

    # 2. Unary Operators: Pop ONE value, negate it, push it back
    of tkUnaryMinus:
      if stack.len < 1:
        raise newException(ValueError, "Malformed expression: missing value for unary minus")
      let a = stack.pop()
      stack.add(-a)

    # 3. Binary Operators: Pop TWO values, evaluate, push back
    of tkPlus, tkMinus, tkTimes, tkDiv, tkPower, tkMod:
      # Note: Adjust these 'of' cases to match your exact enum definitions
      if stack.len < 2:
        raise newException(ValueError, "Malformed expression: missing operands for " & token.value)
      
      # CRITICAL: The second value popped (b) was the right-side operand!
      let b = stack.pop()
      let a = stack.pop()

      case token.value # or token.kind depending on your implementation
      of "+": stack.add(a + b)
      of "-": stack.add(a - b)
      of "*": stack.add(a * b)
      of "/": stack.add(a / b)
      of "^": stack.add(pow(a, b))
      of "%": stack.add(a mod b)
      else: discard

    # 4. Functions: Pop 1 or 2 values depending on the function name
    of tkFunc:
      if stack.len < 1:
        raise newException(ValueError, "Malformed expression: missing arguments for " & token.value)

      case token.value
      # Multi-argument functions (Pop TWO values)
      of "max", "min":
        if stack.len < 2: 
          raise newException(ValueError, "max/min requires 2 arguments")
        let b = stack.pop()
        let a = stack.pop()
        if token.value == "max": stack.add(max(a, b)) else: stack.add(min(a, b))

      # Standard functions (Pop ONE value)
      of "sin":   stack.add(sin(stack.pop()))
      of "cos":   stack.add(cos(stack.pop()))
      of "tan":   stack.add(tan(stack.pop()))
      of "ln":    stack.add(ln(stack.pop()))
      of "sqrt":  stack.add(sqrt(stack.pop()))
      of "abs":   stack.add(abs(stack.pop()))
      else:
        raise newException(ValueError, "Unknown function execution: " & token.value)

    else: discard

  # The grand finale
  if stack.len == 1:
    return stack[0]
  else:
    raise newException(ValueError, "The stack has dangling values. Check expression integrity.")