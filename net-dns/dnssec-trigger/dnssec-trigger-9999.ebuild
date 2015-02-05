# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils subversion systemd

DESCRIPTION="A tool to configure unbound with usable DNSSEC servers."
HOMEPAGE="http://www.nlnetlabs.nl/projects/dnssec-trigger/"
ESVN_REPO_URI="http://www.nlnetlabs.nl/svn/${PN}/trunk"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+openrc +networkmanager"

COMMON_DEPEND="
	net-libs/ldns
	media-libs/harfbuzz
"
DEPEND="
	${COMMON_DEPEND}
	openrc? ( dev-util/systemd2rc )
"
RDEPEND="
	${COMMON_DEPEND}
	net-dns/unbound
"

src_configure() {
	econf \
		--with-keydir=/etc/dnssec-trigger \
		--with-hooks=$(usex networkmanager networkmanager none)
}

src_compile() {
	default

	# Build OpenRC initscripts
	if use openrc; then
		mkdir openrc || die
		systemd2rc dnssec-triggerd.service > openrc/dnssec-triggerd || die
		systemd2rc dnssec-triggerd-keygen.service > openrc/dnssec-triggerd-keygen || die
	fi
}

src_install() {
	default

	# Instal OpenRC initscripts
	if [ -d openrc ]; then
		for i in openrc/*; do
			doinitd $i || die
		done
	fi
}
