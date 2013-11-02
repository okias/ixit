# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

MPTCP_VER="0.88.0-bfeb908-experimental312"

KEYWORDS=""
HOMEPAGE="http://multipath-tcp.org"
IUSE=""

DESCRIPTION="Full sources without the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree with MPTCP"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-3.12_rc7-mptcp-${MPTCP_VER}.patch"
}

pkg_postinst() {
	ewarn ""
	ewarn "Patch a top of ${KV_MAJOR}.12 is not officially supported! BEWARE!"
	ewarn ""
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
