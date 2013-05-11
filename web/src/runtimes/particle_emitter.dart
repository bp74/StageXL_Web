part of stagexl_runtimes;

class ParticleEmitterDemo extends DisplayObjectContainer {

  BitmapData backgroundBitmapData;
  Bitmap background;
  ParticleEmitter particleEmitter;
  GlassPlate glassPlate;

  int backgroundColor = 0;
  String particleJson = '{"location" : { "x" : 160.00, "y" : 230.00 }, "locationVariance": { "x" : 7.00, "y" : 7.00 }, "speed" : 260.00, "speedVariance" : 10.00, "lifeSpan" : 1.00, "lifespanVariance" : 0.70, "angle" : 0.00, "angleVariance" : 360.00, "gravity" : { "x" : 0.00, "y" : 0.00 }, "radialAcceleration" : -600.00, "tangentialAcceleration" : -100.00, "radialAccelerationVariance" : 0.00, "tangentialAccelerationVariance" : 0.00, "startColor" : { "red" : 1.00, "green" : 0.0 , "blue" : 0.0 , "alpha" : 1.0 }, "finishColor" : { "red" : 1.00 , "green" : 1.00 , "blue" : 0.00 , "alpha" : 1.00 }, "maxParticles" : 200, "startSize" : 30.00, "startSizeVariance" : 20.00, "finishSize" : 5.00, "finishSizeVariance" : 5.00, "duration" : -1.00, "emitterType" : 0, "maxRadius" : 40.00, "maxRadiusVariance" : 0.00, "minRadius" : 0.00, "rotatePerSecond" : 0.00, "rotatePerSecondVariance" : 0.00 }';

  ParticleEmitterDemo() {

    backgroundBitmapData = new BitmapData(380,600, true, backgroundColor);
    background = new Bitmap(backgroundBitmapData);
    addChild(background);

    particleEmitter = new ParticleEmitter(particleJson);
    particleEmitter.x = 190;
    particleEmitter.y = 300;
    particleEmitter.start();

    addChild(particleEmitter);
    juggler.add(particleEmitter);

    //--------------------------------

    this.onEnterFrame.listen((e) {
      var inputJson = html.query("#particleEmitterJson") as html.InputElement;
      var inputBackground = html.query("#particleEmitterBackground") as html.InputElement;
      var json = inputJson.value;
      var color = int.parse(inputBackground.value) | 0xFF000000;

      if (json != particleJson) {
        particleJson = json;
        particleEmitter.updateConfig(particleJson);
      }

      if (color != backgroundColor) {
        backgroundColor = color;
        backgroundBitmapData.fillRect(new Rectangle(0,0,380, 600), backgroundColor);
      }
    });

    GlassPlate glassPlate = new GlassPlate(380, 600);
    glassPlate.onMouseMove.listen(_onMouseEvent);
    glassPlate.onMouseDown.listen(_onMouseEvent);
    addChild(glassPlate);
  }

  _onMouseEvent(MouseEvent me) {
    if (me.buttonDown) {
      particleEmitter.setEmitterLocation(me.localX - 190, me.localY - 300);
    }
  }

}
