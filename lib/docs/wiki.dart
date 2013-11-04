part of stagexl_docs;

class NullTreeSanitizer implements html.NodeTreeSanitizer {
  void sanitizeTree(node) {}
}

class Wiki {

  html.DivElement _wikiIndex;
  html.DivElement _wikiContent;
  html.DivElement _wikiMarkdown;

  Wiki() {
    _wikiIndex = html.querySelector("#wikiIndex");
    _wikiContent = html.querySelector("#wikiContent");
    _wikiMarkdown = html.querySelector("#wikiMarkdown");
  }

  void updatePage() {
    final uriSearch = html.window.location.search;
    final paramMapping = getUriParams(uriSearch);

    _wikiIndex.style.display = "";
    _wikiContent.style.display = "none";

    if (paramMapping.containsKey("article")) {
      _wikiIndex.style.display = "none";
      _wikiContent.style.display = "";

      var article = paramMapping["article"];
      var url = "wiki/$article.md";
      html.HttpRequest.getString(url).then((markdown) {

        var htmlText = markdownToHtml(markdown);
        _wikiMarkdown.setInnerHtml(htmlText, treeSanitizer: new NullTreeSanitizer());

        var preElements = html.querySelectorAll("pre");
        preElements.forEach((e) => e.classes.add("prettyprint"));

        var scriptElement = new html.ScriptElement();
        scriptElement.src = "../assets/prettify/run_prettify.js?lang=dart";
        html.document.body.append(scriptElement);
      });
    }
  }

  Map<String, String> getUriParams(String uriSearch) {

    var paramMapping = new Map<String, String>();

    if (uriSearch != '') {
      final List<String> paramValuePairs = uriSearch.substring(1).split('&');
      paramValuePairs.forEach((e) {
        if (e.contains('=')) {
          final paramValue = e.split('=');
          paramMapping[paramValue[0]] = paramValue[1];
        } else {
          paramMapping[e] = '';
        }
      });
    }

    return paramMapping;
  }

}