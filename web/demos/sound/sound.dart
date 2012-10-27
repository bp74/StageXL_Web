import 'dart:math';
import 'dart:html' as html;
import 'package:dartflash/dartflash.dart';

Stage stage;
RenderLoop renderLoop;
Resource resource;

var heyJudeNotes = [
  'C4','A3','A3','C4','D4','G3',
  'G3','A3','A3#','F4','F4','E4','C4','D4','C4','A3#','A3',
  'C4','D4','D4','D4','G4','F4','E4','F4','D4','C4',
  'F3','G3','A3','D4','C4','C4','A3#','A3','E3','F3'];

var heyJudeLyrics = [
  'Hey ','Jude, ',"don't ",'make ','it ','bad.<br>',
  'Take ','a ','sad ','song ','and ','make ','it ','better.<br>', '', '', '',
  'Remember ','','','to ','let ','her ','into ','','your ','heart.<br>',
  'Than ','you ','can ','start ', '', 'to ','make ','things ','better.', '', ' '];

//-----------------------------------------------------------------------------------

class Piano extends DisplayObjectContainer
{
  List noteNames = [
    'C3', 'C3#', 'D3', 'D3#', 'E3', 'F3', 'F3#', 'G3', 'G3#', 'A3', 'A3#', 'B3',
    'C4', 'C4#', 'D4', 'D4#', 'E4', 'F4', 'F4#', 'G4', 'G4#', 'A4', 'A4#', 'B4', 'C5'
  ];

  Map song;
  int songIndex;
  Bitmap songPointer;

  Piano(this.song)
  {
    // add all piano keys

    for(int n = 0, x = 0; n < noteNames.length; n++) {
      var noteName = noteNames[n];
      var noteSound = resource.getSound('Note${n+1}');

      var pianoKey = new PianoKey(this, noteName, noteSound);
      pianoKey.x = x + (noteName.endsWith('#') ? -16 : 0);
      pianoKey.y = 35;

      if (noteName.endsWith('#')) {
        addChild(pianoKey);
      } else {
        addChildAt(pianoKey, 0);
        x = x + 47;
      }
    }

    // prepare karaoke

    this.songIndex = 0;
    this.songPointer = new Bitmap(resource.getBitmapData('Finger'));
    this.songPointer.pivotX = 20;
    addChild(this.songPointer);
    this.update();
  }

  void checkSongNote(String noteName)
  {
    var notes = this.song['notes'];
    if (noteName == notes[this.songIndex]) {
      if (this.songIndex == notes.length - 1)
        resource.getSound('Cheer').play();
      this.songIndex++;
      this.update();
    }
  }

  void update()
  {
    var lyrics = this.song['lyrics'];
    var notes = this.song['notes'];

    // update karaoke lyrics

    var lyricsDiv = html.query('#lyrics');
    var current = -1;

    for(int w = 0, c = 0; w < lyrics.length; w++) {
      if (lyrics[w] != '') c = w;
      if (w == this.songIndex) current = c;
    }

    lyricsDiv.innerHTML = '';

    for(int w = 0; w < lyrics.length; w++) {
      if (w == current)
        lyricsDiv.addHTML('<span id="word">${lyrics[w]}</span>');
      else
        lyricsDiv.addHTML(lyrics[w]);
    }

    // update finger position

    if (this.songIndex < notes.length) {
      var noteName = notes[songIndex];
      for(int i = 0; i < this.numChildren; i++) {
        var displayObject = this.getChildAt(i);
        if (displayObject is PianoKey) {
          if (displayObject.noteName == noteName) {
            Tween tweenX = new Tween(this.songPointer, 0.4, Transitions.easeInOutCubic);
            tweenX.animate('x', displayObject.x + displayObject.width / 2);
            renderLoop.juggler.add(tweenX);
            Tween tweenY = new Tween(this.songPointer, 0.4, Transitions.sine);
            tweenY.animate('y', -10);
            renderLoop.juggler.add(tweenY);
          }
        }
      }
    } else {
      Tween tweenY = new Tween(this.songPointer, 0.4, Transitions.linear);
      tweenY.animate('alpha', 0);
      renderLoop.juggler.add(tweenY);
    }
  }

  void reset()
  {
    this.songIndex = 0;
    this.songPointer.alpha = 1;
    this.update();
  }
}

//-----------------------------------------------------------------------------------

class PianoKey extends DisplayObjectContainer
{
  Piano piano;
  String noteName;
  Sound sound;

  PianoKey(this.piano, this.noteName, this.sound)
  {
    var key = null;

    if (noteName.endsWith('#')) {
      key = 'KeyBlack';
    } else if (noteName.startsWith('C5')) {
      key = 'KeyWhite0';
    } else if (noteName.startsWith('C') || noteName.startsWith('F')) {
      key = 'KeyWhite1';
    } else if (noteName.startsWith('D') || noteName.startsWith('G') || noteName.startsWith('A')) {
      key = 'KeyWhite2';
    } else if (noteName.startsWith('E') || noteName.startsWith('B')) {
      key = 'KeyWhite3';
    }

    // draw the key

    var bitmapData = resource.getBitmapData(key);
    var bitmap = new Bitmap(bitmapData);
    this.addChild(bitmap);

    // print note on key

    var textFormat = new TextFormat('Helvetica,Arial', 10, 0x000000, align:TextFormatAlign.CENTER);
    textFormat.color = noteName.endsWith('#') ? Color.White : Color.Black;

    var textField = new TextField();
    textField.defaultTextFormat = textFormat;
    textField.text = noteName;
    textField.width = bitmapData.width;
    textField.height = 20;
    textField.mouseEnabled = false;
    textField.y = bitmapData.height - 20;
    addChild(textField);

    // add event handlers

    this.on.mouseDown.add(keyDown);
    this.on.mouseOver.add(keyDown);
    this.on.mouseUp.add(keyUp);
    this.on.mouseOut.add(keyUp);
  }

  void keyDown(MouseEvent me)
  {
    if (me.buttonDown) {
      this.sound.play();
      this.alpha = 0.7;
      this.piano.checkSongNote(this.noteName);
    }
  }

  void keyUp(MouseEvent me)
  {
      this.alpha = 1.0;
  }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

void main()
{
  // Initialize the Display List

  stage = new Stage('stage', html.document.query('#stage'));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // add a background image

  var backgroundBitmapData = new BitmapData(940, 500, false, 0xA0A0A0);
  var backgroundBitmap = new Bitmap(backgroundBitmapData);
  stage.addChild(backgroundBitmap);

  // load the images and sounds for the piano

  resource = new Resource();
  resource.addImage('KeyBlack','../common/images/piano/KeyBlack.png');
  resource.addImage('KeyWhite0','../common/images/piano/KeyWhite0.png');
  resource.addImage('KeyWhite1','../common/images/piano/KeyWhite1.png');
  resource.addImage('KeyWhite2','../common/images/piano/KeyWhite2.png');
  resource.addImage('KeyWhite3','../common/images/piano/KeyWhite3.png');
  resource.addImage('Finger','../common/images/piano/Finger.png');
  resource.addSound('Cheer','../common/sounds/Cheer.mp3');

  for(int i = 1; i <= 25; i++)
    resource.addSound('Note$i','../common/sounds/piano/Note$i.mp3');

  resource.load().then((res) {
    var piano = new Piano({'notes': heyJudeNotes, 'lyrics': heyJudeLyrics});
    piano.x = 120;
    piano.y = 30;
    stage.addChild(piano);

    html.query('#startOver').on.click.add((e) => piano.reset());
  });
}



