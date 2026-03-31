#include<iostream>
#include<cuda_runtime.h>

__global__ void vecAddkernel(float *A,float *B,float *C ,int  n){
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    if(i < n)
    {
        C[i] = A[i]+B[i];
    }
}

void vecAdd(float *A_h,float *B_h,float *C_h,int n)
{
    
    int size = n *sizeof(float);
    float *A_d,*B_d,*C_d;

    cudaMalloc((void**)&A_d,size);
    cudaMalloc((void**)&B_d,size);
    cudaMalloc((void**)&C_d,size);


   

    cudaMemcpy( A_d,A_h,size, cudaMemcpyHostToDevice);
    cudaMemcpy( B_d,B_h,size, cudaMemcpyHostToDevice);

    int threadsPerblock  = 256;
    int blockPergrid = (n + threadsPerblock -1)/threadsPerblock;
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    vecAddkernel<<<blockPergrid,threadsPerblock>>>(A_d,B_d,C_d,n);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms = 0;
    cudaEventElapsedTime(&ms, start, stop);

std::cout << "Kernel Time: " << ms << " ms\n";
    cudaMemcpy(C_h,C_d,size, cudaMemcpyDeviceToHost);

    cudaFree(A_d);
    cudaFree(B_d);
    cudaFree(C_d);
}
int main()
{
    int n = 50000000;
    int size = n*sizeof(float);

    float *A = (float*)malloc(size);
    float *B = (float*)malloc(size);
    float *C=  (float*)malloc(size);

    for(int i =0;i < n ;i++)
    {
        A[i] = i * 1.0f;
        B[i] = i * 2.0f;
    }


    vecAdd(A,B,C,n);
    
    for(int i = 0;i < 20 ;i++)
    {
        std::cout<<C[i]<<" ";
    }

    free(A);
    free(B);
    free(C);
    return 0;
}