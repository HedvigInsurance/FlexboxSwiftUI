#!/bin/bash

MODULE_MAP="$CI_WORKSPACE"/Sources/FlexboxSwiftUIObjC/module.modulemap

if [ -f "$MODULE_MAP" ] ; then
    rm "$MODULE_MAP"
fi
