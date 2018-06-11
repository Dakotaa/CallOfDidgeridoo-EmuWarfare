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

    for (int i = 0; i < 30; i++) {
      decorations.add(new Decor(int(random(0, width)), int(random(0, height)), random(0.2, 0.4), false, bushImages));  
    }
    
    truck.setX(0);
    truck.setY(height/2);
    truck.setHeading(PI*0.5);
    truck.setSpeed(0);
    truck.setHP(1);
    truck.resetMaxSpeed();
    inventory.put("Boomerang", 5);
    inventory.put("Vegemite", 3);
    inventory.put("Grenade", 10);
    inventory.put("Landmine", 10);
    inventory.put("Gas", 10);

    textScene[0] = "November 4, 1932 \n \n \nMajor G.P.W Meredith,\n \nWe've received reports that a massive herd has been spotted near the dam. \n We want you to wait near the dam and ambush them.\n\nYou'll have a pickup truck and a mounted Lewis light machine gun.\n \n \nGood luck,\nPrime Minister Lyons";
    endScene[0] = "Operation Update - November 4, 1932 \n  \n  \nIt began raining as soon as we set out.\nBy the time we made it to the area the emus were spotted, the mud made it impossible to move our truck.\n\nUpon spotting us, the emus scattered.\n\nWe fear that this delay and chance for them to escape will make our objective harder to complete, as the emus are\nnow scatted across multiple areas.\n\n - Major G.P.W Meredith";
    
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