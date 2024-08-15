
import java.util.ArrayList;

Hexagon[] hexs = new Hexagon[1000];

ArrayList<Float> kE = new ArrayList<Float>();

void setup(){
  fullScreen();
  for(int i = 0; i < hexs.length; i++) hexs[i] = new Hexagon();
  frameRate(120);
}

void draw(){
  
  kE.add(calculateKE(hexs));
  
  background(0);
  noStroke();
  for(int i = 0; i < hexs.length; i++) for(int j = 0; j < i; j++){
    if(hexs[i].pos.z > hexs[j].pos.z){
      Hexagon temp = hexs[i];
      hexs[i] = hexs[j];
      hexs[j] = temp;
    }
  }
  //for(int i = 0; i < hexs.length; i++){
  //  PVector POS = hexs[i].pos.copy();
  //  float z = POS.z;
  //  POS.set(hexs[i].Pz * POS.x / z,hexs[i].Pz * POS.y / z);
  //  POS.add(hexs[i].Pz * 5 * sign(POS.x) / z, hexs[i].Pz * 5 * sign(POS.y) / z);
  //  float X = 2 * abs(POS.x);
  //  float Y = 2 * abs(POS.y);
  //  if((X > width || Y > height) || z < 0){
  //    hexs[i].pos.set(PVector.random3D().mult(random(1)).add(100,-100,1000));
  //    hexs[i].vel.set(new PVector(-100,100,-1000));
  //    //hexs[i].pos.set(PVector.random3D().mult(random(1)).add(0,0,10));
  //  }
  //}
  for(Hexagon a : hexs) a.show();
  for(Hexagon a : hexs) a.follow(hexs);
  for(Hexagon a : hexs) a.update();
  
  if(frameCount % 100 == 0)
    saveStrings("KE.txt",kE.toString().split(","));
  
  saveFrame("frames\\frame-####.png");
  if(frameCount >= 10000) exit();
}

int sign(float alpha){return alpha >= 0 ? 1 : -1;}

float calculateKE(Hexagon[] h){
  float total = 0;
  for(Hexagon H : h) total += H.vel.magSq();
  return total;
}
