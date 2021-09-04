file = open('untitled.fcf', 'r')
out = open('coef.txt', 'w')

out.write('coef\t\tEQU\t\t*\n')
ntaps = 0
for i, line in enumerate(file):
  if i > 22:
    if '.' in line:
      out.write(f'\t\tDC\t\t{line}')
      ntaps += 1
out.write(f'ntaps\t\tEQU\t\t{ntaps}')

out.close()
file.close()