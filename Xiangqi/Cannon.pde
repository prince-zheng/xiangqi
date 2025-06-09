public class Cannon extends Piece {

  public Cannon(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(1);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    boolean screen = false;
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    for (int F = f + 1; F < files; F++) {
      if (checkBounds(F, r) && !canCapture(F, r) && !screen) legal.add(new PVector(F, r));
      else if (!checkBlocks(F, r) && !screen) screen = true;
      else if (canCapture(F, r) && screen) {
        legal.add(new PVector(F, r));
        break;
      }
      else if (!checkBlocks(F, r) && screen) break;
    }
    screen = false;
    for (int F = f - 1; F >= 0; F--) {
      if (checkBounds(F, r) && !canCapture(F, r) && !screen) legal.add(new PVector(F, r));
      else if (!checkBlocks(F, r) && !screen) screen = true;
      else if (canCapture(F, r) && screen) {
        legal.add(new PVector(F, r));
        break;
      }
      else if (!checkBlocks(F, r) && screen) break;
    }
    screen = false;
    for (int R = r + 1; R < ranks; R++) {
      if (checkBounds(f, R) && !canCapture(f, R) && !screen) legal.add(new PVector(f, R));
      else if (!checkBlocks(f, R) && !screen) screen = true;
      else if (canCapture(f, R) && screen) {
        legal.add(new PVector(f, R));
        break;
      }
      else if (!checkBlocks(f, R) && screen) break;
    }
    screen = false;
    for (int R = r - 1; R >= 0; R--) {
      if (checkBounds(f, R) && !canCapture(f, R) && !screen) legal.add(new PVector(f, R));
      else if (!checkBlocks(f, R) && !screen) screen = true;
      else if (canCapture(f, R) && screen) {
        legal.add(new PVector(f, R));
        break;
      }
      else if (!checkBlocks(f, R) && screen) break;
    }
    
    checkChecks(legal);
    
    return legal;
    
  }
  
  @Override
  public boolean canCheck() {
    
    boolean screen = false;
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    for (int F = f + 1; F < files; F++) {
      if (!checkBlocks(F, r) && !screen) screen = true;
      else if (canCaptureCheck(F, r) && screen) return true;
      else if (!checkBlocks(F, r) && screen) break;
    }
    screen = false;
    for (int F = f - 1; F >= 0; F--) {
      if (!checkBlocks(F, r) && !screen) screen = true;
      else if (canCaptureCheck(F, r) && screen) return true;
      else if (!checkBlocks(F, r) && screen) break;
    }
    screen = false;
    for (int R = r + 1; R < ranks; R++) {
      if (!checkBlocks(f, R) && !screen) screen = true;
      else if (canCaptureCheck(f, R) && screen) return true;
      else if (!checkBlocks(f, R) && screen) break;
    }
    screen = false;
    for (int R = r - 1; R >= 0; R--) {
      if (!checkBlocks(f, R) && !screen) screen = true;
      else if (canCaptureCheck(f, R) && screen) return true;
      else if (!checkBlocks(f, R) && screen) break;
    }
    
    return false;
    
  }
  
  @Override boolean noLegal() {
    
    return checkLegal().size() == 0;
    
  }
  
  @Override
  public int getPiece() {
    return 6;
  }
  
}
