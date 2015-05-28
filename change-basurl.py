#!/bin/env python

import os

yum_etc = '/etc/yum.repos.d/'
new_repo = 'http://repo.euca/euca-repo/'
baseurls = [
  ( 'eucalyptus', 'eucalyptus.repo', new_repo + '/eucalyptus/downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/' ),
  ( 'euca2ools', 'euca2ools.repo', new_repo + '/euca2ools/downloads.eucalyptus.com/software/euca2ools/3.2/centos/6/x86_64')
]

for r in baseurls:
  name = r[0]
  fname = r[1]
  url = r[2]
  f = open( os.path.join(yum_etc, fname), 'r' )
  conf = f.readlines()
  f.close()

  f = open( os.path.join(yum_etc, fname), 'w' )
  for line in conf:
    if line.startswith('mirrorlist'):
      f.write('#' + line)
    else:
      f.write(line)
  f.write('baseurl=' + url)
  f.close()
