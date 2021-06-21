import matplotlib.pyplot as plt
import numpy as np

# copiado da Carlota, adaptado e a dar bem

def fex31(N,T,Nestados):
    # Fluxo --> n� de particulas que saem por unidade de �rea e intervalo de tempo

    # dados da abertura
    dr=0.01       
    dA=np.pi*dr**2
    dt=0.01 # Intervalo de tempo 
    r=np.zeros((N,3)) # posicoes das particulas a 3D
    v=np.zeros((N,3)) # velocidades a 3D
    Fluxo=0
    erroF=0
    pressao=0
    erroP=0
    A=1
    # gerar Nestados
    for n in range(Nestados):
        # gerar posicoes
        # podemos fazer desta maneira porque é um gás ideal (as coordenadas tem distribuicao uniforme)
        r[:,0:2] = np.random.rand(N,2)-0.5   # coordenadas x e y [-1/2 1/2]
        r[:,2] = np.random.rand(N)-1         # coordenadas z [-1 0]
        # gerar velocidades
        # em qualquer gas as velocidades tem a distribui��o de velocidades de Maxwell --> ver express�o nos slides
        v=np.random.randn(N,3)*np.sqrt(T)   # geramos v com a distribui��o de velocidades de Maxwell com vari�ncia proporcional � temperatura
        
        # no intervalo de tempo dt as particulas movem-se
        rn=r+v*dt # as particulas moveram-se uniformemente

        # determinamos agora quais s�o as particulas que saem da caixa pela abertura
        condicao_saida1 = np.where(rn[:,2]>0)
        condicao_saida2 = np.where(np.sqrt(rn[:,0]**2+rn[:,1]**2)<dr)
        condicao_saida = np.intersect1d(condicao_saida1,condicao_saida2)
        numero = np.count_nonzero(condicao_saida) # n� de particulas que saem

        condicao = np.where(rn[:,2]>0) # aqui consideramos todas as particulas que batem na parede
        #a)
        Fluxo += numero / (dA * dt)
        erroF += (numero/ (dA * dt))**2
        #b)
        Forca = -np.sum(-2 * v[condicao,2] / dt)  # For�a exercida na parede
        pressao += Forca / A
        erroP += (Forca / A)**2

    Fluxo/=Nestados # media do Fluxo
    erroF/=Nestados # media do Fluxo ao quadrado
    erroF=np.sqrt((erroF-Fluxo**2)/Nestados)
    pressao/=Nestados
    erroP/=Nestados
    erroP=np.sqrt((erroP-pressao**2)/Nestados)

    return Fluxo,erroF,pressao,erroP


if __name__ == "__main__":

    N=1000         # n de particulas
    Nestados=int(1e4)   # n de estados

    Tv=np.linspace(0.1,10,10)
    Fluxo=np.zeros(len(Tv))
    erroF=np.zeros(len(Tv))
    pressao=np.zeros(len(Tv))
    erroP=np.zeros(len(Tv))

    i=0
    for T in Tv:
        Fluxo[i],erroF[i],pressao[i],erroP[i] = fex31(N,T,Nestados)
        i=i+1


    plt.figure(1)
    plt.errorbar(Tv,Fluxo,yerr=erroF,linestyle='',marker='x')
    # plt.plot(Tv,Fluxo,'x')
    T=np.arange(0,10,0.1)
    Fluxo_teorico=N*np.sqrt(T/(2*np.pi))
    plt.plot(T,Fluxo_teorico,'r-')
    plt.xlabel('T')
    plt.ylabel('Fluxo')
    plt.title('Fluxo em funcao da temperatura')

    plt.figure(2)
    plt.errorbar(Tv,pressao,yerr=erroP,linestyle='',marker='x')
    # plt.plot(Tv,pressao,'x')
    T=np.arange(0,10,0.1)
    pressao_teorico=N*T    # P=(N/V)KbT
    plt.plot(T,pressao_teorico,'r-')
    plt.xlabel('T')
    plt.ylabel('Pressao')
    plt.title('Pressao em funcao da temperatura')


    plt.show()