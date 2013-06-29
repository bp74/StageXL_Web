part of stagexl_demos;

class SoundDemo extends DisplayObjectContainer{
  
  final List<String> _heyJudeNotes = [
    'C4', 'A3', 'A3', 'C4', 'D4', 'G3',
    'G3', 'A3', 'A3#', 'F4', 'F4', 'E4', 'C4', 'D4', 'C4', 'A3#', 'A3',
    'C4', 'D4', 'D4', 'D4', 'G4', 'F4', 'E4', 'F4', 'D4', 'C4',
    'F3', 'G3', 'A3', 'D4', 'C4', 'C4', 'A3#', 'A3', 'E3', 'F3'];

  final List<String> _heyJudeLyrics = [
    'Hey ', 'Jude, ', "don't ", 'make ', 'it ', 'bad.<br>',
    'Take ', 'a ', 'sad ', 'song ', 'and ', 'make ', 'it ', 'better.<br>',  '',  '',  '',
    'Remember ', '', '', 'to ', 'let ', 'her ', 'into ', '', 'your ', 'heart.<br>',
    'Than ', 'you ', 'can ', 'start ', '', 'to ', 'make ', 'things ', 'better.', '', ' '];

  SoundDemo() {
    
    var background = new Bitmap(resourceManager.getBitmapData('Background'));
    addChild(background);
  
    var piano = new Piano(_heyJudeNotes, _heyJudeLyrics);
    piano.x = 120;
    piano.y = 30;
    addChild(piano);
  
    html.query('#startOver').onClick.listen((e) => piano.resetSong());
  }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

class Piano extends DisplayObjectContainer {

  final List<String> songNotes;
  final List<String> songLyrics;
  
  final List<String> _pianoNotes = [
    'C3', 'C3#', 'D3', 'D3#', 'E3', 'F3', 'F3#', 'G3', 'G3#', 'A3', 'A3#', 'B3',
    'C4', 'C4#', 'D4', 'D4#', 'E4', 'F4', 'F4#', 'G4', 'G4#', 'A4', 'A4#', 'B4', 'C5'];
  
  Map<String, PianoKey> _pianoKeys = new Map<String, PianoKey>();
  Bitmap _karaokeFinger;
  int _songNoteIndex = 0;
  
  Piano(this.songNotes, this.songLyrics) {
    
    // add piano keys
    for(int n = 0, x = 0; n < _pianoNotes.length; n++) {
      var sound = resourceManager.getSound('Note${n+1}');
      var pianoNote = _pianoNotes[n];
      var pianoKey = _pianoKeys[pianoNote] = new PianoKey(this, pianoNote, sound);
      
      if (pianoNote.endsWith('#')) {
        pianoKey.x = x - 16;
        pianoKey.y = 35;
        addChild(pianoKey);
      } else {
        pianoKey.x = x;
        pianoKey.y = 35;
        addChildAt(pianoKey, 0);
        x = x + 47;
      }
    }

    // prepare karaoke finger
    _karaokeFinger = new Bitmap(resourceManager.getBitmapData('Finger'));
    _karaokeFinger.pivotX = 20;
    addChild(_karaokeFinger);
    
    _updateKaraoke();
  }

  //---------------------------------------------------------------------------------

  checkSongNote(String note) {
    
    // is it the next note of the song?
    if (_songNoteIndex < songNotes.length && songNotes[_songNoteIndex] == note) {
      if (_songNoteIndex == songNotes.length - 1)
        resourceManager.getSound('Cheer').play();
      
      _songNoteIndex++;
      _updateKaraoke();
    }
  }

  //---------------------------------------------------------------------------------

  resetSong() {
    _songNoteIndex = 0;
    _karaokeFinger.alpha = 1;
    _updateKaraoke();
  }
  
  //---------------------------------------------------------------------------------

  _updateKaraoke() {
    
    // update karaoke lyrics
    var lyricsDiv = html.query('#lyrics');
    var wordIndex = -1;
    lyricsDiv.innerHtml = '';

    for(int w = 0, last = 0; w < songLyrics.length; w++)  {
      if (songLyrics[w] != '') last = w;
      if (w == this._songNoteIndex) wordIndex = last;
    }

    for(int w = 0; w < songLyrics.length; w++) {
      if (w == wordIndex) {
        lyricsDiv.appendHtml('<span id="word">${songLyrics[w]}</span>');
      } else {
        lyricsDiv.appendHtml(songLyrics[w]);
      }
    }

    // update finger position
    if (_songNoteIndex < songNotes.length) {
      var songNote = songNotes[_songNoteIndex];
      if (_pianoKeys.containsKey(songNote)) {
        var pianoKey = _pianoKeys[songNote];
        juggler.removeTweens(_karaokeFinger);
        _karaokeFinger.y = 0;
            
        var tweenX = new Tween(this._karaokeFinger, 0.4, TransitionFunction.easeInOutCubic);
        var tweenY = new Tween(this._karaokeFinger, 0.4, TransitionFunction.sine);
        tweenX.animate.x.to(pianoKey.x + pianoKey.width / 2);
        tweenY.animate.y.to(-10);
        juggler.add(tweenX);
        juggler.add(tweenY);
      }
    } else {
      var tween = new Tween(_karaokeFinger, 0.4, TransitionFunction.linear);
      tween.animate.alpha.to(0);
      juggler.add(tween);
    }
  }
}

//-----------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------

class PianoKey extends Sprite {
  
  final Piano piano;
  final String note;
  final Sound sound;

  PianoKey(this.piano, this.note, this.sound) {
    
    String key;

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
    var textColor = note.endsWith('#') ? Color.White : Color.Black;
    var textFormat = new TextFormat('Helvetica,Arial', 10, textColor, align:TextFormatAlign.CENTER);

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
    this.onMouseDown.listen(_keyDown);
    this.onMouseOver.listen(_keyDown);
    this.onMouseUp.listen(_keyUp);
    this.onMouseOut.listen(_keyUp);
  }

  _keyDown(MouseEvent me) {
    if (me.buttonDown) {
      this.sound.play();
      this.alpha = 0.7;
      this.piano.checkSongNote(this.note);
    }
  }

  _keyUp(MouseEvent me) {
      this.alpha = 1.0;
  }
}
