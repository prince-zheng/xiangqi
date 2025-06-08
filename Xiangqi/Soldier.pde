public class Soldier extends Piece {

  public Soldier(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(6);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
        
    int team = -1;
    if (isRed()) team = 1;
        
    int f = int(getPos().x);
    int r = int(getPos().y);
        
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    if (checkBounds(f, r - 1 * team)) legal.add(new PVector(f, r - 1 * team));
    
    if (crossRiver()) {
      if (checkBounds(f + 1, r)) legal.add(new PVector(f + 1, r));
      if (checkBounds(f - 1, r)) legal.add(new PVector(f - 1, r));
    }
    
    checkChecks(legal);
    
    return legal;
    
    
  }
  
  @Override
  public boolean canCheck() {
        
    int team = -1;
    if (isRed()) team = 1;
        
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    if (checkBounds(f, r - 1 * team) && canCaptureCheck(f, r - 1 * team)) return true;
    
    if (crossRiver()) {
      if (checkBounds(f + 1, r) && canCaptureCheck(f + 1, r)) return true;
      if (checkBounds(f - 1, r) && canCaptureCheck(f - 1, r)) return true;
    }
    
    return false;
    
  }
  
  public boolean crossRiver() {
    return (getPos().y <= river && isRed()) || (getPos().y >= river + 1 && !isRed());
  }
  
  @Override
  public int getPiece() {
    return 7;
  }
  
}
