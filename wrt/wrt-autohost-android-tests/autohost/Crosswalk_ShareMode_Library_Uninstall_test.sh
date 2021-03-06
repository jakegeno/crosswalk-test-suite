#!/bin/bash
# Program:
#       This program install & uninstall Crosswalk

# Copyright (c) 2013 Intel Corporation.

# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

# * Redistributions of works must retain the original copyright notice, this list
#   of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the original copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of Intel Corporation nor the names of its contributors
#   may be used to endorse or promote products derived from this work without
#   specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Author:
#        IVAN CHEN <yufeix.chen@intel.com>

local_path=$(dirname $0)

#get current time as log file's name
logName=Crosswalk_Android_Launcher_UI_Uninstall_test_`date '+%Y%m%d%H%M'`.log
reportName="Crosswalk_Android_Test.result"
resultName="Crosswalk_Android_Test.result.log"

CROSSWALK_APK=`cat $local_path/../Crosswalk_wrt_BFT.conf | grep "Android_Crosswalk_Name" | cut -d "=" -f 2`
echo "Crosswalk APK name is " $CROSSWALK_APK 2>&1 >> $local_path/../log/$logName

grep "Success" $local_path/../log/INSTALL_RESULT 2>&1 >> $local_path/../log/$logName
#install
if [ $? -eq 0 ];then
   #uninstall
    adb uninstall org.xwalk.runtime.lib > $local_path/../log/INSTALL_RESULT
    echo "uninstall xwalk" 2>&1 >> $local_path/../log/$logName
    grep "Success" $local_path/../log/INSTALL_RESULT  2>&1 >> $local_path/../log/$logName
    if [ $? -eq 0 ];then
       echo "XwalkRuntimeLib Uninstall successflly" >> $local_path/../log/result/$resultName
       echo "Crosswalk_Android_Launcher_UI_Uninstall***************************** [Pass]" >> $local_path/../log/result/$resultName
       echo "Crosswalk_Android_Launcher_UI_Uninstall                                PASS" >> $local_path/../log/result/$reportName
       adb install -r $local_path/../resources/installer/$CROSSWALK_APK &> $local_path/../log/INSTALL_RESULT
       exit 0
    else
       echo "XWalkRuntimeLib.apk Uninstall Failure" >> $local_path/../log/result/$resultName
       echo "Crosswalk_Android_Launcher_UI_Uninstall***************************** [Fail]" >> $local_path/../log/result/$resultName
       echo "Crosswalk_Android_Launcher_UI_Uninstall                                FAIL" >> $local_path/../log/result/$reportName
       exit 1
    fi
else
   echo "Crosswalk installed failure" >> $local_path/../log/result/$resultName
   echo "Crosswalk_Android_Launcher_UI_Uninstall***************************** [Fail]" >> $local_path/../log/result/$resultName
   echo "Crosswalk_Android_Launcher_UI_Uninstall                                 FAIL" >> $local_path/../log/result/$reportName
   exit 1
fi
