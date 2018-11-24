class DataReader{
  private int maxVerticeCnt;
  private int[] ind2Vertice;
  private Vertice[] vertices;
  private Edge[] edgeList;
  
  public int[] getInd2Vertice(){
    return ind2Vertice;
  }
  
  public Vertice[] getVertices(){
    return vertices;
  }
  
  public Edge[] getEdgeList(){
    return edgeList;
  }
  
  public DataReader(String fileName){
    Table table   = loadTable(fileName);
    maxVerticeCnt = table.getRowCount() * 2;
    ind2Vertice = new int[maxVerticeCnt];
    int verticeCnt = 0;
    
    for (TableRow row : table.rows()) {
    
    int v1 = row.getInt(0);
    int v2 = row.getInt(1);
    float len = row.getFloat(2);
    
    boolean v1Found = false;
    boolean v2Found = false;
    
    for(int i = 0; i < verticeCnt; i++){
      if ((!v1Found) && (ind2Vertice[i] == v1)){
        v1Found = true;
      }
      if ((!v2Found) && (ind2Vertice[i] == v2)){
        v2Found = true;
      }
      if ((v1Found) && (v2Found)){
        break;
      }
    }
    
    if (!v1Found){
      ind2Vertice[verticeCnt++] = v1;
    }
    
    if (!v2Found){
      ind2Vertice[verticeCnt++] = v2;
    }
    
  }
  
  int[] ind2VerticeTemp = ind2Vertice;
  ind2Vertice           = new int[verticeCnt];
  
  for(int i = 0; i < verticeCnt; i++){
    ind2Vertice[i] = ind2VerticeTemp[i];
  }
  
  vertices = new Vertice[verticeCnt];
  edgeList = new Edge[verticeCnt];
  
  int curVerCnt = 0;
  
  for (TableRow row : table.rows()) {
    int  v1 = row.getInt(0);
    int  v2 = row.getInt(1);
    float d = row.getFloat(2);
    
    int v1Ind = HelperClass.findInd(ind2Vertice, v1);
    int v2Ind = HelperClass.findInd(ind2Vertice, v2);
    
    if (vertices[v1Ind] == null){
      vertices[v1Ind] = new Vertice(v1);
    }
    
    if (vertices[v2Ind] == null){
      vertices[v2Ind] = new Vertice(v2);
    }
    
    if (edgeList[v1Ind] == null){
      edgeList[v1Ind] = new Edge(vertices[v1Ind], vertices[v2Ind], d);
    }
    else{
      Edge lastEdge = edgeList[v1Ind].getLastEdge();
      Edge newEdge  = new Edge(vertices[v1Ind], vertices[v2Ind], d);
      lastEdge.setNextEdge(newEdge);
    }
    
    if (edgeList[v2Ind] == null){
      edgeList[v2Ind] = new Edge(vertices[v2Ind], vertices[v1Ind], d);
    }
    else{
      Edge lastEdge = edgeList[v2Ind].getLastEdge();
      Edge newEdge  = new Edge(vertices[v2Ind], vertices[v1Ind], d);
      lastEdge.setNextEdge(newEdge);
    }
  }
 }//End of dataReader cons
} // End of Datareader class
  
