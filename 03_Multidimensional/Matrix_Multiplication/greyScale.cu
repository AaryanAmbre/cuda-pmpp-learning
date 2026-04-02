#include <iostream>
#include <cuda_runtime.h>
#include <cuda.h>
using namespace std;


__global__ void grayScale(unsigned char * Pin,unsigned char *Pout ,int width,int height){
    //create index for each thread in 2D ROw and column 
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col  = threadIdx.x + blockIdx.x * blockDim.x;

    //Create A boundry Box and appl the Luminance formula for Scaling the image Gray
    if (row < height && col<width)
    {
        int grayOffset = row * width + col;
        int rgbOffset = grayOffset * 3;

        unsigned char r = Pin[rgbOffset];
        unsigned char g = Pin[rgbOffset +1];
        unsigned char b = Pin[rgbOffset +2];

        Pout[grayOffset] =0.299f * r + 0.587f * g + 0.114f * b;
    }
    
}

int main(){
    // initialize the height and width of image
    int width = 16;
    int height = 16;

    //Create a size variable for storing the value of byes needed for Pin and Pout
    int rgbsize = width * height *3;
    int graysize =  width * height;

    //Create memory for h_pin and H_pout in host to store the actual values we get;
    unsigned char *h_Pin = new unsigned char[rgbsize];
    unsigned char *h_Pout = new unsigned char[graysize];
    //creates dummy data
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {

            int idx = (y * width + x) * 3;
            h_Pin[idx]     = x * 20;   // R
            h_Pin[idx + 1] = y * 30;   // G
            h_Pin[idx + 2] = 40;       // B
        }
    }

    //Creates Space for Device Pin and pout using malloc
    unsigned char *d_Pin,*d_Pout;
    cudaMalloc(&d_Pin,rgbsize);
    cudaMalloc(&d_Pout,graysize);
    //Copy data from h_PIn to d_PIN
    cudaMemcpy(d_Pin,h_Pin,rgbsize,cudaMemcpyHostToDevice);
    
    //blocks in a single grid
    dim3 gridDim(1,1);
    //threads in single block = x * y = 16*16 = 256
    dim3 blockdim(16,16);
    
    //calls the kernel Function 
    grayScale<<<gridDim,blockdim>>>(d_Pin,d_Pout,width,height);
    //Copy data from device P_out to Host Pout
    cudaMemcpy(h_Pout,d_Pout,graysize,cudaMemcpyDeviceToHost);

    cout << "Grayscale Output:\n";
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            cout << (int)h_Pout[y * width + x] << "\t";
        }
        cout << "\n";
    }

    //free data
    cudaFree(d_Pin);
    cudaFree(d_Pout);

    delete[] h_Pin;
    delete[] h_Pout;
    return 0;
}