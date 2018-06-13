class LevelZombies extends Level {
  int wave, emusLeft;
  LevelZombies() {
    super();
    dropItems = true;
    gunWorking = true;
    wave = 1;
    emusLeft = 5;
  }

  void setupLevel() {
    backgroundColour = color(100);
    showHUD = true;
    allowItems = true;
    gunWorking = true;
    guns.add(new Gun_M60(200));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
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
    inventory.put("Grenade", 0);
    inventory.put("Landmine", 0);
    inventory.put("Gas", 0);

    scene = 4;
  }


  void update() {
    track = true;
    super.update();
    if (emusLeft == 0) {
      wave++;
      emusLeft = int(wave*=4);
    } else {
      if ((frameCount%(int(random(100, 300))) == 0)) {
        emus.add(new NaziEmu(random(0, width), 0, random(0.4, 0.6)));
      }
    }

    text("Wave: " + wave, 1000, 50);
  }
}