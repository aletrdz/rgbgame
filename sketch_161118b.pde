import processing.video.*;
color c1 = 0;
color c2 = 0;
color preview = 0;
int colCounter = 0;
boolean checkColor = false;

Capture cam;

void setup() {
  size(1280, 720);
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void captureEvent(Capture cam){
  cam.read();
}
void draw() {

  set(0,0, cam);
  //game title
  String title = "The RGB Game";
  float slength = textWidth(title);
  fill(255);
  textSize(48);
  text(title, (width/2) - (slength/2), 100);
  
  //instructions
  textSize(36);
  String instructions = "Click on a color and try to match it!";
  float ilength = textWidth(instructions);
  text(instructions, (width/2) - (ilength/2), 150);

   //checks if user has picked a color
   if (c1 != 0){
     fill(c1);
     noStroke();
     rect(25, 75, 100, 100);
     preview = get(mouseX, mouseY);
     fill(preview);
     rect(width-125, height - 175, 100, 100);
   }
    if (c2 != 0){
     fill(c2);
     noStroke();
     rect(width -125, 75, 100, 100);
   }
    //compares colors
    if(c1 != 0 && c2!= 0  && colCounter%2 == 0){
      check2Colors();
    }
 
}

void mousePressed(){
  colCounter++;
  if (colCounter%2 == 1){
    c1 = get(mouseX, mouseY);
  
  }else{
  c2 = get(mouseX, mouseY);
  }
}


void check2Colors(){
    //code taken from daniel shiffman's tutorial on computer vision
      float r1 = red(c1);
      float g1 = green(c1);
      float b1 = blue(c1);
      float r2 = red(c2);
      float g2 = green(c2);
      float b2 = blue(c2);

      // Using euclidean distance to compare colors
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.
      
      //checking color distance
      if(d < 20){
        fill(127,255,0);
        String winning = "You won!";
        float wlength = textWidth(winning);
        textSize(48);
        text(winning, (width/2) - (wlength/2), height/2);
      }else{
        String losing = "Better luck next time!";
        float llength = textWidth(losing);
        fill(255, 0, 0);
        textSize(48);
        text(losing, (width/2) - (llength/2), height/2);
      }
}