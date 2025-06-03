int files = 9;
int ranks = 10;

boolean RED = true;
boolean BLACK = false;

boolean turn = RED;

float scale = 1;
boolean pic = false;

float grid = files * ranks * scale;
float corner = grid / 2;
float river = ranks / 2 - 1;
int pieceSize = int(grid * 5 / 6);

Piece piece;
boolean pieceSelected = false;

Piece[] board = new Piece[files * ranks];

// String boardPos = "9/9/9/9/9/9/9/9/9/9 r";
String boardPos = "rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR r";

void settings() { 
  size(int(grid * files), int(grid * ranks));
}

void setup() {
  
  frameRate(60);
  drawBoard();
  
  board = convertFEN(boardPos);    
  drawPieces();
  
}

void draw() {

  
}

void mousePressed() {
  
  int f = int(mouseX / grid);
  int r = int(mouseY / grid);
  
  if (pieceSelected) {
    
    ArrayList<PVector> legal = piece.checkLegal();
    
    for (PVector legalMove: legal) {
      
      if (int(legalMove.x) == f && int(legalMove.y) == r) {
        
        board[int(piece.getPos().y) * (ranks - 1) + int(piece.getPos().x)] = null;
        piece.setPos(f, r);
        board[r * (ranks - 1) + f] = piece;
        
        turn = !turn;
        break;
        
      }
    
    }
    
    drawBoard();
    drawPieces();
    
    pieceSelected = false;

    
  }
  
  else {
    piece = board[r * (ranks - 1) + f];
    if (piece != null && piece.isRed() == turn) {
    
      strokeWeight(4 * scale);
      circle(corner + grid * f, corner + grid * r, pieceSize);
      pieceSelected = true;
    
    }
    else pieceSelected = false;
  }

}

void drawBoard() {
  
  background(239, 188, 84);
  
  stroke(0);
  strokeWeight(3 * scale);
  noFill();
  
  float borderx = grid * (files - 1);
  float bordery = grid * (ranks - 1);
  
  float borderd = 6 * scale;
  
  rect(corner, corner, borderx, bordery);
  
  rect(corner - borderd, corner - borderd, borderx + borderd * 2, bordery + borderd * 2);
  
  for (int f = 0; f < files - 1; f++) {
    for (int r = 0; r < ranks - 1; r++) {
      if (r != river) square(corner + grid * f, corner + grid * r, grid);
    }
  }
  
  // board markings for starting points

  for (int f = 0; f < files; f++) {
    for (int r = 0; r < ranks; r++) {
       
       boolean soldierPos = (r == river - 1 || r == river + 2) && f % 2 == 0;
       boolean cannonPos = (r == river - 2 || r == river + 3) && (f == 1 || f == files - 2);
       
       if (soldierPos || cannonPos) {
         
         float markings = (grid - borderd) / 4;
         
         if (f > 0) {
         
           float x = corner + grid * f;
           float y = corner + grid * r;
         
           line(x - borderd, y - borderd, x - markings, y - borderd);
           line(x - borderd, y - borderd, x - borderd, y - markings);
         
           line(x - borderd, y + borderd, x - markings, y + borderd);
           line(x - borderd, y + borderd, x - borderd, y + markings);
         
         }
       
         if (f < files - 1) {
         
           float x = corner + grid * f;
           float y = corner + grid * r;
         
           line(x + borderd, y - borderd, x + markings, y - borderd);
           line(x + borderd, y - borderd, x + borderd, y - markings);
         
           line(x + borderd, y + borderd, x + markings, y + borderd);
           line(x + borderd, y + borderd, x + borderd, y + markings);
         
         }
         
       }
       
    }
    
  }
  
  // palace lines
  
  float palaceL = corner + grid * (files / 2 - 1);
  float palaceR = corner + grid * (files / 2 + 1);
  
  line(palaceL, corner, palaceR, corner + grid * 2);
  line(palaceR, corner, palaceL, corner + grid * 2);
  line(palaceL, corner + grid * (ranks - 3), palaceR, corner + grid * (ranks - 1));
  line(palaceR, corner + grid * (ranks - 3), palaceL, corner + grid * (ranks - 1));
  
}

void drawPieces() {
  
  for (int i = 0; i < board.length; i++) {
    if (board[i] != null) {
    
      PImage icon = board[i].getIcon();
      icon.resize(pieceSize, pieceSize);
      
      float pieceOffset = (grid - pieceSize) / 2;
      
      PVector piecePos = board[i].getPos().copy().mult(grid);
      image(icon, piecePos.x + pieceOffset, piecePos.y + pieceOffset);
    
    }
  }

}

Piece[] convertFEN(String FEN) {
  
  Piece[] pos = new Piece[files * ranks];
  
  char turnColor = FEN.charAt(FEN.length() - 1);
  FEN = FEN.substring(0, FEN.length() - 2);
  
  if (turnColor == 'b') turn = BLACK;
  else turn = RED;
  
  String[] FENarr = split(FEN, '/');
  
  for (int r = 0; r < FENarr.length; r++) {
    int f = 0;
    for (int c = 0; c < FENarr[r].length(); c++) {
      
      char placement = FENarr[r].charAt(c);
      
      if (Character.isDigit(placement)) {
        f += Integer.parseInt(String.valueOf(placement));
      }
      else {
        
        boolean isRed = Character.isUpperCase(placement);
        placement = Character.toLowerCase(placement);
        
        Piece piece = new Piece();
        
        if (placement == 'a') {
          piece = new Advisor(f, r, isRed);
        }
        if (placement == 'c') {
          piece = new Cannon(f, r, isRed);
        }
        if (placement == 'r') {
          piece = new Chariot(f, r, isRed);
        }
        if  (placement == 'b') {
          piece = new Elephant(f, r, isRed);
        }
        if (placement == 'k') {
          piece = new General(f, r, isRed);
        }
        if (placement == 'n') {
          piece = new Horse(f, r, isRed);
        }
        if (placement == 'p') {
          piece = new Soldier(f, r, isRed);
        }
        
        pos[r * (ranks - 1) + f] = piece;
        f++;
        
      }
      
    }
  }
  
  return pos;

}
