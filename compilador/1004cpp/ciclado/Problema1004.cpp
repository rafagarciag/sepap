#include <iostream>
using namespace std;

int GCD(int a, int b)
{
    int Remainder;

    while( b != 0 )
    {
        Remainder = a % b;
        a = b;
        b = Remainder;
    }

    return a;
}

int main()
{
	int x, y;

	
	cin >> x;
	cin >> y;
    while(true){
        cout << "a";
    }
	cout << "The Greatest Common Divisor of "
	     << x << " and " << y << " is " << GCD(x, y) << endl;  

	return 0;
}
