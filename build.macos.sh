#!/bin/bash

echo --------------------------------------------------------------------------------

FLEX4=~/Library/Flex

${FLEX4}/bin/mxmlc -library-path+=${FLEX4}/frameworks/libs/ -source-path+=${FLEX4}/frameworks/projects/framework/src/ -load-config ${FLEX4}/frameworks/flex-config.xml -load-config obj/textlabMac.xml -library-path+=src/com/ -source-path+=src/ -output bin/textlab.swf -debug=true -incremental=true -benchmark=false -static-link-runtime-shared-libraries=true -optimize=true

# ${FLEX4}/bin/fdb bin/textlab.swf

echo --------------------------------------------------------------------------------
