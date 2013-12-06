OVERLAY="/var/lib/layman/ixit"
mkdir /tmp/updatehook


for cat in $OVERLAY/*
do
	CAT=$(sed -e "s/.*\///" <<< $cat)
	#CAT="$cat"
	for pkg in $cat/*
	do
		PKG=$(sed -e "s/.*\///" <<< $pkg)
		if ! [ -f ${OVERLAY}/${CAT}/${PKG}/.update.sh ]
		then
			continue
		fi

		cd /tmp/updatehook
		NEW_VERSION=`${OVERLAY}/${CAT}/${PKG}/.update.sh`
		echo "${CAT}/${PKG} Version information: $NEW_VERSION"
		rm /tmp/updatehook/*


		cd ${OVERLAY}/${CAT}/${PKG}
		if [ -f ${PKG}-${NEW_VERSION}*ebuild ]
		then
			echo "${CAT}/${PKG}: Nothing to do, up-to-date."
			continue
		fi

		echo "${CAT}/${PKG}: Updating ebuild to: $NEW_VERSION..."
		LAST_EBUILD=`ls | grep ^${PKG}- | grep -v 9999 | sort --version-sort -r | head -n1`
		echo "${CAT}/${PKG} Actual version: $LAST_EBUILD"
		cp $LAST_EBUILD ${PKG}-${NEW_VERSION}.ebuild
		repoman manifest && \
		emerge -v1 =${CAT}/${PKG}-${NEW_VERSION} && \
		git add . -A && \
		git commit -m "${CAT}/${PKG}: automated bump to version $NEW_VERSION" && \
		echo "${CAT}/${PKG}: Update successed. Please push changes!"
		done
done

rm -rf /tmp/updatehook

