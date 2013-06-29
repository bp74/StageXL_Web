part of stagexl_demos;

class FlipBookDemo extends DisplayObjectContainer {
  
  Random _random = new Random();
  TextureAtlas _textureAtlas;
  List _bitmapDatas;
  
  FlipBookDemo() {
    
    // Get all the 'walk' bitmapDatas in the texture atlas.

    _textureAtlas = resourceManager.getTextureAtlas('walkTextureAtlas');
    _bitmapDatas = _textureAtlas.getBitmapDatas('walk');
    
    // start the first walking man.
    
    _startWalkingMan();
  }
  
  _startWalkingMan() {

    var scale = _random.nextDouble();

    // Create a flip book with the list of bitmapDatas.
    var flipBook = new FlipBook(_bitmapDatas, 30);
    flipBook.x = -128;
    flipBook.y = 20.0 + 180.0 * scale;
    flipBook.scaleX = flipBook.scaleY = 0.5 + 0.5 * scale;
    flipBook.play();

    addChild(flipBook);
    sortChildren((c1, c2) => (c1.y - c2.y).toInt());

    // Add a tween to make the man walk from the left to the right.

    var tween = new Tween(flipBook, 5.0 + (1.0 - scale) * 5.0, TransitionFunction.linear);
    tween.animate.x.to(940.0);
    tween.onComplete = () {
      juggler.remove(flipBook);
      removeChild(flipBook);
    };

    juggler.add(flipBook);
    juggler.add(tween);
    juggler.delayCall(_startWalkingMan, 0.2);
  }  
}

