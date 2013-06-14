# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PLOCALES="ar cs de el_GR en es fa fr hu it ja ko lt nl pl pt_BR ru sr sv th tr uk zh_CN zh_TW"
EHG_REPO_URI="https://code.google.com/p/quite-rss"
inherit l10n qt5 mercurial

DESCRIPTION="A Qt5-based RSS/Atom feed reader"
HOMEPAGE="http://code.google.com/p/quite-rss/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="dev-db/sqlite:3
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtxml:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwebkit:5[multimedia]"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS HISTORY_EN HISTORY_RU README )

src_prepare() {
	my_rm_loc() {
		sed -i -e "s:lang/${PN}_${1}.ts::" lang/lang.pri || die 'sed on lang.pri failed'
	}
	l10n_find_plocales_changes "lang" "${PN}_" '.ts'
	l10n_for_each_disabled_locale_do my_rm_loc

	qt5_src_prepare
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}
