part of stagexl_demos;

class TweenerDemo extends DisplayObjectContainer {
  
  TweenerDemo() {
    var textField1 = new TextField();
    textField1.defaultTextFormat = new TextFormat('Helvetica,Arial', 14, Color.DarkGray, bold:true);
    textField1.text = 'ToDo: show a cool demo ...';
    textField1.x = 10;
    textField1.y = 10;
    textField1.width = 920;
    textField1.height = 20;
    addChild(textField1);
  }
}

