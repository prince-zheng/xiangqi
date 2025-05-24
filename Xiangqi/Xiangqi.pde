int[] board = new int[90];

int files = 9;
int ranks = 10;

int grid = files * ranks;
int corner = grid / 2;

int river = ranks / 2 - 1;

void settings() { 
  size(grid * files, grid * ranks);
}

void setup() {
  
  background(239, 188, 84);
  drawBoard();
  
}

void draw() {
  
}

void drawBoard() {
  
  stroke(0);
  strokeWeight(3);
  noFill();
  
  int borderx = grid * (files - 1);
  int bordery = grid * (ranks - 1);
  
  int borderd = 6;
  
  rect(corner, corner, borderx, bordery);
  
  rect(corner - borderd, corner - borderd, borderx + borderd * 2, bordery + borderd * 2);
  
  for (int f = 0; f < files - 1; f++) {
    for (int r = 0; r < ranks - 1; r++) {
      if (r != river) square(corner + grid * f, corner + grid * r, grid);
    }
  }

  for (int f = 0; f < files; f++) {
    for (int r = 0; r < ranks; r++) {
       
       boolean soldierPos = (r == river - 1 || r == river + 2) && f % 2 == 0;
       boolean cannonPos = (r == river - 2 || r == river + 3) && (f == 1 || f == files - 2);
       
       if (soldierPos || cannonPos) {
         
         int markings = (grid - borderd) / 4;
         
         if (f > 0) {
         
           int x = corner + grid * f;
           int y = corner + grid * r;
         
           line(x - borderd, y - borderd, x - markings, y - borderd);
           line(x - borderd, y - borderd, x - borderd, y - markings);
         
           line(x - borderd, y + borderd, x - markings, y + borderd);
           line(x - borderd, y + borderd, x - borderd, y + markings);
         
         }
       
         if (f < files - 1) {
         
           int x = corner + grid * f;
           int y = corner + grid * r;
         
           line(x + borderd, y - borderd, x + markings, y - borderd);
           line(x + borderd, y - borderd, x + borderd, y - markings);
         
           line(x + borderd, y + borderd, x + markings, y + borderd);
           line(x + borderd, y + borderd, x + borderd, y + markings);
         
         }
         
       }
       
    }
  }
  
  int palaceL = corner + grid * (files / 2 - 1);
  int palaceR = corner + grid * (files / 2 + 1);
  
  line(palaceL, corner, palaceR, corner + grid * 2);
  line(palaceR, corner, palaceL, corner + grid * 2);
  line(palaceL, corner + grid * (ranks - 3), palaceR, corner + grid * (ranks - 1));
  line(palaceR, corner + grid * (ranks - 3), palaceL, corner + grid * (ranks - 1));
  
}
