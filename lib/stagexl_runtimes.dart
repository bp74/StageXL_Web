library stagexl_runtimes;

import 'dart:json' as json;
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_flump/stagexl_flump.dart';
import 'package:stagexl_particle/stagexl_particle.dart';

part 'runtimes/flump.dart';
part 'runtimes/texture_packer.dart';
part 'runtimes/particle_emitter.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;

void _init() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;

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

void mainFlump() {
  _init();
  resourceManager
  ..addCustomObject('flump', FlumpLibrary.load('images/flumpLibrary.json'))
  ..load().then((_) => stage.addChild(new FlumpDemo()));
}

void mainTexturePacker() {
  _init();
  resourceManager
  ..addTextureAtlas('levelUp', 'images/LevelupTextureAtlas.json', TextureAtlasFormat.JSONARRAY)
  ..load().then((_) => stage.addChild(new TexturePackerDemo()));
}

void mainParticleEmitter() {
  _init();
  stage.addChild(new ParticleEmitterDemo());
}
