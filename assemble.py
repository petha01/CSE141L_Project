# This is the script that takes in the assembly code and
# turns it into machine code

# dictionaries to indicate instructions and registers
instructions = {
    'add': '000',
    'xor': '001',
    'and': '010',
    'rsl': '011',
    'mov': '100',
    'ld' : '101',
    'st' : '110',
    'blqz': '111',
}

registers = {
  'r0': '000',
  'r1': '001',
  'r2': '010',
  'r3': '011',
  'r4': '100',
  'r5': '101',
  'r6': '110',
  'r7': '111',
}

lookup_table = {
  '100': '000',
  '10': '001',
  '5': '010',
  '1': '011',
  '0': '100',
  '-1': '101',
  '-30': '110',
  
}

branches = {}

def translate(assembly_file, machine_file):

  total_lines = 0
  # read the assembly program file
  input = open(assembly_file, 'r')
  file_string = input.read()
  
  # output the machine code file
  output = open(machine_file, 'w')
  
  # Split the assembly code into individual lines
  lines = file_string.split('\n')

  for line in lines:
    branch = False
    if line[:2] == "//":
      continue

    words = line.replace(",", "").split()
    if len(words) == 0:
      continue
    
    if ':' in line:
      jump = line.replace(":", "").split()
      branches[jump[0]] = total_lines + 1
      continue

    # Check if instruction is valid
    if words[0] in instructions:
      if words[0] == 'blqz':
        branch = True
      opcode = instructions[words[0]]
    else:
      raise ValueError(f"Invalid instruction: {words[0]} in line {line}")

    # Check if operand/destination is valid
    if words[1] in registers:
      reg1 = registers[words[1]]
    else:
      raise ValueError(f"Invalid register: {words[1]} in line {line}")
    
    # Check if operand register is valid
    
    if branch:   # if it is a branch
      num = total_lines - branches[words[2]] + 1
      print(str(num) + "\n")
      if num in lookup_table:
        reg2 = lookup_table[words[2]]
      
    if words[2] in registers:
      reg2 = registers[words[2]]
    elif words[2] in lookup_table:
      reg2 = lookup_table[words[2]]
    else:
      try:
        if not branch:
          num = int(words[2])
        keys_except_last_three = list(lookup_table.keys())[:-3]
        output.write(instructions['mov'] + registers['r4'] + lookup_table['0'] + "\n")
        print(instructions['mov'] + registers['r4'] + lookup_table['0'])
        total_lines += 1

        for key in keys_except_last_three:
          while num >= int(key):
            output.write(instructions['mov'] + registers['r5'] + lookup_table[key] + "\n")
            output.write(instructions['add'] + registers['r4'] + registers['r5'] + "\n")
            print(instructions['mov'] + registers['r5'] + lookup_table[key])
            print(instructions['add'] + registers['r4'] + registers['r5'])
            total_lines += 2
            num -= int(key)
        reg2 = registers['r4']
        if words[0] == 'mov':
            output.write(instructions['mov'] + reg1 + lookup_table['0'] + "\n")
            print(instructions['mov'] + reg1 + lookup_table['0'])
            output.write(instructions['add'] + reg1 + registers['r4'] + "\n")
            print(instructions['add'] + reg1 + registers['r4'])
            continue
      except:
        raise ValueError(f"Invalid register: {words[1]} in line {line}")
    machine_line = opcode + reg1 + reg2
    output.write(machine_line + "\n")
    print(machine_line)
    total_lines += 1

  # Close the file
  input.close()
  output.close()
translate('test_files/simple.txt', 'test_files/simple_out.txt')

  
