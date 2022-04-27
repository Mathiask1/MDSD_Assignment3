package math_expression;

import java.util.*;
	
public class Test34 {
	public int sideA;
	public int sideB;
	public int sideC;
	public int perimeterTriangle;
	public int radius;
	public int perimeterCircle;
	private External external;
	
	public Test34(External external){
		this.external = external;
	}
	
	public interface External{
		public int pow(int n, int m);
		public int sqrt(int n);
		public int pi();
	}
	public void compute() {
		sideA = 3;
		sideB = 4;
		sideC = this.external.sqrt( (this.external.pow( (sideA),   2 )) + (this.external.pow( (sideB),   2 )) );
		perimeterTriangle = (sideA) + (sideB) + (sideC);
		radius = 5;
		perimeterCircle = (2 * (radius)) * this.external.pi();
	}

	
}
