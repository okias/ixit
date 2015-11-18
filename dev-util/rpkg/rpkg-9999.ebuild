# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Utility for interacting with rpm+git packaging systems"
HOMEPAGE="https://fedorahosted.org/rpkg"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"


LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-python/git-python
	dev-python/kitchen
	dev-python/pycurl
	dev-util/koji
"
DEPEND="
	${COMMON_DEPEND}
	dev-python/setuptools
"
RDEPEND="
	${COMMON_DEPEND}
	app-arch/rpm[python]
	dev-util/mock
	net-misc/curl
	net-misc/openssh
"
