# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mock/mock-1.0.3.ebuild,v 1.2 2011/11/02 22:44:19 vapier Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Tool for checking common errors in RPM packages"
HOMEPAGE="http://rpmlint.zarb.org/"
EGIT_REPO_URI="git://git.code.sf.net/p/rpmlint/code"
[ "${PV}" = 9999 ] || SRC_URI="mirror://sourceforge/rpmlint/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
[ "${PV}" = 9999 ] || KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	app-arch/rpm[python]
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
	|| ( dev-python/python-magic sys-apps/file[python] )
	dev-python/pyenchant
"

src_install() {
	default

	insinto /usr/share/rmplint/config
	newins ${FILESDIR}/fedora.config config
}
