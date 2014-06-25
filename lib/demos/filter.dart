part of stagexl_demos;

class FilterDemo extends DisplayObjectContainer {

  FilterDemo() {

    var kingBitmapData = resourceManager.getBitmapData('king');
    var sunBitmapData = resourceManager.getBitmapData('sun');
    var backgroundBitmapData = new BitmapData(230, 245, true, 0xFFF0F0F0);
    var kingBitmaps = new List<Bitmap>();

    var filters = [
      {'name': 'DropShadowFilter (black)', 'filter': new DropShadowFilter(10, PI / 4, Color.Black, 8, 8) },
      {'name': 'GlowFilter (red)', 'filter': new GlowFilter(Color.Red, 20, 20) },
      {'name': 'ColorMatrixFilter (grayscale)', 'filter': new ColorMatrixFilter.grayscale() },
      {'name': 'ColorMatrixFilter (invert)', 'filter': new ColorMatrixFilter.invert() },
      {'name': 'BlurFilter (radius 1)', 'filter': new BlurFilter(1, 1) },
      {'name': 'BlurFilter (radius 5)', 'filter': new BlurFilter(5, 5) },
      {'name': 'BlurFilter (radius 20)', 'filter': new BlurFilter(20, 20) },
      {'name': 'AlphaMaskFilter', 'filter': new AlphaMaskFilter(resourceManager.getBitmapData('sun'))}];

    //--------------------------------------------------------------------------------
    // Add kings with 8 different filters

    for(int i = 0; i < filters.length; i++) {

      var filter = filters[i]['filter'] as BitmapFilter;
      var name = filters[i]['name'] as String;
      var x = 235 * (i % 4);
      var y = 250 * (i ~/ 4);

      var backgroundBitmap = new Bitmap(backgroundBitmapData);
      backgroundBitmap.x = x;
      backgroundBitmap.y = y;
      addChild(backgroundBitmap);

      var kingBitmap = new Bitmap(kingBitmapData);
      kingBitmap.x = x + 40;
      kingBitmap.y =  y + 45;
      kingBitmap.filters = [filter];
      kingBitmap.applyCache(-20, -20, kingBitmapData.width + 40, kingBitmapData.height + 40);
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

    var matrix = filters.last['filter'].matrix;
    var bitmap = kingBitmaps.last;

    stage.juggler.transition(0.0, PI * 2 * 100, 600.0, TransitionFunction.linear, (value) {
      matrix.identity();
      matrix.translate(- sunBitmapData.width / 2, - sunBitmapData.height / 2);
      matrix.rotate(value);
      matrix.translate(60, 90 + sin(value) * 40);
      bitmap.refreshCache();
    });
  }
}
