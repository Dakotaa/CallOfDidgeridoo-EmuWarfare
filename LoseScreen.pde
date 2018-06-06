class LoseScreen extends Level {
  LoseScreen() {
    super();
  }

  void update() {
    pushMatrix();
    background(0);
    textSize(50);
    textFont(stamp50);
    textAlign(CENTER);
    fill(255);
    text("YOU LOST. PRESS TAB.", width/2, height/2);
    popMatrix();
  }
}