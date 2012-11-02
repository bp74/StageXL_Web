import 'dart:math';
import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

class Flag extends Bitmap implements Animatable
{
    num vx, vy;

    Flag(BitmapData bitmapData, this.vx, this.vy):super(bitmapData)
    {
      this.pivotX = bitmapData.width / 2;
      this.pivotY = bitmapData.height / 2;
    }

    bool advanceTime(num time)
    {
      var tx = x + vx * time;
      var ty = y + vy * time;
      if (tx > 910 || tx < 30) vx = -vx; else x = tx;
      if (ty > 470 || ty < 30) vy = -vy; else y = ty;
      return true;
    }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
TextureAtlas textureAtlas;
Random random = new Random();
num fpsAverage;

void main()
{
  // Initialize the Display List
  stage = new Stage('myStage', html.document.query('#stage'));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  juggler = renderLoop.juggler;

  // load the texture atlas with flag images
  Future loader = TextureAtlas.load('../common/images/flags.json', TextureAtlasFormat.JSONARRAY);

  loader.then((result) {
    textureAtlas = result;

    // let's start with 250 flags
    addFlags(250);

    // add html-button event listeners
    html.query('#minus10').on.click.add((e) => removeFlags(10));
    html.query('#minus50').on.click.add((e) => removeFlags(50));
    html.query('#plus50').on.click.add((e) => addFlags(50));
    html.query('#plus10').on.click.add((e) => addFlags(10));

    // add event listener for EnterFrame (fps meter)
    stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
  });
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

void onEnterFrame(EnterFrameEvent e)
{
  if (fpsAverage == null) {
    fpsAverage = 1.00 / e.passedTime;
  } else {
    fpsAverage = 0.05 / e.passedTime + 0.95 * fpsAverage;
  }

  html.query('#fpsMeter').innerHTML = 'fps: ${fpsAverage.round()}';
}

//-----------------------------------------------------------------------------------

void addFlags(int amount)
{
  while(--amount >= 0) {
    var flagIndex = random.nextInt(textureAtlas.frameNames.length);
    var flagName = textureAtlas.frameNames[flagIndex];
    var flagBitmapData = textureAtlas.getBitmapData(flagName);

    var flag = new Flag(flagBitmapData, random.nextInt(200) - 100, random.nextInt(200) - 100);
    flag.x = 30 + random.nextInt(940 - 60);
    flag.y = 30 + random.nextInt(500 - 60);
    flag.addTo(stage);

    juggler.add(flag);
  }

  html.query('#spriteCounter').innerHTML = 'Sprites: ${stage.numChildren}';
}

//-----------------------------------------------------------------------------------

void removeFlags(int amount)
{
  while(--amount >= 0 && stage.numChildren > 0) {
    var displayObject = stage.getChildAt(0);
    displayObject.removeFromParent();
    juggler.remove(displayObject);
  }

  html.query('#spriteCounter').innerHTML = 'Sprites: ${stage.numChildren}';
}
