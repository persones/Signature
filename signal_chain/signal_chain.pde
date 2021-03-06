State state;
PImage img;  // Declare variable "a" of type PImage
color mill = color(0);
int pixelIndex = 0;
color[] colorArray = {
  color(0, 0, 255), 
  color(0, 255, 0), 
  color(255, 0, 0), 
  color(200, 200, 0), 
  color(0, 200, 200), 
  color(200, 0, 200)
};
int factor = 4;

int colorIndex =0;

void setup() {

  println("starting:");
  //img = loadImage("../lena.jpg");  // Load the image into the program
  img = loadImage("../signature.jpg");  // Load the image into the program
  img.resize(100, 100);
  size(img.width * factor, img.height * factor);
  //size(img.width , img.height);
  frameRate(60);
  //img.filter(BLUR, 1);
  img.filter(THRESHOLD, 0.6);
  img = EdgeDetection(img);
  img = Inverse(img);
  img.filter(THRESHOLD, 0.6);
  pixelIndex = findNewStartingPoint();
  img.set(toX(pixelIndex), toY(pixelIndex), color(255, 0, 0));
  stroke(204, 102, 0);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
}

void draw() {
  scale (factor);
  if (pixelIndex >= 0) {
    pixelIndex = findWhereToGo(pixelIndex);
  }
  else {
    colorIndex = (colorIndex + 1) % 6;
    pixelIndex = findNewStartingPoint();
  }
  img.set(toX(pixelIndex), toY(pixelIndex), colorArray[colorIndex]);
  //image(img, 0, 0);
}

int findNewStartingPoint() { 
  int curX = toX(pixelIndex);
  int curY = toY(pixelIndex);

  for (int squareSize = 1; squareSize < img.width; squareSize++) {
    rect(curX - squareSize, curY - squareSize, curY - squareSize, curY + squareSize);  
    println(squareSize);
    for (int i = -squareSize; i <= squareSize; i++) {
      if (img.get(curX + i, curY + squareSize) == mill) {
        println(squareSize);
        return ((curY + squareSize) * width) + curX + i;
      }
      if (img.get(curX + i, curY - squareSize) == mill) {
        println(squareSize);
        return ((curY - squareSize) * width) + curX + i;
       
      }
      if (img.get(curX + squareSize, curY + i) == mill) {
        println(squareSize);
        return ((curY + i) * width) + curX + squareSize;
      }
      if (img.get(curX - squareSize, curY + i) == mill) {
        println(squareSize);
        return ((curY + i) * width) + curX - squareSize;
      }
    }
  }
    println("done!");
    state = State.DONE;
    return (-1);
  
}

boolean getBoolPixel(int x, int y) {
  if ((x < 0) || (y < 0) || (x >= width) || (y >= height)) {
    return true;
  }
  if (img.get(x, y) == mill) {
    return false;
  }
  return true;
}

int getEdginess(int x, int y) {
  if ((x < 0) || (y < 0) || (x >= width) || (y >= height)) {
    return -1;
  }
  int edginess = 0;
  for (int yIndex = -1; yIndex < 2; yIndex++) {
    for (int xIndex = -1; xIndex < 2; xIndex++) {
      if ((xIndex != 0) || (yIndex != 0)) {
        if (getBoolPixel(x + xIndex, y + yIndex)) {
          edginess++;
        }
      }
    }
  }
  //println ("edginess at (" + x + ", " + y + ") is "+ edginess); 
  return edginess;
}

int findWhereToGo(int i) {
  int x = toX(i);
  int y = toY(i);
  int maxX = 0;
  int maxY = 0;
  int maxEdginess = -1;
  for (int yIndex = -1; yIndex < 2; yIndex++) {
    for (int xIndex = -1; xIndex < 2; xIndex++) {
      if (!((xIndex == 0) && (yIndex == 0)) && (!(getBoolPixel(x + xIndex, y + yIndex)))) {
        int curEdginess = getEdginess(x + xIndex, y + yIndex);
        if (curEdginess > maxEdginess) {
          maxX = x + xIndex;
          maxY = y + yIndex;
          maxEdginess = curEdginess;
        }
      }
    }
  }
  if (maxEdginess == -1) {
    println ("nowhere to go");
    return -1;
  }
  //println ("going to "+ maxX + " " + maxY);
  return maxY * width + maxX;
}


int toX(int i) {
  return i % width;
}

int toY(int i) {
  return i / width;
}

