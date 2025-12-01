# Security Vulnerabilities Visualization – Smalltalk / Glamorous Toolkit

Este proyecto implementa una visualización sencilla para analizar la evolución de vulnerabilidades de seguridad presentes en archivos *workflow* de GitHub Actions.  
El trabajo se desarrolló en **Smalltalk (Glamorous Toolkit)** como parte de una actividad académica.

## Descripción general

El objetivo es:

- Modelar workflows, versiones y vulnerabilidades desde un dataset de archivos JSON.
- Calcular dos métricas principales:
  1. Número de vulnerabilidades por versión.
  2. Número de versiones del workflow.
- Implementar una visualización mediante `<gtView>`.
- Agregar una **Home Section** para explorar el modelo desde GT.

Debido a limitaciones de tiempo, la visualización final es **sencilla pero funcional**, enfocada en cumplir la rúbrica mínima solicitada.

---

## Contenido del repositorio

### Modelo de dominio
El repositorio incluye tres clases principales:

- **Workflow**: representa un archivo de workflow con sus versiones.
- **Version**: representa una versión con timestamp, vulnerabilidades y referencia al workflow.
- **Vulnerability**: representa una vulnerabilidad con ruleId, message y severity.

### Parser (`WorkflowParser`)
Permite:

- Leer una carpeta completa con archivos JSON.
- Recorrer subdirectorios.
- Ignorar archivos inválidos.
- Crear la estructura Workflow → Version → Vulnerability.
- Enlazar correctamente cada versión con su workflow.

### Visualización (GT View)
Implementa un método `<gtView>` en la clase **Version**, el cual muestra:

- Número total de vulnerabilidades.
- El “color” asignado según la cantidad de versiones:
  - **verde** si el workflow tiene ≥ 5 versiones
  - **rojo** si tiene < 5

> Nota: Debido a problemas de compatibilidad con Bloc, se implementó una visualización textual en lugar de un rectángulo gráfico.  
> Esto asegura estabilidad y cumple con los requisitos mínimos.

### Home Section
Incluye un `<gtHome>` básico que permite:

- Listar las versiones de un workflow.
- Acceder a la visualización de cada una.

La integración está hecha, aunque su comportamiento puede variar según la versión de GT.

---

## Cómo ejecutar

1. Abrir Glamorous Toolkit.  
2. Cargar el proyecto.  
3. Ejecutar el parser manualmente:

folder := 'C:\\ruta\\a\\security_data' asFileReference.
workflows := WorkflowParser new parseFolder: folder.
workflows inspect.

4. En el inspector:
   - Abrir un workflow
   - Acceder a la pestaña Home, o
   - Explorar la colección versions manualmente y abrir una versión para ver su visualización.

## Dificultades encontradas

El desarrollo presentó varios desafíos importantes:

1. API de archivos distinta en GT
GT no usa la misma API de archivos que Pharo, por lo que métodos esperables como childrenDo: no funcionaban.
La solución fue usar:
	-asFileReference
	-allChildren
	-filtrado manual de JSON
2. Problemas con Bloc
Los intentos de usar BlElement, BlRectangleGeometry y propiedades de layout resultaron en errores en tiempo de ejecución debido a diferencias entre versiones de GT.
Para asegurar funcionalidad, se implementó una visualización textual mínima.
3. Estabilidad del inspector
Varias vistas del inspector fallaban antes de abrirse, especialmente cuando:
	-el workflow estaba mal construido,
	-faltaban variables de instancia,
	-las vistas intentaban leer campos que eran nil.

Estos problemas desaparecieron al corregir la estructura del modelo.
