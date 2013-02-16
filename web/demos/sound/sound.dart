import 'dart:math';
import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;

var heyJudeNotes = [
  'C4', 'A3', 'A3', 'C4', 'D4', 'G3',
  'G3', 'A3', 'A3#', 'F4', 'F4', 'E4', 'C4', 'D4', 'C4', 'A3#', 'A3',
  'C4', 'D4', 'D4', 'D4', 'G4', 'F4', 'E4', 'F4', 'D4', 'C4',
  'F3', 'G3', 'A3', 'D4', 'C4', 'C4', 'A3#', 'A3', 'E3', 'F3'];

var heyJudeLyrics = [
  'Hey ', 'Jude, ', "don't ", 'make ', 'it ', 'bad.<br>',
  'Take ', 'a ', 'sad ', 'song ', 'and ', 'make ', 'it ', 'better.<br>',  '',  '',  '',
  'Remember ', '', '', 'to ', 'let ', 'her ', 'into ', '', 'your ', 'heart.<br>',
  'Than ', 'you ', 'can ', 'start ', '', 'to ', 'make ', 'things ', 'better.', '', ' '];

List pianoNotes = [
  'C3', 'C3#', 'D3', 'D3#', 'E3', 'F3', 'F3#', 'G3', 'G3#', 'A3', 'A3#', 'B3',
  'C4', 'C4#', 'D4', 'D4#', 'E4', 'F4', 'F4#', 'G4', 'G4#', 'A4', 'A4#', 'B4', 'C5'];

//-----------------------------------------------------------------------------------

class Piano extends DisplayObjectContainer {
  
  List songNotes;
  List songLyrics;
  int noteIndex;
  Bitmap noteFinger;

  Piano(this.songNotes, this.songLyrics) {
    
    // add all piano keys

    for(int n = 0, x = 0; n < pianoNotes.length; n++) {
      var pianoKey = new PianoKey(this, pianoNotes[n], resourceManager.getSound('Note${n+1}'));
      pianoKey.x = x;
      pianoKey.y = 35;

      if (pianoNotes[n].endsWith('#')) {
        pianoKey.x = x - 16;
        addChild(pianoKey);
      } else {
        addChildAt(pianoKey, 0);
        x = x + 47;
      }
    }

    // prepare karaoke

    this.noteIndex = 0;
    this.noteFinger = new Bitmap(resourceManager.getBitmapData('Finger'));
    this.noteFinger.pivotX = 20;
    addChild(this.noteFinger);
    this.update();
  }

  void checkSongNote(String note) {
    
    // is it the next note of the song?

    if (this.noteIndex < songNotes.length && songNotes[this.noteIndex] == note) {
      if (this.noteIndex == songNotes.length - 1)
        resourceManager.getSound('Cheer').play();
      this.noteIndex++;
      this.update();
    }
  }

  void update() {
    
    // update karaoke lyrics

    var lyricsDiv = html.query('#lyrics');
    var wordIndex = -1;

    lyricsDiv.innerHtml = '';

    for(int w = 0, last = 0; w < songLyrics.length; w++)  {
      if (songLyrics[w] != '') last = w;
      if (w == this.noteIndex) wordIndex = last;
    }

    for(int w = 0; w < songLyrics.length; w++) {
      if (w == wordIndex)
        lyricsDiv.appendHtml('<span id="word">${songLyrics[w]}</span>');
      else
        lyricsDiv.appendHtml(songLyrics[w]);
    }

    // update finger position

    if (this.noteIndex < songNotes.length) {
      for(int i = 0; i < this.numChildren; i++) {
        var displayObject = this.getChildAt(i);
        if (displayObject is PianoKey) {
          if (displayObject.note == songNotes[noteIndex]) {
            this.noteFinger.y = 0;
            Tween tweenX = new Tween(this.noteFinger, 0.4, TransitionFunction.easeInOutCubic);
            tweenX.animate('x', displayObject.x + displayObject.width / 2);
            Tween tweenY = new Tween(this.noteFinger, 0.4, TransitionFunction.sine);
            tweenY.animate('y', -10);
            renderLoop.juggler.removeTweens(this.noteFinger);
            renderLoop.juggler.add(tweenX);
            renderLoop.juggler.add(tweenY);
          }
        }
      }
    } else {
      Tween tweenY = new Tween(this.noteFinger, 0.4, TransitionFunction.linear);
      tweenY.animate('alpha', 0);
      renderLoop.juggler.add(tweenY);
    }
  }

  void reset() {
    this.noteIndex = 0;
    this.noteFinger.alpha = 1;
    this.update();
  }
}

//-----------------------------------------------------------------------------------

class PianoKey extends Sprite {
  
  Piano piano;
  String note;
  Sound sound;

  PianoKey(this.piano, this.note, this.sound) {
    
    var key = null;

    if (note.endsWith('#')) {
      key = 'KeyBlack';
    } else if (note.startsWith('C5')) {
      key = 'KeyWhite0';
    } else if (note.startsWith('C') || note.startsWith('F')) {
      key = 'KeyWhite1';
    } else if (note.startsWith('D') || note.startsWith('G') || note.startsWith('A')) {
      key = 'KeyWhite2';
    } else if (note.startsWith('E') || note.startsWith('B')) {
      key = 'KeyWhite3';
    }

    // draw the key

    var bitmapData = resourceManager.getBitmapData(key);
    var bitmap = new Bitmap(bitmapData);
    this.addChild(bitmap);

    // print note on key

    var textFormat = new TextFormat('Helvetica,Arial', 10, 0x000000, align:TextFormatAlign.CENTER);
    textFormat.color = note.endsWith('#') ? Color.White : Color.Black;

    var textField = new TextField();
    textField.defaultTextFormat = textFormat;
    textField.text = note;
    textField.width = bitmapData.width;
    textField.height = 20;
    textField.mouseEnabled = false;
    textField.y = bitmapData.height - 20;
    addChild(textField);

    // add event handlers

    this.useHandCursor = true;
    this.onMouseDown.listen(keyDown);
    this.onMouseOver.listen(keyDown);
    this.onMouseUp.listen(keyUp);
    this.onMouseOut.listen(keyUp);
  }

  void keyDown(MouseEvent me) {
    
    if (me.buttonDown) {
      this.sound.play();
      this.alpha = 0.7;
      this.piano.checkSongNote(this.note);
    }
  }

  void keyUp(MouseEvent me) {
      this.alpha = 1.0;
  }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

void main() {
  
  // Initialize the Display List

  stage = new Stage('stage', html.document.query('#stage'));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the images and sounds for the piano

  resourceManager = new ResourceManager()
    ..addBitmapData('KeyBlack','../common/images/piano/KeyBlack.png')
    ..addBitmapData('KeyWhite0','../common/images/piano/KeyWhite0.png')
    ..addBitmapData('KeyWhite1','../common/images/piano/KeyWhite1.png')
    ..addBitmapData('KeyWhite2','../common/images/piano/KeyWhite2.png')
    ..addBitmapData('KeyWhite3','../common/images/piano/KeyWhite3.png')
    ..addBitmapData('Finger','../common/images/piano/Finger.png')
    ..addBitmapData('Background','../common/images/piano/Background.jpg')
    ..addSound('Cheer','../common/sounds/Cheer.mp3');

  for(int i = 1; i <= 25; i++)
    resourceManager.addSound('Note$i','../common/sounds/piano/Note$i.mp3');

  resourceManager.load().then((res) {
    var background = new Bitmap(resourceManager.getBitmapData('Background'));
    stage.addChild(background);

    var piano = new Piano(heyJudeNotes, heyJudeLyrics);
    piano.x = 120;
    piano.y = 30;
    stage.addChild(piano);

    html.query('#startOver').onClick.listen((e) => piano.reset());
  });
}
