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
      else if (!screen) break;
      else if (screen && canCapture(F, r)) {
        legal.add(new PVector(F, r));
        break;
      }
    }
    screen = false;
    for (int F = f - 1; F >= 0; F--) {
      if (checkBounds(F, r) && !canCapture(F, r) && !screen) legal.add(new PVector(F, r));
      else if (!checkBlocks(F, r) && !screen) screen = true;
      else if (!screen) break;
      else if (screen && canCapture(F, r)) {
        legal.add(new PVector(F, r));
        break;
      }
    }
    screen = false;
    for (int R = r + 1; R < ranks; R++) {
      if (checkBounds(f, R) && !canCapture(f, R) && !screen) legal.add(new PVector(f, R));
      else if (!checkBlocks(f, R) && !screen) screen = true;
      else if (!screen) break;
      else if (screen && canCapture(f, R)) {
        legal.add(new PVector(f, R));
        break;
      }
    }
    screen = false;
    for (int R = r - 1; R >= 0; R--) {
      if (checkBounds(f, R) && !canCapture(f, R) && !screen) legal.add(new PVector(f, R));
      else if (!checkBlocks(f, R) && !screen) screen = true;
      else if (!screen) break;
      else if (screen && canCapture(f, R)) {
        legal.add(new PVector(f, R));
        break;
      }
    }
    
    return legal;
    
  }
  
  @Override
  public String getPiece() {
    return "Cannon";
  }
  
}
