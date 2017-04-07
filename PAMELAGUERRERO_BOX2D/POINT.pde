class Point{
  protected Box2DProcessing mBox2DRef;
  protected Body mBody;
  private boolean delete = false;
  
  Point(Box2DProcessing box2D){
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = mBox2D.coordPixelsToWorld(random(width),random(height/2));
    bd.setFixedRotation(true);
    mBody = mBox2D.createBody(bd);
    
    PolygonShape base = new PolygonShape();
    Vec2[] vertices = new Vec2[6];
    vertices[0] = mBox2DRef.vectorPixelsToWorld(new Vec2(-8, 13));
    vertices[1] = mBox2DRef.vectorPixelsToWorld(new Vec2(0, 13));
    vertices[2] = mBox2DRef.vectorPixelsToWorld(new Vec2(9, 13));
    vertices[3] = mBox2DRef.vectorPixelsToWorld(new Vec2(-8, -13));
    vertices[4] = mBox2DRef.vectorPixelsToWorld(new Vec2(0, -14));
    vertices[5] = mBox2DRef.vectorPixelsToWorld(new Vec2(9, -13));

    base.set(vertices, vertices.length);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = base;
    fd.density = 1.0f;
    fd.friction = 0.2f;
    fd.restitution = 1f;
    
    mBody.setAngularVelocity(random(-4, 4));
    mBody.createFixture(fd);
    mBody.setUserData(this);
  
  }
  
  void draw(){
    
    Vec2 pos = mBox2D.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    Fixture f = mBody.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    pushMatrix();
    fill(255,random(85),100);
      translate(pos.x,pos.y);
      rotate(angle);
       beginShape();{
       for (int i = 0; i < ps.getVertexCount(); i++) {
        Vec2 v = mBox2DRef.vectorWorldToPixels(ps.getVertex(i));
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    popMatrix();
       }
  }
  
  
  void delete(){
    delete = true;
  }
  
  boolean done(){  
   if(delete)
     mBox2D.destroyBody(mBody);
   return delete; 
  }
  
}