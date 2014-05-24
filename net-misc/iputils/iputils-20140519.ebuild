# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic eutils toolchain-funcs fcaps
SRC_URI="https://www.github.com/${PN}/${PN}/archive/s${PV}.tar.gz -> ${P}.tar.gz
		mirror://gentoo/iputils-s20121221-manpages.tar.bz2"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux"

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="https://github.com/iputils/iputils/"

LICENSE="BSD-4"
SLOT="0"
IUSE="caps doc gnutls idn ipv6 SECURITY_HAZARD ssl static"

LIB_DEPEND="caps? ( sys-libs/libcap[static-libs(+)] )
	idn? ( net-dns/libidn[static-libs(+)] )
	ipv6? (
		ssl? (
			gnutls? ( net-libs/gnutls[static-libs(+)] )
			!gnutls? ( dev-libs/openssl:0[static-libs(+)] )
		)
	)"
RDEPEND="!net-misc/rarpd
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	virtual/os-headers"

S=${WORKDIR}/${PN}-s${PV}

src_prepare() {
	# epatch "${FILESDIR}"/${PN}-20121221-printf-size.patch
	# epatch "${FILESDIR}"/${PN}-20121221-owl-pingsock.diff # TODO, does anyone seen this work?
	use SECURITY_HAZARD && epatch "${FILESDIR}"/${PN}-20071127-nonroot-floodping.patch
	use static && append-ldflags -static

	mv "${WORKDIR}"/${PN}-s20121221/doc/* "${S}"/doc/ || die
}

src_compile() {
	emake \
		USE_CAP=$(usex caps) \
		USE_IDN=$(usex idn) \
		USE_GNUTLS=$(usex gnutls) \
		USE_CRYPTO=$(usex ssl) \
		$(use ipv6 || echo IPV6_TARGETS=)
}

ipv6() { usex ipv6 "$*" '' ; }

src_install() {
	into /
	dobin arping ping $(ipv6 ping6)
	into /usr
	dobin clockdiff
	dosbin rarpd rdisc ipg tftpd tracepath $(ipv6 tracepath6)

	dodoc INSTALL RELNOTES
	use ipv6 \
		&& dosym ping.8 /usr/share/man/man8/ping6.8 \
		|| rm -f doc/*6.8
	rm -f doc/{setkey,traceroute6}.8
	doman doc/*.8

	use doc && dohtml doc/*.html
}

pkg_postinst() {
	fcaps cap_net_raw \
		bin/{ar,}ping \
		$(ipv6 bin/ping6) \
		usr/bin/clockdiff
}
