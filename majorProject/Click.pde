// Yingjin Song
// u6122877

class ClickArea{
  
  float xpos;
  float ypos;
  float w;
  float h;
  
  int clickCount=0;
  boolean show=false;
  int last=60;
  
  ClickArea(float xpos, float ypos,float w,float h){
    this.xpos=xpos;
    this.ypos=ypos;
    this.w=w;
    this.h=h;
  }
  
  boolean inArea(){
    if(mouseX>xpos && mouseX<xpos+w &&
    mouseY>ypos && mouseY<ypos+h){
      return true;
    }else{
      return false;
    }
    
  }
  
  
  void showShadowLeft(){
    if(last>0){
      last-=2;
      pushMatrix();
      translate(726,581);
      rotate(-PI/20);
      pushStyle();
      tint(255, last);
      image(ghostshadow, 0, 0);
      popStyle();
      popMatrix();
    }
  }
  
  void showShadowRight(){
    if(last>0){
      last-=2;
      pushMatrix();
      translate(1864,142);
      //rotate(-PI/20);
      pushStyle();
      tint(255, last);
      image(ghostshadow, 0, 0);
      popStyle();
      popMatrix();
    }
  }
  
  
  
  void show(){
    pushStyle();
    noFill();
    stroke(30,255,255);
    strokeWeight(5);
    rect(xpos,ypos,w,h);
    popStyle();
  }
}

//=new ClickArea(833,541,40,26);  //note
//=new ClickArea(958,589,50,33);  //book
//=new ClickArea(296,125,358,400);  //window
//=new ClickArea(761,486,50,90);  //doll
//=new ClickArea(658,237,726,369);  //photo
//=new ClickArea(1125,321,116,357);  //cloth