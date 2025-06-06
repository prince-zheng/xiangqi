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
    
    if (checkBounds(f + 1, r) && isPalace(f + 1, r) && !flyingGeneral(f + 1)) legal.add(new PVector(f + 1, r));
    if (checkBounds(f - 1, r) && isPalace(f - 1, r) && !flyingGeneral(f - 1)) legal.add(new PVector(f - 1, r));
    if (checkBounds(f, r + 1) && isPalace(f, r + 1)) legal.add(new PVector(f, r + 1));
    if (checkBounds(f, r - 1) && isPalace(f, r - 1)) legal.add(new PVector(f, r - 1));
    
    return legal;
    
  }
  
  public boolean flyingGeneral(int f) {
    
    if (isRed()) { 
      for (int R = int(getPos().y) - 1; R >= 0; R--) {
        if (!checkBlocks(f, R) && board[R * (ranks - 1) + f].getPiece().equals("General")) return true;
        else if (!checkBlocks(f, R)) return false;
      }
    }
    else {
      for (int R = int(getPos().y) + 1; R < ranks; R++) {
        if (!checkBlocks(f, R) && board[R * (ranks - 1) + f].getPiece().equals("General")) return true;
        else if (!checkBlocks(f, R)) return false;
      }
    }
    return false;
    
  }
  
  @Override
  public String getPiece() {
    return "General";
  }
  
}
