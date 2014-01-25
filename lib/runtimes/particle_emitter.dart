part of stagexl_runtimes;

class ParticleEmitterDemo extends DisplayObjectContainer {

  BitmapData backgroundBitmapData;
  Bitmap background;
  ParticleEmitter particleEmitter;
  GlassPlate glassPlate;

  int backgroundColor = 0;
  String particleJson = "";

  Map particleConfig = {
    "maxParticles":200,
    "duration":0,
    "lifeSpan":0.9, "lifespanVariance":0.4,
    "startSize":10, "startSizeVariance":20,
    "finishSize":70, "finishSizeVariance":0,
    "shape":"circle",
    "emitterType":0,
    "location":{"x":0, "y":0}, "locationVariance":{"x":0, "y":0},
    "speed":100, "speedVariance":10,
    "angle":0, "angleVariance":360,
    "gravity":{"x":0, "y":100},
    "radialAcceleration":20, "radialAccelerationVariance":0,
    "tangentialAcceleration":10, "tangentialAccelerationVariance":0,
    "minRadius":0, "maxRadius":100, "maxRadiusVariance":0,
    "rotatePerSecond":0, "rotatePerSecondVariance":0,
    "compositeOperation":"source-over",
    "startColor":{"red":1, "green":0.75, "blue":0, "alpha":1},
    "finishColor":{"red":1, "green":0, "blue":0, "alpha":0}
  };

  ParticleEmitterDemo() {

    backgroundBitmapData = new BitmapData(380,600, true, backgroundColor);
    background = new Bitmap(backgroundBitmapData);
    addChild(background);

    particleEmitter = new ParticleEmitter(particleConfig);
    particleEmitter.x = 190;
    particleEmitter.y = 300;
    particleEmitter.start();

    addChild(particleEmitter);
    stage.juggler.add(particleEmitter);

    //--------------------------------

    this.onEnterFrame.listen((e) {
      html.InputElement inputJson = html.querySelector("#particleEmitterJson");
      html.InputElement inputBackground = html.querySelector("#particleEmitterBackground");

      var newParticleJson = inputJson.value;
      var color = int.parse(inputBackground.value) | 0xFF000000;

      if (newParticleJson != particleJson) {
        particleJson = newParticleJson;
        particleConfig = JSON.decode(newParticleJson);
        particleEmitter.updateConfig(particleConfig);
      }

      if (color != backgroundColor) {
        backgroundColor = color;
        backgroundBitmapData.fillRect(new Rectangle(0,0,380, 600), backgroundColor);
      }

      if (particleEmitter.particleCount == 0) {
        particleEmitter.start();
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
