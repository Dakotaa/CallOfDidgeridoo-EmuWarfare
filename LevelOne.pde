class LevelOne extends Level {
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

    for (int i = 0; i < 600; ++i) {
      rains.add(new Rain());
    }

    for (int i = 0; i < 30; i++) {
      decorations.add(new Decor(int(random(0, width)), int(random(0, height)), random(0.2, 0.4), false, bushImages));
    }

    guns.add(new Gun_Lewisgun(75));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    //disables item use, gun use, and movement
    allowItems = false;
    gunWorking = false;
    truckWorking = false;

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

    textScene[0] = "October 30, 1932 \n \n \nMajor G.P.W Meredith,\n \nA herd of 50 emus have been spotted near Campon, Australia. \nWe're assigning Sergeant S. McMurray and Gunner J. O'Hallora to help you deal with them.\n\nYou'll have a pickup truck and a mounted Lewis light machine gun.\n \n \nGood luck,\nPrime Minister Lyons";
    endScene[0] = "Operation Update - October 30, 1932 \n  \n  \nIt began raining as soon as we set out.\nBy the time we made it to the area the emus were spotted, the mud made it impossible to move our truck.\n\nUpon spotting us, the emus scattered.\n\nWe fear that this delay and chance for them to escape will make our objective harder to complete, as the emus are\nnow scatted across multiple areas.\n\n - Major G.P.W Meredith";

    typewriter.loop(5);
  }


  void update() {
    super.update();
    if (scene == 1 && !levelEnded) {
      if (scene != 0) {
        endTimer++;
        if (!levelEnded) {
          fill(0, endTimer/2);
          rect(width/2, height/2, width, height);
        }
      }

      if (endTimer > 600) {
        if (getLevelData() < 1) {
          setLevelData(1);
        }
        levelEnded = true;
      }
    }
  }
}
