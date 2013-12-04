# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3

DESCRIPTION="Fedora initscripts."
HOMEPAGE="https://fedorahosted.org/initscripts/"
EGIT_REPO_URI="https://git.fedorahosted.org/git/initscripts.git"
LICENSE="GPLv2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
"

src_prepare() {
	sed -i "1 s/python/python2/" po/xgettext_sh.py
	sed -i 's|\$(ROOT)|$(DESTDIR)/$(ROOT)|g' Makefile
}

src_install() {
	default
	rm ${D}/var/log/wtmp
	rm ${D}/var/run/utmp
	rm ${D}/usr/share/man/man8/service.8
}
