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
    
    for (int F = 0; F < files; F++) {
      legal.add(new PVector(F, r));
    }
    for (int R = 0; R < ranks; R++) {
      legal.add(new PVector(f, R));
    }
    
    return legal;
    
  }
  
  @Override
  public String getPiece() {
    return "Chariot";
  }
  
}
