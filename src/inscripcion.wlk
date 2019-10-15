
class Estudiante {
	var aprobaciones = []
	var carreras = []
	var inscripciones = []
	
	method registrarAprobacion(materia, nota) {
		//aprobaciones.add(aprobacion)
		if (not aprobaciones.any({ aprobacion => aprobacion.materia() == materia })){
			aprobaciones.add(new Aprobacion(materia = materia, nota = nota))
		}
		else (self.error("ya está aprobada"))
	}
	
	method buscarMateria(materia) {
		return aprobaciones.find({ aprobacion => aprobacion.materia() == materia })
	}
	
	method materiasAprobadas() {
		return aprobaciones.filter({ aprobacion => aprobacion.nota() >  3})
	}
	
	method aproboLaMateria(materia) {
		return self.buscarMateria(materia).nota() > 3
	}
	
	method cuantasAprobadasTiene() {
		return self.materiasAprobadas().size()
	}
	method promedio() {
		return self.materiasAprobadas().sum({ aprob => aprob.nota()}) / self.cuantasAprobadasTiene()
	}
	
	method todasLasMateriasInscriptas() {
		return carreras.map({ carrera => carrera.materias()}).flatten()
	}
	
	method inscribirseACarrera(carrera) {
		carreras.add(carrera)
	}
	
	method puedeInscribirseAMateria(materia) {
		return self.coincideConCarreraInscripta(materia) and self.aproboLaMateria(materia) and not self.estaInscripto(materia) and self.cumpleRequisitos(materia)
	}
	
	method inscribirseAMateria(materia){
		inscripciones.add(materia)
	}
	
	// AUXILIARES
	method coincideConCarreraInscripta(materia) {
		return carreras.any({carrera => carrera.tieneMateria(materia)})
	}
	method conQueCarrera(materia) {
		return carreras.find({ carrera => carrera.tieneMateria(materia)})
	}
	
	method estaInscripto(materia) {
		return inscripciones.any({mat => mat == materia})
	}
	
	method cumpleRequisitos(materia) {
		var carrera = self.conQueCarrera(materia)
		return carrera.requisitosDeLaInscripcionDe(materia).all({requisito => self.aproboLaMateria(requisito)})
	}
}

class Materia {
	var property requisitos = []
}

class Aprobacion {
	var property materia
	var property nota
}

object programacion {
	
	var elementosDeLaProgramacion = new Materia( )
	var matematica1 = new Materia()
	var objetos1 = new Materia()
	var objetos2 = new Materia(requisitos = [objetos1])
	var objetos3 = new Materia (requisitos = [objetos2])
	
	var materias = [elementosDeLaProgramacion, matematica1, objetos1, objetos2, objetos3]
	method tieneMateria(materia) {
		return materias.any({ mat => mat == materia})
	}
	
	method elementosDeLaProgramacion() {
		return materias.find({mat => mat == elementosDeLaProgramacion })
	}
	
	method matematica1() {
		return materias.find({mat => mat == matematica1 })
	}

	method objetos1() {
		return materias.find({mat => mat == objetos1 })
	}

	method objetos2() {
		return materias.find({mat => mat == objetos2 })
	}

	method objetos3() {
		return materias.find({mat => mat == objetos3 })
	}

}

object medicina {
	var quimica = new Materia()
	var biologia1 = new Materia()
	var biologia2 = new Materia( requisitos = [biologia1])
	var anatomiaGeneral = new Materia()
	
	var materias = [quimica, biologia1, biologia2, anatomiaGeneral]
	
	method tieneMateria(materia) {
		return materias.any({ mat => mat == materia})
	}
	
}

object derecho {
	var latin = new Materia()
	var derechoRomano = new Materia()
	var historiaDelDerechoArgentino = new Materia()
	var derechoPenal = new Materia()
	var derechoPenal2 = new Materia( requisitos = [derechoPenal])
	
	var property materias = [latin, derechoRomano, historiaDelDerechoArgentino, derechoPenal, derechoPenal2]
	
	method tieneMateria(materia) {
		return materias.any({ mat => mat == materia})
	}
	method requisitosDeLaInscripcionDe(materia) {
		return materia.requisitos()
	}
}