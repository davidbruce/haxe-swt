#!/bin/bash

mvn dependency:copy-dependencies -DoutputDirectory=temp

rm -rf src/swt/_internal/jars

mkdir -p src/swt/_internal/jars/common
mkdir -p src/swt/_internal/jars/aarch64/macos
mkdir -p src/swt/_internal/jars/x86-64/macos
mkdir -p src/swt/_internal/jars/aarch64/linux
mkdir -p src/swt/_internal/jars/x86-64/linux
mkdir -p src/swt/_internal/jars/x86-64/windows

mv temp/org.eclipse.swt.cocoa.*.aarch64* src/swt/_internal/jars/aarch64/macos
mv temp/org.eclipse.swt.cocoa.*.x86_64* src/swt/_internal/jars/x86-64/macos
mv temp/org.eclipse.swt.gtk.*.aarch64* src/swt/_internal/jars/aarch64/linux
mv temp/org.eclipse.swt.gtk.*.x86_64* src/swt/_internal/jars/x86-64/linux
mv temp/org.eclipse.swt.win32* src/swt/_internal/jars/x86-64/windows
mv temp/org.eclipse.swt* src/swt/_internal/jars/common

rmdir temp