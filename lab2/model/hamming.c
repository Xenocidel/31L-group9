#include<stdio.h>
#include<math.h>
#include "svdpi.h"
#include "vpi_user.h"



void encoder(
                int data_in,
                int* data_out,
                int* parity_out
		
		)
{
    int i, a[10], c[4], r[14], clk[4], n, sum = 0;
    printf("%d\n", data_in);
    //int *a = (int *)svGetArrayPtr(data_in);
    a[0]= data_in & 1;
    a[1]= data_in>>1 & 1;
    a[2]= data_in>>2 & 1;
    a[3]= data_in>>3 & 1;
    a[4]= data_in>>4 & 1;
    a[5]= data_in>>5 & 1;
    a[6]= data_in>>6 & 1;
    a[7]= data_in>>7 & 1;
    a[8]= data_in>>8 & 1;
    a[9]= data_in>>9 & 1;
    a[10] =data_in>>10 & 1;
    printf("%x\n", data_in&(512));    
    //printf("%x\n", a[5]);
    //printf("%x\n", a[3]);
    //printf("%x\n", a[2]);
    //printf("%x\n", a[9]);
    printf("%x\n", a[0]);


    c[0]=(a[0] + a[1] + a[3] + a[4] + a[6] + a[8] + a[10])%2;
    c[1]=(a[0] + a[2] + a[3] + a[5] + a[6] + a[9] + a[10])%2;
    c[2]=(a[1] + a[2] + a[3] + a[7] + a[8] + a[9] + a[10])%2;
    c[3]=(a[4] + a[5] + a[6] + a[7] + a[8] + a[9] + a[10])%2;

    printf("data bits after hamming code is\n");

    for(i=10;i>=0;i--) {
        printf("%d",a[i]&1);
    }
    printf("\n");
    for(i=3;i>=0;i--) {
        printf("%d",c[i]);
    }
    printf("\n");
    *data_out = data_in;
    *parity_out = ((c[3]&1) << 3) | ((c[2]&1) << 2) | ((c[1]&1) << 1) | ((c[0]&1));
    //*parity_out = 0xff;
    

//    int *data_out_ptr;
//    data_out_ptr = (int *) svGetArrayPtr(data_out);
//    for(i=10;i>=0;i--) {
//        //data_out_ptr[i] = 1;
//        //*(int *)svGetArrElemPtr(data_out, i) = 1;
//        *(int *)svGetArrElemPtr1(data_out, i) = a[i]&0x1;
//    }
//    for(i=3;i>=0;i--) {
//        printf("insert c[%d]: %d\n", i, c[i]);
//        *(int *)svGetArrElemPtr1(parity_out, i) = 1;
//        //*(int *)svGetArrElemPtr1(parity_out, i) = c[i];
//        printf("arr c[%d]: %d\n", i, *(int *)svGetArrElemPtr1(parity_out, i));
//    }

//    printf("Enter recieved code\n");
//    for(i=0;i<7;i++)
//        scanf("%d",&r[i]);
//
//    clk[0]=(r[3]+r[1]+r[2]+r[6])%2;
//    clk[1]=(r[0]+r[2]+r[1]+r[5])%2;
//    clk[2]=(r[0]+r[2]+r[3]+r[4])%2;
//
//    sum=4*clk[2]+2*clk[1]+1*clk[0];
//
//    if(sum==0)
//        printf("\n u have recived coorrect code\n");
//    if(sum==1)
//    {   printf("Error in check bit 2\n");
//        printf("The correct code is");
//        r[6]=(r[6]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
//    if(sum==2)
//    {
//        printf("Error in check bit 1\n");
//        printf("The correct code is");
//        r[5]=(r[5]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
//    if(sum==3)
//    {
//        printf("\nError in data bit 1");
//        printf("The correct code is");
//        r[1]=(r[1]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
//    if(sum==4)
//    {
//        printf("\n Error in chect bit 0");
//        printf("The correct code is");
//        r[4]=(r[4]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
//    if(sum==5)
//    {
//        printf("\n Error in data bits 3");
//        printf("The correct code is");
//        r[3]=(r[3]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
//    if(sum==6)
//    {
//        printf("Error in data bits 0");
//        printf("The correct code");
//        r[0]=(r[0]+1)%2;
//        for(i=0;i<7;i++);
//        printf("%d",r[i]);
//    }
//    if(sum==7)
//    {
//        printf("Error in data bits 2");
//        printf("The correct code is");
//        r[2]=(r[2]+1)%2;
//        for(i=0;i<7;i++)
//        printf("%d",r[i]);
//    }
}

