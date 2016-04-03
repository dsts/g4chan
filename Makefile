name=g4chan

chrome_extension_dir=chrome

chrome_browser=chromium
chrome_key=g4chan.pem

g4chan.crx: 
	"$(chrome_browser)" --pack-extension="$(chrome_extension_dir)" --pack-extension-key="$(chrome_key)"
	mv chrome.crx $@
