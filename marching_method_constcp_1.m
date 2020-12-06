
% Parallel flow


clc
clear 




%% Main code

mfrh = 0.8837;    
mfrc = 0.6;
tic
%Importing data
T1 = readtable('co2datac','ReadVariableNames',false);
T2 = readtable('waterdatac','ReadVariableNames',false);

NTU = 0.376/mfrc; % dependent on Cp, NTU = UA/Cmin, U depends on convective htc (h), thickness of wall, thermal conductivity(k) (inlet to outlet, 1deg C)
R = 0.9378*(mfrc/mfrh); % dependent on Cp, R = Ch/Cc -> table data  ( Ch- mdot Cph )
L = 1;

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

for i = 1:n
    
    B(1) = Thi;
    B(2) = Tci;
    X(1) = Thi;
    X(2) = Tci;
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
    j = j+1;
    
end

l = 0:Le:L;
plot(l,Tempc);
hold on
plot(l,Temph);
xlabel('Length(m)');
ylabel('Temperature(C)');
grid on
legend("Cold Fluid", "Hot Fluid");
% Tempc
% Temph

toc


        
        

     
