# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Command line interface for running a full Ethereum node"
HOMEPAGE="https://www.ethereum.org/"
SRC_URI="https://github.com/ethereum/go-ethereum/archive/v${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="dev-lang/go"

S="${WORKDIR}/go-ethereum-${PV}"

src_compile() {
	emake geth
}

src_install() {
	dobin build/bin/geth
	dodoc README.md AUTHORS
}
