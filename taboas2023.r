taboa.intervalos=function(X,B,nome){
  
  library(tables)
  library(pander)
  datos1=cut(X,breaks = B)
  datos=data.frame(datos1)
  ola= tabular( (datos1+1 ) ~1  , data=datos )
  x=rowLabels(ola)
  x=gsub("\\(","",x)
  x=gsub("\\]","",x)
  rowLabels(ola)=x
  
  colLabels(ola)[length(colLabels(ola))]="$n_i$"
  rowLabels(ola)[length(rowLabels(ola))]=" "
  dimnames(rowLabels(ola))[[2]]="$L_{i-1} - L_i$"
  # pander(ola)
  ola
}


taboa.intervalosvello=function(X,B,nome){
  
  library(knitr)
  library(kableExtra)
  
  auxi=table(cut(X,breaks = B))
  x=dimnames(auxi)[[1]]
  x[length(x)+1]=""
  n=as.vector(auxi)
  n[length(n)+1]=sum(n)
  
  # engadido cando fixen presentacions de EstI en quarto
  x=gsub("\\(","",x)
  x=gsub("\\]","",x)
  datos=data.frame(x,n)
  names(datos)=c("$L_{i-1} - L_i$","$n_i$")
  
  if (knitr::is_html_output()) {
    kable(datos,caption = nome, escape = FALSE) %>%
      kable_styling("striped", full_width = F) %>%
      column_spec(1, bold = T) %>%
      row_spec(length(x), bold = T, color = "black", background = "gray")
  }
  if (knitr::is_latex_output()) {
    kable(datos,caption = nome, escape = FALSE) %>%
      kable_styling("striped", full_width = F) %>%
      column_spec(1, bold = T) %>%
      row_spec(length(x), bold = T, color = "black", background = "gray")
  }
  if (knitr::pandoc_to("docx")) {print(nome);datos}
  if (knitr::pandoc_to("odt")) {print(nome);datos}
}

taboa=function(X,nome){

  library(tables)
  library(pander)
  datos1=factor(X)
  datos=data.frame(datos1)
  ola= tabular( (datos1+1 ) ~1  , data=datos )
   colLabels(ola)[length(colLabels(ola))]="$n_i$"
  rowLabels(ola)[length(rowLabels(ola))]=" "
  dimnames(rowLabels(ola))[[2]]=nome
  # pander(ola)
  ola
}

taboa_frecuencias=function(X,nomes){

  library(tables)
  library(pander)
  X[[1]]=factor(X[[1]])
  #crear a fórmula para a taboa
  fml=paste0("(X[[1]] + 1) ~ (X[[2]]")

  if (length(X)>2){
  for (i in 3:(length(X))){
    fml=paste0(fml,"+X[[",i,"]]")
  }
  }
  fml=paste0(fml,")")

  ola=tabular(as.formula(fml) )
  rowLabels(ola)[length(rowLabels(ola))]=" "
  colLabels(ola)[1,]=nomes[-1]#"$x_i$",
  dimnames(rowLabels(ola))[[2]]=nomes[1]

  for (i in 2:dim(X)[2]){
    if (nomes[i]=="$n_i$"){ ola[,i-1]=c(X[[i]],sum(X[[i]]))}
    if (nomes[i]=="$f_i$"){ ola[,i-1]=c(X[[i]],1)}
    if (nomes[i]=="$N_i$"|nomes[i]=="$F_i$"|nomes[i]=="$L_{i-1}-L_i$"){ ola[1:(dim(ola)[1]-1),i-1]=c(X[[i]]);ola[(dim(ola)[1]),i-1]=" "}
  }
ola
}


