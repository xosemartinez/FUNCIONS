Cargar ficheiro de funcions


```r
source("taboas2023.r")
```

Colección de funcións para elaborar táboas e incluilas en ficheiros Rmd. 

Están feitas antes do último boom de paquetes para facer táboas, por que non me daba convencido ningún. Ao final traballei co paqiete `tables`, por que me permite tunear o resultado con facilidade.

### taboa(X,nome)

Fai unha táboa a partir dun vector numérico.

- X: vector numérico
- nome: nome para a columna de valores


```r
set.seed(123)
vector=rbinom(40,4,0.7)
texto="valores"
ola=taboa(vector,texto)
ola
```

```
## Error in if (result %in% c("html4", "html5")) result <- "html": argument is of length zero
```

```r
pander(ola)
```


-----------------
 valores   $n_i$ 
--------- -------
   *0*       1   

   *1*       4   

   *2*      13   

   *3*      15   

   *4*       7   

            40   
-----------------


### taboa.intervalos=function(X,B)

Fai unha táboa agrupada en intervalos a partir dun vector numérico dunha variable continua.

- X: vector numérico. Variable continua, ainda que non é obrigatorio
- B: vector cos extremos do intervalo.


```r
set.seed(123)
vector=rnorm(40,4,0.7)
texto="valores"
cortes=seq(25,55,5)/10
ola=taboa.intervalos(vector,cortes)
ola
```

```
## Error in if (result %in% c("html4", "html5")) result <- "html": argument is of length zero
```

```r
pander(ola)
```


-------------------------
 $L_{i-1} - L_i$   $n_i$ 
----------------- -------
    *2.5, 3*         2   

    *3, 3.5*         5   

    *3.5, 4*        12   

    *4, 4.5*        12   

    *4.5, 5*         6   

    *5, 5.5*         3   

                    40   
-------------------------

### taboa_frecuencias=function(X,nomes)

Fai unha táboa con diferentes columnas de frecuencias.

- X: táboa con formato de data.frame. Ou sexa, a 1ª columna valores e os demais frecuencias
- nomes: vector cos nomes de columnas, definitivos, preparados para latex

Un exemplo, coas catro frecuencias


```r
set.seed(321)
tba=as.data.frame(table(rbinom(60,4,0.4)))# creacion da taboa orixinal
tba$Freq2=tba$Freq/sum(tba$Freq)#engadir frecuencias relativas
tba$Freq3=cumsum(tba$Freq)#frecuencias acumuladas
tba$Freq4=cumsum(tba$Freq2)#frecuencias acumuladas relativas
pander(taboa_frecuencias(tba,c("Valores","$n_i$","$f_i$","$N_i$","$F_i$")))
```


---------------------------------------------
 Valores   $n_i$    $f_i$    $N_i$    $F_i$  
--------- ------- --------- ------- ---------
   *0*       5     0.08333     5     0.08333 

   *1*      24     0.40000    29     0.48333 

   *2*      22     0.36667    51     0.85000 

   *3*       6     0.10000    57     0.95000 

   *4*       3     0.05000    60     1.00000 

            60     1.00000                   
---------------------------------------------

Un exemplo con cualitativa nominal, e polo tanto dúas frecuencias


```r
set.seed(234)
sitios=round(runif(20,2,5))
casos=length(unique(sitios))
sitios=factor(sitios,labels = c("Noia","Muros","Cee","Boiro","Outes","Dumbría")[1:casos])
sitios=as.character(sitios)
tba=as.data.frame(table(sitios))
tba$Freq2=tba$Freq/sum(tba$Freq)
pander(taboa_frecuencias(tba,c("Valores","$n_i$","$f_i$")))
```


-------------------------
 Valores   $n_i$   $f_i$ 
--------- ------- -------
 *Boiro*     3     0.15  

  *Cee*     10     0.50  

 *Muros*     3     0.15  

 *Noia*      4     0.20  

            20     1.00  
-------------------------

Un exemplo creando directamente a taboa/data.frame, e metendo intervalos


```r
valores=c("0-20","20-40","40-60","60-80","80-100")
frecuencias=c(46,1,2,0,1)
tba=data.frame(valores,frecuencias)
pander(taboa_frecuencias(tba,c("$L_{i-1}-L_{i}$","$n_i$")))
```


-------------------------
 $L_{i-1}-L_{i}$   $n_i$ 
----------------- -------
     *0-20*         46   

     *20-40*         1   

     *40-60*         2   

     *60-80*         0   

    *80-100*         1   

                    50   
-------------------------
