(new MutationObserver(observe)).observe(document.documentElement, {
  childList: true
});

function observe(mutations) {
  for (var i = 0, l = mutations.length; i < l; ++i) {
    var mutation = mutations[i];

    if (isInteresting(mutation)) {
      if (takeAction(mutation)) {
        this.disconnect();
        break;
      }
    }
  }

  function isInteresting(mutation) {
    return mutation.type == "childList" && mutation.addedNodes.length;
  }

  function takeAction(mutation) {
    for (var i = 0, l = mutation.addedNodes.length; i < l; ++i) {
      var node = mutation.addedNodes[i];

      if (node.nodeType === document.ELEMENT_NODE && node.nodeName == "HEAD") {
        inject();
        return true;
      }
    }

    return false;
  }
}

function inject() {
  // Note: The number 651 is supposedly a version number. This might change and
  // thus break this script in the future. It will be necessary to retrieve the
  // value of the variable cssVersion that is defined in a script tag and use
  // it to generate the URL.
  var aprilFoolsStyleSheetUrl = "https://s.4cdn.org/css/md2016.651.css";

  var link = document.createElement('link');
  link.setAttribute("rel", "stylesheet");
  link.setAttribute("type", "text/css");
  link.setAttribute("href", aprilFoolsStyleSheetUrl);

  document.head.appendChild(link);
}
