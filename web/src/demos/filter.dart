part of stagexl_demos;

class FilterDemo extends DisplayObjectContainer {
  
  final List _filters = [
    {'name': 'DropShadowFilter (black)', 'filter': new DropShadowFilter(10, PI / 4, Color.Black, 0.8, 8, 8) },
    {'name': 'GlowFilter (red)', 'filter': new GlowFilter(Color.Red, 1.0, 20, 20) },
    {'name': 'ColorMatrixFilter (grayscale)', 'filter': new ColorMatrixFilter.grayscale() },
    {'name': 'ColorMatrixFilter (invert)', 'filter': new ColorMatrixFilter.invert() },
    {'name': 'BlurFilter (radius 1)', 'filter': new BlurFilter(1, 1) },
    {'name': 'BlurFilter (radius 5)', 'filter': new BlurFilter(5, 5) },
    {'name': 'BlurFilter (radius 10)', 'filter': new BlurFilter(10, 10) },
    {'name': 'BlurFilter (radius 20)', 'filter': new BlurFilter(20, 20) }
  ];
    
  FilterDemo() {

    var targetBitmapData = new BitmapData(940, 500, true, 0x000000);
    var sourceBitmapData = resourceManager.getBitmapData('king');
    var backgroundBitmapData = new BitmapData(230, 245, true, 0xFFF0F0F0);

    var targetBitmap = new Bitmap(targetBitmapData);
    addChild(targetBitmap);

    for(int i = 0; i < _filters.length; i++) {
      
      var x = 235 * (i % 4);
      var y = 250 * (i ~/ 4);
      var filter = _filters[i]['filter'] as BitmapFilter;
      var name = _filters[i]['name'] as String;
      var sourceRectangle = new Rectangle(0, 0, sourceBitmapData.width, sourceBitmapData.height);
      var targetPoint = new Point(x + 40, y + 45);
      
      targetBitmapData.applyFilter(sourceBitmapData, sourceRectangle, targetPoint, filter);

      var backgroundBitmap = new Bitmap(backgroundBitmapData);
      backgroundBitmap.x = x;
      backgroundBitmap.y = y;
      addChildAt(backgroundBitmap, 0);

      var textField = new TextField();
      textField.defaultTextFormat = new TextFormat('Helvetica Neue, Helvetica, Arial', 14, Color.Black);
      textField.x = x + 5;
      textField.y = y + 5;
      textField.width = 200;
      textField.text = name;
      addChild(textField);
    }
  }
}
