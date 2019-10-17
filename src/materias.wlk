import inscripcion.*
// del pizarrón
class Materia {
	const property inscriptos = []
	const property enEspera = []
	var property cupo 
	var property requisitos = []
	method anotar(estudiante) {
		if (self.completa()) {
			enEspera.add(estudiante)
		} else {
			inscriptos.add(estudiante)
		}
	}
	method completa() {
		return inscriptos.size() == cupo
	}
}

class Carrera {
	var property materias = []
	
	method tieneMateria(materia) {
		return materias.contains(materia)
	}
}