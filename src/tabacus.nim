import system, tables, strutils # standard library
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
    var line: string
    # readLine returns false on EOF / Ctrl+D
    try:
      let ok: bool = n.readLine()
      if not ok:
        break

      line = n.getLine()
    except IOError as e:
      echo "Error: ", e.msg
      break
    except EOFError:
      break
    except Exception as e:
      echo "Error: ", e.msg

    if line in ["quit", "exit"]:
      break

    if line.len > 0:
      n.historyAdd(line)

      try:
        var expr: string = line
        var targetVar: string = ""

        # Check for assignment: "varName = expr"
        if '=' in line:
          let parts: seq[string] = line.split('=', maxsplit = 1)
          targetVar = parts[0].strip()
          expr = parts[1].strip()

          # Validate variable name (must be a valid identifier)
          if targetVar.len == 0 or not targetVar[0].isAlphaAscii():
            raise newException(ValueError, "Invalid variable name: " & targetVar)

        # Lex and evaluate the right-hand side
        let tokens: seq[Token] = mathLexer(expr)
        let rpn: seq[Token] = shuntingYard(tokens)
        let res: float = evaluateRPN(rpn, vars)

        # Save to 'ans'
        vars["ans"] = res

        # If it was an assignment like `x = 10`, save to the variable too
        if targetVar.len > 0:
          vars[targetVar] = res
          echo targetVar, " = ", res
        else:
          echo res
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
