class Level {
  float mobLocationX, mobLocationY;
  String[] textScene = new String[1];
  String[] endScene = new String[1];
  PVector[] groups = new PVector[20];
  int scene, character, endTimer= 0;
  boolean textComplete;
  boolean levelEnded;
  boolean showHUD, gunWorking, dropItems = true;
  color backgroundColour;
  Level() {
    backgroundColour = color(214, 154, 0);
    mobLocationX = random(width-700, width);
    mobLocationY = random(0, height);
    constrain(mobLocationX, 0, width);
    constrain(mobLocationY, 0, height);
    for (int i = 0; i < groups.length; i++) {
      groups[i] = new PVector(random(50, width-50), random(40, height-40));
      //groups[i].x = random(300, width-300);
      //groups[i].y = random(200, height-200);
    }
  }

  void setupLevel() {
  }

  void clearLevel() {
    emus.clear();
    bloods.clear();
    bullets.clear();
    guns.clear();
    projectiles.clear();
    gasses.clear();
    groundItems.clear();
    explosions.clear();
    music1.pause();
    fortunateson.pause();
    nasheed.pause();
    track = false;
    levelEnded = false;
    keepEmusOnScreen = true;
    character = 0;
    scene = 0;
    endTimer = 0;
  }

  float getGroupLocationX(int groupNum) {
    return groups[groupNum].x;
  }

  float getGroupLocationY(int groupNum) {
    return groups[groupNum].y;
  }

  float getMobLocationX() {
    return mobLocationX;
  }

  float getMobLocationY() {
    return mobLocationY;
  }

  int getScene() {
    return scene;
  }

  void setScene (int s) {
    scene = s;
  }

  void update() {

    // Typing text scene.
    if (scene < textScene.length) {
      pushMatrix();
      background(255);
      fill(0);
      String text = textScene[scene].substring(0, character);
      textAlign(LEFT);
      textFont(typeWriterFont);
      text(text + "|", 100, 100);
      popMatrix();
      textFont(stamp30);
      if (frameCount%3 == 0) {
        if (character < textScene[scene].length()) {
          character++;
        }
      }

      if (character == textScene[scene].length()) {
        textComplete = true;
      }
    } else if (levelEnded) {
      pushMatrix();
      background(255);
      fill(0);
      String text = endScene[0].substring(0, character);
      textAlign(LEFT);
      textFont(typeWriterFont);
      text(text + "|", 100, 100);
      popMatrix();
      textFont(stamp30);
      if (frameCount%3 == 0) {
        if (character < endScene[0].length()) {
          character++;
        }
      }
    } else {
      if (frameCount%20 == 0) {
        mobLocationX += random(-10, 10);
        mobLocationY += random(-10, 10);
      }

      if (frameCount%120 == 0) {
        for (int i = 0; i < groups.length; i++) {
          groups[i].x += random(-30, 30);
          groups[i].y += random(-30, 30);
        }
      }

      boomerangTimer.update();
      fill(0, 255, 0);
      noStroke();
      rect(0, 0, 100, 40);
      fill(0);
      text("FPS: " + (int) frameRate, 2, 15);
      background(backgroundColour);
      fill(0);

      ArrayList<Blood> bloodToRemove = new ArrayList();
      for (Blood b : bloods) {
        b.update();  
        if (b.toRemove()) {
          bloodToRemove.add(b);
        }
      }

      ArrayList<Projectile> projectilesToRemove = new ArrayList();
      for (Projectile p : projectiles) {
        p.update();
        if (p.getToRemove()) {
          projectilesToRemove.add(p);
        }

        if (p.getX() > width + 100 || p.getX() < - 00 || p.getY() > height + 100 || p.getY() < -100) {
          projectilesToRemove.add(p);
        }
      }

      ArrayList<Bullet> toRemove = new ArrayList();
      for (Bullet b : bullets) {
        b.drawBullet();
        if (b.getY() > height || b.getY() < 0 || b.getX() > width || b.getX() < 0) {
          toRemove.add(b);
        }
      }

      ArrayList<GroundItem> groundItemsToRemove = new ArrayList();
      for (GroundItem g : groundItems) {
        g.update();
        if (g.toRemove()) {
          groundItemsToRemove.add(g);
        }
      }

      truck.update();


      for (Gun g : guns) {
        g.drawGun();
      }

      ArrayList<Emu> emuRemove = new ArrayList();
      for (Emu e : emus) {
        e.update();
        if (e.isDead()) {
          int r = (int) random(20);
          if (r == 1) {
            if (dropItems) {
              spawnItem();
            }
          }
          oof.play();
          oof.rewind();
          emuRemove.add(e);
        }
      }

      if (gunWorking) {
        for (Gun g : guns) {
          if (frameCount%g.getRateOfFire()==0 && mousePressed && mouseButton == LEFT) { // https://forum.processing.org/one/topic/shoot-multiple-bullets.html
            if (truck.getSpeed() > 0 || truck.getSpeed() < 0) {
              gunInnac = 2;
            } else {
              gunInnac = 0;
            }
            if (g.getAmmo() > 0 && !g.getReloading()) {
              if (aiming) {
                for (int i = 0; i < g.getNumShots(); i++) {
                  bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), mouseX, mouseY, true, g.getDamage()));
                }
                g.shoot();
              } else {
                for (int i = 0; i < g.getNumShots(); i++) {
                  bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), 10000, 10000, false, g.getDamage()));
                }
                g.shoot();
              }
            }
            //gunShot.play(); //https://processing.org/reference/libraries/sound/SoundFile.html
          }
        }
      }

      ArrayList<Explosion> explosionsToRemove = new ArrayList();
      for (Explosion e : explosions) {
        e.update(); 
        if (e.isComplete()) {
          explosionsToRemove.add(e);
        }
      }

      ArrayList<Gas> gasToRemove = new ArrayList();
      for (Gas g : gasses) {
        g.update();
        if (g.isComplete()) {
          gasToRemove.add(g);
        }
      }

      if (aiming) {
        strokeWeight(3);
        stroke(200, 50);
        line(truck.gunX(), truck.gunY(), mouseX, mouseY);
        strokeWeight(1);
        noStroke();
      }
      projectiles.removeAll(projectilesToRemove);
      bullets.removeAll(toRemove); // Removes offscreen bullets (https://stackoverflow.com/questions/18448671/how-to-avoid-concurrentmodificationexception-while-removing-elements-from-arr)
      emus.removeAll(emuRemove);
      explosions.removeAll(explosionsToRemove);
      bloods.removeAll(bloodToRemove);
      gasses.removeAll(gasToRemove);
      groundItems.removeAll(groundItemsToRemove);
      textAlign(CORNER);
      fill(0);
      //textSize(20);
      //text((int) gun1.getAmmo() + " | " + (int) gun1.getMaxAmmo(), 200, 30);

      if (showHUD) {
        hud.update();
      }
    }
  }
}