# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit git-r3

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An identification and authentication framework for WSGI"
HOMEPAGE="http://repoze.org/"
EGIT_REPO_URI="https://github.com/repoze/${MY_PN}.git"
[ "${PV}" = 9999 ] || SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-python/paste
	net-zope/zope-interface
"
DEPEND="
	${COMMON_DEPEND}
	dev-python/coverage
	dev-python/nose
	dev-python/setuptools
"
RDEPEND="
	${COMMON_DEPEND}
"
