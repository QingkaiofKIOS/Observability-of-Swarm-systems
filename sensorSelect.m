function [f_a,Delta,DeltaIndexSet]=sensorSelect(A,C,H,L)

f_a=0;
f_s=1;

ColumnT=[];
if ~isempty(L)

  for i=1:size(L,2)

      sumColumn=0;

      for j=1:size(L,1)
      
           sumColumn=sumColumn+L(j,i);

      end

      ColumnT(end+1)=sumColumn;

  end

end


if ismember(0,ColumnT)%if there exists some columns of L with all zero
         if testrankobsrvability(A,C)
             f_s=1;
         else
             Delta_t=eyes(size(L,1),size(L,2));
            if th1solver(A,H,L,C,Delta_t)
                f_s=1;
            else
                f_s=0;%sensor unselectable
            end
         end
end

DeltaIndexSet=[];
Delta=zeros(size(L,1),size(L,2));
if f_s==1%if sensor selectable
 [DeltaIndexSet,Delta]=NetSelect(L);
else
 fprintf('It is not sensor selectable!');
end

G=digraph(L');
plot(G);
