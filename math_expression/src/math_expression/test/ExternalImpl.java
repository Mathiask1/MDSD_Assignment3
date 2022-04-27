package math_expression.test;

import math_expression.*;

class ExternalImpl implements Test27.External, Test28.External, Test29.External, Test30.External, Test31.External, Test34.External {

	public int pi() {
		return 3;
	}

	public int sqrt(int n) {
		int temp;
		int sr = n / 2;
		do {
			temp = sr;
			sr = (temp + (n / temp)) / 2;
		} while ((temp - sr) != 0);

		return sr;
	}
	
	public int pow(int n, int m) {
        int base = n, power = m;
        int result = 1;
        // running loop while the power > 0
        while (power != 0) {
            result = result * base;
            // power will get reduced after
            // each multiplication
            power--;
        }
		return result;
	}
	
}
