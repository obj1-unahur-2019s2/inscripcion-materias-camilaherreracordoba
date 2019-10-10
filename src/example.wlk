class Estudiante {
	var property nombre 
	var aprobaciones = #{}
	method registrarProbacion(aprobacion) {
		aprobaciones.add(aprobacion)
	}
	method curso(materia) {
		return aprobaciones.any({aprobacion => aprobacion == materia})
	}
	
	method buscarMateria(materia) {
		return aprobaciones.find({ aprobacion => aprobacion == materia })
	}
	method aproboLaMateria(materia) {
		return self.buscarMateria(materia).nota() > 3
	}
	method promedio() {
		return aprobaciones.sum({ aprobacion => aprobacion.nota()}) / aprobaciones.size()
	}
}

class Materia {
	var property nombre
}

class Aprobacion {
	var property materia = []
	var property nota
}