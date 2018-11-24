public class System{
  int[] ind2Vertices;
  Vertice[] vertices;
  Edge[]    edgeList;
  float     totalKineticE;
  
  float bigger;
  float w_scaled;
  float h_scaled;
  float rad_scaled;
  
  public System(int[] _ind2Vertices, Vertice[] _vertices, Edge[] _edgeList){
    ind2Vertices  = _ind2Vertices;
    vertices      = _vertices;
    edgeList      = _edgeList;
    totalKineticE = 5; 
  }
    
  public void setup(float w, float h){
    bigger  = (w > h) ? w : h;
    w_scaled  = w / bigger;
    h_scaled = h / bigger;
    rad_scaled = Constants.RAD / bigger;
    
    for(int i = 0; i < vertices.length; i++){
      float x, y;
      boolean collision;
      
      do{
        collision = false;
        x = random(rad_scaled, w_scaled - rad_scaled);
        y = random(rad_scaled, h_scaled - rad_scaled);
        for(int j = 0; j < i; j++){
          Position pos = vertices[j].getPosition();
          float v_x = vertices[j].getPosition().getX();
          float v_y = vertices[j].getPosition().getY();
          if ((HelperClass.getDist(x,y, v_x, v_y) < rad_scaled)){
            collision = true;
            //break;
          }
        }
      }while(collision == true);
       vertices[i].setPosition(x,y);
    }
    
    for (int i = 0; i < edgeList.length; i++){
      Edge movingEdge = edgeList[i];
      while (movingEdge != null){
        int v1Ind = HelperClass.findInd(ind2Vertices, movingEdge.getV1().getID());
        int v2Ind = HelperClass.findInd(ind2Vertices, movingEdge.getV2().getID());
        float len = HelperClass.getDist(vertices[v1Ind], vertices[v2Ind]);
        movingEdge.updateDistance();
        movingEdge.scaleDesiredDist(bigger);
        movingEdge = movingEdge.getNextEdge();
      }
    }
  }
  
  private Force calculateRepulsionForce(Vertice v1, Vertice v2){
    float x1     = v1.getX();
    float y1     = v1.getY();
    float x2     = v2.getX();
    float y2     = v2.getY();
    float dist  = HelperClass.getDist(x1, y1, x2, y2);
    
    float abs_m    = abs((y2 - y1) / (x2 - x1));
    float angle    = atan(abs_m);
    
    float repulsion_f = Constants.R / (sq(dist));
    float fx = repulsion_f * cos(angle);
    float fy = repulsion_f * sin(angle);
    
    
    float xSign =  1;
    float ySign =  1;
    
    if ((x1 - x2) < 0){
      xSign = -1;
    }
    
    if ((y1 - y2) < 0){
      ySign = -1;
    }

    fx *= xSign;
    fy *= ySign;
    return new Force(fx,fy);
  }

  public void tickClock(){
    if (abs(totalKineticE) > Constants.B){
      totalKineticE = 0;
      for(int v1Ind = 0; v1Ind < vertices.length; v1Ind++){
        Force cumV1Force = new Force(0,0);
        for(int v2Ind = 0; v2Ind <vertices.length; v2Ind++){
          if (v1Ind != v2Ind){
            cumV1Force.addForce(calculateRepulsionForce(vertices[v1Ind], vertices[v2Ind]));
          }
        }
        
        Edge curEdge = edgeList[v1Ind];
        while (curEdge != null){
          cumV1Force.addForce(curEdge.getSpringForce());
          curEdge = curEdge.getNextEdge();
        }
        vertices[v1Ind].setForce(cumV1Force);
      }
      
      for(int i = 0; i < vertices.length; i++){
        vertices[i].moveVertice();
        totalKineticE += vertices[i].getKineticEnergy();
      }
      
      for(int i = 0; i < edgeList.length; i++){
        Edge curEdge = edgeList[i];
        while (curEdge != null){
          curEdge.updateDistance();
          curEdge = curEdge.getNextEdge();
        }
      }
    }
    
  }
      
  public void setEnergy(){
    totalKineticE = 2 *Constants.B;
  }
  
}
        
      
  
  
    
