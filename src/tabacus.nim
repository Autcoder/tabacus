import system
import lexer
import parser
import executor

proc main(): int =
  while true:
    var line: string
    try:
      stdout.write("input> ")
    except IOError, EOFError:
      echo "repl error occured"
    stdout.flushFile()
    if stdin.endOfFile():
      echo "bye!"
      break
    
    try:
      line = readLine(stdin)
    except IOError, EOFError:
        echo "input error"

    if line in ["quit", "exit"]:
      echo "bye!"
      break

    var tokens: seq[Token]
    var tkline: seq[Token]
    try:
      tokens = mathLexer(line)
    except KeyError:
      echo "invalid input"
    tkline = shuntingYard(tokens)
    # dispatch commands here
    echo "line → ", line
    # Print out the tokens
    echo "tokens → ", tokens
    # Print out the shunting yard output
    echo "shunting yard → ", tkline
    # Evaluate the shunting yard output
    echo "result → ", evaluateRPN(tkline)
    

when isMainModule:
  quit(if main() != 0: 1 else: 0)