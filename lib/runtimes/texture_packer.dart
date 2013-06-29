part of stagexl_runtimes;

class TexturePackerDemo extends DisplayObjectContainer {
  
  TextureAtlas _textureAtlas;
  
  TexturePackerDemo() {
   
    _textureAtlas = resourceManager.getTextureAtlas('levelUp');
    _showLevelupAnimation();

    //-----------------------------------------
    
    BitmapData.load('images/LevelupTextureAtlas.png').then((bitmapData) {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = 70;
      bitmap.y = 40;
      addChild(bitmap);
    });
  }
  
  _showLevelupAnimation() {
    
    num offset = 330;
    
    for(int i = 0; i < 7; i++) {
      
      var bitmapData = _textureAtlas.getBitmapData('LevelUp${i}');
      var bitmap = new Bitmap(bitmapData);
      
      bitmap.pivotX = bitmapData.width / 2;
      bitmap.pivotY = bitmapData.height / 2;
      bitmap.x = offset + bitmapData.width / 2;
      bitmap.y = 150;
      bitmap.scaleX = 0.0;
      bitmap.scaleY = 0.0;
      addChild(bitmap);
      
      var tween1 = new Tween(bitmap, 2.0, TransitionFunction.easeOutElastic);
      tween1.animate.scaleX.to(1.0);
      tween1.animate.scaleY.to(1.0);
      tween1.delay = i * 0.05;

      var tween2 = new Tween(bitmap, 0.4, TransitionFunction.linear);
      tween2.animate.scaleX.to(0.0);
      tween2.animate.scaleY.to(0.0);
      tween2.delay = 2.0;
      tween2.onComplete = () => bitmap.removeFromParent();

      juggler.add(tween1);
      juggler.add(tween2);

      offset = offset + 5 + bitmapData.width;
    }  
    
    juggler.delayCall(() => _showLevelupAnimation(), 3.0);
  }

}

