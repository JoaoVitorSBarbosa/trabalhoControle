%% Lipa Workspace
clc;
clear;

%% Main

s = tf('s');

R = 300;
Vin = 14.8;
D = 12/Vin;
c = 6.75*10^(-9);
L = 35.15*10^(-3);
K = 1.84;


G = K * ((Vin)/(L*c*s^2+(L/R)*s+1));
bode(G);
%T = feedback(G*K,1);
%nyquist(T);
%rlocus(G);


%step(T * 12);
%Gc = s + 122.96*10^(3);
%k = 0:.01:50;
%rlocus(G,k);
%title("Lugar geométrico das raízes");
%%
T = feedback(G*K,1);
%figure, step(T*D*14.8);
%stepinfo(T*D*14.8)
%title('Resposta ao degrau');


%% Resposta em frequência
Ts = 3.4673;
Tsd = Ts/3;
Up = 4/100;
zeta = -log(Up)/(sqrt(pi^2+log(Up)^2));
wn = 4/(Tsd*zeta);
tetam = 100 * zeta;

sd1 = -zeta*wn + wn * sqrt(-1*(1-zeta^2));
sd2 = -zeta*wn - wn * sqrt(-1*(1-zeta^2));

[Gm,Pm,Wcg,Wcp] = margin(G);
disp(Pm);

%% sintonia
s = tf('s');

R = 300;
Vin = 14.8;
D = 12/Vin;
c = 6.75*10^(-9);
L = 35.15*10^(-3);
K = 1.84;


G = K * ((Vin)/(L*c*s^2+(L/R)*s+1));

%bode(G);
Gf = feedback(G,1);
%step(G);

tau = 1.2 * (10^-4);
theta = 7.5 * (10 ^ -6);
k = 14.8;

Kc = (0.6*tau)/(theta*k);

Ti = tau;
Gc = Kc + 1/(Ti*s); %Funcao do compensador
K2 = 1.31; 

Tc = feedback(G*Gc*K2,1);
step(Gf, Tc);
stepinfo(Tc)
legend('T (Funcao sem compensacao)','Tc (Funcao com compensacao)');
title('Resposta ao degrau');
grid on;