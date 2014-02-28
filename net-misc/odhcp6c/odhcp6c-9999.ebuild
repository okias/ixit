# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="DHCP server for the OpenWRT project."
HOMEPAGE="https://github.com/sbyx/odhcp6c"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	sys-apps/uci
"

src_prepare() {
	sed -i 's/-Werror //' CMakeLists.txt
	sed -i 's/O_CREAT)/O_CREAT, 0644)/' src/odhcp6c.c || die
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	install -d "${D}/etc/config"
	touch "${D}/etc/config/dhcp"
}
