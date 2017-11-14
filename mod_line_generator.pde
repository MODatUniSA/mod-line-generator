float linePosition;
float startPosition;
float lineWidth;
float speed;
float loopNumber;
boolean verticalOrientation;
boolean oppositeDirection;
float orientedScreenWidth;
float orientedScreenHeight;

void setup() {
  // Projector dimensions
  // size(1920, 1080);
  
  // Draw to the second monitor for debugging
  fullScreen(2);
  
  // Set direction to false for opposite direction
  oppositeDirection = false;
  
  // Set orientation
  verticalOrientation = true;
  
  orientedScreenWidth = width;
  orientedScreenHeight = height;
  if (verticalOrientation) {
    orientedScreenWidth = height;
    orientedScreenHeight = width;
  }
  
  // Configure the lines and speed
  lineWidth = orientedScreenHeight/20;
  speed = 2;
  
  // Line colour and width
  stroke(0);
  strokeWeight(lineWidth);
  
  // General setup
  loopNumber = 1;
  startPosition = 0;
  if (oppositeDirection) {
    startPosition -= orientedScreenHeight;
  }
  linePosition = startPosition;
}

void draw() {
  // Background colour
  background(255);
  smooth();
  
  // Draw enough lines to cover 2x screen height
  for (float i = 0; i <= (orientedScreenHeight/lineWidth); i++) {
    if (verticalOrientation) {
      line(linePosition + (lineWidth * 2 * i), 0, linePosition + (lineWidth * 2 * i), orientedScreenWidth);
    } else {
      line(0, linePosition + (lineWidth * 2 * i), orientedScreenWidth, linePosition + (lineWidth * 2 * i));
    }
  }
  
  // Set the canvas to move next loop
  if (oppositeDirection) {
    linePosition += speed;
  } else {
    linePosition -= speed;
  }
  
  // Start again if we've moved one screen height
  if (oppositeDirection) {
    if (linePosition > orientedScreenHeight) { 
      linePosition = startPosition;
      loopNumber += 1;
      println("Loop #", loopNumber);
    }
  } else {
    if (linePosition < -orientedScreenHeight) { 
      linePosition = startPosition;
      loopNumber += 1;
      println("Loop #", loopNumber);
    }
  }
}