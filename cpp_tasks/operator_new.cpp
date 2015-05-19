// difference between new and new [] - delete and delete []
/* prints :
 now new [3] and then delete[] a
A::A()
A::A()
A::A()
A::~A()
A::~A()
A::~A()
 now new [3] and then delete a
A::A()
A::A()
A::A()
A::~A()
*/
#include <iostream>
using namespace std;


class A {
	int i;
public:
	A(void):i(1) {
		cout<<"A::A()\n";
	}
	~A() {
		cout<<"A::~A()\n";
	}

};

int main(void) {

	cout <<" now new [3] and then delete[] a \n";
	A * a = new A [3];
	delete [] a;

	cout <<" now new [3] and then delete a \n";
	a = new A [3];
	delete a;

	return 1;
}