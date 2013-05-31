State state;
PImage img;  // Declare variable "a" of type PImage

void setup() {
  println("starting:");
  img = loadImage("../lena.jpg");  // Load the image into the program
  size(img.width, img.height);
  img.filter(BLUR, 1);
  img.filter(THRESHOLD, 0.6);
  int i = findNewStartingPoint();
  img.set(toX(i), toY(i), color(255, 0, 0));
  
  // The image file must be in the data folder of the current sketch 
  // to load successfully  
}

void draw() {
  image(img, 0, 0);
}

int findNewStartingPoint() {
  for (int x = 0; x < width; x++) {
   for (int y =0; y < height; y++) {
    if (img.get(x,y) == color(0)) {
      println(x);
      println(y);
      return (y * width) + x;
    } 
   }
  }
  println("done!")
  state = DONE;
  return (-1);
}

int findWhereToGo(int i) {
  int x = toX(i);
  int y = toY(i);
  

int toX(int i) {
  return i % width;
}

int toY(int i) {
  return i / width;
}
