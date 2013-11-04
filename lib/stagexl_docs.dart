library stagexl_docs;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'markdown.dart';

part 'docs/transitions.dart';
part 'docs/wiki.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;

void _init() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;

  var canvas = html.querySelector("#stage");
  if (canvas != null) {
    stage = new Stage('stage', canvas);
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);
    juggler = renderLoop.juggler;
    resourceManager = new ResourceManager();
  }
}

//-----------------------------------------------------------------------------

void mainTransitions() {
  _init();
  var transititionTypeDemo = new TransititionTypeDemo();
  var transitionDiv = transititionTypeDemo.getTransitionDiv();
  html.querySelector("#transitions").children.add(transitionDiv);
}

void mainWiki() {
  var wiki = new Wiki();
  wiki.updatePage();
}