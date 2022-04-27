package math_expression;

import java.util.*;
	
public class Test30 {
	public int x;
	private External external;
	
	public Test30(External external){
		this.external = external;
	}
	
	public interface External{
		public int pow(int n, int m);
		public int sqrt(int n);
		public int pi();
	}
	public void compute() {
		x = this.external.sqrt( this.external.pow( this.external.pi(),   2 ) );
	}

	
}
