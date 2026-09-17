object casa {
  var property cuidador = tom
  var property quilombero = jerry
  var property suciedad = 100

  method pasaElDia() {
    cuidador.limpiar(self)
    if (quilombero != null && cuidador.puedeAtraparlo(quilombero)) {
      quilombero = null
    }
  }

  method pasaLaNoche() {
    cuidador.dormir()
    if (quilombero != null) {
      quilombero.hacerQuilombo(self)
    }
  }

  // Métodos auxiliares para que los actores modifiquen la casa
  method ensuciar(cantidad) {
    suciedad = suciedad + cantidad
  }

  method limpiar(cantidad) {
    suciedad = 0.max(suciedad - cantidad) // Evita que la suciedad sea negativa
  }

  method limpiarTotalmente() {
    suciedad = 0
  }
}



object tom {
  var property energia = 0

  method limpiar(casa) {
    casa.limpiar(100)
    energia = energia - 40
  }

  method velocidad() = 5 + (energia / 10)

  method puedeAtraparlo(unQuilombero) =  self.velocidad() > unQuilombero.velocidad()

  method dormir() {
    energia = energia  + 50
  }

  method interrumpirSueño() {
    energia = energia - 20
  }
}



object jerry {
  var peso = 0

  method hacerQuilombo(casa) {
    casa.ensuciar(110)
    self.robaComida()
  }

  method robaComida() {
    peso = peso + 1
  }
  
  method velocidad() = 10 - peso
}



object tuffy {
  method velocidad() = 10
  
  method hacerQuilombo(casa) {
    casa.cuidador().interrumpirSueño()
  }
}



object robocat {
  method limpiar(casa) {
    casa.limpiarTotalmente()
  }

  method puedeAtraparlo(unQuilombero) =  true

  method dormir() {
    // Robocat no necesita dormir, así que no hace nada
  }

  method interrumpirSueño() {
    // No le afecta
  }
  
}



object pandilla {
  var property miembros = [jerry, tuffy]

  method hacerQuilombo(casa) {
    miembros.forEach( { quilombero => quilombero.hacerQuilombo(casa) } )
    if (miembros.size() > 3) {
      casa.cuidador().interrumpirSueño()
    }
  }

  method velocidad() = miembros.map( { quilombero => quilombero.velocidad() } ).min() / 2
}


// Codificar un nuevo cuidador y quilombero que puedan estar en la casa.
// ME FALTA

// Escribir los tests necesarios para probar el correcto funcionamiento del código.
// ME FALTA

// ¿Cuáles son las interfaces que hay en la solución?
// Interfaz Cuidador (Tom, Robocat, Spike): Entienden limpiar(casa), puedeAtrapar(unQuilombero), dormir() e interrumpirSueño().
// Interfaz Quilombero (Jerry, Tuffy, Pandilla, Butch): Entienden velocidad() y hacerQuilombo(casa).