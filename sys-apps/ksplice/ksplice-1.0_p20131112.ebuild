# Copyright 2013 iXit Group
# Distributed under the terms of the GNU General Public License v2

EAPI=5

REV="d2f0a159f4528cf932b7a276e38c9cfddc1281c4"
if [[ ${PV} == "9999*" ]]; then
	EGIT_REPO_URI="https://github.com/jirislaby/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/jirislaby/${PN}/archive/${REV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${REV}"
fi

DESCRIPTION="Rebootless Linux kernel security updates"
HOMEPAGE="https://github.com/jirislaby/ksplice http://www.ksplice.com/"

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
