#include <cstdlib>
#include <iostream>
#include <math.h>
#include <time.h>

#define SIZE 30000000
#define TYPE double
#define HOWMANY 2
#define THRESHOLD 0.001

using namespace std;

/* Check results */
void check_results(const int   arraySize, 
                   const TYPE *inputA, 
                   const TYPE *inputB, 
                   const TYPE *output)
{
    bool b = false;
    for (int i = 0; i < arraySize; i++) {
        TYPE a2 = inputA[i]*inputA[i];
        TYPE b2 = inputB[i]*inputB[i];
        TYPE outputOK = log(sqrt(a2 + b2));
        TYPE diff = outputOK - output[i];
        if (diff < 0) diff = -diff;
        if (diff > THRESHOLD) {
            //cout << "Error at " << i << endl;
            b = true;
            cout << "[" << i << "] = " << output[i]
                 << "*** Should be = " << outputOK << endl;
            cout << "a2 = " << a2 << " b2 = " << b2 << endl; 
        }
    }

    if (not b) {
        cout << "Finished successfully" << endl;
    } else {
        cout << "Some errors ocurred" << endl;
    }
}


void initialize_data(const int   arraySize, 
                           TYPE *inputA,
                           TYPE *inputB)
{
    for (int i = 0; i < arraySize; i++) {
        inputA[i] = i+1;
        inputB[i] = i+1;
    }
}


void get_date(int   argc, 
              char* argv[]) 
{
    if ( (argc == 2) && (string(argv[1]) == "-p") ) {
        time_t t = time(NULL);
        cout << t << endl;
    }
}
