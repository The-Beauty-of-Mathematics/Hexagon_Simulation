int hexcnt = 0;

class Hexagon{
  PVector pos;
  PVector vel;
  PVector acc;
  final float dx = 0.01;
  final float Pz = 1000;
  
  Hexagon(){
    pos = PVector.random3D().mult(random(1)).add(0,0,1000);
    //pos = fromAngle(TWO_PI * (hexcnt++) / 2000.0).add(0,0,1000);
    vel = new PVector();
    acc = new PVector();
  }
  
  void follow(Hexagon[] a){
    for(Hexagon b : a) if(b != this){ 
      float dist = PVector.dist(b.pos,pos);
      PVector d = PVector.sub(b.pos,pos);
      //acc.add(d.copy().setMag(100 * (dist - 100) / (dist * dist + 1)));
      acc.add(new PVector(-d.z,0,d.x).mult(cos(dist / 100)));
      acc.add(new PVector(d.y,-d.x,0).mult(cos(dist / 100 + 2 * PI / 3)));
      acc.add(new PVector(0,d.z,-d.y).mult(cos(dist / 100 + 4 * PI / 3)));
      //acc.add(b.vel.copy().mult(2 / a.length));
      //if(dist < 100 && (pos.z > 0 && b.pos.z > 0)){
      //  push();
      //  translate(width / 2, height / 2);
      //  stroke(255);
      //  line(pos.x / pos.z,pos.y / pos.z,b.pos.x / b.pos.z,b.pos.y / b.pos.z);
      //  pop();
      //}
      //acc.add(d.copy().setMag((dist - 100) * dist * dist / (dist * dist + 1)));
      //acc.add(d.setMag((dist - 100) / (dist * dist + 1)));
      //acc.add(PVector.sub(new PVector(0,0,100),pos).mult(0.01));
      //acc.add(d.setMag(1 / (dist * dist)));
      //if(dist < 100) acc.add(b.vel.copy().setMag(10));
      //if(dist < 50) acc.add(d.copy().setMag(100));
    }
  }
  
  void update(){
    pos.add(vel.copy().mult(dx));
    vel.add(acc.copy().mult(dx));
    //vel.mult(0.5);
    vel.mult(25 / sqrt(vel.mag()));
    acc.set(0,0,0);
  }
  
  static final float scale = 100;
  float velScale = 0.1;
  
  void show(){
    //if(pos.z < 10) return;
    //colorMode(HSB);
    push();
    translate(Pz * pos.x / pos.z + width / 2,Pz * pos.y / pos.z + height / 2);
    rotate(pos.z);
    {
      //PVector d = vel.copy();
      PVector d = (new PVector(0,0,1000)).sub(pos);
      PVector cV = new PVector((cos(d.x / scale) + cos(d.y / scale + 2 * PI / 3) + cos(d.z / scale + 4 * PI / 3)) * 0x79 + 0x8,
      (cos(d.z / scale) + cos(d.x / scale + 2 * PI / 3) + cos(d.y / scale + 4 * PI / 3)) * 0x79 + 0x8,
      (cos(d.y / scale) + cos(d.z / scale + 2 * PI / 3) + cos(d.x / scale + 4 * PI / 3)) * 0x79 + 0x8);
      
      float vMag = vel.mag();
      
      cV.setMag(vMag / velScale);
      velScale += 0.1;
      
      if(cV.x > 0xff) cV.x = 0xff;
      if(cV.y > 0xff) cV.y = 0xff;
      if(cV.z > 0xff) cV.z = 0xff;
      
      //color c = color((180 / PI) * atan2(d.z,d.x),255,255);
      color c = color(0xff - cV.x,0xff - cV.y,0xff - cV.z);
      fill(c);
    }
    if(pos.z > 0){
      polygon(0,0,Pz * 5 / pos.z,6);
      //push();
      //fill(255,0,0);
      //ellipse(0,0,2,2);
      //pop();
    }
    pop();
  }
}

// From Processing
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

PVector fromAngle(float ang){
  return new PVector(cos(ang),sin(ang),0);
}
