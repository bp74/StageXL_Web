#import('dart:math');
#import('dart:html', prefix:'html');
#import('../../../packages/dartflash/dartflash.dart');

Resource resource;

void main()
{
  // Initialize the Display List

  Stage stage = new Stage('myStage', html.document.query('#stage'));

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // prepare different Masks for later use

  List<Point> starPath = new List<Point>();

  for(int i = 0; i < 6; i++) {
    num a1 = PI * (i * 60.0) / 180.0;
    num a2 = PI * (i * 60.0 + 30.0) / 180.0;
    starPath.add(new Point(470.0 + 200.0 * cos(a1), 250.0 + 200.0 * sin(a1)));
    starPath.add(new Point(470.0 + 100.0 * cos(a2), 250.0 + 100.0 * sin(a2)));
  }

  Mask rectangleMask = new Mask.rectangle(100.0, 100.0, 740.0, 300.0);
  Mask circleMask = new Mask.circle(470.0, 250.0, 200.0);
  Mask customMask = new Mask.custom(starPath);

  // Use the Resource class to load some Bitmaps

  resource = new Resource();
  resource.addImage('flower1', '../common/images/Flower1.png');
  resource.addImage('flower2', '../common/images/Flower2.png');
  resource.addImage('flower3', '../common/images/Flower3.png');

  resource.load().then((result)
  {
    // Draw a nice looking animation

    Sprite animation = new Sprite();
    Random random = new Random();

    for(int i = 0; i < 150; i++) {
      int f = 1 + random.nextInt(3);
      BitmapData bitmapData = resource.getBitmapData('flower$f');
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.pivotX = 64;
      bitmap.pivotY = 64;
      bitmap.x = 64.0 + random.nextDouble() * (940 - 128);
      bitmap.y = 64.0 + random.nextDouble() * (500 - 128);
      animation.addChild(bitmap);

      Tween tween = new Tween(bitmap, 600, Transitions.linear);
      tween.animate('rotation', PI * 60.0);
      Juggler.instance.add(tween);
    }

    animation.pivotX = 470;
    animation.pivotY = 250;
    animation.x = 470;
    animation.y = 250;
    stage.addChild(animation);

    // add html-button event listeners

    html.query('#mask-none').on.click.add((e) => animation.mask = null);
    html.query('#mask-rectangle').on.click.add((e) => animation.mask = rectangleMask);
    html.query('#mask-circle').on.click.add((e) => animation.mask = circleMask);
    html.query('#mask-custom').on.click.add((e) => animation.mask = customMask);
    html.query('#mask-spin').on.click.add((e) {
      Tween rotate = new Tween(animation, 2.0, Transitions.easeInOutBack);
      rotate.animate('rotation', PI * 4.0);
      rotate.onComplete = () => animation.rotation = 0.0;
      Juggler.instance.add(rotate);
    });
  });
}
