import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

void main()
{
  // Initialize the Display List

  Stage stage = new Stage('myStage', html.document.query('#stage'));

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load a Flump library
  
  FlumpLibrary.load("images/library.json").then((flumpLibrary) {
    
    BitmapData.loadImage("images/atlas0.png").then((bitmapData) {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = 40;
      bitmap.y = 40;
      stage.addChild(bitmap);
    });
    
    FlumpMovie idle = new FlumpMovie(flumpLibrary, "idle");
    idle.x = 500;
    idle.y = 200;
    idle.addTo(stage);   
    
    FlumpMovie walk = new FlumpMovie(flumpLibrary, "walk");
    walk.x = 150;
    walk.y = 460;
    walk.addTo(stage);   
    
    FlumpMovie attack = new FlumpMovie(flumpLibrary, "attack");
    attack.x = 450;
    attack.y = 460;
    attack.addTo(stage);

    FlumpMovie defeat = new FlumpMovie(flumpLibrary, "defeat");
    defeat.x = 720;
    defeat.y = 460;
    defeat.addTo(stage);
    
    renderLoop.juggler.add(idle);
    renderLoop.juggler.add(walk);
    renderLoop.juggler.add(attack);
    renderLoop.juggler.add(defeat);    
  });
}
