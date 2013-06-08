# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]]; then
	VCS_ECLASS=git-2
	EGIT_REPO_URI="git://gitorious.org/qt/${PN}.git"
	EGIT_MASTER="stable"
	KEYWORDS="~arm ~amd64 ~x86"
fi

inherit qt5 ${VCS_ECLASS}

DESCRIPTION="Wayland plugin for Qt"
HOMEPAGE="http://qt-project.org/wiki/QtWayland"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="wayland-compositor"

DEPEND="
	>=dev-qt/qtwebkit-5.1.0_beta1:5"
RDEPEND="${DEPEND}"

src_configure() {
	use wayland-compositor && CONFIG+=wayland-compositor
	eqmake5
}

pkg_postinst() {
	elog "You will need add '-platform wayland' to you qt-application"
	elog "\tqt-application -platform wayland"
}
