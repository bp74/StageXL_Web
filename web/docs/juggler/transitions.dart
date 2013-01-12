import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

void main() {

  var TransitionFunctions = [

    { "name": "linear", "transition": TransitionFunction.linear },
    { "name": "sine", "transition": TransitionFunction.sine },
    { "name": "cosine", "transition": TransitionFunction.cosine },
    { "name": "random", "transition": TransitionFunction.random },

    { "name": "easeInQuadratic", "transition": TransitionFunction.easeInQuadratic },
    { "name": "easeOutQuadratic", "transition": TransitionFunction.easeOutQuadratic },
    { "name": "easeInOutQuadratic", "transition": TransitionFunction.easeInOutQuadratic },
    { "name": "easeOutInQuadratic", "transition": TransitionFunction.easeOutInQuadratic },

    { "name": "easeInCubic", "transition": TransitionFunction.easeInCubic },
    { "name": "easeOutCubic", "transition": TransitionFunction.easeOutCubic },
    { "name": "easeInOutCubic", "transition": TransitionFunction.easeInOutCubic },
    { "name": "easeOutInCubic", "transition": TransitionFunction.easeOutInCubic },

    { "name": "easeInQuartic", "transition": TransitionFunction.easeInQuartic },
    { "name": "easeOutQuartic", "transition": TransitionFunction.easeOutQuartic },
    { "name": "easeInOutQuartic", "transition": TransitionFunction.easeInOutQuartic },
    { "name": "easeOutInQuartic", "transition": TransitionFunction.easeOutInQuartic },

    { "name": "easeInQuintic", "transition": TransitionFunction.easeInQuintic },
    { "name": "easeOutQuintic", "transition": TransitionFunction.easeOutQuintic },
    { "name": "easeInOutQuintic", "transition": TransitionFunction.easeInOutQuintic },
    { "name": "easeOutInQuintic", "transition": TransitionFunction.easeOutInQuintic },

    { "name": "easeInCircular", "transition": TransitionFunction.easeInCircular },
    { "name": "easeOutCircular", "transition": TransitionFunction.easeOutCircular },
    { "name": "easeInOutCircular", "transition": TransitionFunction.easeInOutCircular },
    { "name": "easeOutInCircular", "transition": TransitionFunction.easeOutInCircular },

    { "name": "easeInSine", "transition": TransitionFunction.easeInSine },
    { "name": "easeOutSine", "transition": TransitionFunction.easeOutSine },
    { "name": "easeInOutSine", "transition": TransitionFunction.easeInOutSine },
    { "name": "easeOutInSine", "transition": TransitionFunction.easeOutInSine },

    { "name": "easeInExponential", "transition": TransitionFunction.easeInExponential },
    { "name": "easeOutExponential", "transition": TransitionFunction.easeOutExponential },
    { "name": "easeInOutExponential", "transition": TransitionFunction.easeInOutExponential },
    { "name": "easeOutInExponential", "transition": TransitionFunction.easeOutInExponential },

    { "name": "easeInBack", "transition": TransitionFunction.easeInBack },
    { "name": "easeOutBack", "transition": TransitionFunction.easeOutBack },
    { "name": "easeInOutBack", "transition": TransitionFunction.easeInOutBack },
    { "name": "easeOutInBack", "transition": TransitionFunction.easeOutInBack },

    { "name": "easeInElastic", "transition": TransitionFunction.easeInElastic },
    { "name": "easeOutElastic", "transition": TransitionFunction.easeOutElastic },
    { "name": "easeInOutElastic", "transition": TransitionFunction.easeInOutElastic },
    { "name": "easeOutInElastic", "transition": TransitionFunction.easeOutInElastic },

    { "name": "easeInBounce", "transition": TransitionFunction.easeInBounce },
    { "name": "easeOutBounce", "transition": TransitionFunction.easeOutBounce },
    { "name": "easeInOutBounce", "transition": TransitionFunction.easeInOutBounce },
    { "name": "easeOutInBounce", "transition": TransitionFunction.easeOutInBounce },

  ];

  for(int i = 0; i < TransitionFunctions.length / 4; i++)
  {
    var rowDiv = new html.DivElement();
    rowDiv.classes.add("row");
    html.query("#transitions").elements.add(rowDiv);

    for(int j = 0; j < 4; j++)
    {
      var name = TransitionFunctions[i * 4 + j]["name"];
      var transition = TransitionFunctions[i * 4 + j]["transition"];

      var cellDiv = drawTransition(name, transition);
      cellDiv.id = "cell";
      rowDiv.elements.add(cellDiv);
    }
  }

  html.document.body.elements.add(new html.Element.tag("br"));
  html.document.body.elements.add(new html.Element.tag("br"));
}


html.DivElement drawTransition(String name, num transitionFunction(num ratio)) {

  var div = new html.DivElement();
  div.classes.add("span3");
  div.style.height = "130px";
  //div.style.padding = "0px 5px 0px 5px";

  var canvasElement = new html.CanvasElement(width:200, height:140);
  canvasElement.style.position = "absolute";
  canvasElement.style.zIndex = "1";
  div.children.add(canvasElement);

  var headline = new html.DivElement();
  headline.text = name;
  headline.style.position = "relative";
  headline.style.zIndex = "2";
  headline.style.top = "6px";
  div.children.add(headline);

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
    var y = 109.5 - 79.0 * transitionFunction(ratio);
    graphics.lineTo(x, y);
  }

  graphics.strokeColor(0xFF0000FF, 2);

  stage.addChild(shape);
  stage.materialize();

  return div;
}



