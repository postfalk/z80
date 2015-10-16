#!/usr/bin/python

import sys
import getopt
from subprocess import call
import binascii

OUTPUTFILE = 'z80_code_test.h'
TEMPLATE = (
    '#include <Arduino.h>\n'
    '#ifndef codebase\n'
    '#define codebase\n\n'
    'codebase byte codebase[] {\n'
    '%s'
    '\n};\n\n'
    '#endif'
)

def bin_to_code(bin):
    pass

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
    call(["z80asm", inputfile, "-o", binfile_name])

    with open(binfile_name, 'rb') as f:
        content = f.read()
        hexstring = binascii.hexlify(content)

    f = open(OUTPUTFILE, 'w')
    f.write(TEMPLATE % '  0x00')
    f.close()


    # print 'Input file is "', inputfile
    # print 'Output file is "', outputfile

if __name__ == "__main__":
    main(sys.argv[1:])
