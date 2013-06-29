part of stagexl_demos;

class FilterDemo extends DisplayObjectContainer {

  final List _filters = [
    {'name': 'DropShadowFilter (black)', 'filter': new DropShadowFilter(10, PI / 4, Color.Black, 0.8, 8, 8) },
    {'name': 'GlowFilter (red)', 'filter': new GlowFilter(Color.Red, 1.0, 20, 20) },
    {'name': 'ColorMatrixFilter (grayscale)', 'filter': new ColorMatrixFilter.grayscale() },
    {'name': 'ColorMatrixFilter (invert)', 'filter': new ColorMatrixFilter.invert() },
    {'name': 'BlurFilter (radius 1)', 'filter': new BlurFilter(1, 1) },
    {'name': 'BlurFilter (radius 5)', 'filter': new BlurFilter(5, 5) },
    {'name': 'BlurFilter (radius 20)', 'filter': new BlurFilter(20, 20) },
    {'name': 'AlphaMaskFilter', 'filter': new AlphaMaskFilter(resourceManager.getBitmapData("sun"))}
  ];

  FilterDemo() {

    var kingBitmapData = resourceManager.getBitmapData('king');
    var backgroundBitmapData = new BitmapData(230, 245, true, 0xFFF0F0F0);
    var kingBitmaps = new List<Bitmap>();

    //--------------------------------------------------------------------------------
    // Add kings with 8 different filters

    for(int i = 0; i < _filters.length; i++) {

      var filter = _filters[i]['filter'] as BitmapFilter;
      var name = _filters[i]['name'] as String;
      var x = 235 * (i % 4);
      var y = 250 * (i ~/ 4);

      var filterBounds = filter.getBounds();
      filterBounds.inflate(kingBitmapData.width, kingBitmapData.height);

      var backgroundBitmap = new Bitmap(backgroundBitmapData);
      backgroundBitmap.x = x;
      backgroundBitmap.y = y;
      addChild(backgroundBitmap);

      var kingBitmap = new Bitmap(kingBitmapData);
      kingBitmap.x = x + 40;
      kingBitmap.y =  y + 45;
      kingBitmap.filters = [filter];
      kingBitmap.applyCache(filterBounds.left, filterBounds.top, filterBounds.width, filterBounds.height);
      addChild(kingBitmap);
      kingBitmaps.add(kingBitmap);

      var textField = new TextField();
      textField.defaultTextFormat = new TextFormat('Helvetica Neue, Helvetica, Arial', 14, Color.Black);
      textField.x = x + 5;
      textField.y = y + 5;
      textField.width = 200;
      textField.text = name;
      addChild(textField);
    }

    //--------------------------------------------------------------------------------
    // animate the AlphaMaskFilter

    var bitmapFilter = _filters[7]["filter"];
    var bitmap = kingBitmaps[7];
    var matrix = bitmapFilter.matrix;

    juggler.transition(0.0, PI * 2 * 100, 600.0, TransitionFunction.linear, (value) {
      matrix.identity();
      matrix.translate(-64, -64);
      matrix.scale(1.0, 1.5);
      matrix.rotate(value);
      matrix.translate(kingBitmapData.width / 2 - 15, kingBitmapData.height / 2 - 20);
      bitmap.refreshCache();
    });
  }
}
