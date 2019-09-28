# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1 eutils toolchain-funcs

DESCRIPTION="Python library to interact with keepass databases (supports KDBX3 and KDBX4) "
HOMEPAGE="https://github.com/libkeepass/pykeepass"
SRC_URI="https://github.com/libkeepass/pykeepass/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sh ~sparc ~x86 ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=dev-python/lxml-4.3.4
	>=dev-python/pycryptodome-3.8.2
	>=dev-python/construct-2.9.45
	>=dev-python/argon2_cffi-19.1.0
	>=dev-python/python-dateutil-2.8.0
	>=dev-python/future-0.17.0"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

PATCHES=( "${FILESDIR}/0001-setup.py-exclude-tests-directory.patch" )
