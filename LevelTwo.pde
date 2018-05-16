class LevelTwo extends Level {
  LevelTwo() {
    super();
  }

  void setupLevel() {
    showHUD = true;
    allowItems = true;
    for (int i = 0; i < 50; ++i) {
      emus.add(new StaticEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
    guns.add(new Gun_Minigun(500));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    /*
    inventory.put("Boomerang", 50);
    inventory.put("Vegemite", 25);
    inventory.put("Grenade", 25);
    inventory.put("Landmine", 25);
    inventory.put("Gas", 10);
    */
    music1.rewind();
    music1.loop(5);

    scene = 4;
  }


  void update() {  
    super.update();

    if (emusAlive() < 50) {
      emus.add(new StaticEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
  }
}