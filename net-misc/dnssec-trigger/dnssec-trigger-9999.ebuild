# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils subversion systemd

DESCRIPTION="A tool to configure unbound with usable DNSSEC servers."
HOMEPAGE="http://www.nlnetlabs.nl/projects/dnssec-trigger/"
ESVN_REPO_URI="http://www.nlnetlabs.nl/svn/${PN}/trunk"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	net-libs/ldns
	media-libs/harfbuzz
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/systemd2openrc
"
RDEPEND="
	${COMMON_DEPEND}
	net-dns/unbound
"

src_prepare() {
	default

	mv contrib/01-dnssec-trigger-hook-new_nm 01-dnssec-trigger-hook.sh.in
	sed -i 's|/usr/sbin/pidof|/bin/pidof|' 01-dnssec-trigger-hook.sh.in
}

src_compile() {
	default

	systemd2openrc fedora/dnssec-triggerd.service --pidfile /etc/dnssec-trigger.pid > dnssec-triggerd.openrc
	systemd2openrc fedora/dnssec-triggerd-keygen > dnssec-triggerd.openrc
	systemd2openrc dnssec-triggerd-resolvconf-handle > dnssec-triggerd.openrc
}

src_install() {
	default

	dodir /var/run/dnssec-trigger
	keepdir /var/run/dnssec-trigger

	for name in dnssec-triggerd dnssec-triggerd-keygen dnssec-triggerd-resolvconf-handle; do
		systemd_dounit fedora/${name}.service
		newinitd ${name}.openrc ${name}
	done
}
