function St=pfixo(c)
St=1; dS=1; lambda=0.1;
while dS>1e-7
    Sto=St;
    St=Sto-lambda*(Sto-1+exp(-c*Sto));
    dS=abs(St-Sto);
end
end