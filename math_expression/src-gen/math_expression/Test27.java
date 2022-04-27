package math_expression;

import java.util.*;
	
public class Test27 {
	public int x;
	public int y;
	private External external;
	
	public Test27(External external){
		this.external = external;
	}
	
	public interface External{
		public int pi();
	}
	public void compute() {
		x = this.external.pi();
		y = (x) + 2;
	}

	
}
