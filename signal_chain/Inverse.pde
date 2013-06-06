PImage Inverse (PImage img) {
  PImage invImg = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.pixels.length; i++) { 
    invImg.pixels[i] = color(255 - red(img.pixels[i]), 255 - green(img.pixels[i]), 255 - blue(img.pixels[i]));
  }
  return invImg;
}
   
      
