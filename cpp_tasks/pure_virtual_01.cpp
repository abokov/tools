// example of direct call of pure virtual methods
/* on a screen we will see :

B::func_a
A::func_a()
B::~B
A::~A()
 */

#include <iostream>
using namespace std;

class A {
public:

#ifdef _MSC_VER
	virtual ~A()=0 {  		cout<<"A::~A()"<<endl;	};
	virtual void func_a(void)=0 { cout<<"A::func_a()"<<endl; };
#else
// Borland c++  doesn't allow this inlines - we will declare bodies later
	virtual ~A()=0;
	virtual void func_a(void)=0 ;
#endif
};

#ifndef _MSC_VER

A::~A() {  
   cout<<"A::~A()"<<endl;	
};


void A::func_a(void) { 
	cout<<"A::func_a()"<<endl; 
};

#endif


class B: public A {
public:
	virtual ~B() { 		cout<<"B::~B"<<endl; };

	void test(void);
	virtual void func_a(void) { 	cout<<"B::func_a"<<endl; };
};


void B::test(void) {
	func_a();
	A::func_a();
}


void pure_virtual_test(void) {
	B * b = new B();
	b->test();
	delete b;
};


int main(void) {
	pure_virtual_test();
	return 1;
};

