class Branch {
  PMatrix3D begin, end;                                                  //Create Matrix in Begining and End
  float bLength, bThick;                                                 //Thickness and Length
  float []posmtx=new float[16];                                          // Float to store all values of PMatrix
  float endx, endy, endz;                                                // X Y Z values of end pMatrix
  boolean finish=false;                                                
  float angX,angY;

  Branch(PMatrix3D begin, PMatrix3D end, float bLength, float bThick,float tempangX,float tempangY) {
    this.begin = begin;
    this.end = end;
    this.bLength = bLength;
    this.bThick = bThick;
    angX = tempangX;
    angY = tempangY;
    end.get(posmtx);
    endx=posmtx[3];
    endy=posmtx[7];
    endz=posmtx[11];
  }

  void show() {
    pushMatrix();                                                               //Create Main Branch
    pushStyle();
    applyMatrix(begin);
    translate(0, -bLength/2);
    strokeWeight(2);
    stroke(30, 0, 90);
    noStroke();
    fill(0, 0, 20);
    box(bThick, bLength, bThick);
    popStyle();
    popMatrix();   
  }

  Branch secBrA () {                                                             //Create Child A wich is a Branch ob. with Main Branch as father
    PMatrix3D nBegin =  new PMatrix3D(end);
    float r=random(0,PI/4);
    float r2=random(0,PI/4);
    nBegin.rotateZ(r);
    nBegin.rotateY(r2);
    PMatrix3D nEnd =  new PMatrix3D(end);
    nEnd.rotateZ(r);
    nEnd.rotateY(r2);
    nEnd.translate(0, -bLength);
    nEnd.scale(0.80);
    Branch b = new Branch (nBegin, nEnd, bLength, bThick,angX,angY);
    return b;
  }

  Branch secBrB () {                                                             //Create Child B wich is a Branch ob. with Main Branch as father
    PMatrix3D nBegin =  new PMatrix3D(end);
    float r=random(-PI/4,0);
    float r2=random(-PI/4,0);
    nBegin.rotateZ(r);
    nBegin.rotateY(r2);
    PMatrix3D nEnd =  new PMatrix3D(end);
    nEnd.rotateZ(r);
    nEnd.rotateY(r2);   
    nEnd.translate(0, -bLength);
    nEnd.scale(0.75);
    Branch b = new Branch (nBegin, nEnd, bLength, bThick,angX,angY);
    return b;
  }
}