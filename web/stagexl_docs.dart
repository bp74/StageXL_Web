import 'dart:html';
import '../lib/stagexl_docs.dart';

void main() {

  var pathname  = window.location.pathname;
  var regexp = new RegExp(r"([A-Za-z0-9-_]+)\.html", multiLine:false, caseSensitive:false);
  var match = regexp.firstMatch(pathname);

  if (match != null && match.groupCount == 1) {

    var page = match.group(1);
    print("current page: $page");

    switch(page) {
      case 'transitions': mainTransitions(); break;
      case 'wiki-articles': mainWiki(); break;
    }
  }
}
