# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit python-r1 qmake-utils git-r3

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="http://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="dbus debug geoip +gui qt4 qt5"

# geoip and python are runtime deps only (see INSTALL file)
CDEPEND="
	dev-libs/boost:=
	>=net-libs/rb_libtorrent-0.16.10
	dbus? (
		qt4? ( dev-qt/qtdbus:4 )
		qt5? ( dev-qt/qtdbus:5 )
	)
	gui? (
		qt4? ( dev-qt/qtgui:4 )
		qt5? ( dev-qt/qtgui:5 )
	)
	qt4? (
		dev-qt/qtcore:4
		>=dev-qt/qtsingleapplication-2.6.1_p20130904-r1
	)
	qt5? ( dev-qt/qtcore:5 )
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	${PYTHON_DEPS}
	geoip? ( dev-libs/geoip )
"

REQUIRED_USE="^^ ( qt4 qt5 )"

DOCS=(AUTHORS Changelog TODO)

src_configure() {
	# Custom configure script, econf fails
	local myconf=(
		./configure
		--prefix="${EPREFIX}/usr"
		$(use dbus  || echo --disable-qt-dbus)
		$(use debug && echo --enable-debug)
		$(use geoip || echo --disable-geoip-database)
		$(use gui   || echo --disable-gui)
		$(use qt4   && echo --with-qtsingleapplication=system)
		$(use qt5   && echo --with-qt5)
		$(use qt5   && echo --with-qtsingleapplication=shipped)
	)

	echo "${myconf[@]}"
	"${myconf[@]}" || die "configure failed"
	use qt4 && eqmake4
	use qt5 && eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
}
