// Yingjin Song
// u6122877

class Dark {
  PImage pic;
  float gray;
  float lightning;

  Dark(PImage pic, float gray) {
    this.pic=pic;
    this.gray=gray;
    lightning=gray;
  }

  void display() {
    if (lightning>gray) {
      lightning-=2;
    }

    pushStyle();
    tint(lightning);
    image(pic, 0, 0);
    popStyle();
  }

  void light(float input) {
    lightning=input;
  }
}