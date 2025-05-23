int[] board = new int[90];

int files = 9;
int ranks = 10;

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
  
  int grid = files * ranks;
  int corner = grid / 2;
  
  int borderx = grid * (files - 1);
  int bordery = grid * (ranks - 1);
  
  int doubleBorder = 5;
  
  rect(corner, corner, borderx, bordery);
  rect(corner - doubleBorder, corner - doubleBorder, borderx + doubleBorder * 2, bordery + doubleBorder * 2);
  
  for (int f = 0; f < files - 1; f++) {
    for (int r = 0; r < ranks - 1; r++) {
      if (r != 4) {
        square(corner + grid * f, corner + grid * r, grid);
      }
    }
  }
  
}
