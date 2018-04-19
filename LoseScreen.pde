class LoseScreen extends Level {
  LoseScreen() {}
  
  void update() {
    pushMatrix();
    background(0);
    textSize(50);
    textAlign(CENTER);
    fill(255);
    text("YOU LOST. PRESS ~.", width/2, height/2);
    popMatrix();
  }
}
