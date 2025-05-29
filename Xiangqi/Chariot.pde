public class Chariot extends Piece {

  public Chariot(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(2);
  }
  
}
