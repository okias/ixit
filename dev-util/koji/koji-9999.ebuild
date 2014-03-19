# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Build system for the Fedora project"
HOMEPAGE="https://fedorahosted.org/koji/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="minimal"

COMMON_DEPEND="
	app-arch/rpm
	dev-python/python-krbV
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
	dev-python/pyopenssl
	dev-python/urlgrabber
	sys-apps/yum
"

src_prepare() {
	epatch "${FILESDIR}"/fedora-config.patch

	sed -i "1 s/python/python2/" `find -type f`
	sed -i -e 's/^PYTHON=python$/PYTHON=python2/' koji/Makefile
}

src_install() {
	if use minimal ; then
		emake -j1 -C koji install DESTDIR="${D}" || die
		emake -j1 -C cli install DESTDIR="${D}" || die
	else
		emake -j1 install DESTDIR="${D}" || die
	fi
}
