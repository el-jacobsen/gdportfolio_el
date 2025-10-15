class PowerUp {
  //Member Variables
  int x, y, w, speed;
  char type;
  PImage r1;
  color c1;

  //Constructor
  PowerUp() {
    x = int(random(width));
    y = -100;
    w = 100;
    speed = int(random(1, 6));

    if (random(10)>6.6) {
      r1 = loadImage ("ammoRefill.png");
      type = 'a'; //AMMO

    } else if (random(10)>5.0) {
      r1 = loadImage ("healthRefill.png");
      type = 'h'; //HEALTH

    } else {
      r1 = loadImage ("newTurret.png");
      type = 't'; //FIRING LASER INCREASE

    }
  }

  //Member Methods
  void display() {
    imageMode(CENTER);
    image(r1, x, y);
  }

  void move() {
    y = y + speed;
  }

  boolean reachedBottom () {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Spaceship s) {
    float d = dist(x, y, s.x, s.y);
    if (d<40) {
      return true;
    } else {
      return false;
    }
  }
}
