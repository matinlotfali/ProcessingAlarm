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
        player.loop();
  }
}

void mousePressed()
{
  if (player.isPlaying())
    player.pause();
  else if (mouseButton == LEFT)
    pause = !pause;
  else if (mouseButton == RIGHT)
    time = 3600; //one hour

  refreshScreen();
}

void refreshScreen()
{
  background(255);
  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);

  String time_str = String.format("%02d:%02d", time / 60, time % 60);
  text(time_str, width/2, height/2);

  fill(255, 0, 0);
  textSize(40);
  textAlign(CENTER, CENTER);
  if (pause)
    text("Paused", width/2, height*2/3);
  if (player.isPlaying())
    text("Alarm", width/2, height*2/3);
}
