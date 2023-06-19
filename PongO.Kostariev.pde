class Player {
  
  PVector position;
  float yDir;
  float w = 10;
  float h = 25;
  float b = 15;
  
  public Player(float x, float y, float yDir) 
  {
    this.position = new PVector(x, y);
    this.yDir = yDir;
  }
  public void setDirection(float yDir) 
  {
    this.yDir = yDir;
  }
  public PVector getPosition() 
  {
    return position;
  }
  public float getHeight() 
  {
    return h;
  }
  public float getWidth() 
  {
    return w;
  }
  public void update() 
  {
    position.y += yDir;
    if (position.y < b) 
    {
      position.y = b;
    } 
    else if (position.y > height-b-h) 
    {
      position.y = height-b-h;
    }    
    fill(255);
    rect(position.x, position.y, w, h);
  }
}

class Ball 
{
  PVector position;
  PVector direction;
  float d = 15;
  float s = 5;
  
  public Ball() 
  {
    resetMovement();
  }
  public PVector getPosition() 
  {
    return position;
  }
  public void resetMovement() 
  {
    this.position = new PVector(width/2, height/2);
    float speed = random(-s, s);
    direction = new PVector(speed, speed/2);
  }
  public void setDirection(float x) 
  {
     direction.x = x * speed;
  }
  public void update() 
  {
    position.add(direction);
    if (position.y < 0 || position.y > height) 
    {
      direction.y = -direction.y;
    }
    
    fill(255);
    circle(position.x, position.y, d); 
  }
  public boolean overlapsWith(Player player) 
  {
    var p = player.getPosition();
    var w = player.getWidth();
    var h = player.getHeight();
    var r = d/2;
    
    for (int i = 0; i < 8; i++) 
    {
       var degree = (i * 45) * (PI/180);
       var x = r * cos(position.x + degree) + position.x;
       var y = r * sin(position.y + degree) + position.y;
       if (p.x < x && x < p.x + w &&
           p.y < y && y < p.y + h) return true;
    }
    return false;
  }
}
float speed = 3;
float p1Score = 0;
float p2Score = 0;

Player p1;
Player p2;
Ball ball;

float lastBallPositionX = 0;

void setup() 
{  
  size(500, 500);
  p1 = new Player(10, height/2, 0);
  p2 = new Player(width-20, height/2, 0);
  ball = new Ball();
}

void draw() 
{
  background(0);  
  p1.update();
  p2.update();
  ball.update();
  
  PVector ballPosition = ball.getPosition(); 
  if (ballPosition.x < 0) 
  {
    p2Score += 1;
    ball.resetMovement(); 
  }
  else if (ballPosition.x > width) 
  {
    p1Score += 1;
    ball.resetMovement(); 
  }
  if (ball.overlapsWith(p1)) 
  {
    ball.setDirection(1); 
  }
  if (ball.overlapsWith(p2)) 
  {
    ball.setDirection(-1); 
  }
  
  lastBallPositionX = ballPosition.x;  
  fill(255);
  text("P1 Score: " + p1Score, 10, 20);
  text("P2 Score: " + p2Score, width-80, 20);
}

void keyPressed() 
{
  if (key == 'w') p1.setDirection(-speed);
  else if (key == 's') p1.setDirection(speed);
  
  if (keyCode == UP) p2.setDirection(-speed);
  else if (keyCode == DOWN) p2.setDirection(speed);
}
