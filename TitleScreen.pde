class TitleScreen extends Level {
  TitleScreen() {
  }

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
    textSize(25);
    text("Version 0.0.5", width/2, 150);

    popMatrix();

    for (Button b : buttons) {
      b.update();
    }
  }
}