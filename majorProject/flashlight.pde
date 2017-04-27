// Yingjin Song
// u6122877

float lumi=50;
float stable=50;

void flashlight() {
  if (picIndex==4) {
    float temp=noise(frameCount*0.1);
    if (temp>0.7) {
      lumi=map(temp, 0.7, 0.9, 120, 200);
    }

    if (lumi>stable) {
      lumi-=3;
    }

    loadPixels();
    int loc;
    float lumiFactor=lumi/255;

    float pixelBright;
    float pixelSaturation;
    float d;
    float adjust;
    for (int x=0; x<room.width; x++) {
      for (int y=0; y<room.height; y++) {
        loc=x+y*room.width;
        pixelBright=brightness(room.pixels[loc])*lumiFactor;
        //if(x==y && x==50){
        //  println(pixelBright);
        //}

        pixelSaturation=saturation(room.pixels[loc]);
        d=dist(x, y, mouseX, mouseY);

        if (d<300) {
          //adjust=constrain(1-d/150f, 0, 1);
          //adjust*=4;
          //pixelBright*=adjust;
          //pixelBright=min(pixelBright, 255);

          adjust=255*(300-d)/300;
          pixelBright+=adjust;
          pixelBright=constrain(pixelBright, 0, 255);

          //pixelSaturation/=adjust;
        }

        pixels[loc]=color(hue(room.pixels[loc]), pixelSaturation, pixelBright);
      }
    }
    updatePixels();
  } else {
    evilRoom[picIndex].loadPixels();
    float temp=noise(frameCount*0.1);
    if (temp>0.7) {
      lumi=map(temp, 0.7, 0.9, 120, 200);
    }

    if (lumi>stable) {
      lumi-=3;
    }

    loadPixels();
    int loc;
    float lumiFactor=lumi/255;

    float pixelBright;
    float pixelSaturation;
    float d;
    float adjust;
    for (int x=0; x<room.width; x++) {
      for (int y=0; y<room.height; y++) {
        loc=x+y*room.width;
        pixelBright=brightness(evilRoom[picIndex].pixels[loc])*lumiFactor;
        //if(x==y && x==50){
        //  println(pixelBright);
        //}

        pixelSaturation=saturation(evilRoom[picIndex].pixels[loc]);
        d=dist(x, y, mouseX, mouseY);

        if (d<300) {
          //adjust=constrain(1-d/150f, 0, 1);
          //adjust*=4;
          //pixelBright*=adjust;
          //pixelBright=min(pixelBright, 255);

          adjust=255*(300-d)/300;
          pixelBright+=adjust;
          pixelBright=constrain(pixelBright, 0, 255);

          //pixelSaturation/=adjust;
        }

        pixels[loc]=color(hue(evilRoom[picIndex].pixels[loc]), pixelSaturation, pixelBright);
      }
    }
    updatePixels();
    
  }
}