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
    text("Version 0.0.4", width/2, 150);

    textAlign(LEFT);
    text("Version 0.0.4 Changelog:", 20, 600);
    textSize(20);
    text(" - Emus now animated", 30, 650);
    text(" - Started work on HUD (currently shows FPS, truck condition, ammo)", 30, 675);
    text(" - Optimized levels and buttons, added new Minigun test level.", 30, 700);

    popMatrix();

    for (Button b : buttons) {
      b.update();  
    }
  }
}
