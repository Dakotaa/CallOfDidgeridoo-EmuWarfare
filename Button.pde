// https://hadamlenz.wordpress.com/2014/07/16/building-a-button-in-processing/

class Button {
  float myX, myY, myW, myH;
  int levelNum, permission;
  String myLabel;
  color myColour;
  boolean down, unlocked;
  Level levelType;

  // "permission" is the required number of highest_level in the data.csv (the player must complete lower levels to be able to use this button)
  Button (float x, float y, float w, float h, String label, color colour, int num, int perm, Level l) {
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myLabel = label;
    myColour = colour;
    levelNum = num;
    permission = perm;
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
    if (data.getInt(0, "highest_level") >= permission) {
      unlocked = true;
    }

    if (unlocked) {
      if (mouseX > myX - myW/2 && mouseX < myX + myW/2 && mouseY > myY - myH/2 && mouseY < myY + myH/2) {
        down = true;
      } else {
        down = false;
      }
    }

    pushMatrix();
    if (down) {
      fill (myColour + color(10, 50, 100));
    } else {
      if (unlocked) {
        fill(myColour);
      } else {
        fill(100);
      }
    }

    rectMode(CENTER);
    rect(myX, myY, myW, myH);
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text(myLabel, myX, myY);
    popMatrix();
  }
}