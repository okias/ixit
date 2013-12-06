wget https://code.google.com/p/esmska/
grep "downloads/detail?name=esmska-.*.tar.gz" index.html | sed -e "s/.*name=esmska-//" -e "s/.tar.gz\"$//"
