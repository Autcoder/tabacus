import system
import noise
import lexer, parser, executor

proc main() =
  # Initialize the Noise instance
  var n: Noise = Noise.init()

  # Configure history on the instance
  n.historySetMaxLen(100)
  n.setPrompt("input> ")

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
        let val: float = evaluateRPN(rpn)
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
  main()
