class LevelOne extends Level {
  //String[] textScene = new String[3];
  LevelOne() {
    super();
    showHUD = false;
    allowItems = false;
    dropItems = false;
  }

  void setupLevel() {
    for (int i = 0; i < 40; ++i) {
      emus.add(new BasicEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
    }

    for (int i = 0; i < 400; ++i) {
      rains.add(new Rain());
    }

    guns.add(new Gun_Lewisgun(75));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    allowItems = false;
    gunWorking = false;

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

    textScene[0] = "October 30, 1932 \n \n \nA herd of 50 emus have been spotted near Campon, Australia. \nThe Australians once again deployed Sergeant S. McMurray and Gunner J. O'Hallora, under the command of Major G.P.W Meredith.\n\n";
    endScene[0] = "Operation Update - October 30, 1932 \n  \n  \nPoor weather has delayed the operation.";
  }


  void update() {
    super.update();
    endTimer++;
    if (endTimer > 700) {
      levelEnded = true;
    }
  }
}