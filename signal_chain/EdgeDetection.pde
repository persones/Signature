PImage EdgeDetection(PImage img) {
float[][] kernel = {{ -1, -1, -1, -1, -1}, 
                    { -1, -1, -1, -1, -1},
                    { -1, -1, 24, -1, -1},
                    { -1, -1, -1, -1, -1},
                    { -1, -1, -1, -1, -1}};

                    
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(img.width, img.height, RGB);
  // Loop through every pixel in the image.
  for (int y = 2; y < img.height-2; y++) { // Skip top and bottom edges
    for (int x = 2; x < img.width-2; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -2; ky <= 2; ky++) {
        for (int kx = -2; kx <= 2; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+2][kx+2] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }
  return edgeImg;
}
