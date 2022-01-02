class Ball{
  float x;
  float y;
  int velY;
  int velX;
  float ballSize;
  boolean justScored;
  boolean charged;
  
  Ball(){
    x = 300;
    y = 150;
    velX = 2;
    velY = 2;
    ballSize = 25;
    justScored = false;
    charged = false;
  }
  
  void drawBall(){
    if (justScored == true){
      if(frameCount % 2 == 0){
        fill(75);
      }
    } else{
      fill(255);
    }
    
    if (charged == true){
      if(frameCount % 2 == 0){
        fill(255,0,0);
        text("SUPER CHARGED", 245, 140);
      } else{
        fill(255);
      }
    }
    circle(x,y,ballSize);
  }
  
  void moveBall(){
    y += velY;
    x += velX;
    if(y > height){
      hit.play();
      velY = -2;
    }
    if(y < 0){
      hit.play();
      velY = 2;
    }
  }
  
}
