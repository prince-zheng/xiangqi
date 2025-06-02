public class Piece {
  
  private PVector pos;
  private boolean team;
  
  boolean pic = false;
  
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
  
  public PVector[] checkLegal() {
    return new PVector[0];
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

}
