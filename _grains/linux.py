#!/usr/bin/python2

def linux_lxc():
    import sys, re, platform

    grains = { 'linux_lxc': False }
    if 'Linux' in platform.uname():
        file = open('/proc/1/cgroup', 'r')

        for line in file:
            if re.search('(lxc|nspawn)', line):
                grains['linux_lxc'] = True
                break
    return grains
