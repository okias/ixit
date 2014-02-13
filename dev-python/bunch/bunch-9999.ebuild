# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Python dictionary with attribute-style access"
HOMEPAGE="http://github.com/dsc/bunch"
EGIT_REPO_URI="https://github.com/dsc/${PN}.git"
[ "${PV}" = 9999 ] || SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/nose
	dev-python/setuptools
"
