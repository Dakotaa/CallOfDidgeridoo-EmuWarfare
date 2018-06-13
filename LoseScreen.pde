class LoseScreen extends Level {
  int killed;
  LoseScreen(int k) {
    super();
    killed = k;
  }

  void update() {
    pushMatrix();
    background(0);
    textSize(50);
    textFont(stamp50);
    textAlign(CENTER);
    fill(255);
    text("YOU LOST.", width/2, 200);
    text("Press ENTER to submit your score. Press TAB to return to menu.", width/2, height-200);

    rectMode(CENTER);
    fill(150);
    rect(960, 540, 400, 500);

    fill(255);
    text("SCORE: " + killed, width/2, 300);

    fill(0);
    textAlign(CENTER);
    textSize(50);
    textSize(20);
    text("High Scores", 960, 330); 
    text("Enter your name: " + name, 960, 360);
    for (int i = 0; i < scores.getRowCount(); i++) {
      if (scores.getRowCount() > 0) {
        text(scores.getString(i, 4), width/2 - 60, 430 + i*40);
        text(scores.getInt(i, 1), width/2 + 60, 430 + i*40);
      }
    }

    text("Press ENTER to submit.", width/2, 900);
    text("RIGHT CLICK to restart.", width/2, 950);
    popMatrix();
  }
}