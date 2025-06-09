public class Piece {
  
  private PVector pos;
  private boolean team;

  public Piece() {
    
  }
  
  public Piece(int file, int rank, boolean isRed) {
    pos = new PVector(file, rank);
    team = isRed;
  }
  
  public PVector getPos() {
    return pos;
  }
  
  public void setPos(int file, int rank) {
    pos = new PVector(file, rank);
  }
  
  public void setPos(PVector newPos) {
    pos = newPos;
  }
  
  public boolean isRed() {
    return team;
  }
  
  public PImage getIcon() {
    return createIcon(int(random(7)));
  }
  
  public ArrayList<PVector> checkLegal() {
    return new ArrayList<PVector>();
  }
  
  public boolean canCheck() {
    return false;
  }
  
  public boolean noLegal() {
    return true;
  }
  
  public int getPiece() {
    return 0;
  }
  
  public PImage createIcon(int row) {
    
    PImage icons = loadImage("xiangqiPieces.png");
    int iconSize = 100;
    
    int col = int(pic);
    if (!isRed() ^ flip) col += 2;
    
    return icons.get(col * iconSize, row * iconSize, iconSize, iconSize);
    
  }
  
  public boolean checkBounds(int f, int r) {
    
    // checks board bounds
    if (f < 0 || r < 0 || f >= files || r >= ranks) return false;
    
    // checks against friendly fire
    if (board[r * (ranks - 1) + f] != null && board[r * (ranks - 1) + f].isRed() == isRed()) return false;
    
    // checking against checks
    //move(f, r);
    //boolean checked = inCheck(team);
    //board[int(pos.y) * (ranks - 1) + int(pos.x)] = piece;
    //piece.setPos(int(pos.y), int(pos.x));
    //board[r * (ranks - 1) + f] = null;
    //if (checked) return false;
    
    return true;
  
  }
  
  public boolean canCapture(int f, int r) {
    return board[r * (ranks - 1) + f] != null && board[r * (ranks - 1) + f].isRed() != isRed();
  }
  
  public boolean canCaptureCheck(int f, int r) {
    int i = r * (ranks - 1) + f;
    return board[i] != null && board[i].isRed() != isRed() && board[i].getPiece() == 1;
  }
  
  // for "blocking the elephant's eye" and "hobbling the horse's leg"
  public boolean checkBlocks(int f, int r) {
    return board[r * (ranks - 1) + f] == null;
  }
  
  // for advisor and general restrictions
  public boolean isPalace(int f, int r) {
    if (f < files / 2 - 1 || f > files / 2 + 1) return false;
    if (isRed()) return r >= ranks - 3;
    else return r <= 2;
  }
  
  public void checkChecks(ArrayList<PVector> legal) {
    
    for (int i = legal.size() - 1; i >= 0; i--) {
      
      // check for discovery checks
      Piece[] tempBoard = board.clone();
      PVector tempPos = pos;
      move(int(legal.get(i).x), int(legal.get(i).y));
      
      for (Piece threat: board) {
        if (threat != null && threat.isRed() != team && threat.canCheck()) {
          legal.remove(i);
          break;
        }
      }
      
      piece.setPos(tempPos);
      board = tempBoard;
    
    }
  
  }

}
