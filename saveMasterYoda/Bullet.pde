class Bullet{
 
  //variables
  int x;
  int y;
  int d;
  int speed;
  
  boolean shouldRemove;
  
  int left;
  int right;
  int top;
  int bottom;
  
  float dx;
  float dy;
  
  //constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    d=15;
    
    speed = 25;
    
    shouldRemove = false;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void render(){
   fill(0);
   circle(x,y,d); 
  }
  
  void move(){
  //float dx = mouseX - x;
  //float dy = mouseY - y;
  
  // Calculate distance to the mouse
  float distance = sqrt(dx * dx + dy * dy); 
  
  if (distance > 1) { 
    float speedX = dx / distance * speed;
    float speedY = dy / distance * speed;
    x += speedX;
    y += speedY;
  }

  left = x - d/2;
  right = x + d/2;
  top = y - d/2;
  bottom = y + d/2;
}

  void checkRemove(){
    if(y < 0){
      shouldRemove = true;
   }
  }
  
  void shootEnemy(Enemy anEnemy){
    if(top <= anEnemy.bottom &&
       bottom >= anEnemy.top &&
       left <= anEnemy.right &&
       right >= anEnemy.left){
        anEnemy.shouldRemove = true; 
        shouldRemove = true;
       }
   }
   
   void shootYoda(Yoda aYoda){
    if(top <= aYoda.bottom &&
       bottom >= aYoda.top &&
       left <= aYoda.right &&
       right >= aYoda.left){
        aYoda.shouldRemove = true; 
        shouldRemove = true;
       }
   }
}
