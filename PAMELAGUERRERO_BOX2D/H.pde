class H extends HB{
  private boolean flying = false;
  private Vec2 velocity;
  
  
  
  H( float xInit, float yInit, Box2DProcessing box2D){
    super(xInit, yInit, BodyType.DYNAMIC, box2D);
    velocity = new Vec2( 0, 0 );
  }
  
  public void update() {
    if(mBox2DRef.getBodyPixelCoord(mBody).y >= height-62 && stopped){  
      mBody.setLinearVelocity(new Vec2(0,0));
      stopped = false;
    }
    
  }
  
  public void move(String direction){
    
    if(direction == "up"){
      flying = true;
      velocity.set(new Vec2(0,400));  
    }
    
    if(direction == "left"){
      velocity.set(new Vec2(-1,0));
    }
    
    if(direction == "right"){
      velocity.set(new Vec2(1,0));
    }
    applyVelocity(velocity);
    velocity.mul(0);
  }
  
  public void stopMove(String direction) {
    if(direction == "up"){
      flying = false;
    }
    stopVelocity();
    velocity.mul(0);
  }
  
  public void stopMove(){
    stopVelocity();
    velocity.mul(0);
  }
  
  public Vec2 getPosition(){
    return mBox2DRef.getBodyPixelCoord(mBody);
  }
  
}