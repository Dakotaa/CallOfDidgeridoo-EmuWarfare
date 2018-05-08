class LevelOne extends Level {
  //String[] textScene = new String[3];
  LevelOne() {
    super();
    showHUD = false;
    allowItems = false;
  }

  void setupLevel() {
    for (int i = 0; i < 40; ++i) {
     emus.add(new BasicEmu(random(width*.75, width), random(300, height-300), random(0.1, 0.4)));
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

    textScene[0] = "November 2, 1932 \n \n \nA herd of 50 emus have been spotted near Campon, Australia. \nThe Australians deployed Sergeant S. McMurray and Gunner J. O'Hallora, under the command of Major G.P.W Meredith.\n\nAfter a delay due to rainfall, they deployed again, but were only able to kill a few birds.";
  }


  void update() {
    super.update();
    
    if (emusAlive() < 20) {
        gunWorking = false;
        for (Emu e : emus) {
          e.setAttacking(false);
        }
    }
  }
}