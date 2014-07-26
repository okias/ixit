# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils games

SRC_URI="http://download.ixit.cz/distfiles/${P}.tar.xz
		sdl2? ( http://download.ixit.cz/${PN}-sdl2_20140712.patch )"
DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/ http://ixit.cz/dosbox-get-rid-of-sdl-1-2-switch-to-2-0/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug hardened opengl +sdl2"

DEPEND="alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/glu virtual/opengl )
	debug? ( sys-libs/ncurses )
	media-libs/libpng:0
	!sdl2? (
		media-libs/libsdl[joystick,video,X]
		media-libs/sdl-net
		media-libs/sdl-sound
	)
	sdl2? (
		media-libs/libsdl2[joystick,video,X]
		media-libs/sdl2-net
	)"

S=${WORKDIR}/${PN}

src_prepare() {
	use sdl2 && epatch "${DISTDIR}"/${PN}-sdl2_20140712.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa alsa-midi) \
		$(use_enable !hardened dynamic-core) \
		$(use_enable !hardened dynamic-x86) \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_with sdl2)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	make_desktop_entry dosbox DOSBox /usr/share/pixmaps/dosbox.ico
	doicon src/dosbox.ico
	prepgamesdirs
}
