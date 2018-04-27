class LevelOne extends Level {
  LevelOne() {
  }

  void setupLevel() {
    /*
    for (int i = 0; i < 5; ++i) {
      emus.add(new BasicEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
    */
    for (int i = 0; i < 5; ++i) {
      emus.add(new BuffEmu(random(width*.75, width), random(300, height-300), random(0.3, 0.6)));
    }

    for (int i = 0; i < 5; ++i) {
      emus.add(new VietEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.3)));
    }
    guns.add(new Gun_Lewisgun(75));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }
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
  }


  void update() {
    super.update();
  }
}
