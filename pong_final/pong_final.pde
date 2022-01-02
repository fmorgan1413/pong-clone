PFont font;
import processing.sound.*;

Player player1;
Computer player2;
Ball ball;

SoundFile hit;
SoundFile superhit;
SoundFile score;
SoundFile scoredon;

int player1Score;
int player2Score;
String gamestate;
boolean up, down;

void setup(){
  size(600,300);
  player1 = new Player();
  player2 = new Computer();
  ball = new Ball();
  player1Score = 0;
  player2Score = 0;
  up = false;
  down = false;
  gamestate = "title";
  
  //font from: https://www.1001fonts.com/november-font.html
  font = createFont("novem___.ttf",18);
  
  //sound from: https://www.zapsplat.com/music/table-tennis-ping-pong-bat-hit-ball-1/
  hit = new SoundFile(this,"sport_table_tennis_ping_pong_bat_hit_ball_001.mp3");
  
  //sound from: https://www.zapsplat.com/music/table-tennis-ping-pong-ball-bounce-hit-table-3/
  superhit = new SoundFile(this,"sport_table_tennis_ping_pong_ball_bounce_hit_table_003.mp3");
  
  //sound from: https://freesound.org/people/zut50/sounds/162395/
  score = new SoundFile(this,"162395__zut50__yay.mp3");
  
  //sound from: https://freesound.org/people/phmiller42/sounds/124996/
  scoredon = new SoundFile(this,"124996__phmiller42__aww.wav");
}

void draw(){
  background(0);
  
  if (gamestate == "title"){
    title();
  }
  else if (gamestate == "game"){
    game();
  }
  else if (gamestate == "game over"){
    gameover();
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      up = true;
    }
    if(keyCode == DOWN){
      down = true;
    }
  }
  if(key == ' ' && gamestate == "title"){
    gamestate = "game";
  }
  if(key == ' ' && gamestate == "game over"){
    player1Score = 0;
    player2Score = 0;
    player1.hits = 0;
    ball.justScored = false;
    gamestate = "game";
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == UP){
      up = false;
    }
    if(keyCode == DOWN){
      down = false;
    }
  }
}

void moveComputer(){
  if(ball.y < player2.y - 15){
    player2.velY = -4;
    player2.y += player2.velY;
  }
  if(ball.y > player2.y + 15){
    player2.velY = 4;
    player2.y += player2.velY;
  }
  if(player2.y >= 225){
    player2.y = 225;
  }
  if(player2.y <= 0){
    player2.y = 0;
  }
}

void hitPaddles(){
  //circle vs rectangle hit detection
  //https://gist.github.com/pzp1997/46c52f06020dd4b15fbd
  if (ball.x - ball.ballSize/2 <= player2.x + player2.w/2 && ball.y + ball.ballSize/2 >= player2.y && ball.y - ball.ballSize/2 <= player2.y + player2.h){
    hit.play();
    ball.justScored = false;
    ball.charged = false;
    if (player2.velY == -4){
        ball.velX = 2;
        ball.x += ball.velX;
        ball.velY = -2;
        ball.y += ball.velY;
      }
      if (player2.velY == 4){
        ball.velX = 2;
        ball.x += ball.velX;
        ball.velY = 2;
        ball.y += ball.velY;
      }
   }
   if (ball.x + ball.ballSize/2 >= player1.x && ball.y + ball.ballSize/2 >= player1.y && ball.y - ball.ballSize/2 <= player1.y + player1.h){
     player1.hits ++;
     ball.justScored = false;
     if (player1.velY == -2 && player1.hits < 5){
        hit.play();
        ball.velX = -2;
        ball.x += ball.velX;
        ball.velY = -2;
        ball.y += ball.velY;
      }
      if (player1.velY == 2 && player1.hits < 5){
        hit.play();
        ball.velX = -2;
        ball.x += ball.velX;
        ball.velY = 2;
        ball.y += ball.velY;
      }
      if (player1.velY == -2 && player1.hits == 5){
        ball.charged = true;
        superhit.play();
        ball.velX = -5;
        ball.x += ball.velX;
        ball.velY = -5;
        ball.y += ball.velY;
        player1.hits = 0;
      }
      if (player1.velY == 2 && player1.hits == 5){
        ball.charged = true;
        superhit.play();
        ball.velX = -5;
        ball.x += ball.velX;
        ball.velY = 5;
        ball.y += ball.velY;
        player1.hits = 0;
      }
    }
}

void reset(){
  if(ball.x > 600){
    scoredon.play();
    ball.justScored = true;
    ball.charged = false;
    ball.x = width/2;
    ball.y = height/2;
    player2Score++;
    player1.hits = 0;
  }
  else if(ball.x < 0){
    score.play();
    ball.justScored = true;
    ball.charged = false;
    ball.x = width/2;
    ball.y = height/2;
    ball.velX = -2;
    ball.velY = -2;
    player1Score++;
  }
}

void title(){
  textSize(100);
  textFont(font);
  if(frameCount % 2 == 0){
    fill(150);
  } else{
    fill(255);
  }
  text("PONG BOOTLEG", 250, 50);
  textSize(15);
  text("controls: ", 50, 110);
  text("use the up and down keys to move", 50, 130);
  text("how to win: ", 50, 170);
  text("the first to 5 points wins", 50, 190);
  text("press space to start", 230, 250);
}

void game(){
  stroke(255);
  line(width/2,0,width/2,height);
  textSize(20);
  if(frameCount % 2 == 0){
    fill(150);
  } else{
    fill(255);
  }
  text(player1Score, 310, 20);
  text(player2Score, 280, 20);
  moveComputer();
  if(up == true){
    player1.velY = -2;
    player1.y += player1.velY;
      if(player1.y <= 0){
        player1.y = 0;
      }
  }
  if(down == true){
    player1.velY = 2;
    player1.y += player1.velY;
      if(player1.y >= 225){
        player1.y = 225;
      }
  }
  player1.drawPlayer();
  player2.drawComputer();
  ball.drawBall();
  ball.moveBall();
  hitPaddles();
  reset();
  if(player2Score == 5 || player1Score == 5){
    gamestate = "game over";
  }
}

void gameover(){
  if(frameCount % 2 == 0){
    fill(150);
  } else{
    fill(255);
  }
  if(player2Score == 5){
    text("you lose", 100, 110);
    text("press space to play again", 190, 250);
  }
  if(player1Score == 5){
    text("you win", 100, 110);
    text("press space to play again", 190, 250);
  }
}
