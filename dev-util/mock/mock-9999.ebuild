# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mock/mock-1.0.3.ebuild,v 1.3 2012/06/07 21:35:09 zmedico Exp $

EAPI="5"

inherit eutils user
[ "${PV}" = 9999 ] && inherit git-r3 autotools

DESCRIPTION="Build RPM packages in chroots"
HOMEPAGE="http://fedoraproject.org/wiki/Projects/Mock"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/mock/attachment/wiki/MockTarballs/mock-${PV}.tar.gz?format=raw -> mock-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
[ "${PV}" = 9999 ] || KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/decoratortools
	sys-apps/usermode
	sys-apps/yum
"

src_prepare() {
	default

	eautoreconf
}

src_install() {
	default

	dosym consolehelper /usr/bin/mock || die

	doemptydir /var/cache/mock
	doemptydir/var/lib/mock
}

pkg_postinst() {
	enewgroup mock
}

doemptydir() {
	dodir $1 || die
	keepdir $1 || die
}

