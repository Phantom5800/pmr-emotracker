lines = ""

with open("location_mapping.lua", "r") as f:
  lines = f.readlines()
  f.close()

i = 0
for k,line in enumerate(lines):
  i += 1
  if i > 717:
    break
  if i > 169:
    value = int(line[5:15])
    old = value
    value += 1
    lines[k] = line.replace(str(old), str(value))

print(lines)
with open("location_mapping.lua", "w") as f:
  f.writelines(lines)
  f.close()
