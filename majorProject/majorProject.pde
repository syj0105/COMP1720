// Yingjin Song
// u6122877

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PImage room;
PImage house;
PImage bookcover;
PImage boss;
PImage ghostphoto;
PImage normalphoto;
PImage ghostshadow;
PImage paper;

PGraphics[]evilRoom;

Minim minim;
AudioPlayer rain_track;
AudioPlayer rain_indoor_track;
AudioPlayer bgm;

AudioSample knock_sound;
AudioSample open_door_sound;
AudioSample paper_sound;
AudioSample book_sound;
AudioSample ghost_sound;
AudioSample photo_sound;
AudioSample laugh_sound;
AudioSample cry_sound;
AudioSample evil_sound;

PFont font;

Dark out;
Rain rain;

Door door;

DialogBox outdoorIntro;
DialogBox indoorIntro;
DialogBox evilIntro;

boolean textTriggered=false;

Element book;
Element note;
Element photo;

ClickArea window;
ClickArea rightWindow;
ClickArea doll;
ClickArea model;

//float shadowAlpha=60;
//float rightShadowAlph=60;
int picIndex=4;
boolean evilFinished=false;

int status=0;
void setup() {
  size(2560, 1440);
  colorMode(HSB);
  font=createFont("evil_font.ttf", 168);
  // http://sucai.redocn.com/font/325872.html

  house=loadImage("House.jpg");
  // https://goo.gl/images/XZZgS8
  house.resize(width, height);

  room=loadImage("room.jpg");
  // https://commons.wikimedia.org/wiki/File:Phoenix-Sunnyslope-Walter_Leon_Lovinggood_House-Bedroom-1945.JPG
  room.resize(2560, 0);
  room=room.get(0, 200, 2560, 1440);

  evilRoom=new PGraphics[4];
  for (int i=0; i<4; i++) {
    evilRoom[i]=createGraphics(width, height);
  }

  evilRoom[0].beginDraw();
  evilRoom[0].image(room, 0, 0);
  evilRoom[0].textFont(font);
  evilRoom[0].textSize(168);
  evilRoom[0].fill(#8A0707);
  evilRoom[0].text("L", 355, 606);
  evilRoom[0].endDraw();

  evilRoom[1].beginDraw();
  evilRoom[1].image(evilRoom[0], 0, 0);
  evilRoom[1].textFont(font);
  evilRoom[1].textSize(168);
  evilRoom[1].fill(#8A0707);
  evilRoom[1].text("I", 369, 471);
  evilRoom[1].endDraw();

  evilRoom[2].beginDraw();
  evilRoom[2].image(evilRoom[1], 0, 0);
  evilRoom[2].textFont(font);
  evilRoom[2].textSize(168);
  evilRoom[2].fill(#8A0707);
  evilRoom[2].text("V", 282, 358);
  evilRoom[2].endDraw();

  evilRoom[3].beginDraw();
  evilRoom[3].image(evilRoom[2], 0, 0);
  evilRoom[3].textFont(font);
  evilRoom[3].textSize(168);
  evilRoom[3].fill(#8A0707);
  evilRoom[3].text("E", 241, 192);
  evilRoom[3].endDraw();

  room.loadPixels();

  bookcover=loadImage("Bookcover.jpg");
  // https://commons.wikimedia.org/wiki/File:In_Search_of_the_Unknown_-_Bookcover_-_Project_Gutenberg_eText_18668.jpg
  boss=loadImage("boss.jpg");
  // https://goo.gl/images/Pvuohz
  boss.resize(width, 0);
  ghostphoto=loadImage("ghostphoto.jpg");
  // https://goo.gl/images/BOqjTh
  normalphoto=loadImage("normalphoto.jpg");
  // http://www.publicdomainpictures.net/view-image.php?image=11276&picture=mother-and-baby-smiling
  normalphoto.resize(0, 640);
  ghostshadow=loadImage("ghostshadow.png");
  // https://pixabay.com/zh/%E9%AC%BC-%E8%83%A1%E5%BE%B7-%E4%B8%87%E5%9C%A3%E8%8A%82-%E5%8F%AF%E6%80%95-%E6%81%90%E6%80%96-%E6%81%90%E6%83%A7-%E9%82%AA%E6%81%B6-%E9%BB%91%E6%9A%97-%E6%AD%BB%E4%BA%A1-%E6%81%B6%E9%AD%94-303833/
  ghostshadow.resize(340, 0);
  paper=loadImage("paper.jpg");

  minim = new Minim(this);
  bgm=minim.loadFile("bgm.mp3");
  // https://soundcloud.com/a2blog/very-creepy-song-with-bells
  bgm.loop();

  rain_track=minim.loadFile("heavy_rain_with_thunder.mp3");
  //  http://www.freesfx.co.uk/download/?type=mp3&id=15857
  rain_track.loop();

  rain_indoor_track=minim.loadFile("thunderwithrain.mp3");
  // http://www.freesfx.co.uk/download/?type=mp3&id=17567
  knock_sound=minim.loadSample( "knocks.mp3");
  //http://www.freesfx.co.uk/download/?type=mp3&id=14360&eula=true
  open_door_sound=minim.loadSample( "door.mp3");
  // http://www.freesfx.co.uk/download/?type=mp3&id=18535
  paper_sound=minim.loadSample( "paper.mp3");
  // http://www.freesfx.co.uk/download/?type=mp3&id=18094
  book_sound=minim.loadSample( "book.mp3");
  // http://www.freesfx.co.uk/download/?type=mp3&id=15755 
  ghost_sound=minim.loadSample( "s.mp3");
  // http://www.freesfx.co.uk/sfx/paper?p=1
  laugh_sound=minim.loadSample( "laugh.mp3");
  // http://www.freesfx.co.uk/download/?type=mp3&id=15070
  cry_sound=minim.loadSample( "cry.mp3");
  // https://cf-media.sndcdn.com/m49c4pybN4Pn.128.mp3?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiKjovL2NmLW1lZGlhLnNuZGNkbi5jb20vbTQ5YzRweWJONFBuLjEyOC5tcDMiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE0NzU5MDIxNDV9fX1dfQ__&Signature=MwCcZWQSD3tzrLBLzvRYo7H01OpR4b-XadMSkWLbBcDsnIYz5Euhl5lyPCA7PCgmbHeiJ-ICx3nd5cZIuwudeU0F9KhoDsIBNEG5Q5m0h4pOI~-vo8Heny8X7m2TLdvpjmbPaPwCNGk68d9lkuuZVkl2IBrTZ8cJKTtI8QAsqOzzZqVk-W6deHYk1lkY62zjpDtbJ4cj4wgcKQmdKY1ylWgbyS9tNi3N~yNmlEcHGbCnL0CWKVBdMFcCgmO-Hd~uhNA4Sd8NiJRW~tRcnaWoiVy~gwdfCQjbjrdhsknYnrZXTVdDMLoq2DYK6-tlP7J4ho60uToEy2gRRYuvVP3Iiw__&Key-Pair-
  evil_sound=minim.loadSample( "newevil_laugh.mp3");  
  // https://soundcloud.com/soundeffectsforfree/evil-laugh2

  init();
}

void init() {
  book=new Element(bookcover, new PVector(1970, 997), 0.01, new PVector(width/2, height/2), 2);
  book.setArea(new ClickArea(1925, 980, 100, 66));

  note=new Element(paper, new PVector(1705, 910), 0.01, new PVector(width/2, height/2), 2);
  note.setArea(new ClickArea(1664, 880, 80, 52));

  photo=new Element(normalphoto, new PVector(1386, 414), 0.1, new PVector(width/2, height/2), 2);
  photo.setArea(new ClickArea(1317, 278, 136, 264));
  photo.anotherPic(ghostphoto);

  window=new ClickArea(586, 50, 530, 790);
  rightWindow=new ClickArea(1901, 168, 240, 720);
  doll=new ClickArea(1535, 765, 100, 180);
  model=new ClickArea(2260, 437, 232, 714); 

  println(house.height);

  out=new Dark(house, 100);
  rain=new Rain(-PI*3/7);

  door=new Door();
  
  outdoorIntro=new DialogBox("You are out of touch with your friend Alice for several days - no phone calls answering or text replying. So you decide to go to her apartment in a stormy night...(Knock on the door before entering))");
  indoorIntro=new DialogBox("It seems everything is good, huh? Use your “hands” to find some clues. Remember to CHECK each useful key for SEVERAL times:))");  
  evilIntro=new DialogBox("Do you find the passcode? Try to enter it..");
  textTriggered=false;
}

void draw() {
  switch(status) {

  case 0:
    cursor(ARROW);
    if (door.area.inArea()) {
      cursor(HAND);
    }
    float temp=noise(frameCount*0.1);
    if (temp>0.7) {
      out.light(map(temp, 0.7, 0.9, 200, 255));
    }
    out.display();
    rain.display();

    outdoorIntro.drawBox(430, 1126, 1800, 300, 5);

    door.trigger();
    break;

  case 1:
    door.display();
    break;

  case 2:
    cursor(ARROW);
    if (clickable()) {
      if (window.inArea() || rightWindow.inArea() ||
        doll.inArea() || model.inArea() ||
        book.area.inArea() || note.area.inArea() ||
        photo.area.inArea()) {
        cursor(HAND);
      }
    }

    flashlight();

    if (indoorIntro.timeOut==false) {
      indoorIntro.drawBox(320, 1200, 1800, 200, 5);
    }


    if (book.isDisplaying==true) {
      book.update();
      book.display();
    }
    if (note.isDisplaying==true) {
      note.update();
      note.display();
    }
    if (photo.isDisplaying==true) {
      photo.update();
      photo.display2();
    }

    if (window.show) {
      window.showShadowLeft();
    }

    if (rightWindow.show) {
      rightWindow.showShadowRight();
    }

    if (textTriggered && evilIntro.timeOut==false) {
      evilIntro.drawBox(100, 1000, 400, 400, 5);
    }


    //model.show();
    break;

  case 3:
    background(0);
    break;

  case 4:
    background(0);
    image(boss, 0, height-boss.height);
    break;
  }
}

void mousePressed() {
  //println(mouseX, mouseY);

  switch(status) {
  case 0:
    door.listenKnock();

    break;

  case 2:
    if (clickable()==false) {
      if (book.isDisplaying) {
        book.isDisplaying=false;
        book.reset();
      }
      if (note.isDisplaying) {
        note.isDisplaying=false;
        note.reset();
      }
      if (photo.isDisplaying) {
        photo.isDisplaying=false;
        photo.reset();
      }
    } else if (clickable()) {
      if (book.area.inArea()) {
        book.isDisplaying=true;
        book_sound.trigger();
        book.area.clickCount++;
      } else if (note.area.inArea()) {
        note.isDisplaying=true;
        paper_sound.trigger();
        note.area.clickCount++;
      } else if (photo.area.inArea()) {
        photo.isDisplaying=true;
        ghost_sound.trigger();
        photo.area.clickCount++;
      } else if (window.inArea()) {
        if (book.area.clickCount>=3 && note.area.clickCount>=3) {
          window.clickCount++;
          if (window.clickCount%5==1) {
            window.show=true;
            window.last=33;
            if (textTriggered==false) {
              picIndex=3;
            }
            textTriggered=true;
            //ghost_sound.trigger();
          } else {
            window.show=false;
          }
        }
      } else if (rightWindow.inArea()) {
        if (book.area.clickCount>=3 && note.area.clickCount>=3) {
          rightWindow.clickCount++;
          if (rightWindow.clickCount%5==1) {
            rightWindow.show=true;
            rightWindow.last=33;
            if (textTriggered==false) {
              picIndex=3;
            }

            textTriggered=true;
            //ghost_sound.trigger();
          } else {
            rightWindow.show=false;
          }
        }
      } else if (doll.inArea()) {
        doll.clickCount++;
        if (doll.clickCount<3) {
          //doll.show=true;
          laugh_sound.trigger();
        } else {
          //doll.show=false;
          cry_sound.trigger();
        }
      } 

      if (model.inArea()) {
        //println("window"+window.clickCount);
        //println("doll"+doll.clickCount);
        //println("photo"+photo.area.clickCount);
        if (window.clickCount>=1 && doll.clickCount>=4 &&
          photo.area.clickCount>=3 && evilFinished) {
          status=3;
          bgm.pause();
          //rain_indoor_track.pause();
        }
      }
    }
    break;

  case 3:
    evil_sound.trigger();
    status=4;
    break;

  case 4:
    init();
    status=0;
    rain_indoor_track.pause();
    rain_track.loop();

    break;
  }
}

void keyPressed() {
  if (status==2) {
    switch(picIndex) {
    case 3:
      if (key=='e' || key=='E') {
        picIndex=2;
      }
      break;

    case 2:
      if (key=='v' || key=='V') {
        picIndex=1;
      }
      break;

    case 1:
      if (key=='i' || key=='I') {
        picIndex=0;
      }
      break;

    case 0:
      if (key=='l' || key=='L') {
        picIndex=4;
        evilFinished=true;
      }
      break;
    }
  }
}



boolean clickable() {
  if (book.isDisplaying) {
    return false;
  }
  if (note.isDisplaying) {
    return false;
  }
  if (photo.isDisplaying) {
    return false;
  }
  return true;
}