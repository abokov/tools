// example - calling of virtual methods in constructor and destructors
/* on a screen we will see :
A::A()
A::func_a()
A::func_b()
B::B
B::func_a
B::func_b
B::~B
B::func_a
B::func_b
A::~A()
A::func_b()


 */

#include <iostream>
using namespace std;

class A {
public:
	A();
	virtual ~A() = 0;
	virtual void func_a(void)=0;
	virtual void func_b(void);
};

A::A() {  
	cout<<"A::A()"<<endl;	
	func_a();  
	func_b();
};



A::~A() {  
	cout<<"A::~A()"<<endl;	
	func_b();
};


void A::func_b(void) { 
	cout<<"A::func_b()"<<endl; 
};

void A::func_a(void) { 
	cout<<"A::func_a()"<<endl; 
};



class B: public A {
public:
	B(void);
	virtual ~B();

	void test(void);
	virtual void func_a(void) { 	cout<<"B::func_a"<<endl; };
	virtual void func_b(void) { 	cout<<"B::func_b"<<endl; };
};

B::B() {
	 cout<<"B::B"<<endl;
	 func_a();
	 func_b();
}

B::~B() {
	 cout<<"B::~B"<<endl;
	 func_a();
	 func_b();
}

void B::test(void) {
//	func_a();
//	A::func_a();
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

