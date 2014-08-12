# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mock/mock-1.0.3.ebuild,v 1.3 2012/06/07 21:35:09 zmedico Exp $

EAPI="5"

inherit eutils user
[ "${PV}" = 9999 ] && inherit mercurial autotools

DESCRIPTION="Allow configured programs to be run with superuser privileges by ordinary users,"
HOMEPAGE="http://fedorahosted.org/usermode"
EHG_REPO_URI="http://hg.fedorahosted.org/hg/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/r/p/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
[ "${PV}" = 9999 ] || KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libuser
"

src_prepare() {
	default

	eautoreconf
}
