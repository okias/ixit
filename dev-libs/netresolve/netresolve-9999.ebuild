# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-3.2.9999.ebuild,v 1.1 2013/10/23 10:58:30 jer Exp $

EAPI=5
GITHUB_USER=pavlix

inherit ixit-github autotools

DESCRIPTION="Network name resolution library"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	net-dns/c-ares
"

src_prepare() {
	eautoreconf
}
