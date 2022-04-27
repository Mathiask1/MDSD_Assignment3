package math_expression;

import java.util.*;
	
public class Test29 {
	public int x;
	public int y;
	private External external;
	
	public Test29(External external){
		this.external = external;
	}
	
	public interface External{
		public int pow(int n, int m);
	}
	public void compute() {
		x = this.external.pow( 4,   2 );
		y = (x) - 2;
	}

	
}
