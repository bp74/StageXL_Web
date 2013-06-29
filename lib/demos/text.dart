part of stagexl_demos;

class TextDemo extends DisplayObjectContainer {

  final String text = 
'Filet mignon leberkas pig pork chop biltong, short loin strip steak turkey brisket ' 
'venison. Pastrami venison pancetta, leberkas pork chop chicken prosciutto beef ribs '
'bresaola kielbasa swine biltong capicola. Hamburger beef ribs ball tip drumstick salami '  
'pig. Capicola pork loin shank, salami chicken hamburger tail. Sirloin spare ribs '
'ground round cow strip steak prosciutto swine bacon corned beef.';

  TextDemo() {

    var textField1 = new TextField();
    textField1.defaultTextFormat = new TextFormat('Helvetica,Arial', 14, Color.Green, bold:true, italic:true);
    textField1.text = text;
    textField1.x = 10;
    textField1.y = 10;
    textField1.width = 920;
    textField1.height = 20;
    addChild(textField1);

    //------------------------------------------------------------------

    var textField2 = new TextField();
    textField2.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Red);
    textField2.text = text;
    textField2.x = 10;
    textField2.y = 50;
    textField2.width = 200;
    textField2.height = 300;
    textField2.wordWrap = true;
    addChild(textField2);

    //------------------------------------------------------------------

    var textField3 = new TextField();
    textField3.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Blue, align:TextFormatAlign.RIGHT);
    textField3.text = text;
    textField3.x = 300;
    textField3.y = 50;
    textField3.width = 200;
    textField3.height = 300;
    textField3.wordWrap = true;
    addChild(textField3);

    //------------------------------------------------------------------

    var textField4 = new TextField();
    textField4.defaultTextFormat = new TextFormat('Caesar Dressing', 30, Color.Black, align:TextFormatAlign.CENTER);
    textField4.text = text;
    textField4.x = 590;
    textField4.y = 50;
    textField4.width = 340;
    textField4.height = 300;
    textField4.wordWrap = true;
    addChild(textField4);    
  }
}
