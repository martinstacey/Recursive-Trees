//                      RECURSIVE TREE                                    MARTIN STACEY 
Branch root;                                                              //Initial Branch
ArrayList <Branch> treeA;                                                 //Stores A branches in  dynamic array 
ArrayList <Branch> treeB; 
int nButX, nButY, sButX, sButY;                                           //DISPLAY: No. Buttons, Size Buttons                                                                         
int []in = {1, 450, 100, 3, 30, 30};                                      //INITIAL CONDITIONS: # Branches[0],Box Size[1],Lenght Branch[2],Thick Branch[3],Max AngleX[4],Max AngleY[5]
PMatrix3D rootBegin, rootEnd;                                             // PMatrix of Initial Branch:Begin and  End. 

void setup() {                  
  size(1000, 1000, P3D);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100);                                           //Instanciate with Initial Conditions (Repeat when Clicked)  
  treeA = new ArrayList <Branch>();                                        //Instanciate Tree
  treeB = new ArrayList <Branch>();
  rootBegin= new PMatrix3D();                                              //Instanciate Initial Branch Matrixes
  rootEnd= new PMatrix3D();                                                //Repeat every Time New Root is Changed
  rootEnd.translate(0, -in[2]);                                            //Translate End Matrix to End of Initial Branch  
  root= new Branch (rootBegin, rootEnd, in[2], in[3], in[4], in[5]);       //Root Instanciate with Initial Variables
  treeA.add(0, root);
}
void draw() {
  background(255, 0, 100);
  display();
  lights();
  translate(500, 800);                                                    //Translate to Center of Screen
  rotateY(mouseX*0.005);                                                  //Move according to MouseX
                                        
  for (int i=0; i<treeA.size(); i++) {                                     //For every root in the tree 
    if (treeA.get(i).endx>-in[1]/2&&treeA.get(i).endx<in[1]/2) {            //If its between x values of Box
      if (treeA.get(i).endy>-in[1]&&treeA.get(i).endy<0) {                  //If its between y values of Box
        if (treeA.get(i).endz>-in[1]/2&&treeA.get(i).endz<in[1]/2) {        //If its between z values of Box
          treeA.get(i).show();                                             //Draw Tree Root
        }
      }
    }
  }
  if  (treeB.size()>=1) {
    for (int i=0; i<treeB.size(); i++) {                                      //For every root in the tree 
      if (treeB.get(i).endx>-in[1]/2&&treeB.get(i).endx<in[1]/2) {            //If its between x values of Box
        if (treeB.get(i).endy>-in[1]&&treeB.get(i).endy<0) {                  //If its between y values of Box
          if (treeB.get(i).endz>-in[1]/2&&treeB.get(i).endz<in[1]/2) {        //If its between z values of Box
            treeB.get(i).show();                                             //Draw Tree Root
          }
        }
      }
    }
  }

  if  (treeB.size()>=1) {
    for (int i=0; i<treeB.size(); i++) {                                     //For every root in the tree 
      if (treeB.get(i).endx>-in[1]/2&&treeB.get(i).endx<in[1]/2) {           //If its between x values of Box
        if (treeB.get(i).endy>-in[1]&&treeB.get(i).endy<0) {                 //If its between y values of Box
          if (treeB.get(i).endz>-in[1]/2&&treeB.get(i).endz<in[1]/2) {       //If its between z values of Box       
            if (treeB.get(i).finish==false) {   
              pushMatrix();
              translate(treeB.get(i).endx, treeB.get(i).endy, treeB.get(i).endz);
              sphere(3);
              popMatrix();
            }
          }
        }
      }
    }
  }
  pushMatrix();                                                           //Perimeter Box
  noFill();
  stroke(0, 0, 50);
  translate(0, -in[1]/2);
  box(in[1]);
  popMatrix();
}
void mousePressed() {
  click();                                                             //Go to display actions when clicked
}
//Bibliography: The Nature of Code Tutorial was seen to be clear on some concepts. https://www.youtube.com/watch?v=fcdNSZ9IzJM&t=141s