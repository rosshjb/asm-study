// main.cpp
// demonstrates functions calls between a C++ program and an external
// assembly language module.
#include <iostream>
#include <iomanip>

using namespace std;

extern "C" {
    // external asm procedures:
    void DisplayTable();
    void SetTextOutColor(unsigned color);

    // local C++ functions:
    int askForInteger();
    void showInt(int value, int width);
}

int main()
{
    SetTextOutColor(0x1E);  // yelow on blue
    DisplayTable();         // call ASM procedure
    return 0;
}

int askForInteger()
{
    int n;

    cout << "Enter an integer between 1 and 90,000:";
    cin >> n;

    return n;
}

void showInt(int value, int width)
{
    cout << setw(width) << value;
}
