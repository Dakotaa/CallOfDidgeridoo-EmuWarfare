// https://hadamlenz.wordpress.com/2014/07/16/building-a-button-in-processing/
class Button {
  float myX, myY, myW, myH;
  String myLabel;
  color myColour;
  boolean down;
  Button (float x, float y, float w, float h, String label, color colour) {
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myLabel = label;
    myColour = colour;
  }

  boolean getDown () {
    return down;
  }

  void setDown (boolean d) {
    down = d;
  }
  
  void update() {
    if (mouseX > myX && mouseX < myX + myW && mouseY > myY && mouseY < myY + myH) {
      down = true;
    } else {
      down = false;
    }

    pushMatrix();
    if (down) {
      fill (myColour + 10);
    } else {
      fill(myColour);
    }

    rectMode(CORNER);
    rect(myX, myY, myW, myH);
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text(myLabel, myX + myW/2, myY + myH/2);
    popMatrix();
  }
}
