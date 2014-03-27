# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit cmake-multilib eutils python-single-r1 vcs-snapshot

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
REV="485846b2a40d8ac7d6c1c5f8af6d15b0c10af19d"
SRC_URI="https://github.com/${PN}/${PN}/archive/${REV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli egl qt4"

RDEPEND="app-arch/snappy[${MULTILIB_USEDEP}]
	media-libs/libpng:0=
	sys-libs/zlib
	sys-process/procps[${MULTILIB_USEDEP}]
	media-libs/mesa[egl?]
	egl? ( || (
		>=media-libs/mesa-8.0[gles1,gles2]
		<media-libs/mesa-8.0[gles]
	) )
	x11-libs/libX11[${MULTILIB_USEDEP}]
	qt4? (
		>=dev-qt/qtcore-4.7:4
		>=dev-qt/qtgui-4.7:4
		>=dev-qt/qtwebkit-4.7:4
		>=dev-libs/qjson-0.5
	)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${REV}" # this shouldn't be here. We have vcs-snapshot

PATCHES=(
	"${FILESDIR}"/${PN}-4.0-system-libs.patch
	"${FILESDIR}"/${PN}-4.0-glxtrace-only.patch
	"${FILESDIR}"/${PN}-4.0-cmake-snappy.patch
)

src_configure() {
	my_configure() {
		mycmakeargs=(
			$(cmake-utils_use_enable egl EGL)
		)
		if multilib_build_binaries ; then
			mycmakeargs+=(
				$(cmake-utils_use_enable cli CLI)
				$(cmake-utils_use_enable qt4 GUI)
			)
		else
			mycmakeargs+=(
				-DBUILD_LIB_ONLY=ON
				-DENABLE_CLI=OFF
				-DENABLE_GUI=OFF
			)
		fi
	cmake-utils_src_configure
	}

	multilib_parallel_foreach_abi my_configure
}

src_compile() {
	cmake-multilib_src_compile
}

src_install() {
	cmake-multilib_src_install

	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2

	dodoc {BUGS,DEVELOPMENT,NEWS,README,TODO}.markdown

	exeinto /usr/$(get_libdir)/${PN}/scripts
	doexe $(find scripts -type f -executable)

}
