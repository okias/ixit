wget http://wiresharkdownloads.riverbed.com/wireshark/src/
xml sel -t -v "/_:html/_:body/_:div/_:table/_:tbody/_:tr/_:td/_:a" index.html | grep "^wireshark-" | sed -e "s/^wireshark-//" -e "s/.tar.bz2$//" | sort --version-sort -r | head -n1

