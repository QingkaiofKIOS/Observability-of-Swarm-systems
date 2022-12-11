function flagOfObservability=th1solver(A,H,L,C,Delta)

sizeOfA=size(A);
rowSizeOfA=sizeOfA(1);

sizeOfL=size(L);
rowSizeOfL=sizeOfL(1);

sizeOfC=size(C);
rowSizeOfC=sizeOfC(1);

syms xi [rowSizeOfA rowSizeOfL]

syms s0

I=eye(rowSizeOfA);

eq1=(s0*I-A)*xi-H*xi*L;
eq2=C*xi*Delta;

tempa=0;
for i=1:1:rowSizeOfA
for j=1:1:rowSizeOfL
    eqa=zeros(1,1);
    eqa=cat(1,tempa,eq1(i,j));
    tempa=eqa;
end
end

tempb=0;
for i=1:1:rowSizeOfC
for j=1:1:rowSizeOfL
    eqb=zeros(1,1);
    eqb=cat(1,tempb,eq2(i,j));
    tempb=eqb;
end
end

eqs=[eqa;eqb];
S=solve(eqs);

sizeOfS=size(S.s0);

if sizeOfS==1
  flagOfObservability=1;
  fprintf('The swarm system is observable');
else
  flagOfObservability=0;
  fprintf('The swarm system is unobservable');
end
