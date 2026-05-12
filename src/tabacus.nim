import system
import lexer

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

    # TODO: Call Lexer
    var tokens: seq[string] = mathLexer(line)
    # TODO: Calculate and return result
    # dispatch commands here
    echo "line → ", line
    echo "tokens → ", tokens
    # TODO: print result
    

when isMainModule:
  quit(if main() != 0: 1 else: 0)