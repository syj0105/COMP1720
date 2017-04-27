// Yingjin Song
// u6122877

class Zoom {
  PImage pic;

  float endScale;
  PVector center;

  float factor=0;
  float scale=1;
  float tintValue;

  Zoom(PImage pic, PVector center, float endScale) {
    this.pic=pic;
    this.center=center;
    this.endScale=endScale;
  }

  void update() {
    factor+=0.05;
    //if (factor>1) {
    //  factor=1;
    //}
    scale=lerp(1, endScale, factor);
    tintValue=lerp(100,0,factor);
  }

  void display() {
    pushMatrix();
    translate(center.x, center.y);
    scale(scale);
    pushStyle();
    tint(tintValue);
    image(pic, -center.x, -center.y);
    popStyle();
    popMatrix();
  }
  
  boolean finish(){
    if(factor>=1){
      return true;
    }else{
      return false;
    }
  }
}