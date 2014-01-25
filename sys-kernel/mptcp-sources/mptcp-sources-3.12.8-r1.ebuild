# Copyright 2013-2014 iXit Group
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="9"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

MPTCP_VER="trunk-fb5859f"
MPTCP_FILE="hybrid-sources-3.12-mptcp-${MPTCP_VER}.patch"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://multipath-tcp.org"
IUSE="deblob experimental"

DESCRIPTION="Full sources including the Gentoo patchset, Multipath support and Kernel DBUS support for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	http://download.ixit.cz/kernel/${MPTCP_FILE}"

src_prepare() {
	epatch "${DISTDIR}/${MPTCP_FILE}"
}

pkg_postinst() {
	ewarn ""
	ewarn "mptcp-sources are rebranded to hybrid-sources with mptcp USE flag"
	ewarn "PLEASE MIGRATE!!! mptcp-sources will be removed soon."
	ewarn ""
	kernel-2_pkg_postinst
	ewarn ""
	ewarn "mptcp-sources are rebranded to hybrid-sources with mptcp USE flag"
	ewarn "PLEASE MIGRATE!!! mptcp-sources will be removed soon."
	ewarn ""

}

pkg_postrm() {
	kernel-2_pkg_postrm
}
