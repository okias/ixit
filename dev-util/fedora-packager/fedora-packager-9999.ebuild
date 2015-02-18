# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools
[ "${PV}" = 9999 ] && inherit git-r3

DESCRIPTION="Helper scripts for Fedora packagers"
HOMEPAGE="https://fedorahosted.org/fedora-packager/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/${PN}"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/iniparse
	dev-python/pycurl
	dev-python/urlgrabber
	dev-util/fedpkg
	dev-util/koji
	dev-util/mock
	dev-util/rpmdevtools
	net-misc/curl
"
# dev-util/rpmlint

src_prepare() {
	[ "${PV}" = 9999 ] && eautoreconf
}

src_configure() {
	econf PYTHON=python2
}
