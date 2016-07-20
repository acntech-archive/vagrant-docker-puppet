#!/usr/bin/env bash
for i in `vagrant global-status | grep virtualbox | awk '{ print $1 }'` ; do vagrant destroy $i ; done
for i in `vagrant global-status | grep docker | awk '{ print $1 }'` ; do vagrant destroy $i ; done
echo "Vagrant global status:" 
vagrant global-status --prune