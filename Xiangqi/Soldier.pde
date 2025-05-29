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
  
}
