import 'dart:html';
import '../lib/stagexl_runtimes.dart';

void main() {

  var pathname  = window.location.pathname;
  var regexp = new RegExp(r"([A-Za-z0-9-_]+)\.html", multiLine:false, caseSensitive:false);
  var match = regexp.firstMatch(pathname);

  if (match != null && match.groupCount == 1) {

    var page = match.group(1);
    print("current page: $page");

    switch(page) {
      case 'flump': mainFlump(); break;
      case 'texture_packer': mainTexturePacker(); break;
      case 'particle_emitter': mainParticleEmitter(); break;
    }
  }
}