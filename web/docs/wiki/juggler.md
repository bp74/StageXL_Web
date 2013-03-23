# The Juggler #

A basic building block in game development is a framework to move things around on the screen. The Juggler is a framework built right into dartflash and it provides animation capabilities and much more. If you are not familiar with the basics of the dartflash library, please read the [Introducing dartflash](wiki-articles.html?article=introduction) article first. 

Let's get started with a simple example. In the previous article you have learned about the Stage and the RenderLoop. The RenderLoop manages the continuous update of the screen and he also keeps track of the time that passes while the game is running. This time is important for the Juggler because all animations are functions over time. Therefore the RenderLoop also provides an instance of the Juggler. 

    var canvas = html.query('#stage');
    var stage = new Stage('myStage', canvas);
    var renderLoop = new RenderLoop();
    var juggler = renderLoop.juggler; 

## Tween ##

Now that we have an instance of the Juggler we can start to animate things. The simplest animation is to move an object from its current position to another position. The current position is know, you only have to provide the time (duration) and the target position. This kind of animation is often referred as tweening.

**tweening:** _Short for in-betweening, the process of generating intermediate frames between two states to give the appearance that the first state evolves smoothly into the second state. Tweening is a key process in all types of animation._

    var spaceship = new Spaceship();
    spaceship.x = 100;
    spaceship.y = 100;
    addChild(spaceShip);

    var tween = new Tween(spaceship, 2.0, TransitionFunction.linear);
    tween.animate("x", 500);
    tween.animate("y", 500);
    juggler.add(tween);

This example greates a spaceship and sets the current position. A Tween is created for the spaceship, the animation should last for 2.0 seconds and the transition should be linear over time. Most importantly the tween should animate the "x" and "y" properties of the spaceship to the desired values. Last but not least the tween if added to the juggler who will take care that the spaceship moves from its current position to the target position. When the tween is finished it is automatically removed from the juggler.

The Tween class does not only animate the position of display objects, it also animates all other properties like alpha, scale or rotation. To keep track of the progress of the animation you can set callbacks for start, update and complete. The delay property enables the deferred start of the animation.

    var tween = new Tween(spaceship, 2.0, TransitionFunction.linear);
    tween.animate("x", 500);
    tween.animate("y", 500);
    tween.onStart = () => print('tween start'); 
    tween.onComplete = () => print('tween complete'); 
    tween.delay = 1.0; 

Of course you can create multiple tweens with different parameters for the same or different display objects at the same time. One tween could animate the position while another tween could animate the alpha property.

## Transition Functions ##

A transition function defines the progress of the animation over time. The simplest transition is linear, where the progress of the animation is linear in relationship to time. Often animations look more natural when the transition accelerates or decelerates. Those transition functions are often called easing functions. 

The example for the Tween class already showed how to use a transition function. You can choose between many different functions which are provided by the dartflash library. There is an overview for all transition functions on the dartflash homepage, the image below just shows some of the common functions.

[http://www.dartflash.com/docs/transitions.html](http://www.dartflash.com/docs/transitions.html)

![Transition Functions](http://www.dartflash.com/assets/screenshot/transitionFunctions.jpg)

If none of the provided transition functions fulfills your needs you can simply build one of your own. The example below shows a custom transition function called "sawtooth". 

    // A transition function looks like this: 
    // num transition(num ratio)
    // ratio is the relative time of the transition (between 0.0 and 1.0)
    // returns the relative progress of the transition (between 0.0 and 1.0)

    var sawtooth = (ratio) => (ratio * 4.0).remainder(1.0);
    var tween = new Tween(spaceship, 2.0, sawtooth);

## Animatables ##

The example above showed how you add a Tween to the Juggler. In fact the Juggler not only takes Tween classes but all classes that implement the Animatable class. Therefore you can create your own classes and add it to the Juggler as long as it implements the Animatable class.

The Animatable class is very simple. It only has one method called 'advanceTime' which takes a time and returns a bool. This method is called by the Juggler on every frame for all Animatables added to the Juggler. The time parameter is the time that has passed since the last call. The boolean return value indicates if the Animatable is still active. If 'false' is returned, the Animatable will be automatically removed from the Juggler and therefore it will no longer be called. 

    abstract class Animatable {
      bool advanceTime(num time);
    }

A simple example is the performance demo on the dartflash homepage. Here we are using a class called FlyingFlag which extends the Bitmap class and implements the Animatable class. The Juggler manages the motion of all flags by calling the 'advanceTime' method of all FlyingFlags.

[http://www.dartflash.com/demos/performance.html](http://www.dartflash.com/demos/performance.html)

    class FlyingFlag extends Bitmap implements Animatable {
            
        // velocity of the flag
        num vx, vy;
    
        FlyingFlag(BitmapData bitmapData, this.vx, this.vy):super(bitmapData) {
          this.pivotX = bitmapData.width / 2;
          this.pivotY = bitmapData.height / 2;
        }

        bool advanceTime(num time) {
          var tx = x + vx * time;
          var ty = y + vy * time;
          if (tx > 910 || tx < 30) vx = -vx; else x = tx;
          if (ty > 470 || ty < 30) vy = -vy; else y = ty;
          return true;
        }
    }

### Delayed Call ###

One of the Animatables provided by the dartflash library out of the box besides the Tween class is the DelayedCall class. This class is not directly related to animations, but is very useful to control the flow of your game. The purpose of this class is obviously to delay the call to a function.

    var action = () => print("Action!");
        
    // Call action after 5.0 seconds
    var delayedAction = new DelayedCall(action, 5.0);
    juggler.add(delayedAction);
    
    // Call action 10 times every 1.0 seconds.
    var repeatAction = new DelayedCall(action, 1.0);
    repeatAction.repeatCount = 10;
    juggler.add(repeatAction);

Of course you can do similar things with the Timer class included in dart:async, but the advantage here is that the calls are synchronized with all the other animations and time related things happening in your game.

### Transition ###

The Transition class also implements the Animatable class. This Animatable is closely related to the Transition Functions shown above and allows you to animate any arbitrary value. As example you could fade the volume of a sound or count up the score in your game. 

    // count from 1000 to 2000 within 5.0 seconds.
    var transition = new Transition(1000, 2000, 5.0, TransitionFunction.linear);
    transition.roundToInt = true;
    transition.onUpdate = (num value) => print(value); 
    juggler.add(transition);

## Juggler ##

The Juggler class itself implements the Animatable class. This allows better control of the time in your game. As example you can add a button to pause the game, therefore you have to pause all animations and accordingly you have to pause the time. You can achieve this by creating your own juggler instance and add all animations to this juggler. Now you only have to add or remove this juggler to the juggler from the RenderLoop and you are done!

    var juggler = new Juggler();
    juggler.add(tween1);
    juggler.add(tween2);
    juggler.add(delayedCall);
	...

	_pauseGame() {
      renderLoop.juggler.remove(juggler);
    }

    _continueGame() {
      renderLoop.juggler.add(juggler);
    }

Another possible usecase is a time lapse juggler. You can implement a TimeLapseJuggler by extending the Juggler class and by overriding the 'advanceTime' method like this:

    class TimeLapseJuggler extends Juggler {
      num speed = 0.5;
      bool advanceTime(num time) {
        super.advanceTime(time * speed);
      }
    }

## Convenience methods ##

For some of the simple use cases the Juggler class provides convenience methods.

    // delay the call the 'action' by 5.0 seconds.
    juggler.delayCall(action, 5.0);

    // a linear transition for a value from 0.0 to 100.0 within 5.0 seconds.
    juggler.startTransition(0.0, 100.0, 5.0, 
      TransitionFunction.linear, (num value) => print(value));
   
    // remove all tweens on the 'spaceship' display object.
    juggler.removeTweens(spaceship);

## Credits ##

The Juggler framework was originally developed by my friend Daniel Sperl for ActionScript 3. Daniel is also the creator of the famous Sparrow and Starling frameworks. If you are not familiar with these frameworks and you are interested in iOS or Stage3D game development you should definitely visit his homepage: [www.gamua.com](http://www.gamua.com).
