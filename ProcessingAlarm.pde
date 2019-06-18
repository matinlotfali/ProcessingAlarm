import processing.sound.*;
static SoundFile player;
//to install minim:
//Tools -> Add Tool menu -> Libraries tab -> Search minim -> Click install

static int time = 3600; //one hour
//static int time = 10*60 + 1; //test case
static boolean pause = true;
static Timer timer;
int size;

void setup()
{
  size(displayWidth, displayHeight);
  size = min(displayWidth, displayHeight);
  frameRate(fRate);

  //for Android - comment out for Desktop
  requestPermission("android.permission.RECORD_AUDIO", "initRecord");

  //for Desktop - comment out for Android
  //initRecord(true); 
}

public void initRecord(boolean granted)
{
  if (granted)
    player = new SoundFile(this, "alarm.mp3");
}

public void draw()
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

void mousePressed()
{
  pause = !pause;
  if(pause)
      timer.cancel();
  else
      startTimer();
}

void startTimer()
{
    timer = new Timer();
    timer.scheduleAtFixedRate(new TimerTask() {
        @Override
        public void run() {
            if (time > 0)
            {
                time--;
                //println(time);

                if (player != null)
                    if (time % 60 == 0)  //check second
                        if (time / 60 == 10 || time / 60 == 5 || time == 0) //check minute
                        {
                            player.loop();
                            //println("player started");
                            timer.schedule(new TimerTask(){
                                @Override
                                public void run() {
                                    player.stop();
                                    //println("player stopped");
                                }
                            }  , 5000);
                        }
            }
        }
    }, 1000, 1000);
}

//for Android - comment out for Desktop
void onBackPressed() {
    super.onBackPressed();
    android.os.Process.killProcess(android.os.Process.myPid());
}