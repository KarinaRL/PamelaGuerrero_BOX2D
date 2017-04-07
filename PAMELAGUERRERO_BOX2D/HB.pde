class HB{
  
  protected Box2DProcessing mBox2DRef;
  protected Body mBody;
  protected boolean stopped = false;
  protected float direction;
  private boolean delete = false;
  HB(float xInit, float yInit, BodyType type, Box2DProcessing box2D){
    direction = 1.0;
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type =BodyType.DYNAMIC;
    bd.position = mBox2DRef.coordPixelsToWorld(xInit,yInit);
    bd.setFixedRotation(true);
    
    if(bd.position.y > 900)
      stopped = true;
    
    mBody = mBox2DRef.createBody(bd);
    
    PolygonShape right = new PolygonShape();
    Vec2[] rvertices = new Vec2[8];
    rvertices[0] = mBox2DRef.vectorPixelsToWorld(new Vec2(15.5, -18.8));
    rvertices[1] = mBox2DRef.vectorPixelsToWorld(new Vec2(10.5, -23.8));
    rvertices[2] = mBox2DRef.vectorPixelsToWorld(new Vec2(-15.5, -8.8));    
    rvertices[3] = mBox2DRef.vectorPixelsToWorld(new Vec2(-15.5, 15.8));
    rvertices[4] = mBox2DRef.vectorPixelsToWorld(new Vec2(0.5, 18.8));
    rvertices[5] = mBox2DRef.vectorPixelsToWorld(new Vec2(0.5, 23.8));
    rvertices[6] = mBox2DRef.vectorPixelsToWorld(new Vec2(15.5, 23.8));
    rvertices[7] = mBox2DRef.vectorPixelsToWorld(new Vec2(8.75, 11.79));
    
   right.set(rvertices, rvertices.length);
    FixtureDef fd = new FixtureDef();
    
    fd.shape = right;
    fd.density = -4f;
    fd.friction = 0.2f;
    fd.restitution = 0.1f;
    
    mBody.createFixture(fd);
    mBody.setUserData(this);
    
  }
  
  void draw() {
    Vec2 pos = mBox2DRef.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    fill(171,242,67);
    Fixture f = mBody.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      scale(direction, 1.0);
      beginShape();
      for (int i = 0; i < ps.getVertexCount(); i++) {
        Vec2 v = mBox2DRef.vectorWorldToPixels(ps.getVertex(i));
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    popMatrix();
    
  }
  
  void applyVelocity(float x,float y){
    Vec2 bodyVec = mBody.getWorldCenter();
    Vec2 worldTarg =  mBox2DRef.coordPixelsToWorld(x,y);
    worldTarg.subLocal(bodyVec);
    worldTarg.normalize();
    direction = round(worldTarg.x) == -1 ? -1 : 1;
    worldTarg.mulLocal((float) 70);
    mBody.applyForce(worldTarg, bodyVec);
    
  }
  
  void applyVelocity(Vec2 movement){
    stopped = false;
    Vec2 bodyVec = mBody.getWorldCenter();
    Vec2 target = bodyVec.add(movement);
    target.subLocal(bodyVec);
    target.normalize();
    direction = target.x == -1 ? -1 : 1;
    target.mulLocal((float) 100);
    mBody.applyForce(target, bodyVec);
  }
  void stopVelocity(){
    stopped = true;
  }
 void delete(){
    delete = true;
  }



}