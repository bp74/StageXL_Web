part of stagexl_demos;

class FlipBookDemo extends DisplayObjectContainer {

  Random _random = new Random();
  TextureAtlas _textureAtlas = resourceManager.getTextureAtlas('walkTextureAtlas');
  Juggler _juggler = stage.juggler;
  List _bitmapDatas;

  FlipBookDemo() {

    // Get all the 'walk' bitmapDatas in the texture atlas
    // and start the first walking man.

    _bitmapDatas = _textureAtlas.getBitmapDatas('walk');
    _startWalkingMan();
  }

  _startWalkingMan() {

    // Create a flip book with the list of bitmapDatas.

    var scale = _random.nextDouble();
    var flipBook = new FlipBook(_bitmapDatas, 30)
      ..x = -128
      ..y = 20.0 + 180.0 * scale
      ..scaleX = 0.5 + 0.5 * scale
      ..scaleY = 0.5 + 0.5 * scale
      ..play()
      ..addTo(this);

    sortChildren((c1, c2) => (c1.y - c2.y).toInt());

    // Add a tween to make the man walk from the left to the right.

    _juggler.tween(flipBook, 5.0 + (1.0 - scale) * 5.0, TransitionFunction.linear)
      ..animate.x.to(940.0)
      ..onComplete = () {
        flipBook.removeFromParent();
        _juggler.remove(flipBook);
      };

    _juggler.add(flipBook);
    _juggler.delayCall(_startWalkingMan, 0.2);
  }
}

