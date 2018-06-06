class LevelThree extends Level {
  //String[] textScene = new String[3];
  LevelThree() {
    super();
    showHUD = false;
    allowItems = false;
    dropItems = false;
  }

  void setupLevel() {
    for (int i = 0; i < 200; ++i) {
      emus.add(new StaticEmu(random(width*.75, width), random(300, height-300), 0.3));
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

    textScene[0] = "November 4, 1932 \n \n \nA massive herd has been spotted.. \nThe Australians deployed again, hoping that the huge group would make it easy to shoot the birds.\n\n";
    endScene[0] = "Operation Update - November 2, 1932 \n  \n  \nAfter killing only about twelve birds, the guns jammed.";
    
    typewriter.loop(5);
  }


  void update() {
    super.update();

    if (emusAlive() < 186) {
      group = false;
      gunWorking = false;
      for (Emu e : emus) {
        e.setLeaving(true);
      }
      endTimer++;
      if (!levelEnded) {
        fill(0, endTimer/3);
        rect(width/2, height/2, width, height);
      }
      if (endTimer > 700) {
        levelEnded = true;
      }
    }
  }
}