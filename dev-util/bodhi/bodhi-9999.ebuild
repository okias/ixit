# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Build system for the Fedora project"
HOMEPAGE="https://fedorahosted.org/bodhi/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+minimal"

COMMON_DEPEND="
	!minimal? ( >=dev-python/turbogears-1.0 )
	!minimal? ( <=dev-python/turbogears-1.5 )
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"

src_compile() {
	if use minimal; then
		:
	else
		inherit
	fi
}

src_install() {
	if use minimal; then
		newbin bodhi/tools/client.py bodhi
	else
		inherit
	fi
}
