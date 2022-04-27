package math_expression;

import java.util.*;
	
public class Test28 {
	public int x;
	public int y;
	private External external;
	
	public Test28(External external){
		this.external = external;
	}
	
	public interface External{
		public int sqrt(int n);
	}
	public void compute() {
		x = this.external.sqrt( 4 );
		y = (x) * 2;
	}

	
}
