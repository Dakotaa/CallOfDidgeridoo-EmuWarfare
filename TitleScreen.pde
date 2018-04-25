class TitleScreen extends Level {
  TitleScreen() {
  }

  void update() {
    pushMatrix();
    background(0);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text("CALL OF DIDGERIDOO: Emu Warfare", width/2, 100);
    textSize(25);
    text("Version 0.0.5", width/2, 150);

    textAlign(LEFT);
    text("Version 0.0.5 Changelog:", 20, 600);
    textSize(20);
    text(" - BuffEmu and Vietnamese Emu added, with animations.", 30, 650);
    text(" - New inventory system, with Boomerangs, Vegemite, and Grenades.)", 30, 675);
    text(" - ", 30, 700);

    popMatrix();

    for (Button b : buttons) {
      b.update();  
    }
  }
}
