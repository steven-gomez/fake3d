/**
 * Generates a 3D scene of a cube and outputs a directory of
 * images of this scene at different rotation increments.
 * Tested with Processing 2.0b7 on Mac OSX 10.7.5.
 * @author steveg
 */

PImage img;
PGraphics buffer; // Buffer for rendering scene in a loop

// Shapes and textures
PShape cube;

boolean outputImages;

/**
 * Set up the scene objects.
 */
void setup() {
  size(500, 500, P3D);
  fill(255);
  
  outputImages = true;
  cube = createShape(BOX, 100);
  buffer = createGraphics(500, 500, P3D);
  
  if (outputImages) {
    renderScene(buffer);
  }
}

/**
 * Render the scene at different rotations and write out the
 * image files.  Then store a copy of the last frame to be
 * displayed by the sketch.
 */
void renderScene(PGraphics buffer) {
  int incs = 36;
  /* int incs = 72; // every 5 degrees */
  for (int i = 0; i < incs; i++) {
    for (int j = 0; j < incs; j++) {
      print(incs+", "+i+ ", "+j+" --- "); 
      scene(buffer, 1.0*i/incs, 1.0*j/incs);
      buffer.save("images/scene-"+incs+"-"+i+"-"+j+".png");
    }
  }
}

void draw() {
  background(30);
  scene(buffer, -1.0 * mouseY / buffer.height, -1.0 * mouseX / buffer.width);
  img = buffer.get(0, 0, buffer.width, buffer.height);
  image(img, 0, 0);
}

/**
 * Draw a planet scene with rotation parameters on two axes.
 */
void scene(PGraphics buffer, float rotAroundX, float rotAroundY) {
  buffer.beginDraw();
  buffer.background(30);
  buffer.smooth();
  buffer.noFill();
  
  pushMatrix();
  buffer.translate(width/2, height/2, 0);

  // Rotation parameters
  float twoPi = 2.0*PI;
  float xRadians = twoPi*rotAroundX;
  float yRadians = twoPi*(rotAroundY);
  
  buffer.rotateX(twoPi*rotAroundX);
  buffer.rotateY(twoPi*rotAroundY);
    
  /*
  // Trying moving the camera instead...
  float theta = yRadians; // y-rotation
  float phi = xRadians; // x-rotation
  float psi = 0; // z-rotation
  float r = 300;
  float x = r*sin(theta)*cos(phi);
  float z = r*sin(theta)*sin(phi);
  float y = r*cos(theta);
    
  System.out.println("x: "+x+", y: "+y+", xRadians: "+xRadians+", yRadians: "+yRadians);
  buffer.camera(x, y, z, 0, 0, 0, 0, 1, 0);      
  */
  
  /*
   * Draw object-space x and y axes for reference
   */
  buffer.stroke(100, 100, 180);
  buffer.strokeWeight(10);
  buffer.line(0, -200, 0, 0, 200, 0);
  
  buffer.stroke(204, 102, 0);
  buffer.line(-200, 0, 0, 200, 0, 0);
  buffer.shape(cube);

  //buffer.pointLight(255,  255,  255,  0,  0,  0);  

  popMatrix();
  
  //buffer.noLights();
  //buffer.pointLight(255,  255,  255,  0,  0,  -150); 

  buffer.endDraw();

}
