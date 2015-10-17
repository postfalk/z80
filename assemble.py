#!/usr/bin/python

import sys
import getopt
from subprocess import call
import binascii

OUTPUTFILE_NAME = 'z80_code.h'
TEMPLATE = (
    '#include <Arduino.h>\n'
    '#ifndef contentdebase\n'
    '#define codebase\n\n'
    'codebase byte codebase[] {\n'
    '%s'
    '\n};\n\n'
    '#endif'
)

def bin_to_c_array(bin):
    hexstring = binascii.hexlify(bin)
    ret = ''
    for i in range(0, len(hexstring), 2):
        ret += '0x{},\n'.format(hexstring[i:i+2])
    ret = ret[0:-2]
    return ret

def main(argv):
    inputfile = ''
    outputfile = ''
    try:
       opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
       print 'test.py -i <inputfile> -o <outputfile>'
       sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'test.py -i <inputfile> -o <outputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg

    binfile_name = '{}.bin'.format(inputfile.split('.')[0])
    print 'Input file:', inputfile
    call(["z80asm", inputfile, "-o", binfile_name])
    print 'Binary file:', binfile_name
    with open(binfile_name, 'rb') as f:
        content = f.read()
    coded_code = bin_to_c_array(content)
    with open(OUTPUTFILE_NAME, 'w') as f:
        f.write(TEMPLATE % coded_code)
    print 'Arduino C array:', OUTPUTFILE_NAME

if __name__ == "__main__":
    main(sys.argv[1:])
