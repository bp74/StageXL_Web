library stagexl_docs;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'markdown.dart';

part 'docs/transitions.dart';
part 'docs/wiki.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

var canvas = html.querySelector("#stage");
var stage= (canvas != null) ? new Stage(canvas, webGL: true) : null;
var renderLoop = new RenderLoop();
var resourceManager = new ResourceManager();

void mainTransitions() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;

  var transititionTypeDemo = new TransititionTypeDemo();
  var transitionDiv = transititionTypeDemo.getTransitionDiv();
  html.querySelector("#transitions").children.add(transitionDiv);
}

void mainWiki() {
  var wiki = new Wiki();
  wiki.updatePage();
}