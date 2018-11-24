static class HelperClass{
  
  static int findInd(int[] array, int vertice){
    for(int i = 0; i < array.length; i++){
      if (array[i] == vertice){
        return i;
      }
    }
    return -1;
  }
  
  static float getDist(Vertice v1, Vertice v2){
    return sqrt(sq(v1.getX() - v2.getX()) + sq(v1.getY() - v2.getY()));
  }
  
  static float getDist(float x1, float y1, float x2, float y2){
    return sqrt(sq(x1 - x2) + sq(y2 - y1));
  }
  
}
  
  
