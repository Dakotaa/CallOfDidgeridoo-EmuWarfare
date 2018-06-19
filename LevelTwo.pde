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

    for (int i = 0; i < 30; i++) {
      decorations.add(new Decor(int(random(0, width)), int(random(0, height)), random(0.2, 0.4), false, bushImages[floor(random(0, bushImages.length))]));
    }

    //sets xpos, ypos, heading, speed, HP, and maxSpeec, and items in inventory
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

    textScene[0] = "November 2, 1932 \n \n \nMajor G.P.W Meredith,\n \nThe rain has ceased, and some 50 emus have been spotted near Campon. \n\nHead out there and try again. \n \n \nGood luck,\nPrime Minister Lyons";
    endScene[0] = "Operation Update - October 30, 1932 \n  \n  \nAs soon as we opened fire, the birds started to split into smaller groups.\nWe were able to kill a number of birds with the machine guns, even in their small groups.\n\nHowever, they began to run away, and got out of range from our guns.\n\n\n - Major G.P.W Meredith";
    truckWorking = true;
  }


  void update() {
    super.update();

    if (emusAlive() < 27) {
      group = false;
      keepEmusOnScreen = false;
      for (Emu e : emus) {
        e.setLeaving(true);
      }
      endTimer++;
      if (!levelEnded) {
        fill(0, endTimer/3);
        rect(width/2, height/2, width, height);
      }
      if (endTimer > 700) {
        if (getLevelData() < 2) {
          setLevelData(2);
        }
        levelEnded = true;
      }
    }
  }
}
