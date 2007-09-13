#!/bin/bash

packageName="ebox-services"

for locale in $(cat LINGUAS  | sed -s 's: :\n:g')
  do
  echo $locale
  msginit --input=${packageName}.pot \
      --locale=$locale --output="$locale.po" \
      --no-translator

  # Get version from configure.ac
  version=$(perl -ne 'if (m/^AC_INIT.*, *\[(.*)\]\)/ ) { print $1; }' ../configure.ac)
  # Put version and package name in po file
  # And charset to UTF-8
  sed -i -e "s/^\"Project-Id-Version:.*$/\"Project-Id-Version: $packageName $version\"/" \
      -e 's/charset=.*\\/charset=UTF-8\\/' -e "s/PACKAGE/$packageName/" $locale.po

done


