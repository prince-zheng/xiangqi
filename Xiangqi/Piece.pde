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
  
  public String getPiece() {
    return "";
  }
  
  public PImage createIcon(int row) {
    
    PImage icons = loadImage("Images/xiangqiPieces.png");
    int iconSize = 100;
    
    int col = int(pic);
    if (!isRed()) col += 2;
    
    return icons.get(col * iconSize, row * iconSize, iconSize, iconSize);
    
  }
  
  public boolean checkBounds(int f, int r) {
    
    // checks board bounds
    if (f < 0 || r < 0 || f >= files || r >= ranks) return false;
    
    // checks against friendly fire
    if (board[r * (ranks - 1) + f] != null && board[r * (ranks - 1) + f].isRed() == isRed()) return false;
    
    return true;
  
  }
  
  public boolean canCapture(int f, int r) {
    return board[r * (ranks - 1) + f] != null && board[r * (ranks - 1) + f].isRed() != isRed();
  }
  
  // for "blocking the elephant's eye" and "hobbling the horse's leg"
  public boolean checkBlocks(int f, int r) {
    return board[r * (ranks - 1) + f] == null;
  }

}
