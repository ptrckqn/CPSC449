//Patrick Quan 10152770 Assignment 1 Shortest Job First
import java.io.*;

public class sjf{
  public static void main(String args[]){
    String inputFile = args[0];
    String outputFile = args[1];
    int waitTime[];
    int burstTime[];
    double avgWaitTime = 0;
    String input[];
    int sortedInput[];

    input = readFile(inputFile).split("\n");
    waitTime = new int[input.length];
    burstTime = new int[input.length];
    sortedInput = new int[input.length];

    for(int i = 0; i < input.length; i++){
      sortedInput[i] = Integer.parseInt(input[i]);
    }

    int tempInt = 0;
    for(int i = 0; i < sortedInput.length - 1; i++){
      for(int j = 0; j < sortedInput.length - 1; j++){
        if(sortedInput[j] > sortedInput[j + 1]){
          tempInt = sortedInput[j];
          sortedInput[j] = sortedInput[j + 1];
          sortedInput[j + 1] = tempInt;
        }
      }
    }

    for(int i = 0; i < sortedInput.length; i++){
      burstTime[i] = sortedInput[i];
      if(i == 0 ){
        waitTime[i] = 0;
      }
      else{
        waitTime[i] = waitTime [i-1] + burstTime[i-1];
      }
      avgWaitTime += waitTime[i];
    }

    avgWaitTime = avgWaitTime / waitTime.length;

    writeFile(outputFile, waitTime, avgWaitTime);
  }

  private static void writeFile(String outputFile, int waitTime[], double avgTime){
    FileWriter fw = null;
    PrintWriter pw = null;
    try{
      fw = new FileWriter(outputFile + ".txt");
      pw = new PrintWriter(fw);
    }
    catch(IOException e){
      System.out.println("Error creating output file");
    }
    for(int i = 0; i < waitTime.length; i++){
      pw.print(waitTime[i]);
      pw.print("\n");
    }
    pw.print(avgTime);
    pw.close();
  }

  private static String readFile(String inputFile){
    BufferedReader br = null;
    String fullString = "";
    String line;

    try{
      br = new BufferedReader(new FileReader(inputFile + ".txt"));
      while ((line = br.readLine()) != null){
        fullString = fullString + line + "\n";

      }
    }
    catch(IOException e){
      System.out.println("Error reading file");
    }
    finally{
      if(br != null){
        try{
          br.close();
        }
        catch(IOException e){
          System.out.println("Error closing BufferedReader");
        }
      }
      else{
        System.out.println("BufferReader did not open");
      }
    }
    return fullString;
  }
}
