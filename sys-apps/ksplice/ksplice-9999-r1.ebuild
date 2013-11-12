# Copyright 2013 iXit Group
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGIT_REPO_URI="https://github.com/jirislaby/${PN}.git"

inherit autotools git-r3

DESCRIPTION="Rebootless Linux kernel security updates"
HOMEPAGE="https://github.com/jirislaby/ksplice http://www.ksplice.com/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog || die "dodoc failed"
}
