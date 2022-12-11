function ranko=testrankobsrvability(A,C)

sizeOfA=size(A);
temp=C;
 
for i=1:1:sizeOfA(1)-1
    
    Q=zeros(i+1,sizeOfA(1));   
    
    Q=cat(1,temp,C*A^i);
    temp=Q;
    
end
 
fprintf('Matrix Qc is');
Q
ranko=rank(Q)
fprintf('The rank of Matrix Qc is%d,',rank(Q))
fprintf('n is%d\n',sizeOfA(1))
 
if(rank(Q)==sizeOfA(1))
    fprintf('So it is observable\n');
else
    fprintf('So it is unobservable\n');
end
