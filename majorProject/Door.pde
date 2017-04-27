// Yingjin Song
// u6122877

class Door {
  ClickArea area=new ClickArea(1091,505, 288,520);
  int count=0;
  int time=0;
  boolean trigger=false;

  Zoom zoom=new Zoom(house, new PVector(1140, 700), 4);

  Door() {
  }

  void listenKnock() {
    if (area.inArea()) {
      knock_sound.trigger();
      count++;
    }
  }

  void trigger() {
    if (count>=3) {
      time++;
    }
    if (time>30) {
      trigger=true;
      status=1;
      open_door_sound.trigger();
    }
  }

  void display() {

    zoom.update();
    zoom.display();
    if (zoom.finish()) {
      status=2;
      
      rain_track.pause();
      rain_indoor_track.loop();
      
    }
  }
}