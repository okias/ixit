# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/kparal/${PN}.git"
	GIT_ECLASS="git-r3"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/kparal/esmska/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg-2 java-ant-2 ${GIT_ECLASS}

DESCRIPTION="Send SMS over the Internet"
HOMEPAGE="https://code.google.com/p/esmska/"

LICENSE="AGPL-3"
SLOT="0"

CDEPEND="dev-java/beansbinding:0
	dev-java/commons-beanutils:1.7
	dev-java/commons-cli:1
	dev-java/commons-codec:0
	dev-java/commons-collections:0
	dev-java/commons-httpclient:3
	dev-java/commons-io:1
	dev-java/commons-lang:2.1
	dev-java/commons-logging:0
	dev-java/jgoodies-looks:2.0
	dev-java/netbeans-platform:7.4"

DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"

java_prepare() {
	# We can't use bundled libraries.
	rm -v lib/*.jar || die

	rm -v lib/beans-binding/beansbinding-1.2.1.jar
	java-pkg_jar-from beansbinding{,.jar} lib/beans-binding/beansbinding-1.2.1.jar
	rm -v lib/commons-beanutils/commons-beanutils-1.8.3.jar
	java-pkg_jar-from commons-beanutils{-1.7,.jar} lib/commons-beanutils/commons-beanutils-1.8.3.jar
	rm -v lib/commons-cli/commons-cli-1.2.jar
	java-pkg_jar-from commons-cli{-1,.jar} lib/commons-cli/commons-cli-1.2.jar
	rm -v lib/commons-codec/commons-codec-1.3.jar
	java-pkg_jar-from commons-codec{,.jar} lib/commons-codec/commons-codec-1.3.jar
	rm -v lib/commons-collections/commons-collections-3.2.1.jar
	java-pkg_jar-from commons-collections{,.jar} lib/commons-collections/commons-collections-3.2.1.jar
	rm -v lib/commons-httpclient/commons-httpclient-3.1.jar
	java-pkg_jar-from commons-httpclient{-3,.jar} lib/commons-httpclient/commons-httpclient-3.1.jar
	rm -v lib/commons-io/commons-io-1.4.jar
	java-pkg_jar-from commons-io{-1,.jar} lib/commons-io/commons-io-1.4.jar
	rm -v lib/commons-lang/commons-lang-2.6.jar
	java-pkg_jar-from commons-lang{-2.1,.jar} lib/commons-lang/commons-lang-2.6.jar
	rm -v lib/commons-logging/commons-logging-1.1.1.jar
	java-pkg_jar-from commons-logging{,.jar} lib/commons-logging/commons-logging-1.1.1.jar
	rm -v lib/JGoodies-Looks/looks-2.1.4.jar
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar lib/JGoodies-Looks/looks-2.1.4.jar
	#rm -v lib/openide-l10n/org-openide-awt.jar
	#java-pkg_jar-from netbeans-platform-7.4 org-openide-awt.jar lib/openide-l10n/org-openide-awt.jar
	rm -v lib/openide-l10n/org-openide-util.jar
	java-pkg_jar-from netbeans-platform-7.4 org-openide-util.jar lib/openide-l10n/org-openide-util.jar

	#echo "rest of it"
	#rm -v lib/*/*.jar || die

}

src_install() {
	local prefix="/usr/share/${PN}"

	#workaround esmska.jar can't run in lib
	#java-pkg_dojar "dist/${PN}.jar"
	insinto ${prefix}
	doins "dist/${PN}.jar"

	for item in lib gateways; do
		insinto ${prefix}/${item}
		doins dist/${item}/*
	done

	#workaround
	#java-pkg_dolauncher
	dobin "${FILESDIR}/${PN}"
	doicon "dist/icons/"
	domenu "resources/${PN}.desktop"
}
