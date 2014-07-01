# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-multilib git-r3

MY_P=${PN}-soft-${PV}

DESCRIPTION="A software implementation of the OpenAL 3D audio API"
HOMEPAGE="http://kcat.strangesoft.net/openal.html"
EGIT_REPO_URI="git://repo.or.cz/openal-soft.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa coreaudio debug neon oss portaudio pulseaudio sse sse2 sse4 wave"

RDEPEND="alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )
	portaudio? ( >=media-libs/portaudio-19_pre[${MULTILIB_USEDEP}] )
	pulseaudio? ( media-sound/pulseaudio[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!<app-emulation/emul-linux-x86-sdl-20131008-r1
		!app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )"

#S=${WORKDIR}/${MY_P}

DOCS="alsoftrc.sample env-vars.txt hrtf.txt README"

src_configure() {
	# -DEXAMPLES=OFF to avoid FFmpeg dependency wrt #481670
	my_configure() {
		local mycmakeargs=(
			$(cmake-utils_use alsa ALSOFT_BACKEND_ALSA)
			$(cmake-utils_use alsa ALSOFT_REQUIRE_ALSA)
			$(cmake-utils_use coreaudio ALSOFT_BACKEND_COREAUDIO)
			$(cmake-utils_use coreaudio ALSOFT_REQUIRE_COREAUDIO)
			$(cmake-utils_use neon ALSOFT_CPUEXT_NEON)
			$(cmake-utils_use neon ALSOFT_REQUIRE_NEON)
			$(cmake-utils_use oss ALSOFT_BACKEND_OSS)
			$(cmake-utils_use oss ALSOFT_REQUIRE_OSS)
			$(cmake-utils_use portaudio ALSOFT_BACKEND_PORTAUDIO)
			$(cmake-utils_use portaudio ALSOFT_REQUIRE_PORTAUDIO)
			$(cmake-utils_use pulseaudio ALSOFT_BACKEND_PULSEAUDIO)
			$(cmake-utils_use pulseaudio ALSOFT_REQUIRE_PULSEAUDIO)
			$(cmake-utils_use sse ALSOFT_CPUEXT_SSE)
			$(cmake-utils_use sse ALSOFT_REQUIRE_SSE)
			$(cmake-utils_use sse2 ALSOFT_CPUEXT_SSE2)
			$(cmake-utils_use sse2 ALSOFT_REQUIRE_SSE2)
			$(cmake-utils_use sse4 ALSOFT_CPUEXT_SSE4_1)
			$(cmake-utils_use sse4 ALSOFT_REQUIRE_SSE4_1)
			$(cmake-utils_use wave ALSOFT_BACKEND_WAVE)
			$(cmake-utils_use wave ALSOFT_REQUIRE_WAVE)
			-DALSOFT_EXAMPLES=OFF
			-DALSOFT_NO_CONFIG_UTIL=ON
		)

		cmake-utils_src_configure
	}

	multilib_parallel_foreach_abi my_configure
}
