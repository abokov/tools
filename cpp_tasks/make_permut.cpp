
#include <iterator>
#include <vector>
#include <iostream>

using namespace std;
bool my_next_permutation( bidirectional_iterator begin, bidirectional_iterator end );

//bool my_next_permutation(BidirectionalIterator & begin, BidirectionalIterator & end);


int main(void) {
	vector<int> v;
	v.push_back(1);
	v.push_back(2);
	v.push_back(3);  // Initialize all elements of a vector

	while (my_next_permutation(v.begin(), v.end() ) ) { 
                    // Loop until all permutations are generated.
		copy(v.begin(), v.end(), ostream_iterator<int>(cout, ""));
		cout << endl;
	}
	return 0;
}


bool my_next_permutation(bidirectional_iterator begin, bidirectional_iterator end) {
	if (begin ==  end )
		return false;

	return true

}

