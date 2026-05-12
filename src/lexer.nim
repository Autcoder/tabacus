import strutils

proc mathLexer*(input: string): seq[string] =
  return input.split(' ')