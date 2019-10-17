import materias.*

class Estudiante {
	var aprobaciones = []
	var carreras = []
//	var inscripciones = []
	
	method registrarAprobacion(materia, nota) {
		//aprobaciones.add(aprobacion)
		if (not aprobaciones.any({ aprobacion => aprobacion.materia() == materia })){
			aprobaciones.add(new Aprobacion(materia = materia, nota = nota))
		}
		else (self.error("ya está aprobada"))
	}
	
	method buscarMateria(materia) {
		return aprobaciones.contains({ aprobacion => aprobacion.materia() == materia})
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
		return self.coincideConCarreraInscripta(materia) and not self.aproboLaMateria(materia) and not self.estaInscripto(materia) and self.cumpleRequisitos(materia)
	}
	
	/*method inscribirseAMateria(materia){
		inscripciones.add(materia)
	}*/
	
	// AUXILIARES
	method coincideConCarreraInscripta(materia) {
		return carreras.any({carrera => carrera.tieneMateria(materia)})
	}
	
	method estaInscripto(materia) {
//		return inscripciones.any({mat => mat == materia})
	return materia.inscriptos().contains(self)  // del profe
	}
	
	method cumpleRequisitos(materia) { // ejemplo del profe
		return materia.requisitos().all({req => self.aproboLaMateria(req)})
	}
	method inscribir(materia){ // hecho por el profe 
		if (not self.puedeInscribirseAMateria(materia)) {
			self.error("no puede cursar")
		} 
		materia.anotar(self)
	}
}/* */ 


class Aprobacion {
	var property materia
	var property nota
}

