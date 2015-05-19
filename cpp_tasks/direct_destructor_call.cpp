// an example of direct destructor calling

#include <iostream>

using namespace std;

class A
{
	long test;
public:
	A() { cout << "A::A()" << endl; }
	virtual ~A() { cout << "A::~A()" << endl; }
};

void foo(void) {
unsigned char buffer [sizeof(A)];
unsigned char buffer2 [sizeof(A)];

{ A * a = new(buffer) A;
  // buffer is in stack, not in heap, so you cannot use delete
  // But you must destruct it, too:
  a->~A();
}

// why we can't use delete for this ? 
{  A * a = new(buffer2) A;

   // Bang!!! exception here!!!
   delete a;
} 
}

int main()
{
	foo();
	return 1;


}