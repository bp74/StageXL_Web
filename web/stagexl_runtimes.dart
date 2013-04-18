library stagexl_runtimes;

import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'src/runtimes/flump.dart';
part 'src/runtimes/texturepacker.dart';

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

      case "flump":
        resourceManager
          ..addFlumpLibrary('flump', 'images/flumpLibrary.json')
          ..load().then((_) => stage.addChild(new FlumpDemo()));
        break;

      case "texturepacker":
        resourceManager
          ..addTextureAtlas('levelUp', 'images/LevelupTextureAtlas.json', TextureAtlasFormat.JSONARRAY)
          ..load().then((_) => stage.addChild(new TexturePackerDemo()));
        break;
    }
  }
}