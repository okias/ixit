# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Python library for interacting with Bugzilla"
HOMEPAGE="https://fedorahosted.org/python-bugzilla/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/setuptools
	|| ( dev-python/python-magic sys-apps/file[python] )
"
