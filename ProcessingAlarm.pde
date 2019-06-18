import processing.sound.*;
SoundFile player;
//to install processing.sound package:
//Tools -> Add Tool menu -> Libraries tab -> Search 'sound' 
// -> Select 'Sound' by 'The Processing Foundation' -> Click install

int time = 3600; //one hour
//int time = 10*60 + 1; //test case
boolean pause = true;
int alarmStartFrame = -1;
int fRate = 10;
int size;

void setup()
{
  size(displayWidth, displayHeight);
  size = min(displayWidth, displayHeight);
  requestPermission("android.permission.RECORD_AUDIO", "initRecord"); //for Android
  //initRecord(true); //for Desktop
  frameRate(fRate);
}

public void initRecord(boolean granted)
{
  player = new SoundFile(this, "alarm.mp3");
}

void draw()
{
  refreshScreen();

  if (pause)
    return;

  if (frameCount%fRate == 0 && time > 0)
  {
    time--;

    if (player == null)
      if (time % 60 == 0)  //check second
        if (time / 60 == 10 || time / 60 == 5 || time == 0) //check minute
        {
          player.loop();
          alarmStartFrame = frameCount;
        }
  }

  if (player != null && player.isPlaying())
    if (frameCount - alarmStartFrame == 5 * fRate)
      player.stop();
}

void mousePressed()
{
  pause = !pause;
  refreshScreen();
}

void onDestroy() {
  super.onDestroy();
  android.os.Process.killProcess(android.os.Process.myPid()); //comment for android
}

void refreshScreen()
{
  background(255);
  strokeWeight(size/200);

  float degree = map(time, 0, 3600, -PI/2, 3*PI/2);
  fill(64, 64, 200);
  stroke(0);
  arc(width/2, height/3, size/2, size/2, -PI/2, degree, PIE);
  noFill();
  ellipse(width/2, height/3, size/2, size/2);

  String time_str = String.format("%02d:%02d", time / 60, time % 60);
  fill(0);
  textSize(size/10);
  textAlign(CENTER, CENTER);
  text(time_str, width/2, height*2/3);

  fill(128, 32, 32);
  rectMode(CENTER);
  rect(width/2, height*4/5, size/2, size/10, 20);
  fill(255);
  textSize(size/20);
  textAlign(CENTER, CENTER);
  if (pause)
    text("Resume", width/2, height*4/5, size/2, size/10);
  else
    text("Pause", width/2, height*4/5, size/2, size/10);
}
