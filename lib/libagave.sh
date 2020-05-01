# This file is part of the Agave project 
# https://github.com/dmedri/agave/
# Copyright (c) 2020 Daniele Medri.
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


# Libraries
source lib/libagave-R.sh
source lib/libagave-utils.sh

# 
# Agave header
# call: agave-header
#
function agave-header {
        echo -e "\e[32mAgave\e[0m - https://github.com/dmedri/agave"
        echo -e "Copyright 2020 Daniele Medri - GNU GPL >= 3.0"
        echo -e "Use 'agave --help' for the available options.\n"
}

#
# Agave help menu
# call: app-options
#
function app-options {
        echo -e "Actions available for the local R packages:\n"
        echo -e "\t\e[34m-b  [pkg]\e[0m	Build packages."
        echo -e "\t\e[34m-bc [pkg]\e[0m	Build and check packages."
        echo -e "\t\e[34m-bi [pkg]\e[0m	Build and install packages."
        echo -e "\t\e[34m-c  [pkg]\e[0m	Basic checks for packages."
        echo -e "\t\e[34m-cc [pkg]\e[0m	CRAN checks for packages."
        echo -e "\t\e[34m-i  [pkg]\e[0m	Install a package."
        echo -e "\t\e[34m-r  [pkg]\e[0m	Remove an installed package."
}
