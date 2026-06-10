#!/usr/bin/env bash
#
# Copyright (c) 2018 Martin Storsjo
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#####
# This is a script for setting up env variables for letting native tools
# find headers and libraries installed by the other msvc-wine scripts.
#
# To use this script, execute it like this:
#     . <path-to-msvc-wine-install>/bin/x64/msvcenv-native.sh
# After executing this, you should be able to run clang-cl and lld-link
# without needing to configure paths manually anywhere.
# (If linking by invoking clang or clang-cl, instead of directly calling
# lld-link, it's recommended to use -fuse-ld=lld.)

SDK=kits/10
BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
# Support having the wrappers in a directory one or two levels below the
# installation directory.
if [ ! -d "$BASE/vc" ]; then
    BASE=$(cd "$BASE"/.. && pwd)
fi
MSVCVER=14.13.26128
SDKVER=10.0.16299.0
NETFXVER=4.8
NETFXSDKVER=v10.0A
ARCH=x86
MSVCBASE="$BASE/vc"
SDKBASE="$BASE/$SDK"
NETFXBASE="$BASE/kits/NETFXSDK/$NETFXVER"
NETFXSDKBASE="$BASE/sdks/Windows/$NETFXSDKVER"
MSVCDIR="$MSVCBASE/tools/msvc/$MSVCVER"
SDKINCLUDE="$SDKBASE/include/$SDKVER"
SDKLIB="$SDKBASE/lib/$SDKVER"
export INCLUDE="$MSVCDIR/atlmfc/include;$MSVCDIR/include;$SDKINCLUDE/shared;$SDKINCLUDE/ucrt;$SDKINCLUDE/um;$SDKINCLUDE/winrt;$SDKINCLUDE/km;$NETFXBASE/include"
export LIB="$MSVCDIR/atlmfc/lib/$ARCH;$MSVCDIR/lib/$ARCH;$SDKLIB/ucrt/$ARCH;$SDKLIB/um/$ARCH;$SDKLIB/km/$ARCH;$NETFXBASE/lib"
export PATH="$BASE/bin/$ARCH:$PATH"
