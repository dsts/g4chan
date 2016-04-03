var self = require("sdk/self");
var pageMod = require("sdk/page-mod");

pageMod.PageMod({
  include: "https://boards.4chan.org/*",
  contentScriptWhen: "ready",
  contentScriptFile: self.data.url("insert_css.js")
});
