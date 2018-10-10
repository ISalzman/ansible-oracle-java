#!/bin/bash
# Simple script to uninstall messy packages provided by Oracle(Sun) JDK especially sun-javadb series

messy_packages=(
  'sun-javadb-core'
  'sun-javadb-client'
  'sun-javadb-docs'
  'sun-javadb-javadoc'
  'sun-javadb-demo'
  'sun-javadb-common'
);

for pkg in "${messy_packages[@]}"
do
  echo ${pkg}
  rpm -e ${pkg}
done

exit 0
