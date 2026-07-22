import subprocess
from pathlib import Path

CALC = "./tabacus"
TEST_DIR = Path("tests")


def parse_tests(content):
    tests = []
    blocks = content.strip().split("TEST:")
    
    for block in blocks:
        block = block.strip()
        if not block:
            continue

        lines = block.splitlines()
        name = lines[0].strip()

        sections = {
            "RUN:": [],
            "EXPECT_STDOUT:": [],
        }

        current = None

        for line in lines[1:]:
            stripped = line.strip()

            if stripped in sections:
                current = stripped
                continue

            if current:
                sections[current].append(line)

        tests.append({
            "name": name,
            "run": "\n".join(sections["RUN:"]).strip() + "\n",
            "stdout": "\n".join(sections["EXPECT_STDOUT:"]).strip(),
        })

    return tests


def clean_output(text):
    lines = text.splitlines()
    cleaned = []

    for line in lines:
        # Strip noise prompt prefixes
        line = line.replace("input> ", "").replace("input>", "")
        
        # Ignore EOF error message emitted on pipe closure
        if line.strip() == "Error: EOF reached":
            continue

        if line.strip():
            cleaned.append(line)

    return "\n".join(cleaned).strip()


def run_test(test):
    proc = subprocess.run(
        [CALC],
        input=test["run"],
        text=True,
        capture_output=True
    )

    out = clean_output(proc.stdout)

    ok = (out == test["stdout"])

    if ok:
        print(f"PASS: {test['name']}")
    else:
        print(f"FAIL: {test['name']}")
        print("Expected stdout:", repr(test["stdout"]))
        print("Actual stdout:  ", repr(out))
        print()

    return ok


def main():
    total = 0
    passed = 0

    for file in TEST_DIR.glob("*.test"):
        tests = parse_tests(file.read_text())

        for test in tests:
            total += 1
            if run_test(test):
                passed += 1

    print(f"\n{passed}/{total} tests passed")


if __name__ == "__main__":
    main()