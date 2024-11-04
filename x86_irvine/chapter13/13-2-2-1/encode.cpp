#include <iostream>
#include <fstream>

#include "translat.h"

int main(int argc, char *argv[])
{
    // Read input and output files from the command line.
    if (argc < 3)
    {
        std::cout << "Usage: encode infile outfile" << std::endl;
        return -1;
    }

    const int BUFSIZE = 2000;
    char buffer[BUFSIZE];

    unsigned char encryptCode;
    std::cout << "Encryption code [0-255]? ";
    std::cin >> encryptCode;

    std::ifstream infile(argv[1], std::ios::binary);
    std::ofstream outfile(argv[2], std::ios::binary);

    std::cout << "Reading " << argv[1] << " and creating "
        << argv[2] << std::endl;
    while (!infile.eof())
    {
        infile.read(buffer, BUFSIZE);
        unsigned int count = infile.gcount(); // character count

        TranslateBuffer(buffer, count, encryptCode);
        outfile.write(buffer, count);
    }

    return 0;
}