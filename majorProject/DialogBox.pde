// Yingjin Song
// u6122877

class DialogBox {
  String boxText;
  int charCounter;
  int displayCounter;
  boolean timeOut=false;

  DialogBox(String boxText) {
    charCounter = 0;
    displayCounter = 0;
    this.boxText = boxText;
  }

  void drawBox(float x, float y, float width, float height,int wordRate) {
    // if you want a "background box", put the drawing code here



    // set text colour and size
    fill(255);
    textSize(56);
    // draw the text (one char at a time)
    text(boxText.substring(0, charCounter), x, y, width, height);
    if (displayCounter % wordRate == 0 && charCounter < boxText.length()) {
      charCounter++;
      if (charCounter>=boxText.length()) {
        charCounter=boxText.length()-1;
      }
    }

    if (charCounter==boxText.length()-1) {
      displayCounter++;

      if (displayCounter>20) {
        timeOut=true;
      }
    }
  }

  boolean isDone() {
    return charCounter >= boxText.length();
  }
}