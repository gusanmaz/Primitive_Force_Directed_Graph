public class Force{
  private float x;
  private float y;
  
  public Force(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  public void setForce(float _x, float _y){
    x = _x;
    y = _y;
  }
  
   public float getX(){
    return x;
  }
  
   public float getY(){
    return y;
  }
  
  public void addForce(Force f){
    x += f.getX();
    y += f.getY();
  }
}
