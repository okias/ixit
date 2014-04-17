# Copyright 2014 David Heidelberger <david.heidelberger@ixit.cz>
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit kde4-base

DESCRIPTION="Translator plasmoid using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

SRC_URI="http://download.ixit.cz/translatoid/${P}-noremember.tar.xz"

DEPEND="
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${PN}"
