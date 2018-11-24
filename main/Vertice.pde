public class Vertice{
  private int   id;
  private Position pos;
  private Force force;
  private Velocity vel;
  private Acceleration acc;
  //private float kineticE;
  
  public Vertice(int _id){
    id       = _id;
    pos      = new Position(-1, -1);
    force    = new Force(0,0);
    vel      = new Velocity(0,0);
    acc      = new Acceleration(0,0);
  }
  
  public int getID(){
    return id;
  }
  
  public void setForce(Force f){
    force.setForce(f.getX(), f.getY());
  }
  
  public void setPosition(float x, float y){
    pos.setPosition(x, y);
  }
  
  public void setPosition(Position pos){
    pos.setPosition(pos.getX(), pos.getY());
  }
  
  public Position getPosition(){
    return pos;
  }
  
  public void moveVertice(){
    float accX = force.getX() / Constants.M;
    float accY = force.getY() / Constants.M;
      
    acc.set(accX, accY);
    Velocity v1;
    float v1x = (vel.getX() + (acc.getX() * Constants.T)) * Constants.D;
    float v1y = (vel.getY() + (acc.getY() * Constants.T)) * Constants.D;
    float dispX = ((v1x + vel.getX()) * Constants.T) / 2;
    float dispY = ((v1y + vel.getY()) * Constants.T) / 2;
    pos.setPosition(pos.getX() + dispX, pos.getY() + dispY);
    vel.setVelocity(v1x, v1y); // Kinetic energy is recalculated at this stage
  }
  
  public float getKineticEnergy(){
    return vel.getKineticEnergy();
  }
  
  public float getX(){
    return pos.getX();
  }
  
   public float getY(){
    return pos.getY();
  }
  
}
  
