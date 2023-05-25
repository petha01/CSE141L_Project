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
  '#0': '000',
  '#1': '001',
  '#30': '010',
  '#-30': '011',
  # Add more integers if needed
}

def translate(assembly_file, machine_file):
  # read the assembly program file
  input = open(assembly_file, 'r')
  file_string = input.read()
  
  output = open(machine_file, 'w')
  
  # Split the assembly code into individual lines
  lines = file_string.split('\n')

  for line in lines:
    words = line.strip().split()
    if len(words) == 0 or words[0] == "//":
      continue

    # Check if instruction is valid
    if words[0] in instructions:
      opcode = instructions[words[0]]
    else:
      print("Error in line: ")
      print(line)
      raise ValueError(f"Invalid instruction: {words[0]}")
  
    # Check if operand/destination is valid
    if words[1] in registers:
      reg1 = registers[words[1]]
    else:
      print("Error in line: ")
      print(line)
      raise ValueError(f"Invalid register: {words[1]}")
    
    # Check if operand register is valid
    if words[2][0] == '#':
      reg2 = lookup_table[words[2]]
    elif words[2] in registers:
      reg2 = registers[words[2]]
    else:
      print("Error in line: ")
      print(line)
      raise ValueError(f"Invalid register: {words[1]}")
    
    machine_line = opcode + reg1 + reg2
    print(machine_line)

  # Close the file
  input.close()
  output.close()
translate('test_files/test.txt', 'test_files/output.txt')

  
