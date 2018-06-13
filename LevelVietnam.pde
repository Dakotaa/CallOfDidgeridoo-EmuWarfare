class LevelVietnam extends Level {
  LevelVietnam() {
    super();
    dropItems = true;
  }

  void setupLevel() {
    backgroundColour = color(19, 110, 0);
    showHUD = true;
    gunWorking = true;
    allowItems = true;
    for (int i = 0; i < 30; ++i) {
      emus.add(new VietEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
    guns.add(new Gun_M60(200));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    for (int i = 0; i < 20; i++) {
      decorations.add(new Decor(int(random(width-600, width)), int(random(0, height)), random(0.4, 0.6), false, jungleImages));
    }

//sets xpos, ypos, heading, speed, HP, and maxSpeec, and items in inventory
    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    inventory.put("Boomerang", 0);
    inventory.put("Vegemite", 0);
    inventory.put("Grenade", 3);
    inventory.put("Landmine", 3);
    inventory.put("Gas", 0);
    fortunateson.rewind();
    fortunateson.loop(5);

    scene = 4;
  }


  void update() {  
    track = true;
    super.update();

    if (emusAlive() < 30) {
      emus.add(new VietEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
  }
}