# FixCampus

## Planteamiento del problema
El sistema va dirigido a la universidad, especificamente el proceso de soporte de infraestructura universitaria con sus bloques academicos (A,B,C,D,E,F,H,I,P). Actualmente, cuando un estudiante, docente o trabajador detecta una falla,
como por ejemplo, el aire acondicionado de un aula no quiere enfriar, el reporte se hace de manera informal, es decir, de forma verbal o por medio de Whatsapp a los numeros que aparecen en algunos salones donde aparecen los encargados
de dichos salones.
Este manejo informal genera varios problemas: Los reportes se pierden o se olvidan, no existe forma de saber el estado de la novedad hecha al encargado, no hay manera de saber cuanto tiempo toma el solucionar un problema, y no se puede
priorizar una falla urgente y una menor. Tampoco existe un historial que permita identificar que bloques o categorias de falla son las mas recurrentes, cual informacion seria valiosa para un mantenimiento preventivo.
El sistema debe responder: Que reportes existen y en que estado estan, quien lo/s reporto y donde exactamente ocurrio el problema, quien es el tecnico/monitor responsable de atenderlo, cuanto tiempo ha pasado desde que se reportó y que
comentarios o seguimientos se ha hecho.

2. Requisitos e interrogatorio
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

## 📊 Diagrama EER del Proyecto (Notación de Chen)

El diseño conceptual y lógico de la base de datos de **FixCampus** se encuentra modelado bajo la notación tradicional de Chen (entidades, atributos y relaciones). 

El archivo fuente del diagrama se encuentra disponible en la carpeta de documentación bajo el nombre del archivo `.drawio`.

### 🔍 Cómo ver o editar el diagrama


* **Visor Oficial Web:** Entra a [draw.io](https://app.diagrams.net/), descarga o clona este repositorio, y arrastra y suelta el archivo `.drawio` directamente sobre el lienzo en blanco para visualizarlo y editarlo de inmediato.
* **Extensión para VS Code:** Si trabajas desde Visual Studio Code, puedes instalar la extensión oficial **Draw.io Integration** (de *hediet*) para abrir, ver y modificar el archivo con un solo clic dentro del entorno de desarrollo.
* **Previsualización Rápida:** También puedes consultar las exportaciones en imagen (`.png` o `.svg`) alojadas en la carpeta de documentación para una vista previa directa desde GitHub.
