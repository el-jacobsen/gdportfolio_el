// El Jacobsen | 17 September 2025 | Space Game
import processing.sound.*;

Spaceship fih;
ArrayList<Rock> corals = new ArrayList<Rock>();
ArrayList<Laser> hydros = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<PowerUp> powups = new ArrayList<PowerUp>();
Timer coralTimer, puTimer, levelTimer;
int score, rocksPassed;
boolean play;
PImage start, over;
SoundFile pew, blowup, space, gend;


void setup() {
  size(800, 900);
  pew = new SoundFile(this, "retroLaser.mp3");
  space = new SoundFile(this, "spaceSound.mp3");
  space.play();
  blowup = new SoundFile(this, "retroExplode.mp3");
  gend = new SoundFile(this, "endGame.mp3");
  fih = new Spaceship();
  score = 0;
  rocksPassed = 0;
  play = false;

  //levelTimer = new Timer (30000);
  //levelTimer.start();

  coralTimer = new Timer(1300);
  coralTimer.start();

  puTimer = new Timer(10000);
  puTimer.start();
}


void draw() {
  start = loadImage ("startGame.png");
  over = loadImage("endGame.png");

  if (!play) {
    startScreen();
  } else {
    background(3, 3, 22);

    //check levels
    // if (level == 1) {
    //}

    //Display stars
    stars.add(new Star());
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
        i--;
      }
      println("Stars: " + stars.size());
    }
    //Distrubuting PowerUps on Timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }

    // Display of powerups
    for (int i = 0; i < powups.size(); i++) {
      PowerUp pu = powups.get(i);
      pu.display();
      pu.move();

      if (pu.intersect(fih)) {
        powups.remove(pu);

        if (pu.type == 't') {
          fih.turretCount++;
          if (fih.turretCount>5) {
            fih.turretCount = 5;
          }
        } else if (pu.type == 'h') {
          fih.health+=50;
          if (fih.health >50) {
            fih.health = 100;
          }
        } else if (pu.type == 'a') {
          fih.laserCount+=100;
        }
      }
    }

    // Distrubution of Rocks on Timer
    if (coralTimer.isFinished()) {
      corals.add(new Rock());
      coralTimer.start();
    }

    //Display of rocks
    for (int i = 0; i < corals.size(); i++) {
      Rock coral = corals.get(i);
      coral.display();

      if (fih.intersect(coral)) {
        corals.remove(coral);
        score+=coral.diam;
        fih.health -= 10;
      }

      coral.move();
      if (coral.reachedBottom()) {
        rocksPassed++;
        corals.remove(coral);
        i--;
      }
      println("Corals: " + corals.size());
    }

    //Display of lasers
    for (int i = 0; i < hydros.size(); i++) {
      Laser hydro = hydros.get(i);
      for (int j =0; j<corals.size(); j++) {
        Rock c = corals.get(j);
        if (hydro.intersect(c)) {
          hydros.remove(hydro);

          c.diam -= 40;
          c.broken = true;

          if (c.diam<40) {
            corals.remove(c);
            blowup.play();
          }
          score+=5;
        }
      }

      hydro.display();
      hydro.move();
      if (hydro.reachedTop()) {
        hydros.remove(hydro);
        i--;
      }
    }
    println("Hydros: " + hydros.size());
    if (pew.isPlaying()) {
      pew.stop();
    } else {
      play = true;
    }
    fih.display();
    fih.move(mouseX, mouseY);

    infoPanel();


    if (fih.health <1 ||  rocksPassed >20) {
      gameOver();
    }
  }
}

void startScreen () {
  background(start);

  textAlign(CENTER);
  textSize(35);
  fill(255);
  text("SPACE GAME", width/2, 150);


  textAlign(CENTER);
  textSize (30);
  fill(255);
  text("EL JACOBSEN 2A", width/2, 250);
  text("CLICK MOUSE TO START", width/2, 300);
  if (mousePressed) {
    play = true;
    space.stop();
  }
}

void gameOver () {
  background(over);
  textAlign(CENTER);
  textSize(35);
  fill(255);
  text("GAME OVER, SCORE: " + score, width/2, 300);
  noLoop();
  gend.play();
}

void mousePressed() {
  if (fih.fire()) {
    hydros.add(new Laser(fih.x, fih.y));
    fih.laserCount--;
    pew.play();
  }
}

void infoPanel() {
  //healthbar
  fill(255);
  rect(55, 770, 106, 10);
  fill(75, 0, 0);
  rect(55, 770, fih.health, 8);

  textAlign(CORNER);
  textSize(20);
  fill(255);
  text("SCORE: " + score, 55, 800);
  text("AMMO: " + fih.laserCount, 55, 830);
  text("ROCKS PASSED: " + rocksPassed, 55, 860);
}
