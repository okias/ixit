# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]]; then
	VCS_ECLASS=git-2
	EGIT_REPO_URI="git://github.com/${PN}/${PN}.git"
	KEYWORDS=""
fi

inherit qmake-utils ${VCS_ECLASS}

DESCRIPTION="Qt5 WebKit web browser"
HOMEPAGE="http://snowshoe.openbossa.org/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug"

DEPEND="
	>=dev-qt/qtwebkit-5.1.0_beta1:5[qml]
	>=dev-qt/qt-components-5.0.0"
RDEPEND="${DEPEND}"

DOCS="README.md"
