clc ; clear all; close all                                                  ;
I1 = imread('okul2.jpg')                                                    ; 
I1 = rgb2gray(I1)                                                           ;
 
K = 0.04                                                                    ;     
Threshold = 0.0091                                                          ;

%%%%%% sobel filter  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dx = [-1 0 1;-2 0 2;-1 0 1]                                                 ;
Ix = conv2(dx,double(I1))                                                   ;

dy = [1 2 1;0 0 0;-1 -2 -1]                                                 ;
Iy = conv2(dy,double(I1))                                                   ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ix2 = Ix.^2                                                                 ;
Iy2 = Iy.^2                                                                 ;
Ixy = Ix.*Iy                                                                ;

Det_M= (Ix2.*Iy2 )                                                          ;
Trace_M=Ix2 + Iy2                                                           ;

R = Det_M - K*((Trace_M)).^2                                                ;
Rmax  = max(max(R)) 
[h , w] = size(R)                                                           ;
Result = zeros(h,w)                                                         ; 

count = 0                                                                   ;

for i = 2:h-1
    
for j = 2:w-1
    
if R(i,j) > Threshold *Rmax && R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)

    Result(i,j) = 1                                                         ;
    
    count = count+1                                                         ;
    
    end                                                                     ;
end                                                                         ;
end                                                                         ;

[posc, posr] = find(Result == 1)                                            ;


imshow(I1)                                                                  ;

hold on                                                                     ;

plot(posr,posc,'r.')                                                        ;
