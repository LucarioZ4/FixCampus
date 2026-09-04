Lista de requisitos de información:
Registrar reportes con descripción, ubicación exacta (bloque, piso, salón), categoría de falla y prioridad.
Autenticar usuarios y diferenciar su rol (Estudiante, Profesor, Técnico, Monitor, Empleado de Aseo).
Asignar un técnico a cada reporte y permitir reasignación si es necesario.
Registrar el avance del reporte a través de los estados: Pendiente → Asignado → En proceso → Solucionado.
Permitir comentarios de seguimiento sobre un reporte.
Conservar un historial de cada cambio de estado, con fecha y responsable del cambio.
Generar estadísticas: reportes por bloque, por categoría, por técnico, tiempos promedio de solución.

Preguntas y supuestos:

Estas son las ambigüedades que se identificaron al analizar el dominio, y la decisión tomada sobre cada una:

¿Un reporte puede tener más de una categoría? No. Se asume que cada reporte pertenece a una sola categoría principal (eléctrico, hidráulico, mobiliario, tecnológico, etc.), para simplificar el modelo. Si un problema abarca varias áreas, se documenta en la descripción o en comentarios.

¿Un reporte puede tener varios técnicos asignados a la vez? Se permite reasignación en el tiempo, pero solo un técnico está activo por reporte en un momento dado. Cada asignación, incluyendo reasignaciones, queda registrada como una fila distinta en Asignaciones, lo que permite ver el histórico de quién ha pasado por un mismo reporte.

¿Un técnico tiene una especialidad fija? Sí. Se asume que cada técnico tiene una categoría principal de especialidad, y el sistema debería sugerir (no forzar) técnicos de esa categoría al momento de asignar.

¿Quién puede comentar un reporte? El usuario que lo creó y el técnico asignado. Se deja abierta la posibilidad de que un rol administrativo (Monitor) también comente para hacer seguimiento.

¿Los estados son un catálogo fijo o un campo de texto? Catálogo fijo, mediante la tabla Estados, para evitar inconsistencias de escritura y permitir controlar el flujo, no se puede pasar de "Pendiente" a "Solucionado" sin pasar por los estados intermedios.

¿Qué guarda HistorialReportes? Un registro por cada cambio de estado del reporte (estado anterior, estado nuevo, fecha, usuario que hizo el cambio), no una copia completa del reporte.

¿Cómo se modela la ubicación? Como una sola tabla Ubicaciones con los campos bloque, piso y salón combinados, en lugar de tres entidades separadas (Bloque, Piso, Salón). Se decide así por alcance del curso: el nivel de detalle adicional no aporta valor al problema de negocio y complicaría el modelo sin necesidad.

¿Quién atiende un reporte primero, el monitor o el técnico? El monitor. Cada monitor tiene a su cargo uno o varios salones y pisos de un bloque, y es el primer responsable de cualquier falla reportada en esas ubicaciones. Solo si la falla supera su alcance (por ejemplo, requiere conocimiento técnico especializado) se escala el reporte a un técnico. Esto significa que el "responsable" de un reporte no siempre es un técnico: puede ser un monitor o un técnico, según en qué punto del flujo esté.
