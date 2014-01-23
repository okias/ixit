# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

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
