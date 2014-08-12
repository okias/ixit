# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

[ ${PV} = 9999 ] && inherit mercurial autotools

DESCRIPTION="Fedora utility for working with dist-git"
HOMEPAGE="https://fedorahosted.org/fedpkg"
EHG_REPO_URI="http://hg.fedorahosted.org/hg/${PN}"
[ ${PV} = 9999 ] || SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
"
DEPEND="
	${COMMON_DEPEND}
	app-text/linuxdoc-tools
	dev-util/gtk-doc
"
RDEPEND="
	${COMMON_DEPEND}
"

src_prepare() {
	default
}

src_configure() {
	[ ${PV} = 9999 ] && { ./autogen.sh || die; }

	default
}
