VERSION=$(cat cmd/dotd/main.go | grep "versionString :=" | cut -d '"' -f 2)

rm -rf dist

GOOS=darwin GOARCH=amd64 go build -x -o dist/dotd-darwin-amd64/dotd cmd/dotd/main.go
GOOS=linux GOARCH=amd64 go build -x -o dist/dotd-linux-amd64/dotd cmd/dotd/main.go
GOOS=linux GOARCH=arm64 go build -x -o dist/dotd-linux-arm64/dotd cmd/dotd/main.go
GOOS=windows GOARCH=amd64 go build -x -o dist/dotd-windows-amd64/dotd.exe cmd/dotd/main.go

(cd dist/dotd-darwin-amd64 && tar -cvzf ../dotd-$VERSION-darwin-amd64.tar.gz . ../../LICENSE)
(cd dist/dotd-linux-amd64 && tar -cvzf ../dotd-$VERSION-linux-amd64.tar.gz . ../../LICENSE)
(cd dist/dotd-linux-arm64 && tar -cvzf ../dotd-$VERSION-linux-arm64.tar.gz . ../../LICENSE)
(cd dist/dotd-windows-amd64 && tar -cvzf ../dotd-$VERSION-windows-amd64.tar.gz . ../../LICENSE)

(cd dist && shasum -a 256 *.tar.gz > checksums.txt)
