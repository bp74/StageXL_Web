# Scaling the Stage #

To scale the Stage you have to setup your HTML and also define some properties of your Stage object. There are two properties which define the scaling and the alignment of the content of the Stage.

### Html Canvas ###

The Html canvas element takes the attributes width and height. Note that this two attributes define the logical size of the canvas and they are different from the style.width and style.height attributes. Only if you don't set the style attributes the width and height attributes will also define the display size of the canvas element in pixels.

    <canvas id="stage" width="800" height="600"></canvas>

The example above defines a logical width and height of 800x600 pixels. This is also the size of the Stage! If you apply different CSS values, the display size will vary from this logical width and height.

### StageScaleMode ###

The StageScaleMode defines how the Stage is scaled on the screen. The default is "SHOW\_ALL" but you can change the scale mode by setting the Stage.scaleMode property.

* **SHOW\_ALL**: The Stage is scaled to fit into the available display area. The aspect ratio of the content is not changed. If the aspect ratio of the display area differs to the original aspect ratio you will get additional Stage area on the left/right or top/bottom edge of the original Stage.
* **NO\_SCALE**: The Stage is not scaled and therefore every pixel of the Stage corresponds with a pixel of the display area. If you use this scale mode your application should be capable of using the additional Stage area if the display size changes.
* **NO\_BORDER**: The Stage is scaled to fit into the available display area. The aspect ratio of the content is not changed. If the aspect ratio of the display area differs to the original aspect ratio the left/right or top/bottom edge of the original Stage will be cut off.
* **EXACT_FIT**: The Stage is scaled to fit exactly into the available display area. The aspect ratio of the content will change. If the aspect ratio of the display area differs to the original aspect ratio the content will be distorted.

### StageAlign ###

According to the StageScaleMode setting, the aspect ratio of the Stage and the display size it is possible that the original Stage is extended or truncated to a new Stage to fit into the available display area. To align the new Stage to the display area you can set the Stage.align property to one of the following values. The default value is NONE.

* **NONE**: Don't align the Stage, therefore it will be in the center.
* **LEFT**: Align the Stage to the left edge.
* **RIGHT**: Align the Stage to the right edge.
* **BOTTOM**: Align the Stage to the bottom edge.
* **BOTTOM\_LEFT**: Align the Stage to the bottom left corner.
* **BOTTOM\_RIGHT**: Align the Stage to the bottom right corner.
* **TOP**: Align the Stage to the top edge.
* **TOP\_LEFT**: Align the Stage to the top left corner.
* **TOP\_RIGHT**: Align the Stage to the top right corner.

## Full Window Stage ##

A common use case is a Stage that fills the whole browser window. The content shouldn't be scaled if the browser window size changes. But the Stage should be extended to cover the available display size. To do this we set the StageScaleMode to 'NO\_SCALE' and the StageAlign to 'TOP\_LEFT'.

HTML/CSS (without enclosing head and body tags):

    <style type="text/css">
      body { margin: 0; padding: 0 }
      #stage { position: absolute; width: 100%; height: 100%; overflow: hidden }
    </style>
    
    <canvas id="stage"></canvas>

Dart:

    var canvas = html.query('#stage');
    var stage = new Stage('myStage', canvas);
    stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.align = StageAlign.TOP_LEFT;

This way you will get a Stage that fits exactly to the display area of the window. We didn't define the width and height attribute of the canvas element, because those attributes will change automatically to match the available display size. 