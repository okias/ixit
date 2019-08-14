# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="https://gitlab.gnome.org/World/PasswordSafe"

SRC_URI="https://gitlab.gnome.org/World/PasswordSafe/-/archive/${PV}/PasswordSafe-${PV}.tar.bz2"

LICENSE="GPL-2+"
IUSE="+introspection"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

S="${WORKDIR}/PasswordSafe-${PV}"

COMMON_DEPEND="
	>=dev-lang/python-3.6.5
	>=dev-python/pykeepass-3.0.3
	>=x11-libs/gtk+-3.24.1:3[introspection?]
	>=dev-libs/libhandy-0.0.10
	>=dev-libs/libpwquality-1.4.0[python]
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:= )
"
RDEPEND="${COMMON_DEPEND}
"
DEPEND="${COMMON_DEPEND}
"

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}
pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}
