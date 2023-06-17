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
  '2': '011',
  '1': '100',
  '0': '101',
  '-1': '110',
  '-30': '111',
}

branches = {
  'zerotwo': 440,
  'zero': 490,
}

BUFFER = 10

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

    if ':' in words[0]:
      jump = line.replace(":", "").split()
      if jump[0] not in branches:
        branches[jump[0]] = total_lines
      else:
        for i in range(0,BUFFER):
          output.write(instructions['mov'] + registers['r4'] + lookup_table['0'] + "\n")
          total_lines += 1
        
      continue
      # JUMP PAD
      # for i in range(0,BUFFER):
      #   output.write(instructions['mov'] + registers['r4'] + lookup_table['0'] + "\n")
      #   total_lines += 1
      # continue

    # if words[0] == "hello":
    #   output.write("hello + \n")
    #   continue
  
    # Check if instruction is valid
    if words[0] in instructions:
      
    # if words[0] == 'blqz' and (words[2] not in branches):
    #   branches[words[2]] = total_lines 
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
    




    if branch:   # if it is a branch
      num = branches[words[2]]
      print(str(num) + "\n")
      
    if words[2] in registers:
      reg2 = registers[words[2]]
    elif (words[2] in lookup_table) and (words[0] == 'mov'):
      reg2 = lookup_table[words[2]]
    else:
      try:
        if not branch:
          num = int(words[2])
        keys_except_last_four = list(lookup_table.keys())[:-3]
        output.write(instructions['mov'] + registers['r4'] + lookup_table['0'] + "\n")
        total_lines += 1

        for key in keys_except_last_four:
          while num >= int(key):
            output.write(instructions['mov'] + registers['r5'] + lookup_table[key] + "\n")
            output.write(instructions['add'] + registers['r4'] + registers['r5'] + "\n")
            total_lines += 2
            num -= int(key)

        reg2 = registers['r4']

        if words[0] == 'mov':
            output.write(instructions['mov'] + reg1 + lookup_table['0'] + "\n")
            output.write(instructions['add'] + reg1 + registers['r4'] + "\n")
            total_lines += 2
            continue
        
      except:
        raise ValueError(f"Invalid register: {words[1]} in line {line}")

    machine_line = opcode + reg1 + reg2
    output.write(machine_line + "\n")
    total_lines += 1

  # Close the file
  input.close()
  output.close()
translate('test_files/program2_revised.txt', 'test_files/program2_revised_out.txt')