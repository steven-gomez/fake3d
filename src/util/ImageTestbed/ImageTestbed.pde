/**
 * Generates a 3D scene of planets/sun and outputs a directory of
 * images of this scene at different rotation increments.
 * Tested with Processing 2.0b7 on Mac OSX 10.7.5.
 * @author steveg
 *
 * Adapted from Planets example, by Andres Colubri
 * Sun and mercury textures from http://planetpixelemporium.com
 */
 
// Will render output frames to a buffer;
// the sketch itself will just display a img copied from the buffer
PImage img;
PGraphics buffer;

// Shapes and textures
PShape sun;
PImage suntex;
PShape planet1;
PImage surftex1;
PShape planet2;
PImage surftex2;

/**
 * Set up the scene objects.
 */
void setup() {
  size(500, 500, P3D);
  suntex = loadImage("sun.jpg");  
  surftex1 = loadImage("planet.jpg");  
  surftex2 = loadImage("mercury.jpg");  
  
  noStroke();
  fill(255);
  sphereDetail(40);

  sun = createShape(SPHERE, 70);
  sun.texture(suntex);  

  planet1 = createShape(SPHERE, 40);
  planet1.texture(surftex1);
  
  planet2 = createShape(SPHERE, 20);
  planet2.texture(surftex2);
  
  buffer = createGraphics(500, 500, P3D);
  renderScene(buffer);
}

/**
 * Render the scene at different rotations and write out the
 * image files.  Then store a copy of the last frame to be
 * displayed by the sketch.
 */
void renderScene(PGraphics buffer) {
  int incs = 10;
  // int incs = 36;
  /* int incs = 72; // every 5 degrees */
  
  for (int i = 0; i < incs; i++) {
    for (int j = 0; j < incs; j++) {
      print(incs+", "+i+ ", "+j+" --- "); 
      scene(buffer, incs, i, j);//i, j);
      buffer.save("images/planets-"+incs+"-"+i+"-"+j+".png");
    }
  }
  
  // Put the last frame, plus some debugging output, onto
  // the sketch canvas
  int fontSize = 20;
  buffer.beginDraw();
  buffer.stroke(255);
  buffer.textSize(fontSize);
  buffer.text("Finished scene rendering loop", 15, height - 40);
  buffer.text("PNGs written to images directory: " + incs*incs,
      15, height - (40-fontSize));
  buffer.endDraw();
  
  img = buffer.get(0, 0, buffer.width, buffer.height);
}

void draw() {
  background(30);
  image(img, 0, 0);
}

/**
 * Draw a planet scene with rotation parameters on two axes.
 */
void scene(PGraphics buffer, int maxIncs, int xInc, int yInc) {
  buffer.beginDraw();
  buffer.background(30);
  buffer.smooth();
  buffer.noFill();
  
  pushMatrix();
  buffer.translate(width/2, height/2, -300);

  // Rotation parameters
  float twoPi = 2.0*PI;
  float xRadians = twoPi*xInc/maxIncs;
  float yRadians = twoPi*yInc/maxIncs;
  
  buffer.rotateX(twoPi*xInc/maxIncs);
  buffer.rotateY(twoPi*yInc/maxIncs);
    
    /*
    float theta = yRadians; // y-rotation
    float phi = xRadians; // x-rotation
    float psi = 0; // z-rotation
    
    float x = sin(yRadians)*cos(xRadians);
    float y = sin(yRadians)*sin(xRadians);
    float z = cos(yRadians);
    
    float r = sqrt(pow((width/2.0),2) + pow((height/2.0),2) + pow(((height/2.0) / tan(PI*30.0 / 180.0)),2));
    buffer.camera(r*x, r*y, r*z, 0, 0, 0, 0, 1, 0);
    */
    /*
    // Try this...
    float n00 = cos(theta)*cos(psi); 
    float n01 = -cos(phi)*sin(psi) + sin(phi)*sin(theta)*cos(psi); 
    float n02 = sin(phi)*sin(psi) + cos(phi)*sin(theta)*cos(psi);
    float n10 = cos(theta)*sin(psi);
    float n11 = cos(phi)*cos(psi) + sin(phi)*sin(theta)*sin(psi); 
    float n12 = -sin(phi)*cos(psi) + cos(phi)*sin(theta)*sin(psi);
    float n20 = -sin(theta); 
    float n21 = sin(phi)*cos(theta);
    float n22 = cos(phi)*cos(theta);
      
    buffer.applyMatrix(  
             n00, n01,  n02,  0.0,
             n10, n11, n12,  0.0,
             n20, n21, n22,  0.0,
             0.0, 0.0, 0.0,  1.0);
   */          
  
  buffer.stroke(255);
  buffer.strokeWeight(10);
  buffer.line(0, -200, 0, 0, 200, 0);
  
  buffer.stroke(204, 102, 0);
  buffer.line(-200, 0, 0, 200, 0, 0);
  buffer.shape(sun);

  buffer.pointLight(255,  255,  255,  0,  0,  0);  

  buffer.translate(width/2, 0, 0);  
  buffer.shape(planet1);  
  
  buffer.translate(-0.75 * width,  -0.6 * height,  50);
  buffer.shape(planet2);
  popMatrix();
  
  buffer.noLights();
  buffer.pointLight(255,  255,  255,  0,  0,  -150); 

  buffer.endDraw();

}