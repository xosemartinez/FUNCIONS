taboa.intervalos=function(X,B){
  
  library(tables)
  library(pander)
  # preparar os intervalos
  datos1=cut(X,breaks = B)
  datos=data.frame(datos1)# con formato data.frame
  ola= tabular( (datos1+1 ) ~1  , data=datos )# facer a taboa
  # quitarlle os '(' e ']' dos nomes de intervalos
  x=rowLabels(ola)# comando de tables
  x=gsub("\\(","",x)
  x=gsub("\\]","",x)
  x=gsub(",",", ",x)
  rowLabels(ola)=x# cambiar os nomes de intervalos
  
  colLabels(ola)[length(colLabels(ola))]="$n_i$"# nome de columna derradeira
  rowLabels(ola)[length(rowLabels(ola))]=" "# a derradeira fila sen nome
  dimnames(rowLabels(ola))[[2]]="$L_{i-1} - L_i$"# nome de columna primeira
  # pander(ola)
  ola # sacar o resultado
}

# a táboa.intervalos vella funcionaba con kableExtra, e
#facia depender o resultado do formato de texto que sacaba
# pero non me fiaba da súa funcionalidade
# sigue por aí, en diferentes documentos antigos de clase

##########################################
taboa=function(X,nome){
  
  library(tables)
  library(pander)
  
  # non recordo se para `tabular` a fila de datos debe ser factor
  datos1=factor(X)
  datos=data.frame(datos1)
  # `table` ten unha notación propia
  ola= tabular( (datos1+1 ) ~1  , data=datos )
  # modifica as etiquetas de 1ª columna ou 1ª fila
  colLabels(ola)[length(colLabels(ola))]="$n_i$"
  rowLabels(ola)[length(rowLabels(ola))]=" "
  dimnames(rowLabels(ola))[[2]]=nome
  # saca un resultado en formato de `table` que podo tratar con pander
  ola
}
################################################3
taboa_frecuencias=function(X,nomes){

  library(tables)
  library(pander)
  # valores taboa como factor
  # creo que se necesita para `tables`
  X[[1]]=factor(X[[1]],levels = X[[1]])

  #crear a fórmula para a taboa. `formule` é un tipo obxecto de R
  fml=paste0("(X[[1]] + 1) ~ (X[[2]]")#valores e frecuencias absolutas
#se hai máis entón engado o resto das frecuencias
  if (length(X)>2){
  for (i in 3:(length(X))){
    fml=paste0(fml,"+X[[",i,"]]")
  }
  }
  fml=paste0(fml,")")# formula final grande

  # as.formula() da a un texto formato de fórmula, 
  # para usar directamente noutros comandos
  ola=tabular(as.formula(fml) )
  
  # tunear a saida, con comandos de `tables`
  rowLabels(ola)[length(rowLabels(ola))]=" "
  colLabels(ola)[1,]=nomes[-1]#"$x_i$",
  
  dimnames(rowLabels(ola))[[2]]=nomes[1]

  # mirar se hai outras columnas
  # e actuar segundo o nome que lles puxen
  for (i in 2:dim(X)[2]){
    if (nomes[i]=="$n_i$"){ ola[,i-1]=c(X[[i]],sum(X[[i]]))}
    if (nomes[i]=="$f_i$"){ ola[,i-1]=c(X[[i]],1)}
    if (nomes[i]=="$N_i$"|nomes[i]=="$F_i$"|nomes[i]=="$L_{i-1}-L_i$"){ ola[1:(dim(ola)[1]-1),i-1]=c(X[[i]]);ola[(dim(ola)[1]),i-1]=" "}
  }
  
# sacar resultados  
ola
}


