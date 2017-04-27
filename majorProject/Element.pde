// Yingjin Song
// u6122877

class Element {
  PImage pic;
  PImage pic2;

  PVector start;
  PVector end;
  float startScale;
  float endScale;
  float factor;

  PVector loc;
  float scale;

  boolean isDisplaying=false;

  ClickArea area;

  Element(PImage pic, PVector start, float startScale, 
    PVector end, float endScale) {
    this.pic=pic;
    this.start=start;
    this.end=end;
    this.startScale=startScale;
    this.endScale=endScale;
  }

  void setArea(ClickArea input) {
    this.area=input;
  }

  void anotherPic(PImage pic2) {
    this.pic2=pic2;
  }

  void update() {
    factor+=0.333;
    if (factor>1) {
      factor=1;
    }
    //isDisplaying=true;
    loc=PVector.lerp(start, end, factor);
    scale=lerp(startScale, endScale, factor);
  }

  void display() {
    pushStyle();
    imageMode(CENTER);

    pushMatrix();
    translate(loc.x, loc.y);
    scale(scale);
    image(pic, 0, 0);
    popMatrix();
    popStyle();
  }

  void display2() {
    pushStyle();
    imageMode(CENTER);

    pushMatrix();
    translate(loc.x, loc.y);
    scale(scale);
    if (area.clickCount%4!=3) {
      image(pic, 0, 0);
    } else {
      image(pic2, 0, 0);
    }
    popMatrix();
    popStyle();
  }

  void reset() {
    factor=0;
    isDisplaying=false;
  }
}