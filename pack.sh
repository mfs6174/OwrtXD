# File: pack.sh 
 # Author: Zhang Xijin(mfs6174)
 # Email: mfs6174@gmail.com
 #
 # Copyright (C) 2011 Zhang Xijin(mfs6174)
 #
 # This file is part of OwrtXD.
 #
 # OwrtXD is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # OwrtXD is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with OwrtXD.  If not, see <http://www.gnu.org/licenses/>.

 # This work is licensed under a Creative Commons Attribution-NonCommercial 2.5 Generic License.
 # http://creativecommons.org/licenses/by-nc/2.5/
 # 未经作者授权绝对不允许用于任何商业目的!
#!/bin/bash
rm -rf wrt >> /dev/null
mkdir wrt
cp mentoinit.sh wrt/
cp -r conf wrt/
cp -r packages wrt/
cp -r mentohust wrt/
if [ "$1" != "1" ]; then
    rm -f wrt/mentohust/mento
    rm -rf wrt/mentohust/mentohust
	echo "true"
fi
tar -cf init.tar wrt
rm -rf wrt
