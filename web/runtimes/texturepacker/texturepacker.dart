import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

Stage stage;
RenderLoop renderLoop;

void main() {
  
  // Initialize the Display List

  stage = new Stage('myStage', html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // Load the texture atlas 

  TextureAtlas.load("images/LevelupTextureAtlas.json", TextureAtlasFormat.JSONARRAY).then((textureAtlas) {
   
    BitmapData.load("images/LevelupTextureAtlas.png").then((bitmapData) {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = 70;
      bitmap.y = 40;
      bitmap.addTo(stage);
    });
    
    showLevelupAnimation(textureAtlas);
  });
}

void showLevelupAnimation(textureAtlas) {
  
  num offset = 330;
  
  for(int i = 0; i < 7; i++) {
    
    BitmapData bitmapData = textureAtlas.getBitmapData("LevelUp${i}");
    
    Bitmap bitmap = new Bitmap(bitmapData);
    bitmap.pivotX = bitmapData.width / 2;
    bitmap.pivotY = bitmapData.height / 2;
    bitmap.x = offset + bitmapData.width / 2;
    bitmap.y = 150;
    bitmap.scaleX = 0.0;
    bitmap.scaleY = 0.0;
    bitmap.addTo(stage);
    
    Tween tween1 = new Tween(bitmap, 2.0, TransitionFunction.easeOutElastic);
    tween1.animate("scaleX", 1.0);
    tween1.animate("scaleY", 1.0);
    tween1.delay = i * 0.05;

    Tween tween2 = new Tween(bitmap, 0.4, TransitionFunction.linear);
    tween2.animate("scaleX", 0.0);
    tween2.animate("scaleY", 0.0);
    tween2.delay = 2.0;
    tween2.onComplete = () => bitmap.removeFromParent();

    renderLoop.juggler.add(tween1);
    renderLoop.juggler.add(tween2);

    offset = offset + 5 + bitmapData.width;
  }  
  
  renderLoop.juggler.delayCall(() => showLevelupAnimation(textureAtlas), 3.0);
}


