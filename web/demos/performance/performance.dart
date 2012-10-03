#import('dart:math');
#import('dart:html', prefix:'html');
#import('package:dartflash/dartflash.dart');

class Flag extends Sprite implements Animatable
{
    num vx, vy;

    Flag(BitmapData bitmapData, num vx, num vy)
    {
      Bitmap bitmap = new Bitmap(bitmapData);
      bitmap.x = -24;
      bitmap.x = -18;
      
      this.addChild(bitmap);
      this.vx = vx;
      this.vy = vy;
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
TextureAtlas textureAtlas;
Random random = new Random();
List frameTimes = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
int frameTimesIndex = 0;

void main()
{
  // Initialize the Display List
  stage = new Stage('myStage', html.document.query('#stage'));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the texture atlas with flag images
  Future loader = TextureAtlas.load('../common/images/flags.json', TextureAtlasFormat.JSONARRAY);
  
  loader.then((result)
  {
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
  num frameTimeSum = 0;
  frameTimesIndex = (frameTimesIndex + 1) % frameTimes.length;
  frameTimes[frameTimesIndex] = e.passedTime;
  frameTimes.forEach((t) => frameTimeSum += t);

  html.query('#fpsMeter').innerHTML = 'fps: ${(frameTimes.length / frameTimeSum).round()}';  
}

//-----------------------------------------------------------------------------------

void addFlags(int amount)
{
  for(int i = 0; i < amount; i++)
  {
    var flagIndex = random.nextInt(textureAtlas.frameNames.length);
    var flagName = textureAtlas.frameNames[flagIndex];
    var flagBitmapData = textureAtlas.getBitmapData(flagName);

    var flag = new Flag(flagBitmapData, random.nextInt(200) - 100, random.nextInt(200) - 100);
    flag.x = 30 + random.nextInt(940 - 60);
    flag.y = 30 + random.nextInt(500 - 60);

    Juggler.instance.add(stage.addChild(flag));
  }

  html.query('#spriteCounter').innerHTML = 'Sprites: ${stage.numChildren}';
}

//-----------------------------------------------------------------------------------

void removeFlags(int amount)
{
  for(int i = 0; i < amount && stage.numChildren > 0; i++)
    Juggler.instance.remove(stage.removeChildAt(i));

  html.query('#spriteCounter').innerHTML = 'Sprites: ${stage.numChildren}';
}
