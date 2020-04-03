# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="GTK3 client for Mastodon"
HOMEPAGE="https://github.com/bleakgrey/tootle"
EGIT_REPO_URI="https://github.com/bleakgrey/tootle.git"
EGIT_BRANCH="refactor"
LICENSE="GPL-3"

KEYWORDS=""
SLOT="0"

RDEPEND="
	net-libs/libsoup
	>=dev-libs/granite-0.5.2
	dev-libs/json-glib
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-util/meson
	dev-lang/vala
"

src_prepare() {
	vala_src_prepare
	default
}

src_install() {
	meson_src_install
	dosym "${EPREFIX}"/usr/bin/{com.github.bleakgrey.,}tootle
}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
