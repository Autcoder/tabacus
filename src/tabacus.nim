import system
import noise
import lexer, parser, executor

proc main() =
  # 1. Initialize the Noise instance
  var n = Noise.init()

  # 2. Configure history on the instance
  n.historySetMaxLen(100)
  n.setPrompt("input> ")

  while true:
    # 3. readLine returns false on EOF / Ctrl+D
    let ok = n.readLine()
    if not ok:
      break

    let inputStr = n.getLine()

    if inputStr in ["quit", "exit"]:
      break

    if inputStr.len > 0:
      # Add to history
      n.historyAdd(inputStr)

      try:
        let tokens = mathLexer(inputStr)
        let rpn = shuntingYard(tokens)
        let val = evaluateRPN(rpn)
        echo val
      except CatchableError as e:
        echo "Error: ", e.msg

when isMainModule:
  main()
