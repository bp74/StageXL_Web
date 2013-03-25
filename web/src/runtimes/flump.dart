part of stagexl_web;

class FlumpDemo extends DisplayObjectContainer {
  
  FlumpDemo() {

    var flumpLibrary = resourceManager.getFlumpLibrary('flump');
      
    var idle = new FlumpMovie(flumpLibrary, 'idle');
    idle.x = 500;
    idle.y = 200;
    addChild(idle);   
    
    var walk = new FlumpMovie(flumpLibrary, 'walk');
    walk.x = 150;
    walk.y = 460;
    addChild(walk);   
    
    var attack = new FlumpMovie(flumpLibrary, 'attack');
    attack.x = 450;
    attack.y = 460;
    addChild(attack);

    var defeat = new FlumpMovie(flumpLibrary, 'defeat');
    defeat.x = 720;
    defeat.y = 460;
    addChild(defeat);
    
    juggler.add(idle);
    juggler.add(walk);
    juggler.add(attack);
    juggler.add(defeat);
    
    //----------------------------
    
    BitmapData.load('images/flumpLibraryAtlas0.png').then((bitmapData) {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = 40;
      bitmap.y = 40;
      addChild(bitmap);
    });
  }
}

