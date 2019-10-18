package main

import (
	"flag"
	"fmt"
	"github.com/adnsio/dotd"
	"os"
)

var (
	addr     string
	upstream string
	logs     bool
	version  bool
)

func init() {
	flag.StringVar(&addr, "address", "[::]:53", "udp address")
	flag.StringVar(&upstream, "upstream", "https://1.1.1.1/dns-query", "upstream dns server")
	flag.BoolVar(&logs, "logs", false, "enable logs")
	flag.BoolVar(&version, "version", false, "output version")
}

func main() {
	versionString := "1.1.0"
	appString := fmt.Sprintf("dotd %s", versionString)

	flag.Usage = func() {
		fmt.Fprintf(flag.CommandLine.Output(), "%s\n\nUsage: dotd [options]\n", appString)
		flag.PrintDefaults()
	}

	flag.Parse()

	if version {
		fmt.Fprintf(flag.CommandLine.Output(), "%s\n", appString)
		os.Exit(2)
	}

	fmt.Printf("%s\n", appString)

	srv := dotd.New(&dotd.Config{
		Addr:     addr,
		Upstream: upstream,
		Logs:     logs,
	})

	srv.Listen()
}
