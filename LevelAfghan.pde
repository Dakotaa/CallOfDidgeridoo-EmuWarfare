class LevelAfghan extends Level {
  LevelAfghan() {
    super();
    gunWorking = true;
    allowItems = true;
    dropItems = true;
  }

  void setupLevel() {
    backgroundColour = color(219, 197, 106);
    showHUD = true;
    allowItems = true;
    gunWorking = true;
    for (int i = 0; i < 10; ++i) {
      emus.add(new AfghanEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }
    guns.add(new Gun_M60(200));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    for (int i = 0; i < 30; i++) {
      decorations.add(new Decor(int(random(0, width)), int(random(0, height)), random(0.2, 0.4), false, bushImages));
    }

    truck.setX(200);
    truck.setY(200);
    truck.setHeading(PI);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    inventory.put("Boomerang", 0);
    inventory.put("Vegemite", 0);
    inventory.put("Grenade", 0);
    inventory.put("Landmine", 10);
    inventory.put("Gas", 0);
    nasheed.rewind();
    nasheed.loop(5);

    scene = 4;
  }


  void update() {  
    track = true;
    super.update();

    /*if (emusAlive() < 30) {
     
     emus.add(new VietEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
     }*/
  }
}