# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rpmdevtools/rpmdevtools-8.3-r1.ebuild,v 1.2 2013/06/04 21:40:33 bicatali Exp $

EAPI=5

[ "${PV}" = 9999 ] && inherit git-r3 autotools

DESCRIPTION="Collection of rpm packaging related utilities"
HOMEPAGE="https://fedorahosted.org/rpmdevtools/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/r/p/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="emacs"

COMMON_DEPEND="
	app-arch/rpm[python]
	net-misc/curl
	emacs? ( app-emacs/rpm-spec-mode )
	dev-util/checkbashisms
"
DEPEND="
	${COMMON_DEPEND}
	dev-lang/perl
	sys-apps/help2man
"
RDEPEND="
	${COMMON_DEPEND}
"

src_prepare() {
	sed -i '1 s/python /python2 /' rpmdev-rmdevelrpms.py rpmdev-* || die
}

src_configure() {
	[ "${PV}" = 9999 ] && eautoreconf

	default
}
