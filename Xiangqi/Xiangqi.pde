int files = 9;
int ranks = 10;

boolean RED = true;
boolean BLACK = false;

boolean turn;

boolean pic = false;
float scale = 1;
boolean resized = false;

boolean engine = true;
boolean flip = false;
boolean randomized = true;

boolean settings = true;

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
  
  board = convertFEN(boardPos);
  
  drawBoard();
  drawSettings();
  
}

void draw() {

  
}

void mousePressed() {
  
  if (!settings) {
  
    int f = int(mouseX / grid);
    int r = int(mouseY / grid);
  
    if (pieceSelected) {
    
      for (PVector legalMove: piece.checkLegal()) {
      
        if (int(legalMove.x) == f && int(legalMove.y) == r) {
        
          move(f, r);
          turn = !turn;
          
          if (checkmate(turn)) print("checkmate");
          
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
      
        for (PVector legalMove: piece.checkLegal()) {
        
          strokeWeight(0);
          fill(255, 255, 255, 155);
          circle(corner + grid * int(legalMove.x), corner + grid * int(legalMove.y), pieceSize / 2);
        
        }
      
    
      }
      else pieceSelected = false;
    }
  
  }
  
  else {
    
    // piece styles
    if (mouseX >= grid * 6 && mouseX <= grid * 6 + grid / 2.25 && mouseY >= grid * 2.75 && mouseY <= grid * 2.75 + grid / 3) {
      pic = !pic;
      drawBoard();
      drawSettings();
    }
    
    // change scale
    if (mouseX >= grid * 6 && mouseX <= grid * 6 + grid / 2.5 && mouseY >= grid * 3.125 && mouseY <= grid * 3.125 + grid / 3) {
      if (scale > 0.1) {
        scale = (scale * 10 - 1) / 10;
        resized = true;
      }
    }
    if (mouseX >= grid * 6.475 && mouseX <= grid * 6.475 + grid / 2.5 && mouseY >= grid * 3.125 && mouseY <= grid * 3.125 + grid / 3) {
      if (scale < 3.0) {
        scale = (scale * 10 + 1) / 10;
        resized = true;
      }
    }
    if (resized) {

      grid = files * ranks * scale;
      corner = grid / 2;
      river = ranks / 2 - 1;
      pieceSize = int(grid * 5 / 6);
      
      windowResize(int(grid * files), int(grid * ranks));

    }
    
    // change game mode
    if (mouseX >= grid * 6 && mouseX <= grid * 6 + grid / 2.25 && mouseY >= grid * 3.875 && mouseY <= grid * 3.875 + grid / 3) {
      if (engine) {
        flip = false;
        randomized = false;
      }
      else {
        randomized = true;
      }
      engine = !engine;
      drawBoard();
      drawSettings();
    }
    
    // change team
    if (mouseX >= grid * 6 && mouseX <= grid * 6 + grid / 2.25 && mouseY >= grid * 4.25 && mouseY <= grid * 4.25 + grid / 3) {
      if (engine) {
        if (randomized) randomized = false;
        else {
          flip = !flip;
        }
        drawBoard();
        drawSettings();
      }
    }
    if (mouseX >= grid * 6.5 && mouseX <= grid * 6.5 + grid / 2.75 && mouseY >= grid * 4.25 && mouseY <= grid * 4.25 + grid / 3) {
      if (engine) {
        randomized = true;
        drawBoard();
        drawSettings();
      }
    }
    
  }

}

// for some reason this fixes window resizing issues
void mouseReleased() {
  
  if (resized) {
    drawBoard();
    drawSettings();
    resized = false;
  }

}

void keyPressed() {
  
  if (key == TAB) {
    settings = !settings;
    if (settings) {
      setup();
    }
    else {
      settings = false;
      if (randomized) flip = int(random(2)) > 0;
      if (flip) turn = !turn;
      drawBoard();
      drawPieces();
    }
  }
  
}

void move(int f, int r) {
  board[int(piece.getPos().y) * (ranks - 1) + int(piece.getPos().x)] = null;
  piece.setPos(f, r);
  board[r * (ranks - 1) + f] = piece;

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

void drawSettings() {
  
  strokeWeight(0);
  fill(0, 0, 0, 155);
  rect(grid, grid, grid * (files - 2), grid * (ranks - 2));

  float indent = grid * 1.5; 
  float indentButton = grid * 6;

  textFont(createFont("Segoe-UI-Symbol.ttf", 128));
  fill(255);

  // settings menu
  textSize(indent / 4);
  text("Settings", indent, indent * 1.2);
  textSize(indent / 5);
  text("Press TAB to Exit", indent, indent * 1.5);
  
  // piece styles
  if (!pic) text("Pieces: Chinese Characters", indent, indent * 2);
  else text("Pieces: Pictures", indent, indent * 2);
  text("[\u21BA]", indentButton, indent * 2);
  
  // change scale
  text("Board Size: " + scale, indent, indent * 2.25);
  text("[\u2212] [+]", indentButton, indent * 2.25);
  
  // game mode
  if (!engine) text("Game Mode: Player vs Player", indent, indent * 2.75);
  else text("Game Mode: Player vs Bot", indent, indent * 2.75);
  text("[\u21BA]", indentButton, indent * 2.75);
  
  // flip board
  if (!engine) text("Player Team: N/A", indent, indent * 3);
  else if (randomized) text("Player Team: Randomized", indent, indent * 3);
  else if (!flip) text("Player Team: Red", indent, indent * 3);
  else text("Player Team: Black", indent, indent * 3);
  if (engine) {
    text("[\u21BA] [?]", indentButton, indent * 3);  
  }
  
  // view team
  
  // color highlights
  fill(240, 0, 0);
  text("Pieces: ", indent, indent * 2);
  text("Board Size: ", indent, indent * 2.25);
  text("Game Mode: ", indent, indent * 2.75);
  text("Player Team: ", indent, indent * 3);
  
  // buttons
  fill(255, 255, 255, 25);
  rect(grid * 6, grid * 2.75, grid / 2.25, grid / 3);
  rect(grid * 6, grid * 3.125, grid / 2.5, grid / 3);
  rect(grid * 6.475, grid * 3.125, grid / 2.5, grid / 3);
  rect(grid * 6, grid * 3.875, grid / 2.25, grid / 3);
  if (engine) {
    rect(grid * 6, grid * 4.25, grid / 2.25, grid / 3);
    rect(grid * 6.5, grid * 4.25, grid / 2.75, grid / 3);
  }


}

boolean checkmate(boolean isRed) {
  Piece temp = piece; // WHY DID THIS FIX EVERYTHING
  for (Piece p: board.clone()) {
    if (p != null && p.isRed() == isRed) {
      piece = p;
      int legalMoves = piece.checkLegal().size();
      if (legalMoves > 0) {
        piece = temp;
        return false;
      }
    }
  }
  piece = temp;
  return true;
}
