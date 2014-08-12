# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools eutils
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Python extension module for Kerberos 5"
HOMEPAGE="http://fedorahosted.org/python-krbV/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	virtual/krb5
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"

src_configure() {
	[ "${PV}" = 9999 ] && eautoreconf

	econf LIBNAME=$(get_libdir)
}

src_install()
{
	default

	dodoc README krbV-code-snippets.py

	find "${ED}" -name '*.la' -delete
}
