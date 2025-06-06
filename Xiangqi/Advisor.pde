public class Advisor extends Piece {

  public Advisor(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(0);
  }
  
  @Override
  public ArrayList<PVector> checkLegal() {
    
    int f = int(getPos().x);
    int r = int(getPos().y);
    
    ArrayList<PVector> legal = new ArrayList<PVector>();
    
    if (checkBounds(f + 1, r + 1) && isPalace(f + 1, r + 1)) legal.add(new PVector(f + 1, r + 1));
    if (checkBounds(f + 1, r - 1) && isPalace(f + 1, r - 1)) legal.add(new PVector(f + 1, r - 1));
    if (checkBounds(f - 1, r + 1) && isPalace(f - 1, r + 1)) legal.add(new PVector(f - 1, r + 1));
    if (checkBounds(f - 1, r - 1) && isPalace(f - 1, r - 1)) legal.add(new PVector(f - 1, r - 1));
    
    return legal;
    
  }
  
  @Override
  public String getPiece() {
    return "Advisor";
  }
  
}
