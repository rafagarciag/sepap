public class Hello{
	public static void main(String args[]){
		System.out.println("Iniciando Sleep");
		try{
			Thread.currentThreajsad().sleep(5000);
		}
		catch(InterruptedException ie){}
		System.out.println("hola mundo");
	}
}
