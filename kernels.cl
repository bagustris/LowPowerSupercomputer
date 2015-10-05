#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void vector_sum ( __global const double *inputA,
                           __global const double *inputB,
                           __global       double *output)
{
    const int i = get_global_id(0);

    double a2 = cbrt( inputA[i]*inputA[i] / M_PI ) ;
    double b2 = cbrt( inputB[i]*inputB[i] * M_PI_2 ) ;
    output[i] = log(sqrt(a2+b2));
}
