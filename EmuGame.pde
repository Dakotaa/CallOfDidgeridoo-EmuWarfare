/**********************************************************************************************************************************************************************************************************************************************************************
 
 CALL OF DIDGERIDOO: EMU WARFARE
 
 2018
 BY: Dakota, Angus
 
 **********************************************************************************************************************************************************************************************************************************************************************/
import ddf.minim.*;

Minim minim;
AudioPlayer gunshot, explosionSound, oof, music1, fortunateson, nasheed, typewriter;
// Declaring all images, image arrays, booleans, and other global variables.
PImage lewisGun, miniGun, M60, emuPhoto, emuPhotoFlipped, explosion, boomerang, vegemite, grenade, landmine, flash, titleImage;
PImage[] emuRun = new PImage[34];    // https://processing.org/discourse/beta/num_1192465513.html
PImage[] emuRunFlip = new PImage[34];
PImage[] buffEmuRun = new PImage[39];
PImage[] buffEmuRunFlip = new PImage[39];
PImage[] vietEmuRun = new PImage[24];
PImage[] vietEmuRunFlip = new PImage[24];
PImage[] afghanEmuRun = new PImage[11];
PImage[] afghanEmuRunFlip = new PImage[11];
PImage[] afghanEmuExplode = new PImage[16];
PImage[] carDamage = new PImage[6];
PImage[] vietCarDamage = new PImage[3];
PImage[] afghanCarDamage = new PImage[3];
PImage[] buffEmuSmash = new PImage[30];
PImage[] buffEmuSmashFlip = new PImage[30];
PImage[] explosionAnimation = new PImage[25];
PImage[] naziEmuRun = new PImage[34];
PImage[] naziEmuRunFlip = new PImage[34];
PImage[] naziEmuAttack = new PImage[35];
PImage[] naziEmuAttackFlip = new PImage[35];
PImage[] blood = new PImage[5];
PImage[] bushImages = new PImage[3];
boolean isDone, autoFire, aiming, gameOver, track, group, allowItems= false;
boolean truckWorking = true;
boolean keepEmusOnScreen = true;
float gunInnac;
int level = -1;
int emusKilled;
String date;
PFont typeWriterFont, stamp20, stamp30, stamp50, stamp100;

// ArrayLists for objects.
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Emu> emus = new ArrayList();
ArrayList<Blood> bloods = new ArrayList();
ArrayList<Gun> guns = new ArrayList();
ArrayList<Level> levels = new ArrayList();
ArrayList<Button> buttons = new ArrayList();
ArrayList<Bush> bushes = new ArrayList();
ArrayList<Timer> timers = new ArrayList();
ArrayList<Projectile> projectiles = new ArrayList();
ArrayList<Explosion> explosions = new ArrayList();
ArrayList<Gas> gasses = new ArrayList();
ArrayList<GroundItem> groundItems = new ArrayList();
ArrayList<Rain> rains = new ArrayList();

Table scores;
Table data;

HashMap<String, Integer> inventory = new HashMap<String, Integer>();    // https://codereview.stackexchange.com/questions/148821/inventory-of-objects-with-item-types-and-quantities

HUD hud = new HUD(true, true, true, true);
Timer boomerangTimer = new Timer(3);
Truck truck = new Truck (6);

void setup() {
  thread("loadImages"); // Runs the loadImages function in another thread, this allows the loading screen to show while the images are being loaded.
  fullScreen(P2D);
  frameRate(60);
  //((PGraphicsOpenGL)g).textureSampling(3); // https://forum.processing.org/two/discussion/8075/why-are-text-and-graphics-so-ugly-and-blocky
  cursor(CROSS);
  levels.add(new LevelOpening()); // Adds the title screen level
  buttons.add(new Button(width/2, 250, 125, 50, "October 30", color(100, 200, 250), 2, 0, new LevelOne()));
  buttons.add(new Button(width/2, 325, 125, 50, "November 2", color(100, 200, 250), 2, 1, new LevelTwo()));
  buttons.add(new Button(width/2, 400, 125, 50, "November 4", color(100, 200, 250), 2, 2, new LevelThree()));
  buttons.add(new Button(width-600, height-100, 100, 75, "Minigun\nTest", color(100, 200, 250), 2, 0, new LevelMinigun()));
  buttons.add(new Button(width-450, height-100, 100, 75, "'Nam", color(50, 150, 50), 2, 0, new LevelVietnam()));
  buttons.add(new Button(width-300, height-100, 100, 75, "Afghan", color(50, 150, 50), 2, 0, new LevelAfghan()));
  buttons.add(new Button(width-150, height-100, 100, 75, "Zombies", color(50, 150, 50), 2, 0, new LevelZombies()));

  minim = new Minim(this);

  File scoreFile = new File(dataPath("scores.csv"));
  scoreFile = new File("data/scores.csv");
  if (scoreFile.exists()) {
    scores = loadTable("scores.csv", "header");
  } else {
    scores = new Table(); 
    scores.addColumn("name");
    scores.addColumn("score");
    scores.addColumn("level");
    scores.addColumn("date");
    saveTable(scores, "data/scores.csv");
  }

  File dataFile = new File(dataPath("data.csv"));
  if (dataFile.exists()) {
    data = loadTable("data.csv", "header");
    println("loaded saved table");
  } else {
    data = new Table(); 
    data.addColumn("highest_level");
    TableRow dataRow = data.addRow();
    dataRow.setInt("highest_level", 0);
    saveTable(data, "data/data.csv");
    println("created table" + data);
  }

  int day = day();
  int month = month();
  int year = year();

  date = new String(day + "/" + month + "/" + year);
}

void draw() {
  if (!isDone) {  // If loading is not done, show the "LOADING..." screen.
    background(0);
    pushMatrix();
    textAlign(CENTER);
    textSize(50);
    text("LOADING...", width/2, height/2);
    textSize(20);
    text("The main levels of this game are based on true historical events", width/2, height/2 + 100);
    popMatrix();
  } else {  // If not loading, draw all the levels (only one level should be in the ArrayList at any time)
    if (!gameOver) {
      for (Level l : levels) {
        l.update();
      }
    } else {
      for (Level l : levels) {
        emusKilled = l.getEmusKilled();
      }
      levels.clear();
      levels.add(new LoseScreen(emusKilled));
      gameOver = false;
    }
  }
}

// Loads all the images in another core thread, sets isDone to true after images are loaded to stop drawing of loading screen.
void loadImages() { // https://forum.processing.org/two/discussion/1360/how-to-speedup-loadimage
  // Load fonts (multiple sizes)
  typeWriterFont = createFont("TravelingTypewriter.ttf", 26);
  stamp20 = createFont("stamp.ttf", 20);
  stamp30 = createFont("stamp.ttf", 30);
  stamp50 = createFont("stamp.ttf", 50);
  stamp100 = createFont("stamp.ttf", 100);
  lewisGun = loadImage("lewisgun.png");
  miniGun = loadImage("minigun.png");
  M60 = loadImage("M60.png");
  M60.resize(int(M60.width*.2), int(M60.height*.2));
  miniGun.resize((int) (miniGun.width*.75), (int) (miniGun.height*.75));
  emuPhoto = loadImage("emu.png");
  boomerang = loadImage("Boomerang.png");
  boomerang.resize((int) (boomerang.width*0.15), (int) (boomerang.height*0.15));
  emuPhotoFlipped = loadImage("emuflipped.png");
  explosion = loadImage("explosion.png");
  vegemite = loadImage("vegemite.png");
  vegemite.resize((int) (vegemite.width*.4), (int) (vegemite.height*.4));
  grenade = loadImage("grenade.png");
  grenade.resize((int) (grenade.width*.2), (int) (grenade.height*.2));
  landmine = loadImage("landmine.png");
  landmine.resize((int) (landmine.width*.075), (int) (landmine.height*.075));
  flash = loadImage("flash.png");
  titleImage = loadImage("titlescreen.png");
  flash.resize((int) (flash.width*.15), (int) (flash.height*.15));
  for (int i = 1; i < emuRun.length; i++) {
    emuRun[i] = loadImage(dataPath("EmuRun/EmuRun" + i + ".png"));    // https://forum.processing.org/two/discussion/4160/is-it-possible-to-load-files-from-a-folder-inside-the-data-folder
  }
  for (int i = 1; i < emuRunFlip.length; i++) {
    emuRunFlip[i] = loadImage(dataPath("EmuRunFlip/EmuRunFlip" + i + ".png"));
  }
  for (int i = 1; i < buffEmuRunFlip.length; i++) {
    buffEmuRun[i] = loadImage(dataPath("BuffEmuRun/BuffEmuRun" + i + ".png"));
  }
  for (int i = 1; i < buffEmuRun.length; i++) {
    buffEmuRunFlip[i] = loadImage(dataPath("BuffEmuRunFlip/BuffEmuRun" + i + ".png"));
  }
  for (int i = 1; i < buffEmuSmash.length; i++) {
    buffEmuSmash[i] = loadImage(dataPath("BuffEmuSmash/BuffEmuSmash" + i + ".png"));
  }
  for (int i = 1; i < buffEmuSmashFlip.length; i++) {
    buffEmuSmashFlip[i] = loadImage(dataPath("BuffEmuSmashFlip/BuffEmuSmash" + i + ".png"));
  }
  for (int i = 1; i < vietEmuRunFlip.length; i++) {
    vietEmuRun[i] = loadImage(dataPath("VietEmuRun/VietEmuRun" + i + ".png"));
  }
  for (int i = 1; i < vietEmuRun.length; i++) {
    vietEmuRunFlip[i] = loadImage(dataPath("VietEmuRunFlip/VietEmuRun" + i + ".png"));
  }
  for (int i = 1; i < naziEmuRunFlip.length; i++) {
    naziEmuRun[i] = loadImage(dataPath("NaziEmuRun/naziEmuRun" + i + ".png"));
  }
  for (int i = 1; i < naziEmuRun.length; i++) {
    naziEmuRunFlip[i] = loadImage(dataPath("NaziEmuRunFlip/naziEmuRun" + i + ".png"));
  }
  for (int i = 1; i < naziEmuAttackFlip.length; i++) {
    naziEmuAttack[i] = loadImage(dataPath("NaziEmuAttack/naziEmuAttack" + i + ".png"));
  }
  for (int i = 1; i < naziEmuAttack.length; i++) {
    naziEmuAttackFlip[i] = loadImage(dataPath("NaziEmuAttackFlip/naziEmuAttack" + i + ".png"));
  }
  for (int i = 1; i < afghanEmuRunFlip.length; i++) {
    afghanEmuRun[i] = loadImage(dataPath("AfghanEmuRun/AfghanEmuRun" + i + ".png"));
  }
  for (int i = 1; i < afghanEmuRun.length; i++) {
    afghanEmuRunFlip[i] = loadImage(dataPath("AfghanEmuRunFlip/AfghanEmuRun" + i + ".png"));
  }
  for (int i = 1; i < afghanEmuExplode.length; i++) {
    afghanEmuExplode[i] = loadImage(dataPath("AfghanExplode/AfghanExplode" + i + ".png"));
  }
  for (int i = 0; i < explosionAnimation.length; i++) {
    explosionAnimation[i] = loadImage(dataPath("Explosion/tile0" + i + ".png"));
  }
  for (int i = 0; i < blood.length; i++) {
    blood[i] = loadImage(dataPath("Blood/blood" + i + ".png"));
    blood[i].resize(200, 200);
  }
  for (int i = 0; i < bushImages.length; i++) {
    bushImages[i] = loadImage(dataPath("Bushes/bush" + i + ".png"));
  }
  for (int i = 0; i < carDamage.length; i++) {
    carDamage[i] = loadImage(dataPath("CarDamage/CarDamage" + i + ".png"));
    carDamage[i].resize(155, 280);
  }
  for (int i = 0; i < vietCarDamage.length; i++) {
    vietCarDamage[i] = loadImage(dataPath("VietCarDamage/VietCarDamage" + i + ".png"));
    vietCarDamage[i].resize(155, 280);
  }
  for (int i = 0; i < afghanCarDamage.length; i++) {
    afghanCarDamage[i] = loadImage(dataPath("AfghanCarDamage/AfghanCarDamage" + i + ".png"));
    afghanCarDamage[i].resize(155, 280);
  }

  lewisGun.resize((int) (lewisGun.width*0.5), (int) (lewisGun.height*0.5));
  gunshot = minim.loadFile(dataPath("gunshot.wav"));
  explosionSound = minim.loadFile(dataPath("explode.mp3"));
  oof = minim.loadFile(dataPath("oof.wav"));
  typewriter = minim.loadFile(dataPath("typewriter.mp3"));
  music1 = minim.loadFile(dataPath("music1.mp3"));
  fortunateson = minim.loadFile(dataPath("fortunateson.mp3"));
  nasheed = minim.loadFile(dataPath("nasheed.mp3"));

  isDone = true;
}

void spawnItem(String type) {
  groundItems.add(new GroundItem(type, 10, random(0, width), random(0, height)));
}

void spawnItem() {
  int r = (int) random(5);
  String type = "Boomerang";
  switch (r) {
  case 0:
    type = "Boomerang";
    break;
  case 1: 
    type = "Vegemite";
    break;
  case 2: 
    type = "Grenade";
    break;
  case 3: 
    type = "Landmine";
    break;
  case 4:
    type = "Gas";
    break;
  }
  groundItems.add(new GroundItem(type, 10, random(0, width), random(0, height)));
}

int emusAlive() {
  return emus.size();
}

void useItem() {
  if (allowItems) {
    throwBoomerang();
    useVegemite();
    throwGrenade();
    placeLandmine();
    throwGas();
  }
}

void throwBoomerang() {
  if (hud.getSelectedItem() == 0) {
    if (inventory.get("Boomerang") > 0) {
      if (!boomerangTimer.isStarted()) {
        boomerangTimer.setStarted(true);
        for (Gun g : guns) {
          projectiles.add(new Boomerang_Thrown(new PVector(truck.gunX(), truck.gunY()), 15, g.getTheta(), mouseX, mouseY));
          inventory.put("Boomerang", inventory.get("Boomerang") - 1);
        }
      } else {
        if (boomerangTimer.isDone()) {
          boomerangTimer.setSeconds(3);
          for (Gun g : guns) {
            projectiles.add(new Boomerang_Thrown(new PVector(truck.gunX(), truck.gunY()), 15, g.getTheta(), mouseX, mouseY));
            inventory.put("Boomerang", inventory.get("Boomerang") - 1);
          }
        }
      }
    }
  }
}

void useVegemite() {
  if (hud.getSelectedItem() == 1) {
    if (inventory.get("Vegemite") > 0) {
      truck.setHP(truck.getHP() + 0.1);
      inventory.put("Vegemite", inventory.get("Vegemite") - 1);
    }
  }
}

void throwGrenade() {
  if (hud.getSelectedItem() == 2) {
    if (inventory.get("Grenade") > 0) {
      for (Gun g : guns) {
        projectiles.add(new Grenade_Thrown(new PVector(truck.gunX(), truck.gunY()), 10, g.getTheta(), mouseX, mouseY));
        inventory.put("Grenade", inventory.get("Grenade") - 1);
      }
    }
  }
}

void placeLandmine() {
  if (hud.getSelectedItem() == 3) {
    if (inventory.get("Landmine") > 0) {
      for (Gun g : guns) {
        projectiles.add(new LandMine(new PVector(truck.gunX(), truck.gunY()), 10, g.getTheta(), mouseX, mouseY));
        inventory.put("Landmine", inventory.get("Landmine") - 1);
      }
    }
  }
}

void throwGas() {
  if (hud.getSelectedItem() == 4) {
    if (inventory.get("Gas") > 0) {
      for (Gun g : guns) {
        projectiles.add(new Gas_Thrown(new PVector(truck.gunX(), truck.gunY()), 10, g.getTheta(), mouseX, mouseY));
        inventory.put("Gas", inventory.get("Gas") - 1);
      }
    }
  }
}

// KeyPressed function to control truck
void keyPressed() {
  if (level != 0) {
    switch(keyCode) {
    case 49: 
      hud.setSelectedItem(0);
      break;
    case 50: 
      hud.setSelectedItem(1);
      break;
    case 51: 
      hud.setSelectedItem(2);
      break;
    case 52: 
      hud.setSelectedItem(3);
      break;
    case 53: 
      hud.setSelectedItem(4);
      break;
    case 65: 
      if (truckWorking) {
        truck.setLeft(true);
      }
      break;
    case 68:
      if (truckWorking) {
        truck.setRight(true);
      }
      break;
    case 87:
      if (truckWorking) {
        truck.setUp(true);
      }
      break;
    case 83:
      if (truckWorking) {
        truck.setDown(true);
      }
      break;
    case 69:
      useItem();
      break;
    }
  }
}

// KeyReleased function to control truck, add new emu, leave level, etc.
void keyReleased() {
  if (level != 0) {  // Keys only work when not on the title screen
    switch(keyCode) {
    case 65:    // Moves truck left
      if (truckWorking) {
        truck.setLeft(false);
      }
      break;
    case 68:    // Moves truck right
      if (truckWorking) {
        truck.setRight(false);
      }
      break;
    case 87:    // Moves truck up
      if (truckWorking) {
        truck.setUp(false);
      }
      break;
    case 83:    // Moves truck down
      if (truckWorking) {
        truck.setDown(false);
      }
      break;
    case 82:    // Reloads gun
      for (Gun g : guns) {
        g.reload();
      }
      break;
    case 81:
      emus.add(new BasicEmu(mouseX, mouseY, random(0.05, 0.5)));
      break;
    case 9:    // Leave to title screen
      if (isDone) {
        level = 0;
        for (Level l : levels) {    // Clears all levels
          l.clearLevel();
        }
        levels.clear();
        levels.add(new TitleScreen()); // Adds the title screen level
        gameOver = false;
        break;
      }
    }
  }

  for (Level l : levels) {
    if (l instanceof LoseScreen) {
      if (keyCode == 8) {
        if (l.getPlayerName().length() >= 1) {
          l.setPlayerName(l.getPlayerName().substring(0, l.getPlayerName().length()-1));
        }
        // Enters score
      } else if (key == ENTER) {
        if (scores.getRowCount() > 10) {
          scores.removeRow(10);
        }
        TableRow scoreRow = scores.addRow();
        scoreRow.setString("player", l.getPlayerName());
        scoreRow.setInt("score", (int) emusKilled);
        scoreRow.setString("date", date);
        saveTable(scores, "data/scores.csv");
        // If any other keys, types in name
      } else {
        l.setPlayerName(l.getPlayerName()+key);
      }
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (level == 0) {    // If in the title screen, buttons can be clicked.
      for (Button b : buttons) {
        if (b.getDown()) {
          b.pressed();
        }
      }
    } else {
      if (level >= 0) {
        for (Level l : levels) {
          if (l.getScene() == 0) {
            typewriter.pause();
            typewriter.rewind();
            l.setScene(l.getScene() + 1);
          }
        }
      }
    }
  }

  if (mouseButton == RIGHT) {    // When right clicking, the gun "aiming" is true, draws the white line and makes the gun more accurate.
    aiming = true;
  }
}


void mouseReleased() {    // Sets aiming to false when not on the title screen and the right mouse button is released.
  if (level != 0) {
    if (mouseButton == RIGHT) aiming = false;
  }
}


// Scroll event to scroll through inventory slots
void mouseWheel (MouseEvent event) {
  // mouse wheel event returns -1 or 1 depending on scroll direction, so this checks the direction.
  if (event.getCount() > 0) {
    if (hud.getSelectedItem() == 4) {    // If last slot is currently selected, scrolling up will roll over to first slot.
      hud.setSelectedItem(0);   // If not on last slot, rolls to next slot up.
    } else {
      hud.setSelectedItem(hud.getSelectedItem() + 1);
    }
  } else {
    if (hud.getSelectedItem() == 0) {
      hud.setSelectedItem(4);
    } else {
      hud.setSelectedItem(hud.getSelectedItem() - 1);
    }
  }
}