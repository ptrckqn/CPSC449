//Patrick Quan 10152770 Assignment 1 Round Robin
import java.io.*;

public class rr{

  public static void main(String args[]){
    String inputFile = args[0];
    String outputFile = args[1];
    int waitTime[];
    int burstTime[];
    double avgWaitTime = 0;
    String input[];
    int qTime = 0;
    int sorted = 0;
    int[] rrInput;
    int count = 0;
    int totalTime = 0;

    input = readFile(inputFile).split("\n");
    waitTime = new int[input.length - 1];
    burstTime = new int[input.length - 1];
    qTime = Integer.parseInt(input[0]);
    rrInput = new int[input.length - 1];

    for(int i = 1; i < input.length; i++){
      rrInput[i - 1] = Integer.parseInt(input[i]);
      totalTime = totalTime + rrInput[i - 1];
    }

    while(sorted != rrInput.length - 1){
      for(int i = 0; i < rrInput.length; i++){
        if(((rrInput[i] - qTime) > 0) && (i != (rrInput.length - 1))){
          waitTime[i + 1] = waitTime[i] + waitTime[i + 1] + qTime;
          rrInput[i] = rrInput[i] - qTime;
        }
        else if(((rrInput[i] - qTime) > 0) && (i == rrInput.length - 1)){
          waitTime[0] = waitTime[i] + waitTime[0] + qTime;
          rrInput[i] = rrInput[i] - qTime;
        }
        else if((rrInput[i] - qTime <= 0) && (i != (rrInput.length - 1))){
          waitTime[i + 1] = waitTime[i] + waitTime[i + 1] + rrInput[i];
          rrInput[i] = rrInput[i] - rrInput[i];
          sorted++;
        }
        else if(((rrInput[i] - qTime) <= 0) && (i == rrInput.length - 1)){
          waitTime[0] = waitTime[i] + waitTime[0] + rrInput[i];
          rrInput[i] = rrInput[i] - rrInput[i];
          sorted++;
        }
        else{
          //Do nothing
        }
      }
    }

    waitTime[0] = waitTime[0] - qTime;

    for(int i = 0; i < rrInput.length; i++){
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
