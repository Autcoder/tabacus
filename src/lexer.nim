import tables

type
  Kind* = enum
    tkInt, tkFloat, tkPlus, tkMinus, tkTimes, tkDiv, tkLPar, tkRPar,
    tkFunc, tkConst, tkInvalid

  Token* = object
    kind*: Kind
    value*: string

# A simple map for scaling
const Constants: Table[system.string, system.string] = {"pi": "3.14159", "e": "2.71828"}.toTable
const Functions: array[0..4, string] = ["sin", "cos", "tan", "log", "sqrt"]
const OpValues: array[0..5, char] = ['+', '-', '*', '/', '(', ')']
const OpNames: array[0..5, Kind] = [tkPlus, tkMinus, tkTimes, tkDiv, tkLPar, tkRPar]

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
        while i < input.len and input[i] in {'0'..'9', '.'}: # Add decimal support
          buf.add(input[i])
          inc i
        result.add(Token(kind: if '.' in buf: tkFloat else: tkInt, value: buf))
      
      # Constants
      of 'a'..'z', 'A'..'Z':
        var buf: string = ""
        while i < input.len and input[i] in {'a'..'z', 'A'..'Z', '0'..'9'}:
          buf.add(input[i])
          inc i
        
        if buf in Constants:
          result.add(Token(kind: tkConst, value: Constants[buf]))
        elif buf in Functions:
          result.add(Token(kind: tkFunc, value: buf))
        else:
          result.add(Token(kind: tkInvalid, value: "Unknown word: " & buf))

      # Operators
      of OpValues:
        result.add(Token(kind: OpNames[OpValues.find(c)], value: $c))
        inc i

      # Invalid
      else:
        result.add(Token(kind: tkInvalid, value: $c))
        inc i