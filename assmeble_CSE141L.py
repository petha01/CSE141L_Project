# This is the script that takes in the assembly code and
# turns it into machine code
instructions = {
    'add': '000',
    'xor': '001'
    'and': '010',
    'rsl': '011',
    'mov': '100',
    'ld' : '101',
    'st' : '110',
    'blqz': '111',
    # Add more instructions as needed
}

registers = {
  'r0': '000',
  
}
def translate(assembly_file):
  # read the assembly program file
  file = open(assembly_file, 'r')
  file_string = file.read()

  # Split the assembly code into individual lines
  lines = assembly_code.split('\n')

  for line in lines:
    words = line.strip().split()

    if len(words) == 0 or len[0]

  
