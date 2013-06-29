library stagexl_docs;

import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'docs/transitions.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;

void _init() {
  BitmapData.defaultLoadOptions.webp = true;
  var canvas = html.query("#stage");
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
  html.query("#transitions").children.add(transitionDiv);
}