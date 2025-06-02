public class Soldier extends Piece {
  
  boolean crossRiver;

  public Soldier(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
    crossRiver = false;
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(6);
  }
  
  @Override
  public PVector[] checkLegal() {
    
    PVector[] legal;
    if (crossRiver) legal = new PVector[3];
    else legal = new PVector[1];
    
    return legal;
    
  }
  
  @Override
  public String getPiece() {
    return "Soldier";
  }
  
}
