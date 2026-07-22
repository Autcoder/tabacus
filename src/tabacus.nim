import system, tables # standard library
import lexer, parser, executor # own modules
import noise # external library

proc main(): int =
  # Initialize the Noise instance
  var n: Noise = Noise.init()

  # Configure history on the instance
  n.historySetMaxLen(100)
  n.setPrompt("input> ")

  # Initialize variables
  var vars = initTable[string, float]()
  vars["ans"] = 0.0

  while true:
    var inputStr: string
    # readLine returns false on EOF / Ctrl+D
    try:
      let ok: bool = n.readLine()
      if not ok:
        break

      inputStr = n.getLine()
    except IOError as e:
      echo "Error: ", e.msg
      break
    except Exception as e:
      echo "Error: ", e.msg

    if inputStr in ["quit", "exit"]:
      break

    if inputStr.len > 0:
      # Add to history
      n.historyAdd(inputStr)

      try:
        let tokens: seq[Token] = mathLexer(inputStr)
        let rpn: seq[Token] = shuntingYard(tokens)
        let val: float = evaluateRPN(rpn, vars)
        vars["ans"] = val
        echo val
      except ValueError as e:
        echo "Error: ", e.msg
      except KeyError as e:
        echo "Error: ", e.msg
      except CatchableError as e:
        echo "Error: ", e.msg
      except Exception as e:
        echo "Error: ", e.msg

when isMainModule:
  quit(if main() != 0: 1 else: 0)
