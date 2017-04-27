// Yingjin Song
// u6122877

class Rain {
  int qty=1000;
  PVector[]loc=new PVector[qty];
  PVector[]end=new PVector[qty];
  PVector spd;

  float cosV, sinV;
  float len;

  Rain(float angle) {
    cosV=cos(angle);
    sinV=sin(angle);
    for (int i=0; i<qty; i++) {
      loc[i]=new PVector(random(width+300), random(height));
      len=random(10, 70);
      end[i]=new PVector(loc[i].x+cosV*len, loc[i].y+sinV*len);
    }

    float spdMag=8;
    spd=new PVector(-cosV*spdMag, -sinV*spdMag);
  }

  //boolean outOfWindow(){
  //  if(end[i].y>height ||
  //  (loc[i].x<0 && end[i].x<0) || 
  //  (loc[i].x>width && end[i].x>width)){
  //    return true;
  //  }else{
  //    return false;
  //  }
  //}

  void display() {
    stroke(220,120);
    strokeWeight(0.5);
    for (int i=0; i<qty; i++) {
      loc[i].add(spd);
      end[i].add(spd);
      if (end[i].y>height ||
        (loc[i].x<0 && end[i].x<0) 
        //|| (loc[i].x>width && end[i].x>width)
        ) {
          
        loc[i]=new PVector(random(0,width+200), random(-20, 0));
        len=random(10, 70);
        end[i]=new PVector(loc[i].x+cosV*len, loc[i].y+sinV*len);
      }

      line(loc[i].x, loc[i].y, end[i].x, end[i].y);
    }
  }
}