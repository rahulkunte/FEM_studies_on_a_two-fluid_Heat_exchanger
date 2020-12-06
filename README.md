# FEM-studies-on-a-Heat-exchanger
Conducted by : 
1) Bilal M.S. Siddiqui, 2) Rahul Sanjay Kunte, 3) Naimur Hussain, 4) Gourab Bal

Finite element approach to evaluating the performance of a heat exchanger with consideration of variation in thermophysical properties of carbon dioxide.

There are two sections that follow, the first explains the code employed using "Assembly method" and the next describes the details for the code for "Marching method".


Section 1: Assembly method
-
Variables used: 

 T1, T2 -> tables used for the imported data of water and carbon dioxide 

 NTU,R -> constants representing Number of transfer units and heat capacity ratio respectively. 

 n -> number of elements, input is taken from the user

 NTUe -> NTU per element 

 A -> stiffness matrix

 B -> matrix containing boundary conditions

 a,b,c,d -> members of the stiffness matrix relating the coefficients obtained by integrating the governing differential equation for hot fluid

 p,q,r,s -> members of the stiffness matrix obtained, similar to the previous coefficients, for cold fluid.

 x,y -> group of matrices of hot and cold fluid coefficients repectively 

 flag,var -> iteration parameters used to check conditions and updation in loops

 X -> Temperature vector, contains all the nodal non-dimensional temperatures.

 cph,cpc -> Cp values of water and carbon dioxide

 Y1,Y2 -> Vectors containing hot fluid and cold fluid nodal temperatures respectively

 CpHotFLuid -> cp of the hot fluid after the loop

 CpColdFluid -> cp of the cold fluid after the loop

 T3 -> table of the cp values after the loop
 
 
 Here, the stiffness matrix is assembled element by element as can be seen from the x and y matrices. 
 Once the stiffness matrix is assembled, the temperature vector is found by taking the inverse and premultiplying with the matrix containing boundary conditions.
 
 
 
 
 Section 2: Marching method
 -
 The method employed is known as marching method and as it is common to constant and variable cp, only the logic of constant cp will be explained here, it can be easily extrapolated to variable cp.
 
Variables used:

  mfrh, mfrc-> mass flow rates of hot and cold fluid
  
  T1,T2 -> tables containing imported data for hot and cold fluid respectively
  
  NTU, R, L -> NTU, R and length of the heat exchanger
  
  n -> number of elements, taken as input from the user
  
  Thi, Tci -> Inlet temperatures of the two fluids, taken as inputs from the user
  
  Le -> Length of each discretized element
  
  B, X, K -> The boundary conditions, Temperature and stiffness matrices respectively
  
  Temph,Tempc -> Hot and cold fluid temperature vectors
  
  a, b, c, d -> coefficients obtained after integrating the governing differential equation for hot fluid
  
  p, q, r, s -> coefficients obtained after integrating the governing differential equation for cold fluid

  i,j -> iterative variables 
  
  l -> iterative length
  
  
  
For the marching method, the stiffness [K] matrix is kept of a constant size, 4x4 throughout for n elements. Each iteration proceeds for a single element and nodal     temperatures are found by inverting the K matrix and the values are stored in the X matrix.
