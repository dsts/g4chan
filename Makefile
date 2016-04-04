name := g4chan
curr_dir := $(shell pwd)

chrome_build_dir := /tmp/g4chan-chrome-build
firefox_build_dir := /tmp/g4chan-firefox-build

common_extension_dir := common
chrome_extension_dir := chrome
firefox_extension_dir := firefox

chrome_browser := chromium
chrome_key := $(wildcard g4chan.pem)

firefox_browser := firefox

.PHONY: all g4chan.xpi g4chan.crx

all: g4chan.xpi g4chan.crx

g4chan.xpi: $(firefox_build_dir)
	rm -rf $(firefox_build_dir)/*
	mkdir $(firefox_build_dir)/data
	cp $(common_extension_dir)/insert_css.js $(firefox_build_dir)/data
	cp $(firefox_extension_dir)/package.json $(firefox_build_dir)
	cp $(firefox_extension_dir)/index.js $(firefox_build_dir)
	cd $(firefox_build_dir) && jpm xpi
	mv $(firefox_build_dir)/\@g4chan* $@

g4chan.crx: $(chrome_build_dir)
	rm -rf $(chrome_build_dir)/*
	mkdir $(chrome_build_dir)/g4chan
	cp $(common_extension_dir)/insert_css.js $(chrome_build_dir)/g4chan
	cp $(chrome_extension_dir)/manifest.json $(chrome_build_dir)/g4chan
	"$(chrome_browser)" --pack-extension=$(chrome_build_dir)/g4chan --pack-extension-key=$(chrome_key)
	mv $(chrome_build_dir)/g4chan.crx $@

$(firefox_build_dir):
	mkdir -p $@

$(chrome_build_dir):
	mkdir -p $@
