public class Horse extends Piece {

  public Horse(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(5);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    if (checkBounds(f + 1, r) && checkBlocks(f + 1, r)) {
      if (checkBounds(f + 2, r + 1)) legal.add(new PVector(f + 2, r + 1));
      if (checkBounds(f + 2, r - 1)) legal.add(new PVector(f + 2, r - 1));
    }
    if (checkBounds(f - 1, r) && checkBlocks(f - 1, r)) {
      if (checkBounds(f - 2, r + 1)) legal.add(new PVector(f - 2, r + 1));
      if (checkBounds(f - 2, r - 1)) legal.add(new PVector(f - 2, r - 1));
    }
    if (checkBounds(f, r + 1) && checkBlocks(f, r + 1)) {
      if (checkBounds(f + 1, r + 2)) legal.add(new PVector(f + 1, r + 2));
      if (checkBounds(f - 1, r + 2)) legal.add(new PVector(f - 1, r + 2));
    }
    if (checkBounds(f, r - 1) && checkBlocks(f, r - 1)) {
      if (checkBounds(f + 1, r - 2)) legal.add(new PVector(f + 1, r - 2));
      if (checkBounds(f - 1, r - 2)) legal.add(new PVector(f - 1, r - 2));
    }

    return legal;
    
  }
  
  @Override
  public String getPiece() {
    return "Horse";
  }
  
}
