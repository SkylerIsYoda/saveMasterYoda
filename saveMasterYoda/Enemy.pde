class Enemy{
  ///////////////////variables
  float enemyX;
  float enemyY;
  int enemyW;
  int enemyH;
  
  boolean shouldRemove;
  
  float left;
  float right;
  float top;
  float bottom;
  
  
  //////////////////constructor
  Enemy(float badX, float badY, int badSize){
   enemyX = badX;
   enemyY = badY;
   enemyW = badSize;
   enemyH = badSize*2;
   
    shouldRemove = false;
   
    left = enemyX - badSize/2;
    right = enemyX + badSize/2;
    top = enemyY - badSize/2;
    bottom = enemyY + badSize/2;

  }
  
  /////////////functions
  void render(){
  }
 }
