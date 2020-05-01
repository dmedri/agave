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


# Configurations
PKGS="packages"
BDIR="_build"
CDIR="_check"

RB="R CMD build"
RI="R CMD INSTALL"
RC="R CMD check"
RR="R CMD REMOVE"

CCRAN="--as-cran"
BOPTS="--md5"
IOPTS="--clean --debug"

DEBUG=TRUE

# 
# Agave: make a single local package
# call: r-build
#
function r-build {
	echo -e "\e[32m### Building... ###\e[0m"
	if [[ $1 != "" ]]; then
		echo -e "\e[32m($1)\e[0m"
		if [[ -f $PKGS/$1/DESCRIPTION ]]; then
			if [[ DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RB ./PKGS/$1 $BOPTS\e[0m\n"
			fi
			$RB ./$PKGS/$1 $BOPTS 
			pv=$(get-pkg-ver "$PKGS/$1/")
			if [[ DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34mmv $1_$pv.tar.gz $BDIR/\e[0m\n"
			fi
			mv $1_$pv.tar.gz $BDIR/
		else
			echo -e "Please, check the '$PKGS/$1' directory"
			echo -e "Something goes wrong, can not build anything."
		fi
	else
		cd $PKGS
		echo -e "\e[32m(all packages)\e[0m"
		for i in `ls -d */`; do
			echo -e "\e[32m($(basename $i))\e[0m"
			if [[ DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RB $(basename $i) $BOPTS\e[0m\n"
			fi
			$RB $(basename $i) $BOPTS
			pv=$(get-pkg-ver "$i")
			if [[ DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34mmv $(basename $i)_$pv.tar.gz ../$BDIR/\e[0m\n"
			fi
			mv $(basename $i)_$pv.tar.gz ../$BDIR/
		done
		cd ..
	fi
}

# 
# Agave: check a single local package
# call: r-check
#
function r-check {
	echo -e "\e[32m### Checking... ###\e[0m"
	if [[ $1 != "" ]]; then
		pv=$(get-pkg-ver "$PKGS/$1/")
		if [[ -f $BDIR/$1_$pv.tar.gz ]]; then
			echo -e "\e[32m($1)\e[0m"
			if [[ $DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RC $BDIR/$1_$pv.tar.gz -o $CDIR/\e[0m\n"
			fi
			$RC $BDIR/$1_$pv.tar.gz -o $CDIR/
		else
			echo -e "Package '$(basename $1)' missing: please, build it." 
		fi
	else
		cd $PKGS
		echo -e "\e[32m(all packages)\e[0m"
		for i in `ls -d */`; do
			pv=$(get-pkg-ver "$i/")
			echo -e "\e[32m($(basename $i))\e[0m"
			if [[ -f ../$BDIR/$(basename $i)_$pv.tar.gz ]]; then
				if [[ DEBUG ]]; then
					echo -e "\n\e[34m$(pwd)\e[0m"
					echo -e "\e[34m$RC ../$BDIR/$(basename $i)_$pv.tar.gz -o ../$CDIR/\e[0m\n"
				fi
				$RC ../$BDIR/$(basename $i)_$pv.tar.gz -o ../$CDIR/
			else
				echo "Package '$i' missing: please, build it."
			fi
		done
	fi
}

# 
# Agave: check a single local package with cran tests
# call: r-check-cran
#
function r-check-cran {
	echo -e "\e[32m### CRAN Checking... ###\e[0m"
	if [[ $1 != "" ]]; then
		pv=$(get-pkg-ver "$PKGS/$1/")
		if [[ -f $BDIR/$1_$pv.tar.gz ]]; then
			echo -e "\e[32m($1)\e[0m"
			if [[ $DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RC $BDIR/$1_$pv.tar.gz $CCRAN -o $CDIR/\e[0m\n"
			fi
			$RC $BDIR/$1_$pv.tar.gz $CCRAN -o $CDIR/
		else
			echo -e "warning: no '$i' package in $BDIR." 
		fi
	else
		cd $PKGS
		echo -e "\e[32m(all packages)\e[0m"
		for i in `ls -d */`; do
			pv=$(get-pkg-ver "$i/")
			echo -e "\e[32m($(basename $i))\e[0m"
			if [[ -f ../$BDIR/$(basename $i)_$pv.tar.gz ]]; then
				if [[ DEBUG ]]; then
					echo -e "\n\e[34m$(pwd)\e[0m"
					echo -e "\e[34m$RC ../$BDIR/$(basename $i)_$pv.tar.gz $CCRAN -o ../$CDIR/\e[0m\n"
				fi
				$RC ../$BDIR/$(basename $i)_$pv.tar.gz $CCRAN -o ../$CDIR/
			else
				echo "Package '$i' missing: please, build it."
			fi
		done
	fi
}

# 
# Agave: install a single local package
# call: r-install
#
function r-install {
	echo -e "\e[32m### Installing... ###\e[0m"
	if [[ $1 != "" ]]; then
		if [[ -d $BDIR ]]; then
			pv=$(get-pkg-ver "$PKGS/$1/")
			if [[ -f $BDIR/$1_$pv.tar.gz ]]; then
				echo -e "\e[32m($1)\e[0m"
				if [[ DEBUG ]]; then
					echo -e "\n\e[34m$(pwd)\e[0m"
					echo -e "\e[34m$RI $BDIR/$1_$pv.tar.gz\e[0m\n"
				fi
				$RI $BDIR/$1_$pv.tar.gz
			else
				echo "Package '$1' missing: please, build it."
			fi
		else
			echo -e "warning: no '$i' package in $BDIR."
		fi
	else
		cd $PKGS
		echo -e "\e[32m(all packages)\e[0m"
		for i in `ls -d */`; do
			pv=$(get-pkg-ver "$i/")
			echo -e "\e[32m($(basename $i))\e[0m"
			if [[ -f ../$BDIR/$(basename $i)_$pv.tar.gz ]]; then
				if [[ DEBUG ]]; then
					echo -e "\n\e[34m$(pwd)\e[0m"
					echo -e "\e[34m$RI ../$BDIR/$(basename $i)_$pv.tar.gz\e[0m\n"
				fi
				$RI ../$BDIR/$(basename $i)_$pv.tar.gz
			else
				echo "Package '$i' missing: please, build it."
			fi
		done
	fi
}

#
# Agave: remove a single local package already installed
# call: r-remove
#
function r-remove {
	echo -e "\e[32m### Removing... ###\e[0m"
	if [[ $1 != "" ]]; then
		if [[ -f $PKGS/$1/DESCRIPTION ]]; then
			echo -e "\e[32m($1)\e[0m"
			if [[ $DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RR $1\e[0m\n"
			fi
			$RR $1
		else
			echo -e "warning: can remove only one available in $PKGS."
		fi
	else
		cd $PKGS
		echo -e "\e[32m(all packages)\e[0m"
		for i in `ls -d */`; do
			echo -e "\e[32m($(basename $i))\e[0m"
			if [[ $DEBUG ]]; then
				echo -e "\n\e[34m$(pwd)\e[0m"
				echo -e "\e[34m$RR $(basename $i)\e[0m\n"
			fi
			$RR $(basename $i)
		done
	fi
}
