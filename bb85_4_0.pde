int paso = 0;
String[] basesAlice = new String[8];
String[] bitsAlice = new String[8];
String[] basesBob = new String[8];
String[] resultadosBob = new String[8];
boolean[] acuerdoClave = new boolean[8];
String claveFinal = "";
float[] posicionesFotones = new float[8];
boolean animacionCompletada = false;
boolean resultadosCalculados = false;

void setup() {
  size(1200, 800); // Dimensiones más grandes para mayor espacio
  textAlign(CENTER, CENTER);
  textSize(18);
  frameRate(30); // Aumento la tasa de fotogramas para animaciones suaves
  reiniciarProceso();
}

void draw() {
  background(30);
  fill(255);

  // Barra de progreso
  fill(100);
  rect(50, 750, 1100, 20);
  fill(0, 255, 0);
  rect(50, 750, map(paso, 0, 7, 0, 1100), 20);
  fill(255);
  text("Paso " + paso + " de 7", width / 2, 730);

  switch (paso) {
    case 0:
      fill(255);
      text("Protocolo BB84: Establecimiento de clave", width / 2, height / 2 - 20);
      text("Este protocolo utiliza propiedades de la física cuántica para establecer una clave segura.", width / 2, height / 2 + 20);
      text("(Haz clic en cualquier parte de la pantalla para avanzar al siguiente paso)", width / 2, height / 2 + 280);
      break;

    case 1:
      dibujarBasesYBits();
      fill(255);
      text("Alice genera bases (\"+\" o \"x\") y bits (0 o 1).", width / 2, height - 140);
      text("Estos datos serán utilizados para codificar los fotones que enviará a Bob.", width / 2, height - 110);
      break;

    case 2:
      animarFotones();
      if (animacionCompletada) {
        dibujarFotonesFinales();
        fill(255);
        text("Alice envía los fotones a Bob codificados según sus bases y bits.", width / 2, height - 140);
        text("Cada fotón está polarizado según la base y el bit correspondiente.", width / 2, height - 110);
      }
      break;

    case 3:
      calcularResultados();
      dibujarRecepcion();
      fill(255);
      text("Bob mide los fotones utilizando sus propias bases aleatorias.", width / 2, height - 140);
      text("Si su base coincide con la de Alice, obtendrá el mismo bit, sino será aleatorio.", width / 2, height - 110);
      break;

    case 4:
      compararBases();
      fill(255);
      text("Alice y Bob comparan públicamente sus bases (pero no los bits).", width / 2, height - 140);
      text("Solo los bits donde las bases coinciden serán utilizados para formar la clave.", width / 2, height - 110);
      break;

    case 5:
      extraerClave();
      fill(255);
      text("Alice y Bob generan una clave común a partir de los bits coincidentes.", width / 2, height - 140);
      text("Este proceso asegura que la clave sea secreta y segura.", width / 2, height - 110);
      break;

    case 6:
      fill(255);
      text("Clave final: " + claveFinal, width / 2, height - 400);
      text("Si las bases coinciden en pocos casos (debido a la aleatoriedad), la clave final será más corta.", width / 2, height - 350);
      text("Esta clave puede ser utilizada para cifrar mensajes entre Alice y Bob.", width / 2, height - 300);
      break;

    case 7:
      fill(255);
      text("Detección de un espía utilizando la clave:", width / 2, height / 2 - 150);
      text("Para detectar a un espía, Alice y Bob sacrifican la mitad de la clave y la comparan públicamente.", width / 2, height / 2 - 100);
      text("Si una fracción significativa de los bits no coincide, significa que un espía pudo haber interceptado los fotones.", width / 2, height / 2 - 50);
      text("Si los bits coinciden, la otra mitad de la clave se usa para la comunicación segura.", width / 2, height / 2);
      text("Esto garantiza la seguridad contra interceptores en el canal cuántico.", width / 2, height / 2 + 50);
      text("Presiona 'R' para reiniciar el proceso y generar una nueva clave.", width / 2, height - 110);

      // Dibujar ejemplo visual de bits sacrificados y comparados
      for (int i = 0; i < 4; i++) {
        fill(255);
        
        text("Alice: " + bitsAlice[i], width / 5 * (i + 1), height / 2 + 100);
        text("Bob: " + resultadosBob[i], width / 5 * (i + 1), height / 2 + 130);

        if (bitsAlice[i].equals(resultadosBob[i])) {
          fill(0, 255, 0); // Verde si coinciden
          text("Coincide", width / 5 * (i + 1), height / 2 + 160);
        } else {
        fill(255, 0, 0); // Rojo si no coinciden
        text("No coincide", width / 5 * (i + 1), height / 2 + 160);
}  
      }
      break;
  }
}

void dibujarBasesYBits() {
  for (int i = 0; i < 8; i++) {
    fill(basesAlice[i].equals("+") ? color(0, 255, 255) : color(255, 0, 0)); // Cian para +, rojo para x
    text("Base: " + basesAlice[i], width / 9 * (i + 1), height / 5);
    fill(bitsAlice[i].equals("0") ? color(0, 255, 0) : color(255, 255, 0)); // Verde para 0, amarillo para 1
    text("Bit: " + bitsAlice[i], width / 9 * (i + 1), height / 5 + 30);
  }
}

void inicializarPosicionesFotones() {
  for (int i = 0; i < 8; i++) {
    posicionesFotones[i] = height / 5 + 40; // Comienzan cerca de Alice
  }
  animacionCompletada = false;
  resultadosCalculados = false;
}

void animarFotones() {
  boolean todosEnDestino = true;
  for (int i = 0; i < 8; i++) {
    if (posicionesFotones[i] < height / 2) {
      posicionesFotones[i] += 5; // Incrementar posición para animación
      todosEnDestino = false;
    }
    fill(bitsAlice[i].equals("0") ? color(0, 255, 0) : color(255, 255, 0)); // Colores según el bit
    ellipse(width / 9 * (i + 1), posicionesFotones[i], 20, 20);

    // Dibujar flechas entre Alice y los fotones
    stroke(255);
    line(width / 9 * (i + 1), height / 5 + 40, width / 9 * (i + 1), posicionesFotones[i] - 10);
  }

  if (todosEnDestino) {
    animacionCompletada = true;
  }
}

void dibujarFotonesFinales() {
  for (int i = 0; i < 8; i++) {
    fill(bitsAlice[i].equals("0") ? color(0, 255, 0) : color(255, 255, 0)); // Colores según el bit
    ellipse(width / 9 * (i + 1), height / 2, 20, 20);
    fill(255);
    text("Bob", width / 9 * (i + 1), height / 2 + 30);
  }
}

void calcularResultados() {
  if (!resultadosCalculados) {
    for (int i = 0; i < 8; i++) {
      if (basesBob[i].equals(basesAlice[i])) {
        resultadosBob[i] = bitsAlice[i]; // Medición correcta
      } else {
        resultadosBob[i] = random(1) < 0.5 ? "0" : "1"; // Medición aleatoria
      }
    }
    resultadosCalculados = true;
  }
}

void dibujarRecepcion() {
  dibujarBasesYBits();
  dibujarFotonesFinales();
  for (int i = 0; i < 8; i++) {
    fill(basesBob[i].equals("+") ? color(0, 255, 255) : color(255, 0, 0)); // Cian para +, rojo para x
    text("Base Bob: " + basesBob[i], width / 9 * (i + 1), height / 2 + 50);
    fill(resultadosBob[i].equals("0") ? color(0, 255, 0) : color(255, 255, 0)); // Colores según el resultado
    text("Resultado: " + resultadosBob[i], width / 9 * (i + 1), height / 2 + 80);
  }
}

void compararBases() {
  dibujarRecepcion();
  for (int i = 0; i < 8; i++) {
    if (basesAlice[i].equals(basesBob[i])) {
      fill(0, 255, 0);
      acuerdoClave[i] = true;
      text("Correcto", width / 9 * (i + 1), height / 2 + 120);
    } else {
      fill(255, 0, 0);
      acuerdoClave[i] = false;
      text("Incorrecto", width / 9 * (i + 1), height / 2 + 120);
    }
  }
}

void extraerClave() {
  compararBases();
  claveFinal = "";
  for (int i = 0; i < 8; i++) {
    if (acuerdoClave[i]) {
      claveFinal += bitsAlice[i];
    }
  }
}

void keyPressed() {
  if (key == 'R' || key == 'r') {
    reiniciarProceso();
  }
}

void mousePressed() {
  if (paso == 2 && !animacionCompletada) {
    return; // No avanzar hasta que la animación esté completa
  }
  paso++;
  if (paso > 7) paso = 0;
}

void generarDatos() {
  for (int i = 0; i < 8; i++) {
    basesAlice[i] = random(1) < 0.5 ? "+" : "x"; // + = rectilínea, x = diagonal
    bitsAlice[i] = random(1) < 0.5 ? "0" : "1";  // Bits aleatorios
    basesBob[i] = random(1) < 0.5 ? "+" : "x";
    resultadosBob[i] = "";
    acuerdoClave[i] = false;
  }
  claveFinal = "";
}

void reiniciarProceso() {
  generarDatos();
  inicializarPosicionesFotones();
  paso = 0;
}
