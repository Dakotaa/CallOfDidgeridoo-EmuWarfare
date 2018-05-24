class LevelTwo extends Level {
  //String[] textScene = new String[3];
  LevelTwo() {
    super();
    showHUD = false;
    allowItems = false;
    dropItems = false;
  }

  void setupLevel() {
    for (int i = 0; i < 40; ++i) {
      emus.add(new BasicEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }

    guns.add(new Gun_Lewisgun(75));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    allowItems = false;
    gunWorking = true;

    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    inventory.put("Boomerang", 5);
    inventory.put("Vegemite", 3);
    inventory.put("Grenade", 10);
    inventory.put("Landmine", 10);
    inventory.put("Gas", 10);

    textScene[0] = "";
  }


  void update() {
    super.update();

    if (emusAlive() < 27) {
      gunWorking = false;
      for (Emu e : emus) {
        e.setTracking(false);
      }
    }
  }
}