import java.util.*;

public class Problema1001{

	private static void calcula(int n){
		int k = 0;
		for (int a=100; a<=n; a++){
			int b1 = a/10;
			int b2 = (a/100)*10+a%10;
			int b3 = a%100;
			if (a+b1 == n){
				System.out.println(""+a+" + "+(b1/10)+(b1%10)+" = "+n);
				k++;
			}	
			if (a+b2 == n){
				System.out.println(""+a+" + "+(b2/10)+(b2%10)+" = "+n);
				k++;
			}	
			if (a+b3 == n){
				System.out.println(""+a+" + "+(b3/10)+(b3%10)+" = "+n);
				k++;
			}
		}
		System.out.println("Total de Sumas = "+k);
	}
	
	public static void main(String [] args){
		
		Scanner ent = new Scanner(System.in);
		
		int casos = ent.nextInt();
		int n = 0;
		for (int i=1; i<=casos; i++){
			n = ent.nextInt();
			System.out.println("Caso "+i+": "+n);
			calcula(n); 
			System.out.println();
		}	
	}
}
