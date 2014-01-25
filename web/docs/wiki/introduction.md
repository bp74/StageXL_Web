# Introducing StageXL  #

In the past and even today, most games on the Web are developed with Adobe Flash and ActionScript 3. With the rise of HTML5 and the lack of support for Flash on mobile devices, developers need and easy migration path. The Dart language is very similar to ActionScript 3 and the StageXL library itself provides the easy to use API of Flash to build games and other graphically rich content. Although StageXL is targeted to existing Flash developers, the API should be appealing to all other game developers too.

This article explains the basic building blocks of the StageXL library and should get you started.

## Display List ##

The rendering model of StageXL relies on the Display List concept. The display list is a hierarchy that contains all objects that should be visible on the screen. To build this hierarchy, three basic types of objects are available.

### The stage ###

The stage is the root of the display list hierarchy and is a wrapper over the HTML5 canvas element. Typically your game has one stage, only in a more advanced scenario you may use two stages on top of each other. 

### Display object container ###

As the name suggests, the display object container is a container of display objects. The stage itself is a display object container. You can add child display objects to the container and thereby build the hierarchy of the display list. If you move, scale or rotate the container, all children will behave accordingly. If you remove the container from the display list, all children will be removed aswell and consequently disappear from the screen.

### Display object ###

The display object is a visual element on the screen. The most basic display object is the Bitmap. A Bitmap contains pixel art and is obviously a very important building block for 2D games.

The hierarchy of the display list is also responsible for the depth management of your display objects. Child display objects are always in front of their predecessor.

## The Display List in action ##

The easiest way to understand the Display List is to look at some code. You can find this example and more advanced examples on the [StageXL github page](https://github.com/bp74/stagexl/tree/master/example). The first example shows the construction of a custom display object container called 'Painting'. 

The painting consists of a rectangluar background and four colorful boxes. The example introduces the BitmapData and Bitmap types. The BitmapData type contains pixels - either by creating a new BitmapData object filled with a flat color (as in our example), or by loading an image from the server. To make those pixels visible, you have to create a Bitmap display object and add it to the display object container (Painting). Please pay attention to the order of the boxes - the boxes added first are in the background, the boxes added later are in the foreground. The example also shows how to set the position of the Bitmap relative to its parent. 

![Modern Art Painting](http://www.stagexl.org/assets/screenshot/example01.png)

    class Painting extends DisplayObjectContainer {
      final List<int> colors = [Color.Red, Color.Green, Color.Blue, Color.Brown];
      
    Painting() {
        var background = new BitmapData(400, 300, false, Color.BlanchedAlmond);
        var backgroundBitmap = new Bitmap(background);
        addChild(backgroundBitmap);
    
        for(var i = 0; i < colors.length; i++) {
          var box = new BitmapData(100, 100, false, colors[i]);
          var boxBitmap = new Bitmap(box);
          boxBitmap.x = 80 + i * 50;
          boxBitmap.y = 60 + i * 30;
          addChild(boxBitmap);
        }
      }
    }

Now that we have created the Painting, we need to add the Painting itself to the display list to make it visible. As explained earlier, the root of the display list is the Stage. Therefore we create the Stage from a canvas element which is part of the HTML document. At the same time we have to take a look at the RenderLoop class. The render loop (also known as game loop) provides a constant stream of events that updates your game logic and draws the display list to the screen. Our painting example looks pretty static, but in fact it is updated 60 times per second - if the positions of the boxes would change over time, you would see a smooth animation.

    import 'dart:html' as html;
    import 'package:stagexl/stagexl.dart'; 
    
    void main() {
      var canvas = html.querySelector('#stage');
      var stage = new Stage(canvas);
      var renderLoop = new RenderLoop();
      renderLoop.addStage(stage);

      var painting = new Painting();
      painting.x = 40;
      painting.y = 40;
      stage.addChild(painting);
    }

## Interactive objects and events ##

All display objects are so called event dispatchers. This means that you can dispatch events or listen to events on each single display object. This is particularly useful for mouse or touch events, this way the objects in your game can individually react to user input. Another common and useful event is dispatched by the render loop whenever a new frame is entered. The following example shows a clock where the time is updated "onEnterFrame" and the color of the time is changed "onMouseClick". The example introduces another display object called TextField, which is used to display text on the screen.

![Running Clock](http://www.stagexl.org/assets/screenshot/clock.png)

    class Clock extends DisplayObjectContainer {
      List _colors = [Color.Black, Color.Blue, Color.Red, Color.Green];
      int _colorIndex = 0;
      TextField _textField;
      
      Clock() {
        _textField = new TextField();
        _textField.defaultTextFormat = new TextFormat("Verdana", 14, Color.Black);
        _textField.width = 200;
        _textField.height = 20;
        _textField.background = true;
        _textField.backgroundColor = Color.Yellow;
        _textField.text = new DateTime.now().toString();
        addChild(_textField);

        this.onEnterFrame.listen(_onEnterFrame);
        this.onMouseClick.listen(_onMouseClick);
      }
      
      _onEnterFrame(EnterFrameEvent e) {
        _textField.text = new DateTime.now().toString();
      }
      
      _onMouseClick(MouseEvent e) {
        _colorIndex = (_colorIndex + 1) % _colors.length;
        _textField.textColor = _colors[_colorIndex];
      }
    }

The enterFrame event could be used to animate display objects over time (as example you could change the "x" and "y" property of a display object). Please note that the StageXL library provides a dedicated framework with easing functions for this use case, therefore we do not recommend using the enterFrame for animations. Please visit the StageXL homepage for more details.

## Resource manager ##

A game consists of many different resources (or assets) like images and sounds. You can load all of those resources one by one, or use the resource manager to do the job. Using the resource manager is as easy as creating a new instance, adding all your resources (name  and URL) and calling a single load method. 

The example below adds three images to the resource manager. Each image is tagged with a unique name and the URL to the image is provided too. When the resource manager has finished loading all images, the load-future completes and you can access the BitmapDatas by the given unique name.

![World](http://www.stagexl.com/assets/screenshot/world.png)

    import 'dart:async';
    import 'dart:html' as html;
    import 'package:stagexl/stagexl.dart';
    
    void main() {
      var canvas = html.querySelector('#stage');
      var stage = new Stage(canvas);
      var renderLoop = new RenderLoop();
      renderLoop.addStage(stage);

      var resourceManager = new ResourceManager()
        ..addBitmapData("house", "../common/images/House.png")
        ..addBitmapData("sun", "../common/images/Sun.png")
        ..addBitmapData("tree", "../common/images/Tree.png");

      resourceManager.load().then((_) {
        var sun = new Bitmap(resourceManager.getBitmapData("sun"));
        var tree = new Bitmap(resourceManager.getBitmapData("tree"));
        var house = new Bitmap(resourceManager.getBitmapData("house"));

        // Not shown: set x and y properties of sun, tree, house

        stage.addChild(sun);
        stage.addChild(tree);
        stage.addChild(house);
      });
    }

## Advanced features ##

This introduction to StageXL should only cover the basic concepts of the display list and get you started. You can find more advanced samples and demos on the StageXL homepage and in the github repository. Hopefully we can talk about one of the advanced features in a future article.

### Sound ###

The StageXL library does not only cover the display list, but also the Sound APIs of Flash. The easy to use Sound API hides the implementation details and provides cross browser compatibility. 

### Juggler animation framework ###

The juggler animation framework is a powerful tool to bring your game objects to life. You can use built in tools like Tweens and easing functions, or you can implement the Animatable interface in your own classes. Later you can add "animatable" objects to the Juggler who keeps track of all your animations.

### Masks and Filters ###

Masks are used to limit the available display area of display objects. Masks can have any arbitrary shape, but most commonly they have a rectangular shape. Only the content within the mask is visible, all pixels outside of the mask are not drawn. Filters provide visual effects like drop shadow, glow or blur to BitmapDatas. 

### Runtimes ###

The StageXL library also contains runtimes for popular third party tools. This is a list of current and future runtimes supported by StageXL out of the box.

* [Texture Packer](http://www.codeandweb.com/texturepacker) - Sprite sheet generator.
* [Flump](http://threerings.github.com/flump) - Adobe Flash timeline animations.
* [Spine](http://esotericsoftware.com) - A 2D skeleton animation tool (coming soon).
* [Tiled Map Editor](http://www.mapeditor.org) - A map and level editor (coming later).
* [Particle Designer](http://www.71squared.com/en/particledesigner) - experimental but pretty cool.
