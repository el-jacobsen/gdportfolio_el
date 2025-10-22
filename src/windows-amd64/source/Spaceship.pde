class Spaceship {
  //Member Variables
  int x, y, w, health, laserCount, turretCount;
  PImage ship;

  //Constructor
  Spaceship() {
    x = width/2;
    y = height/2;
    w = 100;
    health = 100;
    laserCount = 200;
    turretCount = 1;
    ship = loadImage ("fihy.png");
  }

  //Member Methods
  void display() {
    image(ship, x, y);
    imageMode(CENTER);
  }

  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  boolean fire() {
    if (laserCount>0) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock c) {
    float d = dist(x, y, c.x, c.y);
    if (d<40) {
      return true;
    } else {
      return false;
    }
  }
}
