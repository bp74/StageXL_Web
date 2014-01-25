part of stagexl_runtimes;

class TexturePackerDemo extends DisplayObjectContainer {

  TextureAtlas _textureAtlas;

  TexturePackerDemo() {

    _textureAtlas = resourceManager.getTextureAtlas('levelUp');
    _showLevelupAnimation();

    BitmapData.load('images/LevelupTextureAtlas.png').then((bitmapData) {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = 70;
      bitmap.y = 40;
      addChild(bitmap);
    });
  }

  _showLevelupAnimation() {

    for(int i = 0, offset = 330; i < 7; i++) {

      var bitmapData = _textureAtlas.getBitmapData('LevelUp${i}');
      var bitmap = new Bitmap(bitmapData)
        ..pivotX = bitmapData.width / 2
        ..pivotY = bitmapData.height / 2
        ..x = offset + bitmapData.width / 2
        ..y = 150
        ..scaleX = 0.0
        ..scaleY = 0.0
        ..addTo(this);

      stage.juggler.tween(bitmap, 2.0, TransitionFunction.easeOutElastic)
        ..animate.scaleX.to(1.0)
        ..animate.scaleY.to(1.0)
        ..delay = i * 0.05;

      stage.juggler.tween(bitmap, 0.4, TransitionFunction.linear)
        ..animate.scaleX.to(0.0)
        ..animate.scaleY.to(0.0)
        ..delay = 2.0
        ..onComplete = () => bitmap.removeFromParent();

      offset = offset + 5 + bitmapData.width;
    }

    stage.juggler.delayCall(() => _showLevelupAnimation(), 3.0);
  }

}

