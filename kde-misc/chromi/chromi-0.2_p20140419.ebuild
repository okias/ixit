# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit kde4-base

REV="b24cc0217f8294256d2543acbde79a0a26d14602"

DESCRIPTION="Titlebar-less decoration inspired by Google Chrome and Nitrogen minimal mod"
HOMEPAGE="http://kde-look.org/content/show.php/Chromi?content=119069"
SRC_URI="https://github.com/okias/kwin-deco-chromi/archive/${REV}.zip -> ${P}.zip"

SLOT="4"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/kwin-deco-${PN}-${REV}"

DEPEND="
	$(add_kdebase_dep kwin)
"
RDEPEND="${DEPEND}"
