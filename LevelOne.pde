class LevelOne extends Level {
  LevelOne() {
  }

  void setupLevel() {
    for (int i = 0; i < 10; ++i) {
      emus.add(new Emu(random(width*.75, width), random(300, height-300), random(0.05, 0.5)));
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
  }


  void update() {
    super.update();
  }
}
