type
  Kind* = enum
    tkInt, tkPlus, tkMinus, tkTimes, tkDiv, tkLPar, tkRPar, tkInvalid

  Token* = object
    kind*: Kind
    value*: string

proc mathLexer*(input: string): seq[Token] =
  var i: int = 0
  
  while i < input.len:
    let c: char = input[i]

    case c
    of ' ', '\t', '\r', '\n':
      inc i 
    of '0'..'9':
      var num: string = ""
      # Keep consuming as long as it's a digit
      while i < input.len and input[i] in '0'..'9':
        num.add(input[i])
        inc i
      result.add(Token(kind: tkInt, value: num))
      # Note: We don't 'inc i' here because the 'while' loop 
      # already pushed 'i' to the next non-digit character.
    of '+': 
      result.add(Token(kind: tkPlus, value: "+"))
      inc i
    of '-': 
      result.add(Token(kind: tkMinus, value: "-"))
      inc i
    of '*': 
      result.add(Token(kind: tkTimes, value: "*"))
      inc i
    of '/': 
      result.add(Token(kind: tkDiv, value: "/"))
      inc i
    of '(': 
      result.add(Token(kind: tkLPar, value: "("))
      inc i
    of ')': 
      result.add(Token(kind: tkRPar, value: ")"))
      inc i
    else:
      result.add(Token(kind: tkInvalid, value: $c))
      inc i