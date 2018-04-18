class TitleScreen extends Level {
  void TitleScreen() {
  }

  void update() {
    pushMatrix();
    background(0);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text("CALL OF DIDGERIDOO: Emu Warfare", width/2, 100);
    popMatrix();

    buttonOne.update(); // Draws the first button
  }
}
