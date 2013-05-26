# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/kparal/${PN}.git"
	GIT_ECLASS="git-2"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/kparal/esmska/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg-2 java-ant-2  $GIT_ECLASS

DESCRIPTION="Send SMS over the Internet"
HOMEPAGE="https://code.google.com/p/esmska/"

LICENSE="AGPL-3"
SLOT="0"

RDEPEND="
	>=virtual/jre-1.7
	"
DEPEND="
	>=virtual/jdk-1.7
	"

src_install() {
	local prefix="/usr/share/${PN}"

	insinto ${prefix}
	doins "dist/${PN}.jar"

	for item in lib gateways; do
		insinto ${prefix}/${item}
		doins dist/${item}/*
	done

	dobin "${FILESDIR}/${PN}"
	doicon "dist/icons/"
	domenu "resources/${PN}.desktop"
}
