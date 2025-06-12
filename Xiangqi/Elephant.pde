public class Elephant extends Piece {

  public Elephant(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(3);
  }
  
  @Override
  public Piece copy() {
    return new Elephant(int(getPos().x), int(getPos().y), isRed());
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    if (!(isRed() && r == river + 1)) {
      
      if (checkBounds(f + 2, r - 2) && checkBlocks(f + 1, r - 1)) legal.add(new PVector(f + 2, r - 2));
      if (checkBounds(f - 2, r - 2) && checkBlocks(f - 1, r - 1)) legal.add(new PVector(f - 2, r - 2)); 
      
    }
    if (!(!isRed() && r == river)) {
      
      if (checkBounds(f + 2, r + 2) && checkBlocks(f + 1, r + 1)) legal.add(new PVector(f + 2, r + 2));
      if (checkBounds(f - 2, r + 2) && checkBlocks(f - 1, r + 1)) legal.add(new PVector(f - 2, r + 2));
    
    }
    
    checkChecks(legal);
    
    return legal;
    
  }
  
  
  @Override
  public float getMaterial() {
    return 2;
  }
  
}
