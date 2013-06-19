# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE="gles2"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=,gles2=,opengl]
	~dev-qt/qtwidgets-${PV}[debug=]
	virtual/opengl
	gles2? ( media-libs/mesa[egl] )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/opengl
)
pkg_setup() {
	if use gles2; then
		QCONFIG_ADD+="egl opengles2"
		QCONFIG_DEFINE+="EGL QT_OPENGLES2"
	else
		QCONFIG_ADD+="opengl"
		QCONFIG_DEFINE+="QT_OPENGL"
	fi
}

src_configure() {
	local myconf=(
		-egl
		-opengl $(use gles2 && echo es2)
	)
	qt5-build_src_configure
}
