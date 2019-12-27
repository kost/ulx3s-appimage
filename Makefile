VERSION=$(shell date '+%Y.%m.%d')
ulx3s_url=https://github.com/alpin3/ulx3s/releases/download/v2019.12.26/ulx3s-2019.12.26-linux-x86_64.tar.gz

untar:
	cd ulx3s.AppDir/usr && curl $(ulx3s_url) | tar -xvz --strip-components=1 -f -

appimage:
	make-static-appimage ulx3s.AppDir ulx3s-$(VERSION)-x86_64.AppImage

dep:
	# go get -u ./...
	# go get
	go get -u github.com/kost/static-appimage/...

tools:
	go get github.com/mitchellh/gox
	get github.com/tcnksm/ghr

ver:
	echo version $(VERSION)

gittag:
	git tag v$(VERSION)
	git push --tags origin master

clean:
	rm -rf dist

dist:
	mkdir -p dist

gox:
	CGO_ENABLED=0 gox -ldflags="-s -w" -output="dist/{{.Dir}}_{{.OS}}_{{.Arch}}"

draft:
	ghr -draft v$(VERSION) dist/


