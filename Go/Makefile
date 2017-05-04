# GOARCH= amd64 386 arm
# GOOS= linus darwin windows
# GOARM=5 (for RaspPi)

run:
	go run mandelp.go

linux:
	go build -v mandelp.go

raspi:
	GOARCH=arm GOARM=7 go build -v mandelp.go

win:
	GOOS=windows go build -v mandelp.go

#go get -u github.com/gopherjs/gopherjs

run-js:
	gopherjs run mandelp.go

js:
	gopherjs build -m mandelp.go
