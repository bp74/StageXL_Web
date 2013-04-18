part of stagexl_demos;

class MaskingDemo extends DisplayObjectContainer {
  
  final Random _random = new Random();
  
  MaskingDemo() {

    var flowerField = new Sprite();
    flowerField.pivotX = 470;
    flowerField.pivotY = 250;
    flowerField.x = 470;
    flowerField.y = 250;
    addChild(flowerField);
    
    for(int i = 0; i < 150; i++) {
      var f = 1 + _random.nextInt(3);
      var bitmapData = resourceManager.getBitmapData('flower$f');
      var bitmap = new Bitmap(bitmapData);
      bitmap.pivotX = 64;
      bitmap.pivotY = 64;
      bitmap.x = 64 + _random.nextInt(940 - 128);
      bitmap.y = 64 + _random.nextInt(500 - 128);
      flowerField.addChild(bitmap);

      var tween = new Tween(bitmap, 600, TransitionFunction.linear);
      tween.animate.rotation.to(PI * 60.0);
      juggler.add(tween);
    }

    //---------------------------------------------
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

    //---------------------------------------------
    // add html-button event listeners

    html.query('#mask-none').onClick.listen((e) => flowerField.mask = null);
    html.query('#mask-rectangle').onClick.listen((e) => flowerField.mask = rectangleMask);
    html.query('#mask-circle').onClick.listen((e) => flowerField.mask = circleMask);
    html.query('#mask-custom').onClick.listen((e) => flowerField.mask = customMask);
    html.query('#mask-spin').onClick.listen((e) {
      var rotate = new Tween(flowerField, 2.0, TransitionFunction.easeInOutBack);
      rotate.animate.rotation.to(PI * 4.0);
      rotate.onComplete = () => flowerField.rotation = 0.0;
      juggler.add(rotate);
    });    
  }
}
