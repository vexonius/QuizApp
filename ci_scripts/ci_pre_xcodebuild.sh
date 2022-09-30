#!/bin/sh
export PATH="$PATH:/usr/local/bin"

brew tap vexonius/five-swiftlint
brew install five-swiftlint
five-swiftlint lint --path $CI_WORKSPACE --strict
result=$?
if [ "$result" = "2" ] || [ "$result" = "3" ]
then
    exit -1
else
    exit 0
fi
