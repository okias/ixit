# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT="python2_7"

inherit distutils-r1
[ ${PV} = 9999 ] && inherit git-r3

DESCRIPTION="Fedora utility for working with dist-git"
HOMEPAGE="https://fedorahosted.org/fedpkg"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ ${PV} = 9999 ] || SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-util/rpkg
"
DEPEND="
	${COMMON_DEPEND}
	dev-python/setuptools
"
RDEPEND="
	${COMMON_DEPEND}
	dev-python/kitchen
	dev-python/offtrac
	dev-python/pycurl
	dev-python/python-fedora
	dev-util/koji
"
