class BEL {

  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;

  // But we also have to make a body for box2d to know about it
  Body b;

 BEL(float x_,float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w =w_;
    h =h_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = mBox2D.scalarPixelsToWorld(w/2);
    float box2dH = mBox2D.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.angle = a;
    bd.position.set(mBox2D.coordPixelsToWorld(x,y));;
    b = mBox2D.createBody(bd);
   
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.2;
    fd.restitution = 0.2;
    
    // Attached the shape to the body using a Fixture
    b.createFixture(fd);
    b.setUserData(this);
    // Give it some initial random velocity
    b.setLinearVelocity(new Vec2(random(-5,5),random(-5,5)));
    b.setAngularVelocity(300/10);
  }
  void killBody() {
    mBox2D.destroyBody(b); 
  }

  // Draw the boundary, it doesn't move so we don't have to ask the Body for location
  void display() {    
    fill(random(247),36,116);
    noStroke();
    rectMode(CENTER);
    float a = b.getAngle();
    pushMatrix();
    translate(x,y);
    rotate(-a);
    rect(0,0,w,h,10);
    popMatrix();
  }
}