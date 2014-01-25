part of stagexl_runtimes;

class FlumpDemo extends DisplayObjectContainer {

  FlumpDemo() {

    var flumpLibrary = resourceManager.getCustomObject('flump') as FlumpLibrary;
    var juggler = stage.juggler;

    var idle = new FlumpMovie(flumpLibrary, 'idle');
    idle.x = 450;
    idle.y = 150;
    addChild(idle);
    juggler.add(idle);

    var walk = new FlumpMovie(flumpLibrary, 'walk');
    walk.x = 150;
    walk.y = 200;
    addChild(walk);
    juggler.add(walk);

    var attack = new FlumpMovie(flumpLibrary, 'attack');
    attack.x = 750;
    attack.y = 300;
    addChild(attack);
    juggler.add(attack);

    var defeat = new FlumpMovie(flumpLibrary, 'defeat');
    defeat.x = 350;
    defeat.y = 400;
    addChild(defeat);
    juggler.add(defeat);
  }
}

