import ciudades.*
import wollok.game.*

object pepita {
	var property energia = 500
	var property ciudad = buenosAires
	var amiga = ''

	var property position = game.at(3,3)
	method image() = if(energia > 100) { "pepita-gorda-raw.png" } 
						else { "pepita.png" } 

	method come(comida) {
		energia = energia + comida.energia()
	}
	
	method volaHacia(unaCiudad) {
		if (ciudad != unaCiudad) {
			self.move(unaCiudad.position())
			ciudad = unaCiudad
		} else {
			game.say(self, "Ya estoy en "+ciudad+"!")
		}
	}

	method energiaParaVolar(distancia) = 15 + 5 * distancia

	method move(nuevaPosicion) {
		if(energia < self.energiaParaVolar(position.distance(nuevaPosicion))) {
			game.say(self, "Dame de comer primero!")
		} else {
			energia -= self.energiaParaVolar(position.distance(nuevaPosicion))
			self.position(nuevaPosicion)
		}
	}
	
	method volaAComer(unaComida,hubicacion) {
		self.move(hubicacion)
		self.come(unaComida)
		game.removeVisual(unaComida)
	}
	
	method nuevaAmiga(ave) {
		if (amiga != ave) {
			game.say(self, "Hola " + ave.nombre() + "!")
			amiga = ave
		}
	}	
}

object roque {
	var property position = game.at(1,1)
	var property comidaActual = null
	method image() = "jugador.png"
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
	method levantarComida(comida) {
		if(self.tengoComidaEncima()) {
			self.soltarComida()
		}
		comidaActual = comida
		game.removeVisual(comida)
	}
	
	method soltarComida() {
		var x = 6
		var y = 6
		game.addVisualIn(comidaActual, game.at(x,y))
	}
	
	method tengoComidaEncima() {
		return comidaActual != null
	}
}

object pepona {
	var property position = game.at(2,8)
	method image() = "pepona.png"
	method nombre() = "Pepona"
}

object pipa {
	var property position = game.at(5,8)
	method image() = "pepitaCanchera.png"
	method nombre() = "Pipa"
}