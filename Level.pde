class Level {
  float mobLocationX, mobLocationY;
  String[] textScene = new String[1];
  String[] endScene = new String[1];
  PVector[] groups = new PVector[20];
  int scene, character, endTimer= 0;
  boolean textComplete;
  boolean levelEnded, soundStarted, endTimerState, bossDead, textReset;
  boolean showHUD, gunWorking, dropItems = true;
  String name = "";
  color backgroundColour;
  Level() {
    backgroundColour = color(214, 154, 0);

    // sets the random mob location start
    mobLocationX = random(width-700, width);
    mobLocationY = random(0, height);
    constrain(mobLocationX, 0, width);
    constrain(mobLocationY, 0, height);

    // sets random group locations
    for (int i = 0; i < groups.length; i++) {
      groups[i] = new PVector(random(50, width-50), random(40, height-40));
    }
  }

  void setupLevel() {
    truckWorking = true;
  }

  // clears all arraylists, stops sounds, and resets variables to clear the level
  void clearLevel() {
    emus.clear();
    bloods.clear();
    bullets.clear();
    guns.clear();
    projectiles.clear();
    gasses.clear();
    groundItems.clear();
    explosions.clear();
    rains.clear();
    decorations.clear();
    supermarine.pause();
    music1.pause();
    fortunateson.pause();
    myHeart.pause();
    nasheed.pause();
    track = false;
    levelEnded = false;
    keepEmusOnScreen = true;
    character = 0;
    scene = 0;
    bossDead = false;
    endTimer = 0;
    endTimerState = false;
    truck.exploded = false;
    textReset = false;
  }

  // plays one of the five type writer clicks at random
  void typeWriterClick() {
    int n = floor(random(5));

    typeWriterSounds[n].rewind();
    typeWriterSounds[n].play();
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

  boolean getBossDead() {
    return bossDead;
  }

  float getMobLocationY() {
    return mobLocationY;
  }

  int getScene() {
    return scene;
  }

  boolean getEndTimerState() {
    return endTimerState;
  }
  void setScene (int s) {
    scene = s;
  }

  int getEmusKilled() {
    return emusKilled;
  }

  void setEmusKilled (int e) {
    emusKilled = e;
  }

  void setEndTimerState(boolean b) {
    endTimerState = b;
  }

  // function used at the end of a level to update the level data (unlocked level)
  void setLevelData (int level) {
    if (!levelEnded) {
      data.setInt(0, "highest_level", level);
      saveTable(data, "data/data.csv");
    }
  }

  int getLevelData () {
    return (data.getInt(0, "highest_level"));
  }

  String getPlayerName() {
    return name;
  }

  void setPlayerName(String n) {
    name = n;
  }

  void update() {
    // opening text scene
    if (scene < textScene.length) {
      pushMatrix();
      background(255);
      fill(0);

      // sets the text for this scene to a substring from 0 to the current character.
      String text = textScene[scene].substring(0, character);
      textAlign(LEFT);
      textFont(typeWriterFont);
      text(text, 100, 100);
      popMatrix();
      textFont(stamp30);
      
      // adds a new character every 4 frames and plays the sound effect
      if (frameCount%4 == 0) {
        if (character < textScene[scene].length()) {
          character++;
          typeWriterClick();
        }
      }
  
      // if all characters are displayed, the text is complete.
      if (character == textScene[scene].length()) {
        textComplete = true;
        text("Click to continue", width-300, height-20);
      }
    } else if (levelEnded) {
      // resets text so this scene starts from the beginning of the text
      if (!textReset) {
        character = 0;
        textReset = true;
      }
      pushMatrix();
      background(255);
      fill(0);
      String text = endScene[0].substring(0, character);
      textAlign(LEFT);
      textFont(typeWriterFont);
      text(text + "|", 100, 100);
      popMatrix();
      textFont(stamp30);
      if (frameCount%4 == 0) {
        if (character < endScene[0].length()) {
          character++;
          typeWriterClick();
        }
      }

      if (character == endScene[0].length()) {
        textComplete = true;
        text("Press TAB", width-300, height-20);
      }
    } else {
      // randomly moves the mob location every 20 frames
      if (frameCount%20 == 0) {
        mobLocationX += random(-10, 10);
        mobLocationY += random(-10, 10);
      }

      // randomly moves group locations every 120 frames
      if (frameCount%120 == 0) {
        for (int i = 0; i < groups.length; i++) {
          groups[i].x += random(-30, 30);
          groups[i].y += random(-30, 30);
        }
      }
    
      // updates boomerang cooldown timer
      boomerangTimer.update();
      
      fill(0, 255, 0);
      noStroke();
      rect(0, 0, 100, 40);
      fill(0);
      text("FPS: " + (int) frameRate, 2, 15);
      background(backgroundColour);
      fill(0);


      // 
      //  arraylist updates and object removal
      //
      
      ArrayList<Blood> bloodToRemove = new ArrayList();
      for (Blood b : bloods) {
        b.update();  
        if (b.toRemove()) {
          bloodToRemove.add(b);
        }
      }

      for (Decor d : decorations) {
        d.update();
      }

      ArrayList<Projectile> projectilesToRemove = new ArrayList();
      for (Projectile p : projectiles) {
        p.update();
        if (p.getToRemove()) {
          projectilesToRemove.add(p);
        }

        // removes projectiles that leave the screen
        if (p.getX() > width + 100 || p.getX() < - 00 || p.getY() > height + 100 || p.getY() < -100) {
          projectilesToRemove.add(p);
        }
      }

      ArrayList<Bullet> toRemove = new ArrayList();
      for (Bullet b : bullets) {
        b.drawBullet();
        
        // removes bullets that leave the screen
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
          emusKilled++;
          emuRemove.add(e);
        }
      }


      truck.update();

      for (Gun g : guns) {
        g.drawGun();
      }

      if (gunWorking) {
        for (Gun g : guns) {
          // checks if the left mouse button is pressed and the current frame is correct, according to the rate of fire of the current gun.
          if (frameCount%g.getRateOfFire()==0 && mousePressed && mouseButton == LEFT) { // https://forum.processing.org/one/topic/shoot-multiple-bullets.html

            // gun inaccuracy; when the truck is moving, the angle the bullet shoots at is more random
            if (truck.getSpeed() > 0 || truck.getSpeed() < 0) {
              gunInnac = 2;
            } else {
              gunInnac = 0;
            }
            
            // shoots the gun when it is not reloading and has ammo.
            if (g.getAmmo() > 0 && !g.getReloading()) {
              if (aiming) {
                // loops through the number of shots for that gun (Lewis gun shoots one at a time, but minigun shoots multiple)
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

      for (Rain r : rains) {
        r.update();
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
      
      // removes all the objects marked for removal - https://stackoverflow.com/questions/18448671/how-to-avoid-concurrentmodificationexception-while-removing-elements-from-arr
      projectiles.removeAll(projectilesToRemove);
      bullets.removeAll(toRemove);
      emus.removeAll(emuRemove);
      explosions.removeAll(explosionsToRemove);
      bloods.removeAll(bloodToRemove);
      gasses.removeAll(gasToRemove);
      groundItems.removeAll(groundItemsToRemove);
      textAlign(CORNER);
      fill(0);

      if (showHUD) {
        hud.update();
      }
    }
  }
}
