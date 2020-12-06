
clc
clear 
tic



%% Main code

%Importing data
T1 = readtable('co2datac','ReadVariableNames',false);
T2 = readtable('waterdatac','ReadVariableNames',false);

NTU = 1; % dependent on Cp, NTU = UA/Cmin, U depends on convective htc (h), thickness of wall, thermal conductivity(k) (inlet to outlet, 1deg C)
R = 0.5; % dependent on Cp, R = Ch/Cc -> table data  ( Ch- mdot Cph )
po = 1;

for n = 10
    NTUe = NTU/n;
    N = 2*n+2;
    A = zeros(N,N);    % Generates a null matrix 
    B = zeros(N,1);
    B(1) = input('Enter hot fluid inlet temp in C: ');
    B(2) = input('Enter cold fluid inlet temp in C: ');
    A(1,1) = 1;
    A(2,N) = 1;

    a = NTUe/2 - 1;   % Hot fluid
    b = -NTUe/2 ;     % Hot fluid            %Counter current flow
    c = NTUe/2 + 1;   % Hot fluid
    d = -NTUe/2;      % Hot fluid
    p = NTUe*R/2;     % Cold fluid
    q = -NTUe*R/2 -1; % Cold fluid
    r = NTUe*R/2;     % Cold fluid
    s = -NTUe*R/2 + 1;% Cold fluid

    x = [a,b,c,d];
    y = [p,q,r,s];

    flag = 1;
    for i = 3:N
        if mod(i,2) == 0    
            var = 1;
            for j = flag:flag+3
                A(i,j) = y(var);
                var = var + 1;
            end
            flag = flag + 2;
        else
            var = 1;
            for j = flag : flag+3
                A(i,j) = x(var);
                var = var+1;
            end
        end
    end

    
    X = A\B;
    E(po) = X(N-1);
    po = po +1;
end
X


for i = 1:101
 if (round(T2.Var1(i)) == round(X(n-1)))
 cph = T2.Var2(i);
 cph
 end
 
 if (T1.Var1(i) == round(X(2)))
 cpc = T1.Var2(i);
 cpc
     
 end
end

p = 1;
for u = 1:2:N
    Y1(p)=X(u);
    p = p + 1;
end


p = 1;
for u = N:-2:1
    Y2(p)=X(u);
    p = p + 1;
end


CpHotFluid = cph;
CpColdFluid = cpc;
T3 = table(CpHotFluid,CpColdFluid);


toc

for i = 1:n
    N1(i) = i;
end

plot(N1,1-E);
xlabel('Number of elements');
ylabel('Effectiveness');
 

        
        

     
