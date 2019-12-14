
clc ; clear all; close all                                                  ;

%%%timer start
tic 

%%% read image

I1 = imread('okul.jpg')                                                    ; 
I1 = rgb2gray(I1)                                                           ;
 
%%% constant definion.
K = 0.04                                                                    ;     
Threshold = 0.029                                                           ;

%%% Image smoothing with gaussian filter.
filt= fspecial('gaussian',[5 5],1)                                          ;
I2 = filter2(filt,I1)                                                       ;

%%% dx and dy future detection filter.
%%% inputs Image and filter name.
%%% Filters 'Sobel', 'Prewitt', 'Roberts'.
%%% Default filter for empty filter input is 'Sobel'. 
[fx,fy] = my_filter(I2,'Sobel')                                             ;



Ix = fx.^2                                                                  ;
Iy = fy.^2                                                                  ;
Ixy = Ix.*Iy                                                                ;
gfilt= fspecial('gaussian',[7 7],2)                                         ; 
Ix = filter2(gfilt,Ix)                                                      ;
Iy = filter2(gfilt,Iy)                                                      ;
Ixy = filter2(gfilt,Ixy)                                                    ;
figure                                                                      ;
imshow(Ix)                                                                  ;
figure                                                                      ;
imshow(Iy)                                                                  ;
figure                                                                      ;
imshow(Ixy)                                                                 ;
Det_M= (Ix.*Iy )                                                            ;
Trace_M=Ix + Iy                                                             ;

R = Det_M - K*((Trace_M)).^2                                                ;

Rmax  = max(max(R))                                                         ;
[h , w] = size(R)                                                           ;

Result = zeros(h,w)                                                         ; 

%%% kernel size constant '5' mean is 5x5 kernel size.
fs = 5                                                                      ;
count = 0                                                                   ;

%%% There are two option for find corner points. 
%%%  These two option efficiencies are different.
%%% Different procesess time and different amount of corner points.
 


%%% Slow option begin.
%%% slow option. Finish time aproximetly 62 seconds.
%%% 386 corner points.
% for i = 2:h-1
%     
% for j = 2:w-1
% 
% 
% block = [R(i-1,j-1) R(i,j-1) R(i+1,j-1) ; R(i-1,j) R(i,j) R(i+1,j) ; R(i-1,j+1) R(i,j+1) R(i+1,j+1)]    ;
% maxi = max(max(block))                                                                                  ;
%   if R(i,j) > Threshold *Rmax && R(i,j) == maxi 
%                Result(i,j) = 1                                                                          ;
%     
%                count = count+1                                                                          ;
%   end                                                                                                   ;
% 
% end                                                                                                     ;
% end                                                                                                     ;

%%% Slow option end

%%% Fast option begin
%%% Fast option. Finish time aproximetly 3.5 second 
%%% 374 corner points
% 
%  for i = ceil(fs/2):1:h-floor(fs/2)
%     for j = ceil(fs/2):1:w-floor(fs/2)
% if R(i,j) > Threshold *Rmax 
%             
%             block = R(i-floor(fs/2):i+floor(fs/2),j-floor(fs/2):j+floor(fs/2))                        ;
%             if R(i,j) ==  max(max(block))
%             Result(i,j) = 1                                                                           ;
%             count = count+1                                                                           ;
%             end;
%   end                                                                                                 ;
% end                                                                                                   ;
%  end                                                                                                  ;

%%% Fast option end

%%% Show the corners on the orjinal image
[posc, posr] = find(Result == 1)                                                                        ;

figure                                                                                                  ;
imshow(I1)                                                                                              ;

hold on                                                                                                 ;

plot(posr,posc,'r*')                                                                                    ;

hold off                                                                                                ;

disp(count)                                                                                             ;
toc