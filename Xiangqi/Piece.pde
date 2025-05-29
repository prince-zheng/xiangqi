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
  
  public boolean isRed() {
    return team;
  }
  
  public PImage getIcon() {
    return createIcon(int(random(7)));
  }
  
  public PImage createIcon(int row) {
    
    PImage icons = loadImage("Images/xiangqiPieces.png");
    int iconSize = 100;
    
    int col = 0;
    if (!isRed()) col += 2;
    
    return icons.get(col * iconSize, row * iconSize, iconSize, iconSize);
    
  }

}
