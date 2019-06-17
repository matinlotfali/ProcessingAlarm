import ddf.minim.*;
Minim minim;
AudioPlayer player;
//to install minim:
//Tools -> Add Tool menu -> Libraries tab -> Search minim -> Click install

int time = 3600; //one hour
//int time = 10*60 + 1; //test case
boolean pause = true;

void setup()
{
  size(400, 400);
  minim = new Minim(this);
  player = minim.loadFile("alarm.mp3");
  frameRate(10);
}

void draw()
{
  refreshScreen();

  if (!pause && frameCount%10 == 0 && time > 0)
  {
    time--;
    if (time % 60 == 0)  //check second
      if (time / 60 == 10 || time / 60 == 5 || time == 0) //check minute
      {
        player.loop(5);
        //argument 3 plays 2 beeps.
        //argument 4 plays indefinite beeps.
        //argument 5 plays 3 beeps. 
        //I don't know why. WTF !
      }
  }
}

void mousePressed()
{
  if (mouseButton == LEFT)
    pause = !pause;

  refreshScreen();
}

void refreshScreen()
{
  background(255);
  strokeWeight(2);

  float degree = map(time, 0, 3600, -PI/2, 3*PI/2);
  fill(64, 64, 200);
  stroke(0);
  arc(width/2, height/3, width/2, height/2, -PI/2, degree, PIE);
  noFill();
  ellipse(width/2, height/3, width/2, height/2);

  String time_str = String.format("%02d:%02d", time / 60, time % 60);
  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(time_str, width/2, height*2/3);

  fill(128, 32, 32);
  rect(width/4, height*3/4, width/2, height/10, 20);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  if (pause)
    text("Resume", width/4, height*3/4, width/2, height/10);
  else
    text("Pause", width/4, height*3/4, width/2, height/10);
}
