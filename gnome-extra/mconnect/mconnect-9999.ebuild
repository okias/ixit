EAPI=6

EGIT_REPO_URI="https://github.com/bboozzoo/mconnect.git"

inherit meson git-r3

KEYWORDS="~amd64"
SLOT="0"

src_configure() {
        meson_src_configure
}
