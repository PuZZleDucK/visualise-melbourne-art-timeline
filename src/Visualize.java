
import java.nio.file.*;
import java.nio.charset.*;
import java.io.*;
import java.lang.*;
import java.util.*;
import java.math.*;
import java.util.concurrent.*;
public class Visualize {
  private Path path;
  private BufferedReader reader;
  private ConcurrentSkipListMap<Integer,Integer> yearList;

  public static void main(String[] args) throws Exception{
    System.out.println(":: Visualize Melbourne ::");
    Visualize v = new Visualize();
  }


  public Visualize() throws Exception{
    yearList = new ConcurrentSkipListMap<Integer,Integer>();
    path = FileSystems.getDefault().getPath("/home/puzzleduck/Dropbox/x/Outware/data", "Melbourne_Public_Artwork.csv");
//    System.out.println(path.toAbsolutePath());
    reader = Files.newBufferedReader(path, StandardCharsets.UTF_8);
    String line = reader.readLine();
    Integer year;
    while(line != null) {
      StringTokenizer st = new StringTokenizer(line, ",", false); //no delims
      while(st.hasMoreElements()) {
        String thisToken = st.nextToken();
        try {
          if(Integer.parseInt(thisToken) > 0) {
//            System.out.print("[ "+Integer.parseInt(thisToken)+" ]");
            year = Integer.parseInt(thisToken);

            if(!yearList.containsKey(year)) { 
              yearList.put(year, new Integer(1));
            }else{
              yearList.put(year, new Integer((yearList.get(year)).intValue()+1));
            }

          }
        } catch(Exception e) {};
//        System.out.print("\n :: " + thisToken);
      }
//      System.out.println("\n================================");
//      System.out.println(": " + line);
      line = reader.readLine();
    }

//display char[][] = new char[][];
  int counter;
  String[] display = new String[yearList.size()];
  for(Map.Entry<Integer, Integer> yearEntry : yearList.entrySet()) {
//    display[counter] = new String("| "+yearEntry.getKey()+":");
//    System.out.println("RESULT:"+yearEntry.getValue());
      System.out.print("| "+yearEntry.getKey()+":");
    for(int artCount = yearEntry.getValue(); artCount>0; artCount-=1) {
//      display[counter] += "*";
      System.out.print("*");
    }
    System.out.print("\n");
//    counter+=1;
  }


//  for(int displayWidth = 0; displayWidth < 80; displayWidth+=1) {
//    System.out.println();
//  }




  }//Visualize




}//class


