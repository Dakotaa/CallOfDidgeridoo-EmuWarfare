// https://hadamlenz.wordpress.com/2014/07/16/building-a-button-in-processing/
class Button {
  float myX, myY, myW, myH;
  int levelNum;
  String myLabel;
  color myColour;
  boolean down;
  Level levelType;
  Button (float x, float y, float w, float h, String label, color colour, int num, Level l) {
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myLabel = label;
    myColour = colour;
    levelNum = num;
    levelType = l;
  }

  boolean getDown () {
    return down;
  }

  void setDown (boolean d) {
    down = d;
  }

  void pressed() {
    down = false;    // If the mouse is over the button and clicked, sets the level to one, adds a new level one instance, and sets it up.
    level = levelNum;
    levels.add(levelType);
    for (Level l : levels) {
      l.setupLevel();
    }
  }

  void update() {
    if (mouseX > myX && mouseX < myX + myW && mouseY > myY && mouseY < myY + myH) {
      down = true;
    } else {
      down = false;
    }

    pushMatrix();
    if (down) {
      fill (myColour + color(10, 50, 100));
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