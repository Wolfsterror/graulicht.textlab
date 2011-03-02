#!/bin/bash

mxmlc -library-path+=/opt/flex/frameworks/libs/ -source-path+=/opt/flex/frameworks/projects/framework/src/ -load-config /opt/flex/frameworks/flex-config.xml -load-config ./obj/textlabConfig.xml -library-path+=./src/com/ -source-path+=./src/ -output ./bin/textlab.swf -debug=true -incremental=true -benchmark=false -show-binding-warnings=true -show-deprecation-warnings=true -strict=false -use-resource-bundle-metadata=true -warnings=true -verbose-stacktraces=true -static-link-runtime-shared-libraries=true

# fdb bin/textlab.swf
