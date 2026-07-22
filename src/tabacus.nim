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
      # echo "bye!"
      break

    try:
      line = readLine(stdin)
    except IOError, EOFError:
      echo "input error"

    if line in ["quit", "exit"]:
      # echo "bye!"
      break

    try:
      let tokens: seq[Token] = mathLexer(line)
      let tkline: seq[Token] = shuntingYard(tokens)
      echo evaluateRPN(tkline)
    except KeyError as e:
      echo e.msg
    except ValueError as e:
      echo e.msg
    except CatchableError as e:
      echo "Error: ", e.msg
    except Exception as e:
      echo "Error: ", e.msg

when isMainModule:
  quit(if main() != 0: 1 else: 0)
