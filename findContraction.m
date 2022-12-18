function D=findContraction(L)


%find the maximum matching M

%the numbers of row X and column Y of L 
m=size(L,1);
n=size(L,2);

M=zeros(m,n);%M denotes matching
%find the initial matching M
for i=1:m
    for j=1:n
        if L(i,j)==1
            M(i,j)=1;
            break;
        end;
    end
    if M(i,j)==1
        break;
    end
end %get a matching with only an edge

while 1
    
    for i=1:m
        x(i)=0;
    end %The label and mark * for the midpoint of X will be recorded
    for i=1:n
        y(i)=0;
    end %The label and mark * for the midpoint of Y will be recorded
    
    %All unmatched points of M in X are given the label 0 and the label *. The program uses n+1 to represent the label 0 and a negative number to represent the label *
    for i=1:m
        pd=1; %Find all the unsaturated points of M in X
        for j=1:n
            if M(i,j)==1
                pd=0;
            end;
        end
        if pd==1
            x(i)=-n-1;
        end
    end
    pd=0;
    
    while 1
        xi=0;
        %If there is a point in X that has both labels and marks *, then take any point xi in X that has both labels and marks *
        for i=1:m
            if x(i)<0
                xi=i;
                break;
            end;
        end
        
        if xi==0
            pd=1;
            break;
        end %If all the labeled points in X have the mark * removed, the algorithm terminates
        
        x(xi)=x(xi)*(-1);%Remove the xi marker *
        k=1;
        %Any yj adjacent to xi that is not yet labeled is assigned the label i
        for j=1:n
            if L(xi,j)&&y(j)==0
                y(j)=xi;
                yy(k)=j;
                k=k+1;
            end;
        end
        
        if k>1
            k=k-1;
            
            for j=1:k
                pdd=1;
                for i=1:m
                    if M(i,yy(j))==1
                        x(i)=-yy(j);
                        pdd=0;
                        break;
                    end
                end %gives the label j and the mark * to the point xk(that is, xkyj∈M) adjacent to yj in M
                if pdd==1%If yjM- unsaturated direct reverse return
                    break;
                end
            end
            
            if pdd==1
                k=1;
                j=yy(j);%yj is not the saturation point of M
                while 1
                    P(k,2)=j;
                    P(k,1)=y(j);
                    j=abs(x(y(j)));%Take any unsaturated point of M, yj, and go backwards
                    if j==n+1
                        break;
                    end %When the point labeled 0 in X is found, it ends, and m-augmented path P is obtained
                    k=k+1;
                end
                
                for i=1:k
                    if M(P(i,1),P(i,2))==1
                        M(P(i,1),P(i,2))=0;%Remove the edge that matches M in the augmented path P
                    else
                        M(P(i,1),P(i,2))=1;
                    end
                end %Add edges in the augmented path P that do not appear in the match M to the match M
                break;
            end
        end
    end
    
    if pd==1
        break;
    end;
end %If all the labeled points in X have the mark * removed, the algorithm terminates
M; %The maximum match M


Aa=zeros(m,n);%auxiliary graph
for i=1:m
    for j=1:n
        if M(i,j)~=0
            Aa(j,i)=1;
        end
    end
end 


Nm=[];%matched nodes under M
Nodesall=[];%all nodes
for i=1:m
    Nodesall(end+1)=i;
    for j=1:n
        if M(i,j)~=0&& ~ismember(j,Nm)
            Nm(end+1)=j;
        end
    end
end 

Num=setdiff(Nodesall,Nm); %unmatched nodes under M 

Cons={};%storage of dilations
Contemp=[]; %temporary storage of dilation

for i=1:size(Num,2)
    Contemp=[];  
    Contemp(end+1)=Num(i);
    for j=1:size(Nm,2)
       if L(Nm(j),Num(i))~=0
           Contemp(end+1)=Nm(j);
           oddflag=1;%odd and even flag
           endflag=1;%end flag
           StartPointemp=Nm(j);
            
           Nmtemp=setdiff(Nm,Nm(j));
           while endflag
               [Contemp,Nmtemp,endflag,StartPointemp]=conTest(Nmtemp,StartPointemp,Aa,L,oddflag,Contemp,endflag);
           end
         
           if size(Contemp,2)>2
                Cons(end+1)={Contemp(1:2:end)};
           end
       end
        Contemp=[];
        Contemp(end+1)=Num(i);
    end
end


D=Cons;
