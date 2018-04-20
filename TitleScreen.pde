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
    textSize(25);
    text("Version 0.0.3", width/2, 150);

    textAlign(LEFT);
    text("Version 0.0.3 Changelog:", 20, 600);
    textSize(20);
    text(" - Truck now loses more health when running into emus.", 30, 650);
    text(" - Truck will now explode and show Game Over screen when it reaches 0 HP.", 30, 675);
    text(" - Emus image flips to show correct movement direction.", 30, 700);

    popMatrix();

    for (Button b : buttons) {
      b.update();  
    }
  }
}
