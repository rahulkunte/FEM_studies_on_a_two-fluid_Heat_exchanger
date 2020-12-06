
% Parallel flow


clc
clear 




%% Main code

tic
%Importing data
T1 = readtable('D:\Rahul\Final year project\co2datac','ReadVariableNames',false);
% T2 = readtable('D:\Rahul\Final year project\waterdatac','ReadVariableNames',false);


%% Function to approximate cp curve - Gaussian fit with 7 terms
       a1 =       27.29;
       b1 =       31.89;
       c1 =      0.6735;
       a2 =        6.99;
       b2 =       32.45;
       c2 =       2.849;
       a3 =           0;
       b3 =       34.85;
       c3 =     0.02354;
       a4 =       2.155; 
       b4 =       31.73;
       c4 =       8.782;
       a5 =      -2.058;
       b5 =       34.01;
       c5 =       1.906;
       a6 =      -1.576;
       b6 =       62.62;
       c6 =       35.06;
       a7 =       3.536;
       b7 =       44.38;
       c7 =       66.99;


      
%%
L = 1;
mh = 0.8837;
mc = 0.6;

n = input("Enter number of elements: ");
Thi = input("Enter hot fluid inlet temperature (C): ");
Tci = input("Enter cold fluid inlet temperature (C): ");

Le = L/n;
B = zeros(4,1);
X = zeros(4,1);
K = zeros(4,4);
Temph = zeros(n+1,1);
Tempc = zeros(n+1,1);
Temph(1) = Thi;
Tempc(1) = Tci;
j = 2;
Cpc = zeros(n+1,1);
U = 500;
A = pi;
% jk = 2;
% kj = 1;

% for v = 1:size(T1.Var1)
%  if round(Tci) == T1.Var1(v)
%     Cpc(1) = T1.Var2(v);
%     cpc = T1.Var2(v);
%  end
% end
Cpc(1) = a1*exp(-((Tci-b1)/c1)^2) + a2*exp(-((Tci-b2)/c2)^2) + a3*exp(-((Tci-b3)/c3)^2) + a4*exp(-((Tci-b4)/c4)^2) + a5*exp(-((Tci-b5)/c5)^2) + a6*exp(-((Tci-b6)/c6)^2) + a7*exp(-((Tci-b7)/c7)^2);

cpc = Cpc(1); 


% for o = 1:size(T2.Var1)
%  if round(Thi) == round(T2.Var1(o))
%     cph = T2.Var2(o);
%  end
% end

cph = 4.187;
Cc = mc*cpc;
Ch = mh*cph;


for i = 1:n
    
    B(1) = Thi;
    B(2) = Tci;
    X(1) = Thi;
    X(2) = Tci;
        
    NTU = U*A/(min(Cc,Ch)*1000); % dependent on Cp, NTU = UA/Cmin, U depends on convective htc (h), thickness of wall, thermal conductivity(k) (inlet to outlet, 1deg C)
    R = min(Cc,Ch)/max(Cc,Ch); % dependent on Cp, R = Ch/Cc -> table data  ( Ch- mdot Cph )
    
    a = NTU*Le/2 - 1;
    b = -NTU*Le/2;
    c = NTU*Le/2 + 1;
    d = -NTU*Le/2;

    p = -NTU*R*Le/2;
    q = NTU*R*Le/2 - 1; 
    r = -NTU*R*Le/2;
    s = NTU*R*Le/2 + 1;

    K(1,:) = [1,0,0,0];
    K(2,:) = [0,1,0,0];
    K(3,:) = [a,b,c,d];
    K(4,:) = [p,q,r,s];
    
    X = K\B;
    
    Thi = X(3);
    Tci = X(4);
    Temph(j) = X(3);
    Tempc(j) = X(4);
   
%   jk = jk + 2;
   
%     for v = 1:size(T1.Var1)
%      if round(Tempc(j)) == T1.Var1(v)
        
%      end
%     end
        
%     for o = 1:size(T2.Var1)
%      if round(Temph(j)) == round(T2.Var1(o))
%         cph = T2.Var2(o);
%      end
%     end   

    Cpc(j) = a1*exp(-((Tempc(j)-b1)/c1)^2) + a2*exp(-((Tempc(j)-b2)/c2)^2) + a3*exp(-((Tempc(j)-b3)/c3)^2) + a4*exp(-((Tempc(j)-b4)/c4)^2) + a5*exp(-((Tempc(j)-b5)/c5)^2) + a6*exp(-((Tempc(j)-b6)/c6)^2) + a7*exp(-((Tempc(j)-b7)/c7)^2);

     j = j+1;
end

l = 0:Le:L;
plot(l,Tempc);
hold on
plot(l,Temph);
% 
% 
grid on
% Tempc
% Temph
% Cpc

plot(l,Cpc);
xlabel('Length(m)');
ylabel('Temperature(C),Cp(J/g-K)');
legend('Cold Fluid','Hot Fluid','Cp');
toc


%
%           Thi   0     0   0
%           0     Tci   0   0
%           a     b     c   d
%           p     q     r   s
%         
%          
%         
         
        
        

     
