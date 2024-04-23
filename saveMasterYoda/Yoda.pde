class Yoda{
  ///////////////////variables
  float yodaX;
  float yodaY;
  int yodaW;
  int yodaH;
  
  boolean shouldRemove;
  
  float left;
  float right;
  float top;
  float bottom;
  
  //////////////////constructor
  Yoda(float yX, float yY, int ySize){
   yodaX = yX;
   yodaY = yY;
   yodaW = ySize;
   yodaH = ySize*2;
   
   shouldRemove = false;
   
   left = yodaX - ySize/2;
   right = yodaX + ySize/2;
   top = yodaY - ySize/2;
   bottom = yodaY + ySize/2;
  }
  
  /////////////functions
  void render(){
  }
}
