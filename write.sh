#!/bin/bash
set -e

cd "$(dirname "$0")"
mkdir -p src
# rm -rf scares me
rm -r src/
mkdir -p src
for i in {0..3}
do
   echo "c${1:-a} ${i}" > "src/file${i}"
done