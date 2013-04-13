library stagexl_web;

import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'src/demos/filter.dart';
part 'src/demos/masking.dart';
part 'src/demos/movieclip.dart';
part 'src/demos/performance.dart';
part 'src/demos/sound.dart';
part 'src/demos/text.dart';
part 'src/demos/tweener.dart';

part 'src/runtimes/flump.dart';
part 'src/runtimes/texturepacker.dart';

part 'src/docs/transitions.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;

void main() {
  
  BitmapData.defaultLoadOptions = new BitmapDataLoadOptions(png:true, jpg:true, webp:true);
    
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
      
      case "filter":
        resourceManager
          ..addBitmapData('king', 'images/king.png')
          ..load().then((_) => stage.addChild(new FilterDemo())); 
        break;
        
      case "masking": 
        resourceManager
          ..addBitmapData('flower1', 'images/Flower1.png')
          ..addBitmapData('flower2', 'images/Flower2.png')
          ..addBitmapData('flower3', 'images/Flower3.png') 
          ..load().then((_) => stage.addChild(new MaskingDemo())); 
        break;
      
      case "flipbook": 
        resourceManager
          ..addTextureAtlas('walkTextureAtlas', 'images/walk.json', TextureAtlasFormat.JSONARRAY)
          ..load().then((_) => stage.addChild(new FlipBookDemo()));
        break;
        
      case "performance":
        resourceManager
          ..addTextureAtlas('flags', 'images/flags.json', TextureAtlasFormat.JSONARRAY)
          ..load().then((_) => stage.addChild(new PerformanceDemo())); 
        break;
        
      case "sound": 
        resourceManager
          ..addBitmapData('KeyBlack','images/piano/KeyBlack.png')
          ..addBitmapData('KeyWhite0','images/piano/KeyWhite0.png')
          ..addBitmapData('KeyWhite1','images/piano/KeyWhite1.png')
          ..addBitmapData('KeyWhite2','images/piano/KeyWhite2.png')
          ..addBitmapData('KeyWhite3','images/piano/KeyWhite3.png')
          ..addBitmapData('Finger','images/piano/Finger.png')
          ..addBitmapData('Background','images/piano/Background.jpg')
          ..addSound('Cheer','sounds/Cheer.mp3')
          ..addSound('Note1','sounds/piano/Note1.mp3')
          ..addSound('Note2','sounds/piano/Note2.mp3')
          ..addSound('Note3','sounds/piano/Note3.mp3')
          ..addSound('Note4','sounds/piano/Note4.mp3')
          ..addSound('Note5','sounds/piano/Note5.mp3')
          ..addSound('Note6','sounds/piano/Note6.mp3')
          ..addSound('Note7','sounds/piano/Note7.mp3')
          ..addSound('Note8','sounds/piano/Note8.mp3')
          ..addSound('Note9','sounds/piano/Note9.mp3')
          ..addSound('Note10','sounds/piano/Note10.mp3')
          ..addSound('Note11','sounds/piano/Note11.mp3')
          ..addSound('Note12','sounds/piano/Note12.mp3')
          ..addSound('Note13','sounds/piano/Note13.mp3')
          ..addSound('Note14','sounds/piano/Note14.mp3')
          ..addSound('Note15','sounds/piano/Note15.mp3')
          ..addSound('Note16','sounds/piano/Note16.mp3')
          ..addSound('Note17','sounds/piano/Note17.mp3')
          ..addSound('Note18','sounds/piano/Note18.mp3')
          ..addSound('Note19','sounds/piano/Note19.mp3')
          ..addSound('Note20','sounds/piano/Note20.mp3')
          ..addSound('Note21','sounds/piano/Note21.mp3')
          ..addSound('Note22','sounds/piano/Note22.mp3')
          ..addSound('Note23','sounds/piano/Note23.mp3')
          ..addSound('Note24','sounds/piano/Note24.mp3')
          ..addSound('Note25','sounds/piano/Note25.mp3')        
          ..load().then((_) => stage.addChild(new SoundDemo()));
        break;
        
      case "text":
        stage.addChild(new TextDemo());
        break;
        
      case "tweener":
        stage.addChild(new TweenerDemo());
        break;
        
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
        
      case "transitions":
        var transititionTypeDemo = new TransititionTypeDemo();
        var transitionDiv = transititionTypeDemo.getTransitionDiv();
        html.query("#transitions").children.add(transitionDiv);
        break;
    }
  }
}