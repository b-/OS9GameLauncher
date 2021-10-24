#!/bin/sh
for script in *.applescript;
do
  SetFile -t TEXT -c asDB "${script}"
done
