#include <iostream>

using namespace std;

unsigned my_sqrt(int i) {
	if (i<0)
		i=-i;
	int cnt=0, dec=1;
	do {
		i -=dec;
		dec +=2;
		if (i<0)
			break;
		cnt++;
	} while (true);
	return cnt;
}


double my_sqrt2(int i) {

	i=abs(i);

	if (i == 0 )
		return 0;

	const IterSize=10;

	double v=i;
	double x=v;

	for (int cnt=0;cnt<IterSize;cnt++) {
		cout <<"x="<< x << ",v/x="<<v/x<< ",x+ (v/x)=" << x+ (v/x) <<",1/2*(x+ (v/x))="<<(1/2)*(x+ (v/x))<<endl;

		x = ((double)1/2)*(x+ (v/x));	
		cout <<"x="<<x <<endl;

	}	
	return x;
}




int main(void) {
        double d1 = 16, d2=2.0;
        
       	double d3 = double(1)/2 * ( sqrt(d1) + d2/2);
	cout << d3 << endl;
{
       	double d3 = (1/2) * ( sqrt(d1) + d2/2);
	cout << d3 << endl;

}

	do {
		int val;

		cout<< " enter a value : ";
		cin>> val;
		
		
 		cout<<" returned sqrt("<<val<<") = " << my_sqrt(val) << ", "<< my_sqrt2(val) <<endl;


		char in;
		cout<<" Press 'Y' to continue, any other to quit : ";
		cin>> in;
		if (in != 'Y')
			break;

	} while(true);
   
  


};