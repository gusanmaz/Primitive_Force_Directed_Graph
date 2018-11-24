//Change Accordingly
String dataFile = "../data.csv";
DataReader dataReader;
int[] ind2Vertices;
Edge[] edgeList;
Vertice[] vertices;
System system; 
float bigger;

boolean mouseOver;
int mouseOverInd;

boolean dragStart, dragEnd;
int dragInd;
float dragX, dragY;

boolean showLengths;
boolean restart;

void render(){
  for (int i = 0; i < edgeList.length; i++){
      Edge movingEdge = edgeList[i];
      while (movingEdge != null){
        Position p1 = movingEdge.getV1().getPosition();
        Position p2 = movingEdge.getV2().getPosition();
        float x1   = p1.getX() * bigger;
        float y1   = p1.getY() * bigger;
        float x2   = p2.getX() * bigger;
        float y2   = p2.getY() * bigger;
        float rad  = Constants.RAD; //
        
        //ellipseMode(RADIUS);
        stroke(0);
        line(x1, y1, x2, y2);
        fill(200);
        ellipse(x1, y1, rad, rad);
        ellipse(x2, y2, rad, rad);
        
        movingEdge = movingEdge.getNextEdge();
      }
    }
}


void setup(){
  size(900,900);
  //String dataFile("data.csv");
  dataReader = new DataReader(dataFile);
  ind2Vertices = dataReader.getInd2Vertice();
  edgeList     = dataReader.getEdgeList();
  vertices     = dataReader.getVertices();
  system       = new System(ind2Vertices, vertices, edgeList);
  system.setup(width, height);
  bigger  = (width > height) ? width : height;
  showLengths = false;
  restart = false;
  rectMode(CORNER);
  ellipseMode(RADIUS);
}

void draw(){
  background(255);
  fill(50);
  text("Press \"L\" to see edge lengths and \"R\" to restart the animation.",20,20);
  
  if (restart){
    dataReader = new DataReader(dataFile);
    ind2Vertices = dataReader.getInd2Vertice();
    edgeList     = dataReader.getEdgeList();
    vertices     = dataReader.getVertices();
    system       = new System(ind2Vertices, vertices, edgeList);
    system.setup(width, height);
    showLengths = false;
    restart = false;
  }

 render();

  system.tickClock();
  
  if (mouseOver){
    fill(50,200,100);
    float x = vertices[mouseOverInd].getX();
    float y = vertices[mouseOverInd].getY();
    ellipse(x * bigger,y * bigger,Constants.RAD, Constants.RAD);
    float offset = Constants.RAD / 2;
    fill(0);
    text(int(vertices[mouseOverInd].getID()), x * bigger - offset,y * bigger + offset);
    fill(200);
  }

  if (showLengths){
    for(int i = 0; i < edgeList.length; i++){
      Edge curEdge = edgeList[i];
      while(curEdge != null){
        Vertice v1 = curEdge.getV1();
        Vertice v2 = curEdge.getV2();
        float x1 = v1.getX() * bigger;
        float y1 = v1.getY() * bigger;
        float x2 = v2.getX() * bigger;
        float y2 = v2.getY() * bigger;
        float xMid = x1 + ((x2 - x1) / 2);
        float yMid = y1 + ((y2 - y1) / 2);
        float actual  = curEdge.getActualDist() * bigger;
        float desired = curEdge.getDesiredDist() * bigger;
        String info = str(actual) + ", " + str(desired);
        fill(50);
        text(info, xMid, yMid);
        curEdge = curEdge.getNextEdge();
      }
    }
  } 
}

void mouseMoved(){
  float x = mouseX / bigger;
  float y = mouseY / bigger;
  mouseOver = false;
  for(int i = 0; i < vertices.length; i++){
    float vx = vertices[i].getX();
    float vy = vertices[i].getY();
    if (dist(vx, vy, x, y) <= (Constants.RAD / bigger)){
      mouseOver = true;
      mouseOverInd = i;
      break;
    }
  }
}

void mousePressed(){
  dragInd   = -1;
  float x = mouseX / bigger;
  float y = mouseY / bigger;
  for(int i = 0; i < vertices.length; i++){
    float vx = vertices[i].getX();
    float vy = vertices[i].getY();
    if (dist(vx, vy, x, y) <= (Constants.RAD / bigger)){
      dragInd = i;
      break;
    }
  }
}

void mouseReleased(){
  if (dragInd != -1){
    dragX = mouseX / bigger;
    dragY = mouseY / bigger;
    vertices[dragInd].setPosition(dragX, dragY);
    system.setEnergy();
  }
}

void keyPressed(){
  
  if (key == 'l'){
    showLengths = !showLengths;
  }
  
  if (key == 'r'){
    restart = true;
  }
  
}
    
  
  
      
    
    
  


