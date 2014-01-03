# Copyright 2013 iXit Group
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="7"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

MPTCP_VER="trunk-93a1832"
KDBUS_VER="26798ce"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://multipath-tcp.org"
IUSE="deblob experimental -kdbus"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-3.12-mptcp-${MPTCP_VER}.patch"
	use kdbus && epatch "${FILESDIR}/${PN}-3.12-kdbus-${KDBUS_VER}.patch"
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
