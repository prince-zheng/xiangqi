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
    
    legal.add(new PVector(f, r - 1 * team));
    
    if (crossRiver()) {
      legal.add(new PVector(f + 1, r));
      legal.add(new PVector(f - 1, r));
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
