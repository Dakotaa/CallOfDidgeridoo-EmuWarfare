class LevelMinigun extends Level {
  LevelMinigun() {
    super();
    dropItems = true;
  }

  void setupLevel() {
    backgroundColour = color(214, 154, 0);
    showHUD = true;
    allowItems = true;
    for (int i = 0; i < 250; ++i) {
      emus.add(new StaticEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
    guns.add(new Gun_Minigun(500));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    for (int i = 0; i < 30; i++) {
      decorations.add(new Decor(int(random(0, width)), int(random(0, height)), random(0.2, 0.4), false, bushImages));  
    }
    
    gunWorking = true;

//sets xpos, ypos, heading, speed, HP, and maxSpeec, and items in inventory, as well as music
    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    inventory.put("Boomerang", 0);
    inventory.put("Vegemite", 0);
    inventory.put("Grenade", 0);
    inventory.put("Landmine", 0);
    inventory.put("Gas", 0);
    music1.rewind();
    music1.loop(5);

    scene = 4;
  }

  void clearLevel() {
    TableRow scoreRow = scores.addRow();
    scoreRow.setString("name", "test");
    scoreRow.setInt("score", emusKilled);
    scoreRow.setString("date", date);
    saveTable(scores, "data/scores.csv");
    super.clearLevel();
  }
  void update() {  
    track = true;
    super.update();

    if (emusAlive() < 250) {
      emus.add(new StaticEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
  }
}