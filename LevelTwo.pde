class LevelTwo extends Level {
  LevelTwo() {
    super();
  }

  void setupLevel() {
    for (int i = 0; i < 500; ++i) {
      emus.add(new BasicEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
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
    inventory.put("Boomerang", 50);
    inventory.put("Vegemite", 25);
    inventory.put("Grenade", 25);
    inventory.put("Landmine", 25);
    
        scene = 4;
  }


  void update() {  
    super.update();
  }
}
