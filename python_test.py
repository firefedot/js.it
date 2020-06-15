#/usr/bin/python3

import sys
import string

# for run use:
# python3 python_test.py passwd_for_parse.txt

# Check param
if len(sys.argv) > 1:
    path_file = sys.argv[1]
else:
    sys.exit("Please, write path")

# define empty list
passwd_list = []

# Read file with passwd
with open(path_file) as passwd_file:
    for line in passwd_file.read().split(' '):
        # count eq len list with spec symbols
        count = len(line)
        # print(f'{line}: {count} total symbols')
        # every spec symbols +4
        for i in line:
            if i in string.punctuation:
                count += 4
        # print(f'{line}: {count} total counts')
        passwd_list.append((count, line))

# print('unsort list')
# print(passwd_list)

passwd_list.sort(key = lambda x: (x[0], x[1]), reverse=True)
print('sorted list')
print(passwd_list)

print('')
print(f'{string.punctuation} - this all spec symbols')
print('One spec symbol eq 4 count')

