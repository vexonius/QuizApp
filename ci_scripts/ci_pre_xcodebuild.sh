#!/bin/sh

brew tap vexonius/five-swiftlint
brew install five-swiftlint
opt/homebrew/bin/five-swiftlint lint --strict
result=$?
if [ "$result" = "2" ] || [ "$result" = "3" ]
then
    exit -1
else
    exit 0
fi
