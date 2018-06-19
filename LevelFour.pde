class LevelFour extends Level {
  //String[] textScene = new String[3];
  LevelFour() {
    super();
    showHUD = false;
    allowItems = true;
    dropItems = false;
  }

  void setupLevel() {
    emus.add(new BossEmu(random(width*.75, width), random(300, height-300), 0.8));

    guns.add(new Gun_Lewisgun(75));
    for (Gun g : guns) {
      g.setAmmo(g.getMaxAmmo());
    }

    allowItems = true;
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
    inventory.put("Boomerang", 2);
    inventory.put("Vegemite", 5);
    inventory.put("Grenade", 2);
    inventory.put("Landmine", 3);
    inventory.put("Gas", 1);

    textScene[0] = "November 6, 1932 \n \n \nMajor G.P.W Meredith,\n \nWe are receiving negative press about this operation, due to each of our attempts being failures.\nAt this rate, we will not be able to fund this offensive much longer.\n\nHowever, I have got some new info about the enemy, one of the army observers noted that each pack seems to now have its own\nleader, a big, black-plumed bird which stands fully six feet high.\n\nTake your men out again, find this big one, and kill him.\nThis one will probably fight back, so we're going to send you out with some supplies.\n\nGood luck,\nPrime Minister Lyons";
    endScene[0] = "November 6, 1932 \n  \n  \nWe have received very unfortunate news from the front.\n\nOur scouts report a huge herd of emus, larger than any we've seen before, at the location we sent the boys out to.\n\nUpon getting closer, one of the scouts was attacked.\nIt seems these birds are enraged by the loss of their leader, and will attack anything that gets close.\n\nWe're very sorry to say that it is unlikely that Meredith or his men survived.\n\nWe've decided end our involvement with the emus, as this loss of life was not expected.\n\n - Prime Minister Lyons";

    typewriter.loop(5);
    bossDead = false;
  }


  void update() {
    super.update();

    if (scene == 1 && !levelEnded) {
      hud.showItems();

      if (bossDead) {
        track = true;
        if (frameCount%2 == 0) {
          emus.add(new StaticEmu(random(width, width*1.1), random(0, height), random(0.1, 0.4)));
        }
      }

      if (emusAlive() == 0) {
        bossDead = true;
      }

      if (endTimerState) {
        endTimer++;
        rectMode(CENTER);
        fill(0, endTimer/2);
        rect(width/2, height/2, width, height);
      }

      if (endTimer > 600) {
        levelEnded = true;
      }
    }
  }
}