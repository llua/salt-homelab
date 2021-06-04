#!/usr/bin/env python
"""
 Description of the module goes here
"""
import argparse
import os

__author__     = 'Eric Cook'
__license__    = 'ISC'
__version__    = '0.1'
__maintainer__ = __author__
__email__      = 'llua@gmx.com'

def parse_cli():
    args = argparse.ArgumentParser()
    args.add_argument('-V', '--version', action='version', version='%(prog)s {}'.format(__version__))
    return args.parse_args()

def main():
    opts = parse_cli()

if __name__ == '__main__':
    main()
