import json
def fix(d):
    d["require-dev"] = dict(
        [(k, v) for k, v in d["require-dev"].items() if "phpunit" not in k]
    )
    return d
print(json.dumps(fix(json.load(open("composer.json", "r"))), indent=2))
