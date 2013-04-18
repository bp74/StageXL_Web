part of stagexl_demos;

class FlyingFlag extends Bitmap implements Animatable {
  
    num vx, vy;

    FlyingFlag(BitmapData bitmapData, this.vx, this.vy):super(bitmapData) {
      this.pivotX = bitmapData.width / 2;
      this.pivotY = bitmapData.height / 2;
    }

    bool advanceTime(num time) {
      var tx = x + vx * time;
      var ty = y + vy * time;
      if (tx > 910 || tx < 30) vx = -vx; else x = tx;
      if (ty > 470 || ty < 30) vy = -vy; else y = ty;
      return true;
    }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

class PerformanceDemo extends DisplayObjectContainer {
  
  PerformanceDemo() {
    
    // let's start with 250 flags
    _addFlags(250);

    // add html-button event listeners
    html.query('#minus10').onClick.listen((e) => _removeFlags(10));
    html.query('#minus50').onClick.listen((e) => _removeFlags(50));
    html.query('#plus50').onClick.listen((e) => _addFlags(50));
    html.query('#plus10').onClick.listen((e) => _addFlags(10));

    // add event listener for EnterFrame (fps meter)
    this.onEnterFrame.listen(_onEnterFrame);            
  }
  
  //---------------------------------------------------------------------------------

  num _fpsAverage = null;
  
  _onEnterFrame(EnterFrameEvent e) {
    
    if (_fpsAverage == null) {
      _fpsAverage = 1.00 / e.passedTime;
    } else {
      _fpsAverage = 0.05 / e.passedTime + 0.95 * _fpsAverage;
    }
  
    html.query('#fpsMeter').innerHtml = 'fps: ${_fpsAverage.round()}';
  }
  
  //---------------------------------------------------------------------------------
  
  _addFlags(int amount) {
    
    var random = new Random();
    var textureAtlas = resourceManager.getTextureAtlas('flags');
    var flagNames = textureAtlas.frameNames;
    
    while(--amount >= 0) {
      var flagName = flagNames[random.nextInt(flagNames.length)];
      var flagBitmapData = textureAtlas.getBitmapData(flagName);
      
      var flyingFlag = new FlyingFlag(flagBitmapData, random.nextInt(200) - 100, random.nextInt(200) - 100);
      flyingFlag.x = 30 + random.nextInt(940 - 60);
      flyingFlag.y = 30 + random.nextInt(500 - 60);
      addChild(flyingFlag);
      
      juggler.add(flyingFlag);
    }
  
    html.query('#flagCounter').innerHtml = 'Flags: ${numChildren}';
  }
  
  //---------------------------------------------------------------------------------
  
  _removeFlags(int amount) {
    
    while(--amount >= 0 && numChildren > 0) {
      var displayObject = getChildAt(0);
      displayObject.removeFromParent();
      juggler.remove(displayObject);
    }
  
    html.query('#flagCounter').innerHtml = 'Flags: ${numChildren}';
  }
}
