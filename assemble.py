#!/usr/bin/python

import sys
import getopt
from subprocess import check_output, CalledProcessError
import binascii

OUTPUTFILE_NAME = 'z80_code.h'
TEMPLATE = (
    '#include <Arduino.h>\n'
    '#ifndef codebase\n'
    '#define codebase\n\n'
    'codebase byte code[] {\n'
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
    try:
       opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
       print 'assemble.py -i <inputfile>'
       sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'assemble.py -i <inputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
    binfile_name = '{}.bin'.format(inputfile.split('.')[0])
    print '\nInput file:', inputfile
    try:
        check_output(["z80asm", inputfile, "-o", binfile_name])
        print 'Binary file:', binfile_name
        with open(binfile_name, 'rb') as f:
            content = f.read()
        coded_code = bin_to_c_array(content)
        with open(OUTPUTFILE_NAME, 'w') as f:
            f.write(TEMPLATE % coded_code)
        print 'Arduino C array: {}\n\nBuild successfully\n'.format(
            OUTPUTFILE_NAME)
    except CalledProcessError:
        print '\nThere have been errors in your z80 code.\n'

if __name__ == "__main__":
    main(sys.argv[1:])
