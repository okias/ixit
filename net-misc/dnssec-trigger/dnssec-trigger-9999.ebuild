# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils subversion

DESCRIPTION="A tool to configure unbound with usable DNSSEC servers."
HOMEPAGE="http://www.nlnetlabs.nl/projects/dnssec-trigger/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	net-libs/ldns
	media-libs/harfbuzz
"
RDEPEND="${DEPEND}"

ESVN_REPO_URI="http://www.nlnetlabs.nl/svn/${PN}/trunk"

src_prepare() {
	default

	mv contrib/01-dnssec-trigger-hook-new_nm 01-dnssec-trigger-hook.sh.in
	sed -i 's|/usr/sbin/pidof|/bin/pidof|' 01-dnssec-trigger-hook.sh.in
}

src_install() {
	default

	dodir /var/run/dnssec-trigger
	keepdir /var/run/dnssec-trigger
}
