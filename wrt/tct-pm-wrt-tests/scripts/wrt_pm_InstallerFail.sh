#!/bin/bash
#
# Copyright (C) 2010 Intel Corporation
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Author:
#        Yue, jianhui <jianhuix.a.yue@intel.com>

if [ $# != 1 ];then
    echo "Need to add the parameter"
    exit 1
fi

path=$(dirname $(dirname $0))
PACKAGENAME="$path/$1"
p_name=$1
APP_NAME=${p_name%.*}
source $path/scripts/xwalk_common.sh
find_app $APP_NAME

pkgnum=`echo "$pkgids"|wc -w`
if [ $pkgnum -ge 1 ]; then
  uninstall_app $APP_NAME
  find_app $APP_NAME
pkgnum=`echo "$pkgids"|wc -w`
if [ $pkgnum -ge 1 ]; then
    echo "fail to uninstall widget"
    exit 1
  fi
fi
install_app $PACKAGENAME
find_app $APP_NAME
pkgnum=`echo "$pkgids"|wc -w`
if [ $pkgnum -ge 1 ]; then
  echo "The widget should not be installed"
  uninstall_app $APP_NAME
  exit 1
else
  echo "The widget is not installed successfully"
  exit 0
fi
