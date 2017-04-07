class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;

 
  boolean delete = false;

  Particle(float x, float y, float r_) {
    r = r_;
    // This function puts the particle in the Box2d world
    makeBody(x, y, r);
    body.setUserData(this);
   
  }

  // This function removes the particle from the box2d world
  void killBody() {
    mBox2D.destroyBody(body);
  }

  void delete() {
    delete = true;
  }


  // Is the particle ready for deletion?
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = mBox2D.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2 || delete) {
      killBody();
      return true;
    }
    return false;
  }
  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = mBox2D.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(random(236),238,204);
    noStroke();
    ellipse(0, 0, r*2, r*2);
    // Let's add a line so we can see the rotation
    //line(0, 0, r, 0);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = mBox2D.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = mBox2D.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = mBox2D.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(random(-5, 5));
  }
}