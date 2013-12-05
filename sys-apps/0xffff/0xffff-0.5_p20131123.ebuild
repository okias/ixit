# Copyright 2013 iXit Group
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="The 0pen Free Fiasco Firmware Flasher"
HOMEPAGE="http://nopcode.org/0xFFFF/"
REV="c6ee6a8e682078e1ab0aac9d57f2ab869dada0e1"
SRC_URI="https://gitorious.org/${PN}/${PN}/archive/${REV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PN}"
