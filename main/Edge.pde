class Edge{
  private Vertice v1;
  private Vertice v2;
  private float desiredDist;
  private float actualDist;
  private Edge nextEdge;
  
  private float x1, x2, y1, y2;
  //private Force spring_force, repulsion_force;
  
  public Edge(Vertice _v1, Vertice _v2, float _desiredDist){
    v1          = _v1;
    v2          = _v2;
    desiredDist  = _desiredDist;
    nextEdge    = null;
    
    x1     = v1.getX();
    y1     = v1.getY();
    x2     = v2.getX();
    y2     = v2.getY();
    actualDist = HelperClass.getDist(x1,y1,x2,y2);
  }
  
  public Edge getLastEdge(){
    Edge movingEdge = this;
    while (movingEdge.getNextEdge() != null){
      movingEdge = movingEdge.getNextEdge();
    }
    return movingEdge;
  }
  
  public Edge getNextEdge(){
    return nextEdge;
  }
  
  public void setNextEdge(Edge _nextEdge){
    nextEdge = _nextEdge;
  }
  
  public boolean hasNext(){
    return (nextEdge != null);
  }
 
 
  public Vertice getV1(){
    return v1;
  }
  
  public Vertice getV2(){
    return v2;
  }
  
  //Calculates spring force on v1
  public Force getSpringForce(){
    x1     = v1.getX();
    y1     = v1.getY();
    x2     = v2.getX();
    y2     = v2.getY();
    
    float abs_m    = abs((y2 - y1) / (x2 - x1));
    float angle    = atan(abs_m);
    float spring_f = Constants.K * abs(actualDist - desiredDist);
    float fx = spring_f * cos(angle);
    float fy = spring_f * sin(angle);
    
    float sign = -1; //Inner
    if ((desiredDist - actualDist) > 0){
       sign = 1; //Outer
    }
    
    float xSign = 1;
    if ((x1 - x2) < 0){
      xSign = -1;
    }
    
    float ySign = 1;
    if ((y1 - y2) < 0){
      ySign = -1;
    }
            
    fx *= (sign * xSign);
    fy *= (sign * ySign);
    Force springF = new Force(fx, fy);
    return springF;
  }
  
  public void updateDistance(){
    x1 = v1.getX();
    y1 = v1.getY();
    x2 = v2.getX();
    y2 = v2.getY();
    actualDist = HelperClass.getDist(v1, v2);
  }
  
  public void scaleDesiredDist(float bigger){
    desiredDist = desiredDist / bigger;
  }
  
  public float getActualDist(){
    return actualDist;
  }
  
  public float getDesiredDist(){
    return desiredDist;
  }
      
}
  
  
  
  
  
  
  
  
    
