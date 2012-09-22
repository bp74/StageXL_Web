#import('dart:math');
#import('dart:html', prefix:'html');
#import('../../../packages/dartflash/dartflash.dart');

Stage stage;
RenderLoop renderLoop;
Resource resource;

void main()
{
  //------------------------------------------------------------------
  // Initialize the Display List
  //------------------------------------------------------------------

  stage = new Stage('myStage', html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  //------------------------------------------------------------------
  // Use the Resource class to load a TextureAtlas
  //------------------------------------------------------------------

  resource = new Resource();
  resource.addTextureAtlas('walkTextureAtlas', '../common/images/walk.json', TextureAtlasFormat.JSONARRAY);
  resource.load().then((r) => startWalking());
}

//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------

void startWalking()
{
  //------------------------------------------------------------------
  // Get all the 'walk' bitmapDatas in the texture atlas.
  //------------------------------------------------------------------

  TextureAtlas textureAtlas = resource.getTextureAtlas('walkTextureAtlas');
  List<BitmapData> bitmapDatas = textureAtlas.getBitmapDatas('walk');

  //------------------------------------------------------------------
  // Create a movie clip with the list of bitmapDatas.
  //------------------------------------------------------------------

  Random random = new Random();
  num rnd = random.nextDouble();

  MovieClip movieClip = new MovieClip(bitmapDatas, 30);
  movieClip.x = -128;
  movieClip.y = 20.0 + 180.0 * rnd;
  movieClip.scaleX = movieClip.scaleY = 0.5 + 0.5 * rnd;
  movieClip.play();

  stage.addChild(movieClip);
  stage.sortChildren((c1, c2) => (c1.y < c2.y) ? -1 : ((c1.y > c2.y) ? 1 : 0));

  //------------------------------------------------------------------
  // Add a tween to make the man walk from the left to the right.
  //------------------------------------------------------------------

  Tween tween = new Tween(movieClip, 5.0 + (1.0 - rnd) * 5.0, Transitions.linear);
  tween.animate('x', 940.0);
  tween.onComplete = ()
  {
    Juggler.instance.remove(movieClip);
    stage.removeChild(movieClip);
  };

  Juggler.instance.add(movieClip);
  Juggler.instance.add(tween);

  //------------------------------------------------------------------
  // the next animaton should start after 0.2 seconds
  //------------------------------------------------------------------

  Juggler.instance.delayCall(startWalking, 0.2);
}
