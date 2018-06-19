class TitleScreen extends Level {
  TitleScreen() {
  }

  //all of the text and images needed for the title screen, extension of level, calls the buttons
  void update() {
    pushMatrix();
    background(0);
    fill(255);
    imageMode(CORNER);
    image(titleImage, 0, 0);
    imageMode(CENTER);
    textAlign(CENTER);
    textFont(stamp100);
    text("CALL OF DIDGERIDOO: Emu Warfare", width/2, 100);
    //textSize(25);

    textFont(stamp50);
    text("Controls", width/2 + 600, 300);
    textFont(stamp30);
    text("W A S D - Moves truck", width/2 + 600, 350);
    text("Left Click - Shoot", width/2 + 600, 400);
    text("Right Click - Aim", width/2 + 600, 450);
    text("Scroll/1, 2, 3, 4, 5 - Select item", width/2 + 600, 500);
    text("E - Use selected item", width/2 + 600, 550);
    text("TAB - Exit to menu", width/2 + 600, 600);

    popMatrix();

    for (Button b : buttons) {
      b.update();
    }
  }
}