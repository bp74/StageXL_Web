part of stagexl_demos;

class MaskingDemo extends DisplayObjectContainer {

  Juggler _juggler = stage.juggler;
  Random _random = new Random();

  MaskingDemo() {

    // build a field of flowers

    var flowerField = new Sprite()
      ..pivotX = 470
      ..pivotY = 250
      ..x = 470
      ..y = 250
      ..addTo(this);

    for(int i = 0; i < 150; i++) {
      var f = 1 + _random.nextInt(3);
      var bitmapData = resourceManager.getBitmapData('flower$f');
      var bitmap = new Bitmap(bitmapData)
        ..pivotX = 64
        ..pivotY = 64
        ..x = 64 + _random.nextInt(940 - 128)
        ..y = 64 + _random.nextInt(500 - 128)
        ..addTo(flowerField);

      _juggler.tween(bitmap, 600, TransitionFunction.linear)
        ..animate.rotation.to(PI * 60.0);
    }

    // define three different masks

    var starPath = new List<Point>();

    for(int i = 0; i < 6; i++) {
      num a1 = (i * 60) * PI / 180;
      num a2 = (i * 60 + 30) * PI / 180;
      starPath.add(new Point(470 + 200 * cos(a1), 250 + 200 * sin(a1)));
      starPath.add(new Point(470 + 100 * cos(a2), 250 + 100 * sin(a2)));
    }

    var rectangleMask = new Mask.rectangle(100, 100, 740, 300);
    var circleMask = new Mask.circle(470, 250, 200);
    var customMask = new Mask.custom(starPath);

    // add html-button event listeners

    html.querySelector('#mask-none').onClick.listen((e) => flowerField.mask = null);
    html.querySelector('#mask-rectangle').onClick.listen((e) => flowerField.mask = rectangleMask);
    html.querySelector('#mask-circle').onClick.listen((e) => flowerField.mask = circleMask);
    html.querySelector('#mask-custom').onClick.listen((e) => flowerField.mask = customMask);
    html.querySelector('#mask-spin').onClick.listen((e) {
      _juggler.tween(flowerField, 2.0, TransitionFunction.easeInOutBack)
        ..animate.rotation.to(PI * 4.0)
        ..onComplete = () => flowerField.rotation = 0.0;
    });
  }
}
