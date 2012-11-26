import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

void main() {

  var transitionTypes = [

    { "name": "linear", "transition": TransitionType.linear },
    { "name": "sine", "transition": TransitionType.sine },
    { "name": "cosine", "transition": TransitionType.cosine },
    { "name": "random", "transition": TransitionType.random },

    { "name": "easeInQuadratic", "transition": TransitionType.easeInQuadratic },
    { "name": "easeOutQuadratic", "transition": TransitionType.easeOutQuadratic },
    { "name": "easeInOutQuadratic", "transition": TransitionType.easeInOutQuadratic },
    { "name": "easeOutInQuadratic", "transition": TransitionType.easeOutInQuadratic },

    { "name": "easeInCubic", "transition": TransitionType.easeInCubic },
    { "name": "easeOutCubic", "transition": TransitionType.easeOutCubic },
    { "name": "easeInOutCubic", "transition": TransitionType.easeInOutCubic },
    { "name": "easeOutInCubic", "transition": TransitionType.easeOutInCubic },

    { "name": "easeInQuartic", "transition": TransitionType.easeInQuartic },
    { "name": "easeOutQuartic", "transition": TransitionType.easeOutQuartic },
    { "name": "easeInOutQuartic", "transition": TransitionType.easeInOutQuartic },
    { "name": "easeOutInQuartic", "transition": TransitionType.easeOutInQuartic },

    { "name": "easeInQuintic", "transition": TransitionType.easeInQuintic },
    { "name": "easeOutQuintic", "transition": TransitionType.easeOutQuintic },
    { "name": "easeInOutQuintic", "transition": TransitionType.easeInOutQuintic },
    { "name": "easeOutInQuintic", "transition": TransitionType.easeOutInQuintic },

    { "name": "easeInCircular", "transition": TransitionType.easeInCircular },
    { "name": "easeOutCircular", "transition": TransitionType.easeOutCircular },
    { "name": "easeInOutCircular", "transition": TransitionType.easeInOutCircular },
    { "name": "easeOutInCircular", "transition": TransitionType.easeOutInCircular },

    { "name": "easeInSine", "transition": TransitionType.easeInSine },
    { "name": "easeOutSine", "transition": TransitionType.easeOutSine },
    { "name": "easeInOutSine", "transition": TransitionType.easeInOutSine },
    { "name": "easeOutInSine", "transition": TransitionType.easeOutInSine },

    { "name": "easeInExponential", "transition": TransitionType.easeInExponential },
    { "name": "easeOutExponential", "transition": TransitionType.easeOutExponential },
    { "name": "easeInOutExponential", "transition": TransitionType.easeInOutExponential },
    { "name": "easeOutInExponential", "transition": TransitionType.easeOutInExponential },

    { "name": "easeInBack", "transition": TransitionType.easeInBack },
    { "name": "easeOutBack", "transition": TransitionType.easeOutBack },
    { "name": "easeInOutBack", "transition": TransitionType.easeInOutBack },
    { "name": "easeOutInBack", "transition": TransitionType.easeOutInBack },

    { "name": "easeInElastic", "transition": TransitionType.easeInElastic },
    { "name": "easeOutElastic", "transition": TransitionType.easeOutElastic },
    { "name": "easeInOutElastic", "transition": TransitionType.easeInOutElastic },
    { "name": "easeOutInElastic", "transition": TransitionType.easeOutInElastic },

    { "name": "easeInBounce", "transition": TransitionType.easeInBounce },
    { "name": "easeOutBounce", "transition": TransitionType.easeOutBounce },
    { "name": "easeInOutBounce", "transition": TransitionType.easeInOutBounce },
    { "name": "easeOutInBounce", "transition": TransitionType.easeOutInBounce },

  ];

  for(int i = 0; i < transitionTypes.length / 4; i++)
  {
    var rowDiv = new html.DivElement();
    rowDiv.classes.add("row");
    html.query("#transitions").elements.add(rowDiv);

    for(int j = 0; j < 4; j++)
    {
      var name = transitionTypes[i * 4 + j]["name"];
      var transition = transitionTypes[i * 4 + j]["transition"];

      var cellDiv = drawTransition(name, transition);
      cellDiv.id = "cell";
      rowDiv.elements.add(cellDiv);
    }
  }

  html.document.body.elements.add(new html.Element.tag("br"));
  html.document.body.elements.add(new html.Element.tag("br"));
}


html.DivElement drawTransition(String name, num transitionType(num ratio)) {

  var div = new html.DivElement();
  div.classes.add("span3");
  div.style.height = "130px";
  //div.style.padding = "0px 5px 0px 5px";

  var canvasElement = new html.CanvasElement(width:200, height:140);
  canvasElement.style.position = "absolute";
  canvasElement.style.zIndex = "1";
  div.elements.add(canvasElement);

  var headline = new html.DivElement();
  headline.text = name;
  headline.style.position = "relative";
  headline.style.zIndex = "2";
  headline.style.top = "6px";
  div.elements.add(headline);

  var stage = new Stage("stage", canvasElement);
  var shape = new Shape();
  var graphics = shape.graphics;

  graphics.beginPath();
  graphics.moveTo(0.5, 30.5);
  graphics.lineTo(199.5, 30.5);
  graphics.lineTo(199.5, 109.5);
  graphics.lineTo(0.5, 109.5);
  graphics.closePath();

  graphics.strokeColor(0xFF000000);
  graphics.fillColor(0xFFDFDFDF);

  graphics.beginPath();
  graphics.moveTo(0.5, 109.5);

  for(int i = 0; i <= 199; i++) {
    var ratio = i / 199.0;
    var x = 0.5 + ratio * 199.0;
    var y = 109.5 - 79.0 * transitionType(ratio);
    graphics.lineTo(x, y);
  }

  graphics.strokeColor(0xFF0000FF, 2);

  stage.addChild(shape);
  stage.materialize();

  return div;
}



