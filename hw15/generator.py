from json import load
FILENAME = 'sas.json'
f = open(FILENAME)
sas = load(f)
f.close()

def inputstr(l):
    return ', '.join([' '.join([i['type'], i['name']]) for i in l])

def genfun(obj):
    if obj['type'] != 'function':
        return ''
    name = obj["name"]
    inputs = inputstr(obj['inputs'])
    payable = ' payable' if obj['payable'] else ''
    returns = f' returns ({inputstr(obj["outputs"])})' if len(obj["outputs"]) != 0 else ''
    view = ' view' if obj['stateMutability'] == 'view' else ''
    string = f'function {name} ({inputs}) external{payable}{view}{returns};'
    return string

def gen(obj):
    start = 'interface GeneratedInterface {\n'
    end = '}'
    mid = '\n'.join([genfun(i) for i in obj])
    return start + mid + end

print(gen(sas))