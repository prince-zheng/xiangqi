int[] board = new int[90];

void setup() {
  
  size(810, 900);
  background(239, 188, 84);
  drawBoard();

}

void draw() {

}

void drawBoard() {
  
  stroke(0);
  strokeWeight(2);
  noFill();
  
  rect(45, 45, 720, 800);
  rect(40, 40, 730, 810);
  
}
