# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit versionator bash-completion-r1 systemd user toolchain-funcs vala virtualx udev eutils autotools

echo $(get_version_component_range $(get_version_component_count))
if [ $(get_version_component_range $(get_version_component_count)) = 9999 ]; then
	echo $(get_version_component_range -$(get_last_version_component_index))
fi

[ ${PV} == 9999 ] && inherit git-r3

DESCRIPTION="Universal network configuration daemon for laptops, desktops, servers and virtualization hosts"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

LICENSE="GPL-2+"
SLOT="0" # add subslot if libnm-util.so.2 or libnm-glib.so.4 bumps soname version
EGIT_REPO_URI="http://anongit.freedesktop.org/git/NetworkManager/NetworkManager.git"

if [ ${PV} != 9999 ]; then
	U_PN=NetworkManager
	U_P=${U_PN}-${PV}
	SRC_URI="https://download.gnome.org/sources/${U_PN}/$(get_version_component_range -2)/${U_P}.tar.xz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${U_P}"
fi

IUSE="bluetooth connection-sharing consolekit +dhclient dhcpcd gnutls +introspection \
kernel_linux +nss +modemmanager ncurses +ppp resolvconf selinux systemd teamd test \
vala +wext +wifi zeroconf \
avahi bluez5 doc logind +upower +polkit +polkit-users"

REQUIRED_USE="
	modemmanager? ( ppp )
	^^ ( nss gnutls )
	^^ ( dhclient dhcpcd )
	systemd? ( !upower )
	polkit-users? ( polkit )
"
COMMON_DEPEND="
	>=sys-apps/dbus-1.2
	>=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2.32:2
	>=dev-libs/libnl-3.2.8:3=
	polkit? ( >=sys-auth/polkit-0.106 )
	net-libs/libndp
	>=net-libs/libsoup-2.26:2.4=
	net-misc/iputils
	sys-libs/readline
	>=virtual/libgudev-165:=
	bluetooth? ( >=net-wireless/bluez-4.82 )
	bluez5? ( >=net-wireless/bluez-5 )
	connection-sharing? (
		net-dns/dnsmasq[dhcp]
		net-firewall/iptables )
	>=net-wireless/wpa_supplicant-0.7.3-r3[dbus]
	>=virtual/udev-165
	avahi? ( net-dns/avahi:=[autoipd] )
	gnutls? (
		dev-libs/libgcrypt:0=
		net-libs/gnutls:= )
	modemmanager? ( >=net-misc/modemmanager-0.7.991 )
	ncurses? ( >=dev-libs/newt-0.52.15 )
	nss? ( >=dev-libs/nss-3.11:= )
	dhclient? ( =net-misc/dhcp-4*[client] )
	dhcpcd? ( >=net-misc/dhcpcd-4.0.0_rc3 )
	introspection? ( >=dev-libs/gobject-introspection-0.10.3 )
	ppp? ( >=net-dialup/ppp-2.4.5:=[ipv6] net-dialup/rp-pppoe )
	resolvconf? ( net-dns/openresolv )
	systemd? ( >=sys-apps/systemd-200 )
	logind? ( >=sys-apps/systemd-200 )
	upower? ( sys-power/upower )
	teamd? ( >=net-misc/libteam-1.9 )
"
RDEPEND="${COMMON_DEPEND}
	consolekit? ( sys-auth/consolekit )
	connection-sharing? ( net-dns/dnsmasq net-firewall/iptables )
	wifi? ( >=net-wireless/wpa_supplicant-0.7.3-r3[dbus] )
"
DEPEND="${COMMON_DEPEND}
	$([ ${PV} == 9999 ] || echo "doc? (")
	dev-util/gdbus-codegen
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-perl/YAML
	$([ ${PV} == 9999 ] || echo ")")
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	>=sys-kernel/linux-headers-2.6.29
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	test? (
		dev-lang/python:2.7
		dev-python/dbus-python[python_targets_python2_7]
		dev-python/pygobject:2[python_targets_python2_7] )
"

src_prepare() {
	EPATCH_SOURCE=${FILESDIR}/patches-${PV} epatch

	use vala && vala_src_prepare
	use doc && gtkdocize
	eautopoint
	eautoreconf
}

src_configure() {
	econf \
		--disable-more-warnings \
		--localstatedir=/var \
		--disable-ifnet \
		--with-dbus-sys-dir=/etc/dbus-1/system.d \
		--with-udev-dir="$(get_udevdir)" \
		--with-config-plugins-default=keyfile \
		--with-iptables=/sbin/iptables \
		--with-libsoup=yes \
		--enable-concheck \
		--with-crypto=$(usex nss nss gnutls) \
		$(use_with logind systemd-logind) \
		$(use_with consolekit) \
		$(use systemd && echo --with-suspend-resume=systemd) \
		$(use upower && echo --with-suspend-resume=upower) \
		$(use_enable bluez5 bluez5-dun) \
		$(use_enable introspection) \
		$(use_enable vala) \
		$(use_enable ppp) \
		--disable-wimax \
		$(use_enable doc gtk-doc) \
		$(use_enable polkit) \
		$(use_enable polkit-users modify-system) \
		$(use_with dhclient) \
		$(use_with dhcpcd) \
		$(use_with modemmanager modem-manager-1) \
		$(use_with ncurses nmtui) \
		$(use_with resolvconf) \
		$(use_with selinux) \
		$(use_enable teamd teamdctl) \
		$(use_enable test tests) \
		$(use_enable vala) \
		$(use_with wext) \
		$(systemd_with_unitdir)
}

src_test() {
	python_setup
	Xemake check
}

src_install() {
	default


	newinitd "${FILESDIR}/init.d.NetworkManager" NetworkManager
	newconfd "${FILESDIR}/conf.d.NetworkManager" NetworkManager

	# Need to keep the /etc/NetworkManager/dispatched.d for dispatcher scripts
	keepdir /etc/NetworkManager/dispatcher.d

	# Provide openrc net dependency only when nm is connected
	exeinto /etc/NetworkManager/dispatcher.d
	newexe "${FILESDIR}/10-openrc-status-r4" 10-openrc-status
	sed -e "s:@EPREFIX@:${EPREFIX}:g" \
		-i "${ED}/etc/NetworkManager/dispatcher.d/10-openrc-status" || die

	keepdir /etc/NetworkManager/system-connections
	chmod 0600 "${ED}"/etc/NetworkManager/system-connections/.keep* # bug #383765

	# Allow users in plugdev group to modify system connections
	#insinto /usr/share/polkit-1/rules.d/
	#doins "${FILESDIR}/01-org.freedesktop.NetworkManager.settings.modify.system.rules"
}
