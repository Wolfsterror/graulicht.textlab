#!/bin/bash

mxmlc -library-path+=/opt/flex/frameworks/libs/ -source-path+=/opt/flex/frameworks/projects/framework/src/ -load-config /opt/flex/frameworks/flex-config.xml -load-config ./obj/textlabLinux.xml -library-path+=./src/com/ -source-path+=./src/ -output ./bin/textlab.swf -debug=false -incremental=true -benchmark=false -static-link-runtime-shared-libraries=true -optimize=true

# fdb bin/textlab.swf
