class Player{
  int hits;
  float x;
  float y;
  float w;
  float h;
  int velY;
  
  Player(){
   w = 10;
   h = 75;
   x = 590;
   y = 120;
   velY = 5;
  }
  
  void drawPlayer(){
    stroke(0);
    fill(255);
    rect(x,y,w,h);
  }
  
}
