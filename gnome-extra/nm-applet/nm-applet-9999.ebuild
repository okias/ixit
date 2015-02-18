# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.9.10.0.ebuild,v 1.1 2014/09/23 11:56:02 pacho Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="network-manager-applet"

#inherit gnome2
[ "${PV}" = 9999 ] && inherit git-r3 autotools

DESCRIPTION="GNOME applet for NetworkManager"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
EGIT_REPO_URI="git://git.gnome.org/network-manager-applet"
[ "${PV}" = 9999 ] && unset SRC_URI

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=" ~amd64 ~x86"
IUSE="bluetooth gconf +appindicator +introspection modemmanager"

RDEPEND="
	app-crypt/libsecret
	>=dev-libs/glib-2.32:2
	>=dev-libs/dbus-glib-0.88
	>=sys-apps/dbus-1.4.1
	>=sys-auth/polkit-0.96-r1
	>=x11-libs/gtk+-3.4:3[introspection?]
	>=x11-libs/libnotify-0.7.0

	app-text/iso-codes
	>=net-misc/networkmanager-0.9.9.95[introspection?]
	net-misc/mobile-broadband-provider-info

	bluetooth? ( >=net-wireless/gnome-bluetooth-2.27.6:= )
	gconf? (
		>=gnome-base/gconf-2.20:2
		gnome-base/libgnome-keyring )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
	modemmanager? ( >=net-misc/modemmanager-0.7.990 )
	virtual/freedesktop-icon-theme
	virtual/notification-daemon
	virtual/libgudev:=
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
"

src_prepare() {
	[ "${PV}" = 9999 ] && eautoreconf
}

src_configure() {
	#gnome2_src_configure \
	econf \
		--disable-more-warnings \
		--disable-static \
		--localstatedir=/var \
		$(use_with bluetooth) \
		$(use_enable gconf migration) \
		$(use_enable introspection) \
		$(use_with appindicator) \
		$(use_with modemmanager modem-manager-1)
}
