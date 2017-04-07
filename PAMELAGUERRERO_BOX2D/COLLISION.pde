import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

 class CustomListener implements ContactListener {
  CustomListener() {
  }
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if (o1.getClass() == Point.class && o2.getClass() == H.class)
  {
    Point p1 = (Point) o1;
    p1.delete();
    playerScore++;
  }
  if(o2.getClass() == Point.class && o1.getClass() == H.class) 
  {
    Point p2 = (Point) o2;
    p2.delete();
    playerScore++;
  } 
  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
     Particle p1 = (Particle) o1;
     p1.delete();
    Particle p2 = (Particle) o2;
    p2.delete();
   }
   if (o1.getClass() == Particle.class && o2.getClass() == Ground.class) {
     Particle p1 = (Particle) o1;
     p1.delete();
   }
    if(o2.getClass() == Particle.class && o1.getClass() == Ground.class) 
  {
    Particle p2 = (Particle) o2;
    p2.delete();
 
  }
   if (o1.getClass() == Point.class && o2.getClass() == BEL.class) {
      Point p1 = ( Point) o1;
     p1.delete();
   }
    if(o2.getClass() ==  Point.class && o1.getClass() == BEL.class) 
  { 
    Point p2 = (Point) o2;
    p2.delete();
 
  }
  
 // if (o1.getClass() == Point.class && o2.getClass() == Boundary.class)
  //{
//Point p1 = (Point) o1;
   // p1.delete();
    
 // }
 // if(o2.getClass() == Point.class && o1.getClass() == Boundary.class) 
  //{
   // Point p2 = (Point) o2;
//p2.delete();
 
 // }
  
 if (o1.getClass() == Point.class && o2.getClass() == Ground.class)
  {
    Point p1 = (Point) o1;
    p1.delete();
    
  }
  if(o2.getClass() == Point.class && o1.getClass() == Ground.class) 
  {
    Point p2 = (Point) o2;
    p2.delete();
  }
}

// Objects stop touching each other
void endContact(Contact contact) {
}
void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }
  
void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}