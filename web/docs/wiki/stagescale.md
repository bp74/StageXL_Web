# Scaling the Stage #

To scale the Stage you have to setup your HTML and also define some properties of your Stage object. Let's start with some basic properties of the Canvas element and the Stage object.

## Html Canvas ##

The Html Canvas element takes the width and height properties to define the horizontal and vertical pixels within the Canvas. For a simple Canvas whose size doesn't change, the markup will look like the example below. 

    <canvas id="myStage" width="800" height="600"></canvas>

To control the size of the Canvas, you have to set the width and height **stylesheet** properties of the Canvas. If you changed those stylesheet properties you will see that the size of the Canvas changes accordingly, but Html does not change the width and height properties of the Canvas automatically. As a result the content of the Canvas would be distorted. To avoid this distortion the Stage object adjusts the width and height properties to match the size of the Canvas on the screen.

    <canvas id="myStage" style="width:600px; height: 300px;" width="600" height="300"></canvas>

*After the width and height stylesheet properties have changed, the Stage will automatically change the width and height properties of the Canvas.*

## Stage ##

The Stage adapts the Canvas element to the Display List. If the Canvas size is changing, the Stage will automatically scale the Display List to match with the new Canvas size. You can control how the Display List is scaled with the *stageScaleMode* and *align* property. The exmample below shows the default configuration of the Stage.

    var canvas = html.querySelector('#myStage');
    var stage = new Stage(canvas);  
    stage.scaleMode = StageScaleMode.SHOW_ALL;
    stage.align = StageAlign.NONE;

It is also important to be aware of the coordinate system of the Stage and Display List. The Stage constructor takes two optional parameters to define the default coordinate system, if those parameters are not supplied the current width and height properties of the Canvas element  are used. 

    var canvas = html.querySelector('#myStage');
    var stage = new Stage(canvas, width: 800, height: 600);  

This way the Stage is using a coordinate system of 800x600 pixels, regardless of the size of the Stage. Even if the Canvas is much smaller or bigger, your Display Objects are still placed within a 800x600 grid. Please note that the size of this grid can change dependent on the scaleMode property. To get the current size of the Stage, you can query the *contentRectangle* property.

    var rectangle = stage.contentRectangle;

## StageScaleMode ##

The StageScaleMode defines how the Stage is scaled inside of the Canvas.

* **SHOW_ALL**: (Default) The Stage is scaled to fit inside the available Canvas area and the aspect ratio of the Display List is constant. To avoid distortions the Stage is extended to the left, right, top or bottom side.
* **NO_SCALE**: The Stage is not scaled and every pixel of the Stage corresponds with a pixel on the Canvas. If you use this scale mode your application should be capable of using the additional Stage area.
* **NO_BORDER**: The Stage is scaled to fit inside the available Canvas area and the aspect ratio of the Display List is constant. To avoid distortions the Stage is truncated on the left, right, top or bottom side.
* **EXACT_FIT**: The Stage is scaled to fit inside the available Canvas area and the aspect ratio of the Display List is adjusted. If the aspect ratio of the canvas is different to the Stage, the Display List will be distorted.

The following original 100w,100h image:

![original](http://www.stagexl.org/assets/screenshot/orig.png)

Placed on a stage initialized with:

	var stage = new Stage(canvas, width: 100, height: 100);
	stage.align = StageAlign.TOP_LEFT; 

Will display as follows when placed in an html canvas with a width of 200px and a height of 75px:

##### SHOW_ALL #####
![showall](http://www.stagexl.org/assets/screenshot/show_all.png)

##### NO_SCALE #####
![noscale](http://www.stagexl.org/assets/screenshot/no_scale.png)

##### NO_BORDER #####
![noborder](http://www.stagexl.org/assets/screenshot/no_border.png)

##### EXACT_FIT #####
![exactfit](http://www.stagexl.org/assets/screenshot/exact_fit.png)


## StageAlign ##

According to the StageScaleMode setting and the aspect ratio of the Stage and Canvas it is necessary to extended or truncated the available Stage area to fit inside the available Canvas area. To align the new Stage area you can set the Stage.align property to one of the following values.

* **NONE**: (Default) Don't align the Stage, therefore it will be in the center.
* **LEFT**: Align the Stage to the left edge.
* **RIGHT**: Align the Stage to the right edge.
* **BOTTOM**: Align the Stage to the bottom edge.
* **BOTTOM_LEFT**: Align the Stage to the bottom left corner.
* **BOTTOM_RIGHT**: Align the Stage to the bottom right corner.
* **TOP**: Align the Stage to the top edge.
* **TOP_LEFT**: Align the Stage to the top left corner.
* **TOP_RIGHT**: Align the Stage to the top right corner.

## Full Window Stage ##

A common use case is a Stage that fills the whole browser window. The content shouldn't be scaled if the browser window size changes. But the Stage should be extended to cover the available display size. To do this we set the StageScaleMode to 'NO\_SCALE' and the StageAlign to 'TOP\_LEFT'.

HTML/CSS (without enclosing head and body tags):

    <style type="text/css">
      body { margin: 0; padding: 0; overflow: hidden; }
      #stage { position: absolute; width: 100%; height: 100%; }
    </style>
    
    <canvas id="stage"></canvas>

Dart:

    var canvas = html.querySelector('#stage');
    var stage = new Stage(canvas);
    stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.align = StageAlign.TOP_LEFT;

This way you will get a Stage that fits exactly to the display area of the window. We didn't define the width and height attribute of the canvas element, because those attributes will change automatically to match the available display size. 

### Upscaling the Stage ###

Here are two other frequently used configurations:

Scale the Stage to fit within the available Canvas area. Show borders on the left/right or top/bottom side if the aspect ratio does not match. Never truncate any content from the Stage.

    var stage = new Stage(canvas);
    stage.scaleMode = StageScaleMode.SHOW_ALL;
    stage.align = StageAlign.NONE;

Scale the Stage to fill the whole Canvas area. If the aspect ratio does not match, truncate parts from the Stage, but never show any borders.

    var stage = new Stage(canvas);
    stage.scaleMode = StageScaleMode.NO_BORDER;
    stage.align = StageAlign.NONE;

## Getting Started Example ##

To understand the different StageScaleMode and StageAlign settings, it's best to try a little demo and play with the different settings. This exmaple shows a blue background Bitmap and a red circle Shape in the center. Resize the browser window to see the effect.

#### HTML Code ####

    <!DOCTYPE html>
    <html>
      <head>
        <title>Stage Scale Test</title>
        <style type="text/css">
          body { margin: 0; padding: 0; overflow: hidden; }
          #stage { position: absolute; width: 100%; height: 100%; }
          </style>
      </head>
      <body>
        <canvas id="stage"></canvas>
        <script type="application/dart" src="test.dart"></script>
        <script src="packages/browser/dart.js"></script>
      </body>
    </html>

#### Dart Code ####

	import 'dart:html' as html;
	import 'package:stagexl/stagexl.dart';
	
	void main() {
	  var canvas = html.querySelector('#stage');
	  var stage = new Stage(canvas, width: 800, height: 600);
	  stage.scaleMode = StageScaleMode.EXACT_FIT;
	  stage.align = StageAlign.NONE;
	
	  var renderLoop = new RenderLoop();
	  renderLoop.addStage(stage);
	
	  var bitmapData = new BitmapData(800, 600, true, Color.Blue);
	  var bitmap = new Bitmap(bitmapData);
	  stage.addChild(bitmap);
	
	  var shape = new Shape();
	  shape.graphics.ellipse(400, 300, 150, 150);
	  shape.graphics.fillColor(Color.Red);
	  stage.addChild(shape);
	
	  stage.onResize.listen((e) => print(stage.contentRectangle));
	}


