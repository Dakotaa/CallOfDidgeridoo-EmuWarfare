class TitleScreen extends Level {
  TitleScreen() {
  }

  void update() {
    pushMatrix();
    
    background(0);
    fill(255);
    textAlign(CENTER);
    textFont(stamp100);
    text("CALL OF DIDGERIDOO: Emu Warfare", width/2, 100);
    textSize(25);
    text("Version 0.0.5", width/2, 150);

    textFont(stamp30);
    textAlign(LEFT);
    text("Version 0.0.5 Changelog:", 20, 600);
    textSize(20);
    text("BuffEmu and Vietnamese Emu added, with animations.", 30, 650);
    text("New inventory system, with Boomerangs, Vegemite, Grenades, and Landmines.)", 30, 675);
    text("Overhauled explosions, now more realistic and scale damage.", 30, 700);

    popMatrix();

    for (Button b : buttons) {
      b.update();  
    }
  }
}