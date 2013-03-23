# Drawing Vector Shapes #

Often it is useful to draw graphics as vector shapes. Those graphics can be scaled without loosing precision and the download size is much smaller compared to a raster images. Below you can see a cloud made out of vectors following a path which is filled and outlined. 

![Cloud Shape](http://www.dartflash.com/assets/screenshot/cloudShape.jpg)

    // Create a new Shape Display Object.
    Shape shape = new Shape();
    
    // Draw a path to form a cloud.
    shape.graphics.beginPath();
    shape.graphics.moveTo(170, 80);
    shape.graphics.bezierCurveTo(130, 100, 130, 150, 230, 150);
    shape.graphics.bezierCurveTo(250, 180, 320, 180, 340, 150);
    shape.graphics.bezierCurveTo(420, 150, 420, 120, 390, 100);
    shape.graphics.bezierCurveTo(430, 40, 370, 30, 340, 50);
    shape.graphics.bezierCurveTo(320, 5, 250, 20, 250, 50);
    shape.graphics.bezierCurveTo(200, 5, 150, 20, 170, 80);
    shape.graphics.closePath();
   
    // Fill and Stroke the path.
    shape.graphics.fillColor(0xFF8ED6FF);
    shape.graphics.strokeColor(Color.Blue, 5);

## Paths ##

The first thing you have to do is define a path. A path is made out of lines and curves. Use the following methods to draw your path and define a geometrical shape. Allways start with beginPath() and end with closePath().

* beginPath()
* closePath()
* moveTo(num x, num y)
* lineTo(num x, num y)
* arcTo(num controlX, num controlY, num endX, num endY, num radius)
* quadraticCurveTo(num controlX, num controlY, num endX, num endY)
* bezierCurveTo(num controlX1, num controlY1, num controlX2, num controlY2, num endX, num endY)
* arc(num x, num y, num radius, num startAngle, num endAngle, bool antiClockwise)
* rect(num x, num y, num width, num height)
* rectRound(num x, num y, num width, num height, num ellipseWidth, num ellipseHeight)
* circle(num x, num y, num radius)
* ellipse(num x, num y, num width, num height)

Sample:

    graphics.beginPath();
    graphics.moveTo(170, 80);
    graphics.bezierCurveTo(130, 100, 130, 150, 230, 150);
    graphics.bezierCurveTo(250, 180, 320, 180, 340, 150);
    graphics.bezierCurveTo(420, 150, 420, 120, 390, 100);
    graphics.bezierCurveTo(430, 40, 370, 30, 340, 50);
    graphics.bezierCurveTo(320, 5, 250, 20, 250, 50);
    graphics.bezierCurveTo(200, 5, 150, 20, 170, 80);
    graphics.closePath();
	

## Stroke ##

Call a stroke method to draw a line along the path you defined before.

* strokeColor(int color, int width, String joints, String caps)
* strokeGradient(GraphicsGradient gradient, int width, String joints, String caps)
* strokePattern(GraphicsPattern pattern, int width, String joints, String caps)
 
(Default values: width = 1, joints = JointStyle.ROUND, caps = CapsStyle.ROUND )
   
    graphics.strokeColor(0xFF00FF00, 5);


## Fill ##
 
Call a fill method to fill the arae of the path you defined before.

* fillColor(int color)
* fillGradient(GraphicsGradient gradient)
* fillPattern(GraphicsPattern pattern)

Sample:

    graphics.fillColor(Color.Red);

## Gradients and Patterns ##

The stroke and fill methods can not only be used with solid colors, but also with gradients and patters. Below you can learn how to create gradient and patterns.

#### Gradients ####

Use a linear or radial color gradient to stroke or fill your path.

* GraphicsGradient.linear(num startX, num startY, num endX, num endY)
* GraphicsGradient.radial(num startX, num startY, num startRadius, num endX, num endY, num endRadius)

Sample:

    GraphicsGradient gradient = new GraphicsGradient.linear(230, 0, 370, 200);
    gradient.addColorStop(0, 0xFF8ED6FF);
    gradient.addColorStop(1, 0xFF004CB3);
    graphics.fillGradient(gradient);


#### Patterns ####

Use a BitmapData to stroke or fill your path. Use an optional matrix transformation to rotate, scale or translate the BitmapData.

* GraphicsPattern.repeat(BitmapData bitmapData, Matrix matrix)
* GraphicsPattern.repeatX(BitmapData bitmapData, Matrix matrix)
* GraphicsPattern.repeatY(BitmapData bitmapData, Matrix matrix)
* GraphicsPattern.noRepeat(BitmapData bitmapData, Matrix matrix)

Sample:

    Matrix matrix = new Matrix.identity();
    matrix.rotate(Math.PI / 4);
    matrix.scale(0.5, 0.5);

    GraphicsPattern pattern = new GraphicsPattern.repeat(bitmapData, matrix);
    graphics.fillPattern(pattern);

