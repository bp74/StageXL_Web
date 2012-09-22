#import('dart:math');
#import('dart:html', prefix:'html');
#import('../../../packages/dartflash/dartflash.dart');

Stage stage;
RenderLoop renderLoop;
Resource resource;
Random random;
List<BitmapData> bitmapDatas;
List<Flag> flags;
List<num> frameTimes;
int frameTimesIndex;

//-----------------------------------------------------------------------------------

class Flag
{
    Bitmap bitmap;
    num vx, vy;

    Flag(this.bitmap, this.vx, this.vy);

    void update(num passedTime)
    {
      var x = bitmap.x + vx * passedTime;
      var y = bitmap.y + vy * passedTime;
      if (x > 910 || x < 30) vx = -vx; else bitmap.x = x;
      if (y > 470 || y < 30) vy = -vy; else bitmap.y = y;
    }
}

//-----------------------------------------------------------------------------------

void main()
{
  random = new Random();
  bitmapDatas = new List<BitmapData>();
  flags = new List<Flag>();
  frameTimes = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
  frameTimesIndex = 0;

  // Initialize the Display List

  stage = new Stage('myStage', html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // Use the Resource class to load a texture atlas

  resource = new Resource();
  resource.addTextureAtlas('flagsTextureAtlas', '../common/images/flags.json', TextureAtlasFormat.JSONARRAY);
  resource.load().then((result)
  {
    // Get all flags from the texture atlas.
    TextureAtlas textureAtlas = resource.getTextureAtlas('flagsTextureAtlas');
    for(var frameName in textureAtlas.frameNames)
      bitmapDatas.add(textureAtlas.getBitmapData(frameName));

    // add html-button event listeners
    html.query('#minus10').on.click.add((e) => removeFlags(10));
    html.query('#minus50').on.click.add((e) => removeFlags(50));
    html.query('#plus50').on.click.add((e) => addFlags(50));
    html.query('#plus10').on.click.add((e) => addFlags(10));

    // add event listener for EnterFrame
    stage.addEventListener(Event.ENTER_FRAME, (EnterFrameEvent e) => updateFlags(e.passedTime));

    // add 250 flags
    addFlags(250);
  });
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

void addFlags(int amount)
{
  for(int i = 0; i < amount; i++)
  {
    Bitmap bitmap = new Bitmap(bitmapDatas[random.nextInt(bitmapDatas.length)]);
    bitmap.pivotX = 24;
    bitmap.pivotY = 18;
    bitmap.x = 30 + random.nextInt(940 - 60);
    bitmap.y = 30 + random.nextInt(500 - 60);
    stage.addChild(bitmap);

    Flag flag = new Flag(bitmap, 200 * random.nextDouble() - 100, 200 * random.nextDouble() - 100);
    flags.add(flag);
  }

  html.query('#spriteCounter').innerHTML = 'Sprites: ${flags.length}';
}

//-----------------------------------------------------------------------------------

void removeFlags(int amount)
{
  if (flags.length >= amount)
  {
    flags.removeRange(flags.length - amount, amount);

    for(int i = 0; i < amount; i++)
      stage.removeChildAt(stage.numChildren - 1);

    html.query('#spriteCounter').innerHTML = 'Sprites: ${flags.length}';
  }
}

//-----------------------------------------------------------------------------------

void updateFlags(num passedTime)
{
    if (passedTime < 1.0)
    {
      frameTimesIndex = (frameTimesIndex + 1) % frameTimes.length;
      frameTimes[frameTimesIndex] = passedTime;

      num avgFrameTime = 0;
      int frameTimesLength = frameTimes.length;
      for(int i = 0; i < frameTimesLength; i++)
        avgFrameTime += frameTimes[i];

      int flagsLength = flags.length;
      for(int i = 0; i < flagsLength; i++)
        flags[i].update(passedTime);

      html.query('#fpsMeter').innerHTML = 'fps: ${(frameTimes.length/avgFrameTime).round()}';
    }
}

