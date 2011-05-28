import java.util.*;

public class Metodo1001{

	public static void calcula(int n){
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
}
