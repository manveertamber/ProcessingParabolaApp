int gridspacing = 100;
boolean hasChanged = false;
sliderSwitch a;
sliderSwitch b;
sliderSwitch c;

boolean vertexMode = true;
boolean standardMode = false;
boolean factoredMode = false;
button StandardForm;
button VertexForm;
button FactoredForm;

void setup(){
  frameRate(1000);
  fullScreen();
  fill(0);
  background(255);
  drawGrid(gridspacing);
   
    a = new sliderSwitch(width * 0.6,(width * 0.9),(height * 0.07),(height * 0.7));
    b = new sliderSwitch((width * 0.6),(width * 0.9),(height * 0.07),(height * 0.8));
    c = new sliderSwitch((width * 0.6),(width * 0.9),(height * 0.07),(height * 0.9));
  
    StandardForm = new button("Standard Form",height/20,width/10,width * 0.1,height * 0.2);
    VertexForm = new button("Vertex Form",height/20,width/10,width * 0.2,height * 0.2);
    FactoredForm = new button("Factored Form",height/20,width/10,width * 0.3,height * 0.2);
    
    VertexForm.turnOn();
    float avalue = map(a.getPos(),0,a.endx - a.startx,-5,5);
    float bvalue = map(b.getPos(),0,b.endx - b.startx,0-width/2,0 + width/2);
    float cvalue = map(c.getPos(),0,c.endx - c.startx,0-height/2,0 + height/2);
    drawParabolaVertexForm(avalue,bvalue,cvalue, 2); // in vertex form y = a(x - h)^2 + k  with (a,h,k,line thickness)
    
    textAlign(CENTER);
    textSize(width/40);
    text("y = (" + 0 + ")(" + "x - (" + 0 + ")) + (" + 0 + ")",width*0.75,height * 0.1);
    
    textAlign(CORNER);
    textSize(12);
}

void draw(){  

  if(hasChanged){
  if(vertexMode){
    background(255);
    strokeWeight(1);
    drawGrid(gridspacing);
    float avalue = map(a.getPos(),0,a.endx - a.startx,-5,5);
    float bvalue = map(b.getPos(),0,b.endx - b.startx,0-width/2,0 + width/2);
    float cvalue = map(c.getPos(),0,c.endx - c.startx,0-height/2,0 + height/2);
    a.setId("A");
    b.setId("H");
    c.setId("K");
    textAlign(CENTER);
    textSize(width/40);
    String outputAVal = nf(avalue,1,3);
    text("y = (" + outputAVal + ")(" + "x - (" + (int)bvalue + "))² + (" + (int)cvalue + ")",width*0.75,height * 0.1);
    textAlign(CORNER);
    textSize(12);
    drawParabolaVertexForm(avalue,bvalue,cvalue, 2); // in vertex form y = a(x - h)^2 + k  with (a,h,k,line thickness)
    hasChanged = false;
  }
  else if(standardMode){
    background(255);
    strokeWeight(1);
    drawGrid(gridspacing);
    float avalue = map(a.getPos(),0,a.endx - a.startx,-5,5);
    float bvalue = map(b.getPos(),0,b.endx - b.startx,0-width/20,0 + width/20);
    float cvalue = map(c.getPos(),0,c.endx - c.startx,0-height/2,0 + height/2);
    a.setId("A");
    b.setId("B");
    c.setId("C");   
    
    textAlign(CENTER);
    textSize(width/40);
    String outputAVal = nf(avalue,1,3);
    text("y = (" + outputAVal + ")x² + (" +  (int)bvalue + ")x + (" + (int)cvalue + ")",width*0.75,height * 0.1);
    textAlign(CORNER);
    textSize(12);
    
    drawParabolaStandardForm(avalue,bvalue,cvalue,2);
    hasChanged = false;
   
  }
  else{
    background(255);
    strokeWeight(1);
    drawGrid(gridspacing);
    float avalue = map(a.getPos(),0,a.endx - a.startx,-5,5);
    float rvalue = map(b.getPos(),0,b.endx - b.startx,0-width/2,width/2);
    float svalue = map(c.getPos(),0,c.endx - c.startx,0-width/2,width/2);
    a.setId("A");
    b.setId("R");
    c.setId("S");   
    
    textAlign(CENTER);
    textSize(width/40);
    String outputAVal = nf(avalue,1,3);
    text("y = (" + outputAVal + ")(" + "x - (" + (int)rvalue + ")) (x - (" + (int)svalue + "))",width*0.75,height * 0.1);
    textAlign(CORNER);
    textSize(12);
    
    drawParabolaFactoredForm(avalue,rvalue,svalue,2);
    hasChanged = false;
  }
  }
  a.drawIt();
  b.drawIt();
  c.drawIt();
     
  StandardForm.drawIt();
  FactoredForm.drawIt();
  VertexForm.drawIt();
}


public void drawGrid(int spacing){
  int centerx = width/2;
  int centery = height/2;
  
  
  while(centerx > 0){
  line(centerx,0,centerx,height);
  text(centerx - width/2,centerx,centery);
  centerx-=spacing;
  }
  centerx = width/2;
  while(centerx<width){
  line(centerx,0,centerx,height);
  text(centerx - width/2,centerx,centery);
  centerx+=spacing;
  }
  centerx = width/2;
  while(centery > 0){
  line(0,centery,width,centery);
  text((centery - height/2) * -1,centerx,centery); // since processing's y value decreases with height the height number has to be multiplied by -1
  centery-=spacing;
  }
  centerx = width/2;
  centery = height/2;
  while(centery < height){
  line(0,centery,width,centery);
  text((centery - height/2) * -1,centerx,centery); // since processing's y value decreases with height the height number has to be multiplied by -1
  centery+=spacing;
  }
}

public void drawParabolaVertexForm(float a, float h, float k, int linefat){
  a *=-1; // since processing's y value decreases with height
  k*=-1;// since processing's y value decreases with height
  strokeWeight(linefat);
 
for(float count = width/2;count<width;count+=0.025){
  
  float x = count - width/2;
  double ypos = a*Math.pow((x - h),2) + k;
  point(count,(float)ypos + height/2);
}
for(float count = width/2;count>0;count-=0.025){
  float x = count - width/2;
  double ypos = a*Math.pow((x - h),2) + k;
  point(count,(float)ypos + height/2);
}
}


public void drawParabolaStandardForm(float a, float b, float c, int linefat){
  a *=-1; // since processing's y value decreases with height
  b*=-1;// since processing's y value decreases with height
  c*=-1;// since processing's y value decreases with height
  strokeWeight(linefat);
 
for(float count = width/2;count<width;count+=0.025){
  float x = count - width/2;
  double ypos = a * Math.pow((x),2) + c + b*x;
  point(count,(float)ypos + height/2);
}
for(float count = width/2;count>0;count-=0.025){
  float x = count - width/2;
  double ypos = a * Math.pow((x),2) + c + b*x;
  point(count,(float)ypos + height/2);
}
}
public void drawParabolaFactoredForm(float a,float r,float s,int linefat){
  a*=-1;
  strokeWeight(linefat);
  for(float count = width/2;count<width;count+=0.025){
  float x = count - width/2;
  double ypos = a * (x - r) * (x-s);
  point(count,(float)ypos + height/2);
  }
  for(float count = width/2;count>0;count-=0.025){
  float x = count - width/2;
  double ypos = a * (x - r) * (x-s);
  point(count,(float)ypos + height/2);
}
}
void mousePressed(){
  a.changePos();
  
  b.changePos();

   c.changePos();
   a.drawIt();
   b.drawIt();
   c.drawIt();
  
   if(StandardForm.checkPressed()){
     a.setPos((a.endx - a.startx) / 2.0);
     b.setPos((b.endx - b.startx) / 2.0);
     c.setPos((c.endx - c.startx) / 2.0);
     hasChanged = true;
     standardMode = true;
     vertexMode = false;
     factoredMode = false;
     StandardForm.turnOn();
     VertexForm.turnOff();
     FactoredForm.turnOff();
   }
   else if(VertexForm.checkPressed()){
     a.setPos((a.endx - a.startx) / 2.0);
     b.setPos((b.endx - b.startx) / 2.0);
     c.setPos((c.endx - c.startx) / 2.0);
     hasChanged = true;
     standardMode = false;
     vertexMode = true;
     factoredMode = false;
     StandardForm.turnOff();
     VertexForm.turnOn();
     FactoredForm.turnOff();
   }
   else if(FactoredForm.checkPressed()){
     a.setPos((a.endx - a.startx) / 2.0);
     b.setPos((b.endx - b.startx) / 2.0);
     c.setPos((c.endx - c.startx) / 2.0);
     hasChanged = true;
     standardMode = false;
     vertexMode = false;
     factoredMode = true;
     StandardForm.turnOff();
     VertexForm.turnOff();
     FactoredForm.turnOn();
   }

}

void mouseDragged(){
  a.changePos();
  
  
  b.changePos();
  
  c.changePos();
   a.drawIt();
   b.drawIt();
   c.drawIt();
}
void keyPressed(){

if(key == 'm'){
  if(gridspacing>10){
  gridspacing-=10;
  hasChanged = true;
  }
}
else if(key == 'z'){
  gridspacing+=10;
  hasChanged = true;
}
}


class sliderSwitch{
    
    float startx = 0;
    float endx = 0;
    float sliderHeight = 0;
    float heightFromTop = 0;
    float pos = 0;
    String name;
    public sliderSwitch(float startxe, float endxe, float heighte, float ypos){
      startx = startxe;
      endx = endxe;
      sliderHeight = heighte;
      heightFromTop = ypos;
      pos = (startx + endx)/2;
    }
    
    public void drawIt(){
      line(startx,heightFromTop,endx,heightFromTop);
      line(startx,heightFromTop-sliderHeight/2,startx,heightFromTop + sliderHeight/2);
      line(endx,heightFromTop-sliderHeight/2,endx,heightFromTop + sliderHeight/2);
      textAlign(CORNER);
      textSize(width/50);
      text(name,endx + width /100,heightFromTop);
      textSize(12);
      rectMode(CENTER);
      rect(pos,heightFromTop,(endx - startx) * 0.1,sliderHeight);
    }
    public void changePos(){
      if(mouseX >= startx && mouseX<= endx && mouseY > heightFromTop - sliderHeight/2 && mouseY < heightFromTop + sliderHeight/2){
        pos = mouseX;
        
        hasChanged = true;
      } 
    }
    public void setPos(float num){
      pos = num + startx;
      drawIt();
    }
    public float getPos(){
      return pos - startx;
    }
    void setId(String x){
    name = x;
    }
}

class button{
  float xpos, ypos, bheight,bwidth;
  String id;
  boolean on = false;
    public button(String rid, float rheight,float rwidth,float rxpos,float rypos){
    xpos = rxpos;
    ypos = rypos;
    bheight = rheight;
    bwidth = rwidth;
    id = rid;
  }
  
  void drawIt(){
    rectMode(CENTER);
    if(on)
      fill(0,0,255);
    else
      fill(255,0,0);
    rect(xpos,ypos,bwidth,bheight);
    fill(255);
    fill(0);
    textAlign(CENTER);
    text(id,xpos,ypos);
    
    
  }
  
boolean checkPressed(){
    if(mouseX>xpos-bwidth/2 && mouseX<xpos + bwidth/2 && mouseY>ypos-bheight/2 && mouseY<ypos + bheight/2){
      return true;
    }
    return false;
  }
void turnOn(){
  hasChanged = true;
  on = true;
}
void turnOff(){
on = false;
}
}