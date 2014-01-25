library stagexl_runtimes;

import 'dart:convert';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_flump/stagexl_flump.dart';
import 'package:stagexl_particle/stagexl_particle.dart';

part 'runtimes/flump.dart';
part 'runtimes/texture_packer.dart';
part 'runtimes/particle_emitter.dart';

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

var canvas = html.querySelector("#stage");
var stage = (canvas != null) ? new Stage(canvas, webGL: true) : null;
var renderLoop = new RenderLoop();
ResourceManager resourceManager = new ResourceManager();

//-----------------------------------------------------------------------------

void mainFlump() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;
  renderLoop.addStage(stage);

  resourceManager
    ..addCustomObject('flump', FlumpLibrary.load('images/flumpLibrary.json'))
    ..load().then((_) => stage.addChild(new FlumpDemo()));
}

void mainTexturePacker() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;
  renderLoop.addStage(stage);

  resourceManager
    ..addTextureAtlas('levelUp', 'images/LevelupTextureAtlas.json', TextureAtlasFormat.JSONARRAY)
    ..load().then((_) => stage.addChild(new TexturePackerDemo()));
}

void mainParticleEmitter() {
  BitmapData.defaultLoadOptions.webp = true;
  Stage.autoHiDpi = false;
  renderLoop.addStage(stage);
  stage.addChild(new ParticleEmitterDemo());
}
