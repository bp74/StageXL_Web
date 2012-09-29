#import('dart:math');
#import('dart:html', prefix:'html');
#import('package:dartflash/dartflash.dart');

Resource resource;

void main()
{
  // Initialize the Display List

  Stage stage = new Stage('myStage', html.document.query('#stage'));

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);


  TextField textField1 = new TextField();
  textField1.defaultTextFormat = new TextFormat('Helvetica,Arial', 14, Color.DarkGray, bold:true);
  textField1.text = 'ToDo: show a cool demo ...';
  textField1.x = 10;
  textField1.y = 10;
  textField1.width = 920;
  textField1.height = 20;
  stage.addChild(textField1);
}
