class Computer{
  float x;
  float y;
  float w;
  float h;
  int velY;
  
  Computer(){
   w = 10;
   h = 75;
   x = 0;
   y = 120;
   velY = 5;
  }
  
  void drawComputer(){
    stroke(0);
    fill(255);
    rect(x,y,w,h);
  }
}
