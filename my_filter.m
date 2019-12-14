
function [outx,outy] = my_filter(I,filter)


switch filter
    case 'Sobel'
        dx = [-1 0 1 ; -2 0 2 ; -1 0 1];
        dy = [1 2 1 ; 0 0 0 ; -1 -2 -1];
    
        outx = conv2(dx,double(I));
        outy = conv2(dy,double(I));
    case 'Prewitt'
        dx = [-1 0 1 ; -1 0 1 ; -1 0 1];
        dy = [1 1 1 ; 0 0 0 ; -1 -1 -1];
    
        outx = conv2(dx,double(I));
        outy = conv2(dy,double(I));
    case 'Roberts'
         dx = [0 1 ; -1 0];
         dy = [1 0 ; 0 -1];
    
         outx = conv2(dx,double(I));
         outy = conv2(dy,double(I));
    otherwise
         dx = [-1 0 1;-2 0 2;-1 0 1] ;
         dy = [1 2 1;0 0 0;-1 -2 -1]  ;
         outx = conv2(dx,double(I));
         outy = conv2(dy,double(I));
end


end






