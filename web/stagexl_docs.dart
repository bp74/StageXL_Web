library stagexl_docs;

import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'src/docs/transitions.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;

void main() {
  
  BitmapData.defaultLoadOptions.webp = true;
    
  var pathname  = html.window.location.pathname;
  var regexp = new RegExp(r"([A-Za-z0-9-]+)\.html", multiLine:false, caseSensitive:false);
  var match = regexp.firstMatch(pathname);
  
  if (match != null && match.groupCount == 1) {

    var page = match.group(1);
    print("current page: $page");
    
    var canvas = html.query("#stage");
    
    if (canvas != null) {
      stage = new Stage('stage', canvas);
      renderLoop = new RenderLoop();
      renderLoop.addStage(stage);
      juggler = renderLoop.juggler;
      resourceManager = new ResourceManager();
    }
    
    switch(page) {
      
      case "transitions":
        var transititionTypeDemo = new TransititionTypeDemo();
        var transitionDiv = transititionTypeDemo.getTransitionDiv();
        html.query("#transitions").children.add(transitionDiv);
        break;
    }
  }
}