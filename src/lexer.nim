import tables
import parseutils
import funcs
import constantsTable

type
  Kind* = enum
    tkInvalid
    tkComma
    tkConst
    tkDiv
    tkFloat
    tkFunc
    tkInt
    tkLPar
    tkMinus
    tkMod
    tkPlus
    tkPower
    tkRPar
    tkTimes
    tkUnaryMinus
    tkVar

  Token* = object
    kind*: Kind
    value*: string
    num*: float

proc isValueToken(k: Kind): bool =
  k in {tkInt, tkFloat, tkConst, tkRPar, tkVar}

proc makeImplicitMul(result: var seq[Token], nextKind: Kind) =
  if result.len == 0:
    return

  let prev: Token = result[^1]

  let needsMul: bool =
    isValueToken(prev.kind) and
    nextKind in {tkConst, tkFunc, tkLPar, tkInt, tkFloat, tkVar}

  if needsMul:
    result.add(Token(kind: tkTimes, value: "*"))

proc mathLexer*(input: string): seq[Token] =
  var i: int = 0

  while i < input.len:
    let c: char = input[i]

    case c
    of ' ', '\t':
      inc i
    of '(':
      makeImplicitMul(result, tkLPar)
      result.add(Token(kind: tkLPar, value: "("))
      inc i
    of ')':
      result.add(Token(kind: tkRPar, value: ")"))
      inc i
    of ',':
      result.add(Token(kind: tkComma, value: ","))
      inc i
    of '0' .. '9', '.':
      makeImplicitMul(result, tkFloat)

      var buf: string = ""
      var hasDot: bool = false
      var numFloat: float

      while i < input.len and input[i] in {'0' .. '9', '.'}:
        if input[i] == '.':
          if hasDot:
            raise
              newException(KeyError, "Invalid number format: multiple decimal points")
          hasDot = true
        buf.add(input[i])
        inc i

      discard parseFloat(buf, numFloat)

      result.add(Token(kind: if hasDot: tkFloat else: tkInt, value: buf, num: numFloat))
    of 'a' .. 'z', 'A' .. 'Z':
      var buf: string = ""

      while i < input.len and input[i] in {'a' .. 'z', 'A' .. 'Z', '0' .. '9', '_'}:
        buf.add(input[i])
        inc i

      if buf in Constants:
        makeImplicitMul(result, tkConst)
        try:
          result.add(Token(kind: tkConst, value: buf, num: Constants[buf]))
        except KeyError:
          result.add(Token(kind: tkInvalid, value: buf))
      elif buf in OneArgFuncs or buf in TwoArgFuncs:
        makeImplicitMul(result, tkFunc)
        result.add(Token(kind: tkFunc, value: buf))
      else:
        # If it's not a known function or constant, treat it as a variable reference
        makeImplicitMul(result, tkVar)
        result.add(Token(kind: tkVar, value: buf))
    else:
      case c
      of '+':
        result.add(Token(kind: tkPlus, value: "+"))
      of '-':
        let unary: bool =
          result.len == 0 or
          result[^1].kind in {
            tkPlus, tkMinus, tkUnaryMinus, tkTimes, tkDiv, tkPower, tkMod, tkLPar,
            tkComma,
          }

        result.add(Token(kind: if unary: tkUnaryMinus else: tkMinus, value: "-"))
      of '*':
        result.add(Token(kind: tkTimes, value: "*"))
      of '/':
        result.add(Token(kind: tkDiv, value: "/"))
      of '^':
        result.add(Token(kind: tkPower, value: "^"))
      of '%':
        result.add(Token(kind: tkMod, value: "%"))
      else:
        result.add(Token(kind: tkInvalid, value: $c))

      inc i
