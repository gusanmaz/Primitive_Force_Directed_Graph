public class Velocity{
  private float x;
  private float y;
  private float kineticEnergy;
  
  public Velocity(float _x, float _y){
    x = _x;
    y = _y;
    kineticEnergy = (0.5) * Constants.M * ((x*x) + (y*y));
  }
  
  public void setVelocity(float _x, float _y){
    x = _x;
    y = _y;
    kineticEnergy = (0.5) * Constants.M * ((x*x) + (y*y));
  }
  
  public float getKineticEnergy(){
    return kineticEnergy;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
}
