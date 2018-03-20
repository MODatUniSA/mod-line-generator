// Video exporter
import com.hamoid.*;
VideoExport videoExport;

// Line generator code
float linePosition;
float startPosition;
float lineWidth;
float speed;
float maxSpeed;
boolean speedIncrease;
float speedIncreaseValue;
boolean speedIncreasing;
float loopNumber;
boolean verticalOrientation;
boolean oppositeDirection;
float orientedScreenWidth;
float orientedScreenHeight;
color lineColour;
color backgroundColour;

// Colour presets
color colourMODlightPurple = color(187,41,187);
color colourMODdarkPurple = color(110,18,115);
color colourWhite = color(255,255,255);
color colourBlack = color(0,0,0);

void setup() {
  // Projector dimensions
   size(1280, 800);
  
  // Video export
  videoExport = new VideoExport(this, "line-generator.mp4");
  videoExport.startMovie();
  
  // Frame rate to render
  //frameRate(60);
  
  // Hide the curser
  noCursor();
  
  // Draw to the second monitor for debugging
  //fullScreen(2);
  
  // Set direction to false for opposite direction
  oppositeDirection = false;
  
  // Set orientation
  verticalOrientation = true;
  
  // Set it to speed up
  speedIncrease = true;
  speedIncreaseValue = 0.01;
  maxSpeed = 7;
  speedIncreasing = true;
  
  orientedScreenWidth = width;
  orientedScreenHeight = height;
  if (verticalOrientation) {
    orientedScreenWidth = height;
    orientedScreenHeight = width;
  }
  
  // Configure the lines and speed
  lineWidth = orientedScreenHeight/20;
  speed = 1;
  
  // Background, line colour and width
  backgroundColour = color(colourMODlightPurple);
  lineColour = color(colourBlack);
  stroke(lineColour);
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
  background(backgroundColour);
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
  
  // Increase the speed if set
  if (speedIncrease) {
    if (speedIncreasing) {
      if (speed > 0 && speed < maxSpeed) {
        speedIncreasing = true;
        speed += speedIncreaseValue;
      } else if (speed >= maxSpeed) {
        speedIncreasing = false;
        speed -= speedIncreaseValue;
        println("Maximum speed hit");
      }
    } else {
      if (speed > 0 && speed < maxSpeed) {
        speedIncreasing = false;
        speed -= speedIncreaseValue;
      } else if (speed <= 0) {
        speedIncreasing = true;
        speed += speedIncreaseValue;
        println("Minimum speed hit");
      }
    }
    //println("Speed: ", speed);
    //println("Increasing? ", speedIncreasing);
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
  
  // Save frame for video export
  videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    // Pressing 'q' quits the sketch and saves the movie
    videoExport.endMovie();
    exit();
  }
}
