public class Timer {
  // FIELDS:
  int startTime;
  
  // CONSTRUCTOR:
  Timer() {
    reset();
  }
  
  // METHODS:
  public void reset() {
    startTime = millis();  
  }
  
  int elapsedMillis() {
    return millis() - startTime;
  }
 
} // class end