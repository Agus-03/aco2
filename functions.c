calculo_a1 (int xa, int ya, int xb, int yb) {
  int a1, aux, suma_x, suma_y, suma_sqr, suma_prod;
	
	suma_x = xa+xb;
	suma_y = ya+yb;
	suma_sqr = xa * xa + xb * xb;
	suma_prod = xa * ya + xb * yb;

	a1 = 2 * suma_prod - suma_x * suma_y;
	aux = 2 * suma_sqr - suma_x * suma_x;
	a1 = a1/aux;
	return a1;
}

calculo_a0 (int xa, int ya, int xb, int yb) {
	int a0, a1, suma_x, suma_y, suma_sqr, suma_prod;
	
	a1 = calculo_a1(xa, ya, xb, yb);
	suma_x = xa+xb;
	suma_y = ya+yb;
	
	a0 = suma_y/2 - a1 * suma_x/2;
	return a0;
}

LineasImg(int xa, int ya, int xb, int yb){
  int a1 = calculo_a1(int xa, int ya, int xb, int yb);
  int a0 = calculo_a0(int xa, int ya, int xb, int yb);
  int x, y;

  while (x < xb) do {
    x = xa + 1;
    y = a0 + a1 * x;
  }
}

