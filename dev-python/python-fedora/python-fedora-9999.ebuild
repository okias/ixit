# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
[ "${PV}" = 9999 ] && inherit bzr

DESCRIPTION="Python modules for talking to Fedora Infrastructure Services"
HOMEPAGE="https://fedorahosted.org/python-fedora/"
EBZR_REPO_URI="bzr://bzr.fedorahosted.org/bzr/${PN}/devel"
[ "${PV}" = 9999 ] || SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	dev-python/python-bugzilla
	dev-python/bunch
	dev-python/cherrypy
	dev-python/decorator
	dev-python/feedparser
	dev-python/kitchen
	dev-python/mako
	dev-python/pycurl
	dev-python/repoze-who-friendlyform
	dev-python/simplejson
	dev-python/sqlalchemy
"
DEPEND="
	${COMMON_DEPEND}
	dev-python/Babel
	dev-python/nose
	dev-python/paver
	dev-python/setuptools
	dev-python/sphinx
"
RDEPEND="
	${COMMON_DEPEND}
"
