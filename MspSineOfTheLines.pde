import ddf.minim.*;
import ddf.minim.ugens.*;

final int screenWidth = 800;
final int offset = 5;
final int numRows = 7;
//final int numPolys = screenWidth/offset - 10;
final int numPolys = 13;
final int minDiameter = 5;
final int maxDiameter = 720; // set inside Polygons draw()

Minim       minim;
AudioOutput out;
Oscil[]     waves = new Oscil[numRows];
Polygon[][] polys = new Polygon[numRows][numPolys];

final int numSides = 3;
int h, s, b = 0;
float a = 0;
int topCorner = 80; // no idea why this isn't 0,0

void setup() {
  try {
    size(screenWidth, screenWidth);
    smooth();
    noStroke();
    fill(255);

    minim = new Minim(this);

    // use the getLineOut method of the Minim object to get an AudioOutput object
    out = minim.getLineOut();

    for (int i=0; i<numRows; i++) {
      waves[i] = new Oscil(440 +i, 0.20f, Waves.SINE );
      waves[i].patch(out);
      
      for (int j=0; j<numPolys; j++) {
        float x = (j + topCorner) * offset;
        float y = (j + topCorner) * offset;

        if (i >= 0) {
          x = (j + topCorner) * offset;
          y = (j + (35 * i)) * offset;
        }

        // println("x: "+x+" y: "+y);
        polys[i][j] = new Polygon(numSides, x, y, 45, 0.055 * (i+1)/2 );
        // polys[i][j] = new Polygon(numSides, x, y, 45, 0 );
      }
    }
  } 
  catch (Exception e) {
    e.printStackTrace();
    println("Error running setup!");
  }
}

void draw()
{ 
  background(2);
  colorMode(HSB);

  for (int i=0; i<numRows; i++) {
    for (int j=0; j<numPolys; j++) {
      h = j/2 + (i *8);
      s = 80 + (i * 10);
      b = 200 + j;
      a = 10;
      
      fill(h, s, b, a);

      // edges
      // stroke(h,s,b);
      // rotation     
      // polys[i][j].draw((int)random(10+j));
      polys[i][j].draw();
      waves[i].setAmplitude(map(polys[i][j].getHeight(), minDiameter, maxDiameter, 0, 0.20));
      
      int freqRange = 100;
      
      waves[i].setFrequency(map(polys[i][j].getHeight(), minDiameter, maxDiameter, i*freqRange, (i*freqRange)+freqRange ));
      
    }
  }
}

void mouseMoved()
{
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.

  float amp = map( mouseY, 0, height, 1, 0 );
  for (int i  = 0; i < waves.length; i++) { 
    waves[i].setAmplitude( amp );
  }

  float freq = map( mouseX, 0, width, 110, 880 );
  for (int i  = 0; i < waves.length; i++) { 
    waves[i].setFrequency( freq );
  }
}

void keyPressed()
{ 
  switch( key )
  {
  case '1':
    for (int i  = 0; i < waves.length; i++) { 
      waves[i].setWaveform( Waves.SINE );
    }
    break;

  case '2':
    for (int i  = 0; i < waves.length; i++) { 
      waves[i].setWaveform( Waves.TRIANGLE );
    }
    break;

  case '3':
    for (int i  = 0; i < waves.length; i++) { 
      waves[i].setWaveform( Waves.SAW );
    }
    break;

  case '4':
    for (int i  = 0; i < waves.length; i++) { 
      waves[i].setWaveform( Waves.SQUARE );
    }
    break;

  case '5':
    for (int i  = 0; i < waves.length; i++) { 
      waves[i].setWaveform( Waves.QUARTERPULSE );
    }
    break;

  default: 
    break;
  }
}

