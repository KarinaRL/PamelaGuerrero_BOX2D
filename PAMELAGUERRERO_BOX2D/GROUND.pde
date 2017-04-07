class Ground {
  
  protected Box2DProcessing mBox2DRef;
  ArrayList<Vec2> ground;


  Ground(Box2DProcessing box2D) {
    
    mBox2DRef = box2D;
    ground = new ArrayList<Vec2>();
    ground.add(new Vec2(width, height));
    ground.add(new Vec2(width/2,height/2+400));
    ground.add(new Vec2(0,height/2+400));

    ChainShape chain = new ChainShape();

    // We can add 3 vertices by making an array of 3 Vec2 objects
    Vec2[] vertices = new Vec2[ground.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = mBox2D.coordPixelsToWorld(ground.get(i));     
    }
    
    chain.createChain(vertices,vertices.length);
    
    
    BodyDef bd = new BodyDef();
    //bd.position.set(0.0f,0.0f);
    Body body = mBox2DRef.createBody(bd);
    body.createFixture(chain,1);
    body.setUserData(this);
  }

  // A simple function to just draw the edge chain as a series of vertex points
  void draw() {
    strokeWeight(1);
    //stroke(255);
    fill(150,45,255);
    beginShape();
    for (Vec2 v: ground) {
      vertex(v.x,v.y);
    }
    vertex(0,height);
    vertex(width,height);
    endShape();
  }
}