import java.util.*;

public class Problema1002{
	
	public static void main(String [] args){
		
		Scanner ent = new Scanner(System.in);
		
		int casos = ent.nextInt();
		int n = 0;
		for (int i=1; i<=casos; i++){
			n = ent.nextInt();
			System.out.println("Caso "+i+": "+n);
			Metodo1002.calcula(n); 
			System.out.println();
		}	
	}
}
