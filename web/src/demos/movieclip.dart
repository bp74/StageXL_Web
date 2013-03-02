part of dartflash_web;

class MovieClipDemo extends DisplayObjectContainer {
  
  Random _random = new Random();
  TextureAtlas _textureAtlas;
  List _bitmapDatas;
  
  MovieClipDemo() {

    // Get all the 'walk' bitmapDatas in the texture atlas.

    _textureAtlas = resourceManager.getTextureAtlas('walkTextureAtlas');
    _bitmapDatas = _textureAtlas.getBitmapDatas('walk');
    
    // start the first walking man.
    
    _startWalkingMan();
  }
  
  _startWalkingMan() {

    var scale = _random.nextDouble();

    // Create a movie clip with the list of bitmapDatas.
    var movieClip = new MovieClip(_bitmapDatas, 30);
    movieClip.x = -128;
    movieClip.y = 20.0 + 180.0 * scale;
    movieClip.scaleX = movieClip.scaleY = 0.5 + 0.5 * scale;
    movieClip.play();

    addChild(movieClip);
    sortChildren((c1, c2) => (c1.y - c2.y).toInt());

    // Add a tween to make the man walk from the left to the right.

    var tween = new Tween(movieClip, 5.0 + (1.0 - scale) * 5.0, TransitionFunction.linear);
    tween.animate('x', 940.0);
    tween.onComplete = () {
      juggler.remove(movieClip);
      removeChild(movieClip);
    };

    juggler.add(movieClip);
    juggler.add(tween);
    juggler.delayCall(_startWalkingMan, 0.2);
  }  
}

