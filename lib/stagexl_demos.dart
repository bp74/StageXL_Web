library stagexl_demos;

import 'dart:math' hide Point, Rectangle;
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'demos/filter.dart';
part 'demos/masking.dart';
part 'demos/flipbook.dart';
part 'demos/performance.dart';
part 'demos/sound.dart';
part 'demos/text.dart';
part 'demos/tweener.dart';

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

void mainFilter() {
  _init();
  resourceManager
  ..addBitmapData('king', 'images/king.png')
  ..addBitmapData('sun', 'images/Sun.png')
  ..load().then((_) => stage.addChild(new FilterDemo()));
}

void mainMasking() {
  _init();
  resourceManager
  ..addBitmapData('flower1', 'images/Flower1.png')
  ..addBitmapData('flower2', 'images/Flower2.png')
  ..addBitmapData('flower3', 'images/Flower3.png')
  ..load().then((_) => stage.addChild(new MaskingDemo()));
}

void mainFlipbook() {
  _init();
  resourceManager
  ..addTextureAtlas('walkTextureAtlas', 'images/walk.json', TextureAtlasFormat.JSONARRAY)
  ..load().then((_) => stage.addChild(new FlipBookDemo()));
}

void mainPerformance() {
  _init();
  resourceManager
  ..addTextureAtlas('flags', 'images/flags.json', TextureAtlasFormat.JSONARRAY)
  ..load().then((_) => stage.addChild(new PerformanceDemo()));
}

void mainSound() {
  _init();
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
}

void mainText() {
  _init();
  stage.addChild(new TextDemo());
}

void mainTweener() {
  _init();
  stage.addChild(new TweenerDemo());
}

