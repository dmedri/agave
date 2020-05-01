# This file is part of the Agave project 
# https://github.com/dmedri/roaster/
# Copyright (c) 2019-2020 Daniele Medri.
# 
# This program is free software: you can redistribute it and/or modify  
# it under the terms of the GNU General Public License as published by  
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program. If not, see <http://www.gnu.org/licenses/>.                                


#
# Checks for required commands
# call: check-cmdreq awk
# call: check-cmdreq {awk,cut,wget}
#
function check-cmdreq {
        while(($#)); do
                command -v "$1"  >/dev/null 2>&1 \
                || { echo >&2 "Command '$1' is required."; exit; }
                shift
        done
}

#
# Separating line
# call: sepline
#

function sepline {
	echo -e "\n\e[32m--------------------------------------------------\e[0m\n"
}

#
# Get package version
# call: get-pkg-ver $1
#

function get-pkg-ver {
	cat $1/DESCRIPTION|grep 'Version:'|awk '{print $2}'
}
