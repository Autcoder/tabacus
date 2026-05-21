import lexer

proc precedence(k: Kind): int =
  case k
  of tkPlus, tkMinus:
    1
  of tkTimes, tkDiv, tkMod:
    2
  of tkUnaryMinus:
    3
  of tkPower:
    4
  else:
    0

proc isRightAssociative(k: Kind): bool =
  k in {tkPower, tkUnaryMinus}

proc isOperator(k: Kind): bool =
  k in {
    tkPlus,
    tkMinus,
    tkUnaryMinus,
    tkTimes,
    tkDiv,
    tkPower,
    tkMod
  }

proc shuntingYard*(tokens: seq[Token]): seq[Token] =
  var output: seq[Token]
  var stack: seq[Token]

  for token in tokens:

    case token.kind

    of tkInvalid:
      raise newException(ValueError, "Invalid token: " & token.value)
    of tkInt, tkFloat, tkConst:
      output.add(token)

    of tkFunc:
      stack.add(token)

    of tkComma:
      while stack.len > 0 and stack[^1].kind != tkLPar:
        output.add(stack.pop())

    of tkLPar:
      stack.add(token)

    of tkRPar:
      var foundLeftParen: bool = false
      while stack.len > 0:
        if stack[^1].kind == tkLPar:
          foundLeftParen = true
          break
        output.add(stack.pop())
      
      if not foundLeftParen:
        raise newException(ValueError, "Mismatched parentheses: unexpected closing parenthesis")
      
      discard stack.pop() # Safely discard the tkLPar
      if stack.len > 0 and stack[^1].kind == tkFunc:
        output.add(stack.pop())

    else:
      if isOperator(token.kind):

        while stack.len > 0 and isOperator(stack[^1].kind):
          # Unary operators do not pop other unary operators of equal precedence
          if stack[^1].kind == tkUnaryMinus and token.kind == tkUnaryMinus:
            break
            
          if precedence(stack[^1].kind) > precedence(token.kind) or
            (precedence(stack[^1].kind) == precedence(token.kind) and not isRightAssociative(token.kind)):
            output.add(stack.pop())
          else:
            break

        stack.add(token)

  while stack.len > 0:
    let top: Token = stack.pop()

    if top.kind in {tkLPar, tkRPar}:
      raise newException(ValueError, "Mismatched parentheses")

    output.add(top)

  return output