#!/usr/bin/bash
oasis setup -setup-update dynamic
./configure --enable-docs
make doc
mv docs.docdir/* docs/
./clean.sh
cp ./style.css docs/
