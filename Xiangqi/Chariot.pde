public class Chariot extends Piece {

  public Chariot(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(2);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    for (int F = f + 1; F < files; F++) {
      if (checkBounds(F, r)) legal.add(new PVector(F, r));
      else break;
      if (canCapture(F, r)) break;
    }
    for (int F = f - 1; F >= 0; F--) {
      if (checkBounds(F, r)) legal.add(new PVector(F, r));
      else break;
      if (canCapture(F, r)) break;
    }
    for (int R = r + 1; R < ranks; R++) {
      if (checkBounds(f, R)) legal.add(new PVector(f, R));
      else break;
      if (canCapture(f, R)) break;
    }
    for (int R = r - 1; R >= 0; R--) {
      if (checkBounds(f, R)) legal.add(new PVector(f, R));
      else break;
      if (canCapture(f, R)) break;
    }
    
    checkChecks(legal);
    
    return legal;
    
  }
  
  @Override
  public boolean canCheck() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    for (int F = f + 1; F < files; F++) {
      if (checkBounds(F, r) && canCaptureCheck(F, r)) return true;
      if (!checkBounds(F, r) || canCapture(F, r)) break;
    }
    for (int F = f - 1; F >= 0; F--) {
      if (checkBounds(F, r) && canCaptureCheck(F, r)) return true;
      if (!checkBounds(F, r) || canCapture(F, r)) break;
    }
    for (int R = r + 1; R < ranks; R++) {
      if (checkBounds(f, R) && canCaptureCheck(f, R)) return true;
      if (!checkBounds(f, R) || canCapture(f, R)) break;
    }
    for (int R = r - 1; R >= 0; R--) {
      if (checkBounds(f, R) && canCaptureCheck(f, R)) return true;
      if (!checkBounds(f, R) || canCapture(f, R)) break;
    }
    
    return false;
    
  }
  
  @Override
  public boolean noLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    for (int F = f + 1; F < files; F++) {
      if (checkBounds(F, r)) return false;
      else break;
    }
    for (int F = f - 1; F >= 0; F--) {
      if (checkBounds(F, r)) return false;
      else break;
    }
    for (int R = r + 1; R < ranks; R++) {
      if (checkBounds(f, R)) return false;
      else break;
    }
    for (int R = r - 1; R >= 0; R--) {
      if (checkBounds(f, R)) return false;
      else break;
    }
        
    return true;
    
  }
  
  @Override
  public int getPiece() {
    return 5;
  }
  
}
