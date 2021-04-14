import matplotlib.pyplot as plt
import numpy as np
from scipy.special import  factorial 

N=np.array([6,5,4,3,2,1])
P=N/np.sum(N)

Alfa={"A","B","C","D","E","F"}

## ver feito a mao 
####################################

def huffman(p):
    nc=len(p)-1
    label=np.arange(0,len(p))
    filhos = np.zeros((2*nc,2))
    filhos= filhos-1
    codigo= ["" for i in range(2*nc)]



    p_trab=p
    nc_trab=nc
    ncf=nc
    while (nc_trab>1):
        ### 1o carater
        i1 = np.where(p_trab == np.min(p_trab[:nc_trab]))[0][0]
        p1 = np.min(p_trab[:nc_trab])
        p_trab[i1] = p_trab[nc_trab]
        lab1=label[i1]
        # print(label[i1])
        label[i1]=label[nc_trab]
        nc_trab-=1
        ### 2o carater
        i2 = np.where(p_trab == np.min(p_trab[:nc_trab]))[0][0]
        p2 = np.min(p_trab[:nc_trab])
        p_trab[i2] = p_trab[nc_trab] 
        lab2=label[i2]
        # print(label[i2])
        label[i2]=label[nc_trab]
        nc_trab-=1
        ### acrescentar novo caracter composto
        nc_trab +=1
        p_trab[nc_trab]=p1+p2
        ncf+=1
        filhos[ncf]=[lab1,lab2]
        label[nc_trab]=ncf
        # print(p_trab)
        # print(filhos)

    codigo[nc-1]="0"
    codigo[nc-2]="1"
    for i in reversed(range(2*nc)):
        if (filhos[i][0]>-1):
            codigo[int(filhos[i][0])]= codigo[i] +"0"
            codigo[int(filhos[i][1])]= codigo[i] +"1"
    
    return codigo[:nc]

####################################

print("codigo final:\n", huffman(P))
####################################
import codecs
fic= codecs.open("Python\Aula04\MobyDickChapter1.txt", mode="r",encoding="utf-8", errors='ignore')
all_chars=[ord(x) for x in fic.read()]
char_ascii=list(set(all_chars))
vmin=min(char_ascii)
vmax=max(char_ascii)
n_bins=20
values, bins = np.histogram(char_ascii, bins=np.linspace(vmin, vmax, vmax-vmin))
p2=values/np.sum(values)
plt.plot(p2,'kx')

print("codigo final:\n", huffman(p2))


####################################

plt.show()