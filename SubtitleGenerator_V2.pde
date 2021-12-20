//This Script is for Netease 「PowerShow」
// Author: Ward

// Screen/Canva Size
final int Screen_W = 1080;
final int Screen_H = 1260;

// First Subtitle Position
final float baseX = 1080;
final float baseY = 540;

// if exceed, spilt into 2 lines
final float Width_Limit = 260;

// Declare global var
String[] zh;   // First Lang Subtitle
String[] en;   // Second Lang Subtitle
int L;    // line numbers of text
PGraphics graphic; //Transparant canvas
float baseX_t = baseX;
float baseY_t = baseY;
PFont f1;
PFont f2;


void setup() {
  //font & size
  f1 = createFont("PingFangHK-Light",50,true);  
  f2 = createFont("STHeitiSC-Light",38,true);

  graphic = createGraphics(Screen_W,Screen_H);
  background(0);
  String[] lines = loadStrings("list.txt");
  L = lines.length;
  int a = 0;
  int b = 0;
  zh = new String[L/2];
  en = new String[L/2];
  
  // Split into 2 group
  for(int w = 0; w<L; w=w+1)
  {
    if(w%2==0){
      zh[b] = lines[w];
      b=b+1;
    }
    else{
      en[a] = lines[w];
      a=a+1;
    }
  }

  // Fix specific string
  replace();
}

void replace() //Fix Fonts "……"
{
  for(int w = 0; w<L/2; w=w+1)
  {
    en[w] = en[w].replaceAll("…","...");
  }
}



void draw() {
  for(int w = 0; w<L/2; w=w+1)
  {
    graphic.beginDraw();
    graphic.textAlign(CENTER);
    graphic.textFont(f1,50);
    graphic.fill(255);
    if(textWidth(zh[w]) > 150)
    {
      graphic.text(" ",baseY_t,baseX_t);
      baseX_t = baseX +60;
      graphic.text(" ",baseY_t,baseX_t);
      println(zh[w]);
    }
    else
    {
    graphic.text(zh[w],baseY_t,baseX_t);   // STEP 5 Display Text
    }
    graphic.textFont(f2,38);                  // STEP 3 Specify font to be used
    graphic.fill(255);     // STEP 4 Specify font color
    float textWidth = textWidth(en[w]);
    //println(textWidth); 
    //println(zh[w]);
    //println(zh[w].length());
    if(zh[w].length()!=0) //Dul language lines
    {
      if(textWidth > Width_Limit)
      {
          String[] temp = split(en[w]," ");
          int tempLength = temp.length;
          //println(tempLength);
          int splitIndex = floor(tempLength/2)+2;
          String[] tempA = subset(temp,0,splitIndex);
          String[] tempB = subset(temp,splitIndex,tempLength-splitIndex);
          graphic.text(join(tempA," "),baseY_t,baseX_t + 50);
          graphic.text(join(tempB," "),baseY_t,baseX_t + 90);   
      }
      else
      {
        graphic.text(en[w],baseY_t,baseX_t + 50);
        //println(en[w]);
      }
    }
    else //Only English Line
    {
      if(textWidth > Width_Limit)
      {
          String[] temp = split(en[w]," ");
          int tempLength = temp.length;
          //println(tempLength);
          int splitIndex = floor(tempLength/2)+2;
          String[] tempA = subset(temp,0,splitIndex);
          String[] tempB = subset(temp,splitIndex,tempLength-splitIndex);
          graphic.text(join(tempA," "),baseY_t,baseX_t);
          graphic.text(join(tempB," "),baseY_t,baseX_t + 40);   
      }
      else
      {
        graphic.text(en[w],baseY_t,baseX_t);
        //println(en[w]);
      }
    }
    graphic.endDraw();
    graphic.save("./subtitle/ "+ w +".png");
    graphic.clear();
    baseX_t = baseX;
    baseY_t = baseY;
   // background(0); 
  }
  exit();
}
