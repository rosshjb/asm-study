#include <iostream>
#include <cstdlib>
#include <ctime>

#include "indexof.h"

using namespace std;

int main()
{
    // Fill an array with pseudorandom integers.
    const unsigned ARRAY_SIZE = 100000;
    const unsigned LOOP_SIZE = 100000;
    const char* boolstr[] = { "false", "true" };

    long* array = new long[ARRAY_SIZE];
    for (unsigned i = 0; i < ARRAY_SIZE; i++)
        array[i] = rand();

    long searchVal;
    cout << "Enter an integer value to find: ";
    cin >> searchVal;
    cout << "Please wait...\n";

    // Test the Assembly language function
    time_t startTime;
    time(&startTime);

    int count = 0;
    for (unsigned n = 0; n < LOOP_SIZE; n++)
        count = IndexOf(searchVal, array, ARRAY_SIZE);
    bool found = count != -1;

    time_t endTime;
    time(&endTime);

    cout << "Elapsed ASM time: " << long(endTime - startTime)
        << " seconds. Found = " << boolstr[found] << endl;

    delete[] array;

    return 0;
}