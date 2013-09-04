#!/bin/bash
#
# The MIT License (MIT)
#
# Copyright (c) 2013 Christian Babeux <christian.babeux@efficios.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

URCU_GIT="git://git.lttng.org/userspace-rcu.git"
BABELTRACE_GIT="git://git.efficios.com/babeltrace.git"
MODULE_GIT="git://git.lttng.org/lttng-modules.git"
UST_GIT="git://git.lttng.org/lttng-ust.git"
TOOLS_GIT="git://git.lttng.org/lttng-tools.git"

git clone ${URCU_GIT}
git clone ${BABELTRACE_GIT}
git clone ${MODULE_GIT}
git clone ${UST_GIT}
git clone ${TOOLS_GIT}

# URCU
cd userspace-rcu
./bootstrap
./configure --prefix=/usr
make
make install
ldconfig

cd ..

# Babeltrace
cd babeltrace
./bootstrap
./configure --prefix=/usr
make
make install
ldconfig

cd ..

# Module
cd lttng-modules
make
make modules_install
depmod -a

cd ..

# UST
cd lttng-ust
./bootstrap
./configure --prefix=/usr
make
make install
ldconfig

cd ..

# Tools
cd lttng-tools
./bootstrap
./configure --prefix=/usr
make
make install

cd ..

