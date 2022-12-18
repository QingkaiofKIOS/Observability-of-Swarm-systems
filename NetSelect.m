function [DelatM,Delta]=NetSelect(L)


C=findContraction(L);
G=digraph(L');
S=conncomp(G,'OutputForm','cell');
plot(G);

LSCC={};%the leaf SCCs
if size(S,2)~=0
for i=1:size(S,2)%the number of SCCs
     tempSm=cell2mat(S(i));
    for j=1:size(cell2mat(S(i)),2)%the number of nodes in each SCC
        for p=1:size(L,1)%the number of all nodes
            if ~isempty(tempSm) && L(p,tempSm(j))~=0 && ~ismember(p,tempSm)
               tempSm=[];
               break;
            else
                if ~isempty(tempSm) && p==size(L,1) && j==size(cell2mat(S(i)),2)                    
                 LSCC(end+1)={tempSm};
                end
            end
        end
    end
end
end

CommanSCCoDil={};%record comman nodes between SCC and dilation
CommanMatirx=zeros(size(LSCC,2),size(C,2));
CommanTemp=[];
if size(C,2)~=0
for i=1:size(C,2)
     tempCm=cell2mat(C(i));
     CommanTemp=[];
    for j=1:size(LSCC,2)
        tempSCCm=cell2mat(LSCC(j));       
        for p=1:size(tempSCCm,2)
            if ismember(tempSCCm(p),tempCm)&&~ismember(tempSCCm(p),CommanTemp)
               CommanTemp(end+1)=tempSCCm(p);
               CommanMatirx(i,j)=1;
            end
        end
    end
    if ~isempty(CommanTemp)
              CommanSCCoDil(end+1)={CommanTemp};
              CommanTemp=[];
     end
end
end

C
S
LSCC
CommanSCCoDil

for i=1:size(CommanSCCoDil,2)%the size of conmman set
    TempCAm=cell2mat(CommanSCCoDil(i));


end

Sel=zeros(size(L,1),size(L,2));%control matrix Delta;

%select a different node in every intersect set
DelatM=[];%pri input matrix
tempCS=[];
if size(CommanSCCoDil,2)~=0
 for i=1:size(CommanSCCoDil,2)%the ith element in CommanSCCoDil
    for j=1:size(cell2mat(CommanSCCoDil(i)),2)
        tempCS=cell2mat(CommanSCCoDil(i));
        if ~ismember(tempCS(j),DelatM) 
            DelatM(end+1)=tempCS(j);
            tempCS=[];
            break;
        end
    end
 end
end

for i=1:size(C,2)
    if sum(CommanMatirx(:,i))==0
        for j=1:size(cell2mat(C(i)),2)
          tempCS=cell2mat(C(i));
        if ~ismember(tempCS(j),DelatM)
            DelatM(end+1)=tempCS(j);
            tempCS=[];
            break;
        end
       end  
    end
end


for i=1:size(LSCC,2)
calue=0;
    for j=1:size(cell2mat(LSCC(i)),2)
        tempLSCC=cell2mat(LSCC(i));
        if ~ismember(tempLSCC(j),DelatM)
            calue=calue+1;          
        end
    end
    if calue==size(cell2mat(LSCC(i)),2)
        DelatM(end+1)=tempLSCC(j);
    end
end

DelatM;
Delta=zeros(size(L,1),size(L,2));
for i=1:size(L,1)
    if ismember(i,DelatM)
      Delta(i,i)=1;
    end
end
