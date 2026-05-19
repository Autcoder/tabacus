import tables
import std/parseutils

type
  Kind* = enum
    tkFunc, tkConst, tkInvalid, tkMod, tkInt, tkFloat, tkOp

  Token* = object
    kind*: Kind
    value*: string
    num*: float

let Constants: Table[system.string, system.float] = {
    "pi": 3.14159, "e": 2.71828, "tau": 6.28318, "phi": 1.61803, "ln2": 0.69315,
    "ln10": 2.30259, "sqrt3": 1.73205, "sqrt2": 1.41421
  }.toTable

const Functions: array[0..13, string] = [
  "sin", "cos", "tan", "log", "sqrt", "abs", "exp", "ln", "ceil", "floor",
  "round", "asin", "acos", "atan"
  ]

let OpTable: Table[system.char, system.string] = {
  '+': "tkPlus",
  '-': "tkMinus",
  '*': "tkTimes",
  '/': "tkDiv",
  '(': "tkLPar",
  ')': "tkRPar",
  '^': "tkPower",
  '%': "tkMod"
}.toTable

proc mathLexer*(input: string): seq[Token] =
  var i: int = 0
  while i < input.len:
    let c: char = input[i]
    
    case c
      # Whitespace
      of ' ', '\t': inc i
      
      # Numbers
      of '0'..'9':
        var buf: string = ""
        var numFloat: float
        while i < input.len and input[i] in {'0'..'9', '.'}: # Add decimal support
          buf.add(input[i])
          inc i
        discard parseFloat(buf, numFloat)
        if buf[0] == '.':
          result.add(Token(kind: tkFloat, value: buf, num: numFloat))
        else:
          result.add(Token(kind: tkInt, value: buf, num: numFloat))
      
      # Constants
      of 'a'..'z', 'A'..'Z':
        var buf: string = ""
        while i < input.len and input[i] in {'a'..'z', 'A'..'Z', '0'..'9'}:
          buf.add(input[i])
          inc i
        
        if buf in Constants:
          result.add(Token(kind: tkConst, value: buf, num: Constants[buf]))
        elif buf in Functions:
          result.add(Token(kind: tkFunc, value: buf))
        else:
          result.add(Token(kind: tkInvalid, value: "Unknown word: " & buf))

      else:
        
        if OpTable.hasKey(c):
          result.add(Token(kind: tkOp, value: OpTable[c]))
          inc i
        else:
          result.add(Token(kind: tkInvalid, value: $c))
          inc i