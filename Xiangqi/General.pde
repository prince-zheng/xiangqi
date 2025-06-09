public class General extends Piece {

  public General(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(4);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    if (checkBounds(f + 1, r) && isPalace(f + 1, r)) legal.add(new PVector(f + 1, r));
    if (checkBounds(f - 1, r) && isPalace(f - 1, r)) legal.add(new PVector(f - 1, r));
    if (checkBounds(f, r + 1) && isPalace(f, r + 1)) legal.add(new PVector(f, r + 1));
    if (checkBounds(f, r - 1) && isPalace(f, r - 1)) legal.add(new PVector(f, r - 1));
    
    checkChecks(legal);
    
    return legal;
    
  }
  
  // flying general
  public boolean canCheck() {
        
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    if (isRed()) {
      for (int R = r - 1; R >= 0; R--) {
        if (checkBounds(f, R) && canCaptureCheck(f, R)) return true;
        if (!checkBlocks(f, R)) break;
      }
    }
    else {
      for (int R = r + 1; R < ranks; R++) {
        if (checkBounds(f, R) && canCaptureCheck(f, R)) return true;
        if (!checkBlocks(f, R)) break;
      }
    }

    return false;
    
  }
  
  @Override
  public boolean noLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    if (checkBounds(f + 1, r) && isPalace(f + 1, r)) return false;
    if (checkBounds(f - 1, r) && isPalace(f - 1, r)) return false;
    if (checkBounds(f, r + 1) && isPalace(f, r + 1)) return false;
    if (checkBounds(f, r - 1) && isPalace(f, r - 1)) return false;
    
    return true;
  }
  
  @Override
  public int getPiece() {
    return 1;
  }
  
}
