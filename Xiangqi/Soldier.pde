public class Soldier extends Piece {

  public Soldier(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(6);
  }
  
  @Override
  public PVector[] checkLegal() {
        
    int team = -1;
    if (isRed()) team = 1;
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    PVector[] legal;
    
    if (crossRiver()) {
      
      legal = new PVector[3];
      legal[0] = new PVector(f, r - 1 * team);
      legal[1] = new PVector(f + 1, r);
      legal[2] = new PVector(f - 1, r);
      
    }
    else {
      
      legal = new PVector[1];
      legal[0] = new PVector(f, r - 1 * team);
      
    }
    
    return legal;
    
  }
  
  public boolean crossRiver() {
    return (getPos().y <= river && isRed()) || (getPos().y >= river + 1 && !isRed());
  }
  
  @Override
  public String getPiece() {
    return "Soldier";
  }
  
}
