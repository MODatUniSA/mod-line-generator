float linePosition;
float lineWidth;
float speed;
float loopNumber;

void setup() {
  // Projector dimensions
  // size(1920, 1080);
  fullScreen(2);
  
  // Configure the lines and speed
  lineWidth = height/20;
  speed = 1;
  
  // Line colour and width
  stroke(0);
  strokeWeight(lineWidth);
  
  // General setup
  smooth();
  linePosition = 0;
  loopNumber = 1;
}

void draw() {
  // Background colour
  background(255);
  
  // Draw enough lines to cover 2x screen height
  for (float i = 0; i <= (height/lineWidth); i++) { 
    line(0, linePosition + (lineWidth * 2 * i), width, linePosition + (lineWidth * 2 * i));
  }
  
  // Set the canvas to move next loop
  linePosition -= speed;
  
  // Start again if we've moved one screen height
  if (linePosition < -height) { 
    linePosition = 0;
    loopNumber += 1;
    println("Loop #", loopNumber);
  }
}