
float playerX = 700;
float playerY = 750; 

float ballX = playerX + 25;
float ballY = playerY + 150;



int speed = 3;
int size = 40; 
int ballSize = 60;
float r = 0;
float g = 0;
float b = 0;

int state = 0;
float patchWork[][] = new float[32][17];
float ballSpeed = 0;
float cofriction = 0.95;

float counter = 0;
boolean win = false;

int score = 0;





void setup()
{
  size(1280, 960); 
  
}

void draw()
{
  
  patchWork(); //<>//
  
  noStroke();
  fill(155);
  rect(0, (height*3/4) - 50, width, height);
  
  
  textSize(100);
  fill(0);
  text(score, 50, 100);
  
  drawHole();
   
  drawPlayer(playerX, playerY);
  playerMovement();
  
  
  if(state == 1)
  {
    speed = speed * 0;
    chargeUP();
  }else if(state == 2)
  {
    launchBall();
  }else if(state == 3) //<>//
  {
    speed = 3;
    state = 0;
  }
  
  
  
  if(win)
  {
    textSize(100);
    fill(0);
    score++;
    text("You Win!", width/2, height/2);
  }
  
 
}



void keyPressed()
{
  state++;       //increases variable state each time space is pressed
}

void chargeUP()   //charges up power for player
{
  if(r < 255|| g < 255)  
  {
    r += 0.9;
    g -= 0.2;
    counter++;
  } 
     
  if(r >= 255 || g >= 255)
  {
    counter = 0;
    r = 0;
    g = 0;
  }
}

void launchBall()            //function to launch ball once key is pressed 2nd time
{
   //<>//
   
   ballX = playerX + 25;
   ballY = playerY + 150;

   ballY--;                 
    
   drawBall(ballX, ballY);
  
 
  if(r == 0 || g == 0)      //series of if statements check for specific values of a counter variable i made
  {
    ballSpeed = 0;
  }else if(counter  == 71)
  {
    ballSpeed = 1;
  }else if(counter == 142)
  {
    ballSpeed = 2;
  }else if(counter == 213)
  {
    ballSpeed = 3;
  }else if(counter == 284)
  {
    ballSpeed = 4;
  }
  
  if(ballY > height - 30)
  {
    ballSpeed += 2;
  }
  
  
  ballSpeed = ballSpeed * cofriction;  //reduces balls speed due to friction 
  
  checkWin(); //<>//
}

void drawPlayer(float x, float y) //function that draws the player
{
  noStroke(); //<>//
  fill(r, g, b);
  rect(x, y, 50, 150);
  triangle(x - 50, y, x + 25, y - 75, x + 100, y);
}

void playerMovement()                //function determining how player is to be moved
{
  playerX = playerX + speed;         //adds speed to the player enabling movement sideways
  
  if(playerX > 1280 || playerX < 0)  //checks if player has it the borders of the game then alternates speed alternating direction
  {
    speed = speed * -1;
  }
}



void patchWork() //function to create golf green
{
    
  randomSeed(0);
  for(int i = 0; i < patchWork.length; i++){       //goes through outer array
    for(int j = 0; j < patchWork[i].length; j++){  //goes through inner array
       patchWork[i][j] = random(120, 200);         //sets as values to be random float from 120, 199
       noStroke();
       fill(0, patchWork[i][j], 0);                //sets fill by the random array values 
       rect(i*size, j*size, size, size);           //creates patchwork grid
     }
   }

}

void drawHole()               //function which draws hole 
{
  stroke(0, 200, 0);
  fill(0);
  ellipse(370, 300, 75, 75);
}

void drawBall(float x, float y)     //draws ball on the screen
{
 
  noStroke();
  fill(255);
  ellipse(x, y, ballSize, ballSize);  //ball is drawn according to two given formal parameters
}

void checkWin()
{
  if(ballX == 370 && ballY == 300) //checks if the center of the ball and hole alligh indicating it is in 
  {
    win = true;                    //makes win variable true
  }
}
