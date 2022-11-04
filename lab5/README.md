# lab 5 robotica. 

### Sergio Andres Gerena Gomez


## Metodologia
### Analisis
El primer paso es desarrollar el analicis de la sinematica inversa del brazo, partiendo de la siguiente geometria, podemos realizar el siguiente analisis matematico
![image](https://user-images.githubusercontent.com/38962033/199860851-7d300dd7-0d80-43bc-bd3f-8224737be053.png)
De aqui podemos inferir las siguientes ecuaciones para cada uno de los q que nos intereza

$$
\\begin{split}
q_1&=atan2(x,y)\\\\
q_2&=atan2\\left(\\sqrt{1-\\left(\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)^2},\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)+atan\\left(\\frac{(z-L_1)}{\\sqrt{x^2+y^2}}\\right)\\\\
q_3&=-atan2\\left(\\sqrt{1-\\left(\\left(\\frac{(\\sqrt{x^2+y^2-z^2}-L_4)^2}{(2*L_2)^2}\\right)^2-1\\right)^2},\\left(\\frac{(\\sqrt{x^2+y^2-z^2}-L_4)^2}{(2*L_2)^2}\\right)^2-1\\right)\\\\
q_4&=atan2\\left(\\sqrt{1-\\left(\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)^2},\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)
\\end{split}
$$

### Comprobacion usando el toolbox


### Toolbox







    
  ## Resultados
  



  ## Conclusiones

