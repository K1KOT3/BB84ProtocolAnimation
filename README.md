# Simulación del Protocolo BB84

Este proyecto es una animación interactiva del protocolo BB84, desarrollado en Processing. El BB84 es un método de establecimiento de claves basado en la física cuántica que permite garantizar la seguridad de las claves generadas y detectar posibles intentos de espionaje.

## Características

- Simulación paso a paso del protocolo BB84.
- Representación gráfica de los fotones, bases y bits de Alice y Bob.
- Animaciones dinámicas para ilustrar el flujo de información.
- Comparación de bits sacrificados para detectar espías.
- Interactividad para avanzar entre pasos y reiniciar el proceso.

## Requisitos

- [Processing](https://processing.org/) instalado en tu sistema.

## Cómo ejecutar

1. Clona este repositorio:
   ```bash
   git clone https://github.com/K1KOT3/BB84ProtocolAnimation.git
   ```
2. Abre el archivo .pde en Processing.
3. Ejecuta el programa para iniciar la simulación.

## Estructura del proyecto

- animacion-bb84.pde: Archivo principal del programa.
- README.md: Este archivo, con la descripción del proyecto.


La motivación principal para crear esta animación fue la necesidad de representar de forma visual y didáctica un concepto tan complejo como el BB84. Facilitar la comprensión mediante la simulación de los pasos y los conceptos del protocolo nos parecía algo fundamental si queríamos que se enterara bien toda la clase.  

El programa se ha hecho con Procesing, un entorno de programación especializado en la creación de gráficos y animaciones basado en java que aprendí a usar en la carrera y que me ha servido varias veces para explicar conceptos relacionados con ondas o fenómenos físicos, por lo que sabía que podía ser una muy buena solución para esta práctica. Además, hemos usado colores para distinguir bases, bits y estados de los fotones, junto con esferas y animaciones para representarlo de forma más intuitiva. 

El usuario puede interactuar con el programa haciendo clic para avanzar al siguiente paso, y, además, una tecla (R) permite reiniciar el programa y generar nuevos datos. 

## Estructura del programa 

El programa se ha estructurado en varios pasos para representar el flujo del protocolo: 

1. Generación de bases y bits por Alice: Alice elige al azar bases y bits y se representa de forma visual mediante texto y colores. 

2. Animación de los fotones: Los fotones viajan desde Alice hasta Bob y son representados como esferas que cambian de posición en pantalla. 

3. Medición de Bob: Bob mide los fotones usando sus propias bases y los resultados dependen de la coincidencia de bases entre Alice y Bob. 

4. Comparación pública de bases: Alice y Bob intercambian información sobre las bases utilizadas y solo los bits con bases coincidentes se usan para formar la clave final. 

5. Generación de la clave final: Se forma la clave utilizando los bits validados y se ve la clave en pantalla. 

6. Detección de espías: Alice y Bob sacrifican parte de la clave y comparan los bits. Cualquier discrepancia significativa sugiere la presencia de un espía y esto se representa con los bits sacrificados y su estado de coincidencia.

## Explicación del protocolo (por Alberto R.)

Si quisiéremos explicar el protocolo como es de verdad, esta memoria ocuparía mucho más de lo previsto para un divulga ya que habría que explicar cómo funcionan realmente los qubits, propiedades de estos como la no clonación, el estado de superposición y el estado de entanglement, como se generan realmente las bases (por lo que habría que explicar matrices de rotación) y qué son los estado + y -  en los que se convierten los qubits 0 y 1 al pasar por una base diagonal (que no es más que girar la base que conocemos de toda la vida 45 grados haciendo uso de una matriz llamada Haddamard que es la fuente principal de entanglement en la computación cuántica). 

De todas maneras, si se está interesado en entrar más en profundidad en todos estos temas, se van a adjuntar las notas de Aaronson y de igual manera se va a adjuntar una explicación un poco más completa que se hizo para la asignatura de Criptografía Aplicada, que es más extensa que la que se va a hacer aquí, pero menos densa y teórica que la que aparece en las notas de Aaronson. 

Para empezar, decir que este protocolo (el protocolo de intercambio de claves BB84) no funciona y está demostrado que es vulnerable a ataques MITM, se han hecho cambios en protocolos posteriores para solventarlo, pero hoy en día todavía no existe un protocolo de intercambio de claves cuántico que funcione correctamente o en su defecto, que sea suficientemente eficaz, por lo tanto, todo lo que se diga aquí y todos los apuntes de las notas de Aaronson, son teorías matemáticas y físicas que todavía no se han podido demostrar con certeza, una vez aclarado todo esto, vamos con el protocolo. 

Este protocolo nace en 1984 y es desarrollado por Charles Bennett y Gilles Brassard (por eso el BB en el nombre, de los apellidos de ambos), el protocolo nace para intentar demostrar lo que podría llegar a ser la criptografía cuántica en una época en la que todavía la cuántica está en pañales (a día de hoy sigue en pañales, pero al menos parece que está empezando a gatear, que ya es un paso). 

Como en todos los protocolos, tenemos a Alice (Alicia en el país de las maravillas a partir de ahora) y a Bob (Bob Esponja a partir de ahora) que quieren compartir una clave para comunicarse entre ellos sin que ninguna persona externa pueda saber de qué están hablando (El espía a partir de ahora).

Lo que hace Alice es generar una serie de qubits aleatorios al igual que genera una serie de bases también de forma aleatoria, por otra parte, Bob sólo genera las bases de manera aleatoria (las bases elegidas por ambos son secretas, ninguno de los dos sabe de las bases del otro), una vez Alice haya terminado, codifica sus qubits con las bases elegidas y eso es lo que le envía a Bob (no hay que preocuparse en lo que significan los + y los -, simplemente con saber que si un “1” lo codificas con una base “x” sale “–“ y si codificas un “0” con una base “x” sale “+”). 

Una vez le llega esa información a Bob, lo que hace este es descodificar la cadena codificada que le llega con sus bases elegidas de manera aleatoria y obtiene una serie de qubits, de los cuales, los que hayan sido codificados y descodificados con bases distintas darán un resultado aleatorio, los primeros dos qubits están codificados y descodificados con bases distintas y dan un resultado distinto, pero en cambio el quinto qubit está codificado y descodificado con bases distintas pero da el mismo resultado. 

Una vez que Alice comparte su cadena codificada y Bob la descodifica, ambos comparten de manera pública las bases que han elegido y únicamente mantienen los qubits donde las bases coinciden, los otros los eliminan, pero todavía no hemos terminado, los qubits que le quedan (que aproximadamente serán ½ de la cadena original) todavía van a servir para una cosa que se explicará ahora. 

Ahora, estaréis pensado, ¿Y qué tiene que ver todo esto con el espía?, pues muy sencillo, de la cadena que nos ha quedado, cogeremos la mitad de los qubits y los usaremos para detectar si hay intrusos en nuestra comunicación de compartir clave, pero ¿Cómo se supone que haremos esto?, como hemos dicho antes, el espía lee la cadena de Alice con las bases que él haya elegido y esto, aunque piense que no le va a traer ningún problema, va a hacer que se delate sin que llegue siquiera a saberlo. 

El espía tiene 4 opciones: 

1. Alice elige la base + (O base Z, cada quien la llama de una forma) y un qubit Q, el espía elige la base X y al mirar el qubit lo altera (Por el principio de observación) haciendo que sea un qubit Q’, Bob elige también la base + y al usar la segunda parte de la cadena la detectan. 
2. Alice elige la base + y un qubit Q, el espía elige la base + y por lo tanto no altera el contenido del qubit Q, Bob elige la base + también y el espía pasa inadvertido. 
3. Alice elige la base + y un qubit Q, el espía elige la base X y altera el contenido haciendo que sea un qubit Q’, Bob elige la base X también y por lo tanto Alice y Bob descartan ese Qubit, vuelve a pasar inadvertida. 
4. Alice elige la base + y un qubit Q, el espía elige la base X, pero tiene la suerte de no alterar el estado y mantenerlo como un qubit Q, por lo tanto, si Bob elige la misma base que Alice, el espía vuelve a pasar inadvertido.

Ahora todos estaréis pensando, “Pues vaya pedazo de mierda de protocolo, sólo se pilla a un espía el 25% de las veces”, pero tiene que pasar inadvertida por CADA UNO de los qubits que se transmitan y solo hacen falta unos pocos errores para que se pare el protocolo y se vuelva a empezar, pero a partir de los 50 qubits revisados, Alice tiene una probabilidad del 99,9999% de pillar al espía, vamos que ahora ya tiene mejor pinta. 

Una vez se haya revisado y se haya visto que no hay errores ni intrusos, el protocolo se da por finalizado y se obtiene la clave de la mitad de la cadena que no se ha utilizado para revisar si había intrusos, por lo tanto, de la cadena inicial de N qubits, tras hacer el protocolo entero, nos quedaría una clave de N/4 qubits. 

Pero no todo es tan bueno como os lo pintan y yo no estoy aquí para especular con vuestras expectativas sobre un mundo que todavía está en pañales, voy a seros francos, el protocolo no funciona, es vulnerable a MITM, en el caso de que el espía sea un poco inteligente, lo único que tiene que hacer es llevar a cabo el protocolo con ambas partes involucradas y no tienen manera de detectar que han sido víctimas de un MITM. 

## Contribuciones
Las contribuciones son bienvenidas. Si tienes sugerencias o mejoras, crea un issue o un pull request :)
