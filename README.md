# UNlema

Proyecto de Godot en etapa inicial. Actualmente contiene una interfaz de menú con el icono de Godot y los botones **Juega ya** e **Instrucciones**.

**Los botones todavía no realizan acciones:** no hay scripts ni señales conectadas. Tampoco hay una escena principal configurada. Para ver lo que existe, ejecuta `Scenes/main_menu.tscn` siguiendo los pasos de abajo.

## Requisitos

- **Godot:** `project.godot` declara la versión **4.7** y el renderizador **GL Compatibility**. Usa la misma versión que el equipo; la compatibilidad con otras versiones no está verificada. Puedes obtener el editor en el [sitio oficial de Godot](https://godotengine.org/download/).
- La edición estándar del editor es suficiente para el contenido actual; no hay código C# ni dependencias de .NET.
- **Git**, si vas a clonar el repositorio o colaborar.

Este proyecto se abre con Godot. No necesita `npm install`, un servidor web, una base de datos ni un archivo `.env`.

## Inicio rápido desde el editor

1. Si ya tienes esta carpeta descargada, úsala directamente. Si necesitas clonarla, abre PowerShell en la carpeta donde guardarás el proyecto y ejecuta:

   ```powershell
   git clone https://github.com/Laura26cal/UNlema.git
   cd UNlema
   ```

2. Abre Godot y, en el gestor de proyectos, pulsa **Importar / Import**.
3. Selecciona el archivo `project.godot` de esta carpeta y abre el proyecto. Espera a que termine la importación de recursos.
4. En el panel **Sistema de archivos / FileSystem**, abre `Scenes/main_menu.tscn`.
5. Pulsa **F6** (**Ejecutar escena actual / Run Current Scene**).

Deberías ver un menú centrado con el icono y los dos botones. Puedes redimensionar la ventana para revisar la distribución. Pulsa **F8** en el editor para detener la ejecución.

### ¿Por qué F5 pide seleccionar una escena?

**F6 ejecuta la escena abierta; F5 ejecuta la escena principal del proyecto.** Actualmente `project.godot` no contiene `run/main_scene`.

Si quieres usar F5, al pulsarlo selecciona **Seleccionar / Select** y elige `Scenes/main_menu.tscn`, o usa **Seleccionar actual / Select Current** si ya tienes abierto el menú. Godot guardará esa elección en `project.godot`; revisa ese cambio antes de subirlo a Git.

## Comandos en Windows / PowerShell

Ejecuta estos comandos desde la raíz del repositorio, donde está `project.godot`.

### Preparar el ejecutable

Si `godot --version` ya funciona, puedes usar `godot` directamente en lugar de `& $godot` en los ejemplos siguientes.

Si no tienes Godot en el PATH, indica dónde está el archivo `.exe` que descargaste. **Sustituye esta ruta de ejemplo por la ruta real de tu equipo**; el archivo puede tener la versión en el nombre:

```powershell
$godot = 'C:\Herramientas\Godot\Godot.exe'
& $godot --version
```

La variable `$godot` dura únicamente durante esa sesión de PowerShell. El operador `&` permite ejecutar el programa cuya ruta está guardada en la variable, incluso si contiene espacios.

### Abrir el editor

```powershell
& $godot --path . --editor
```

En la primera apertura, espera a que el editor importe los recursos antes de ejecutar el menú.

### Ejecutar el menú directamente

Este comando indica la escena de forma explícita, por lo que funciona sin configurar una escena principal:

```powershell
& $godot --path . 'res://Scenes/main_menu.tscn'
```

### Ejecutar el proyecto con su escena principal

Úsalo después de seleccionar la escena principal desde el editor:

```powershell
& $godot --path .
```

### Importar recursos sin abrir una ventana

```powershell
& $godot --headless --path . --editor --import
```

### Comprobar que la escena puede arrancar sin interfaz gráfica

Primero ejecuta la importación anterior. Después:

```powershell
& $godot --headless --path . --quit-after 2 'res://Scenes/main_menu.tscn'
```

Es una comprobación breve de carga: revisa los errores de la terminal. No comprueba la apariencia del menú ni las acciones de los botones.

## Qué contiene el repositorio

```text
UNlema/
├── Scenes/
│   └── main_menu.tscn   # Única escena: interfaz del menú
├── project.godot       # Configuración y punto de entrada del editor
├── icon.svg            # Icono del proyecto y logo mostrado en el menú
├── icon.svg.import     # Configuración de importación del SVG
├── .editorconfig       # Codificación UTF-8
├── .gitattributes      # Normalización de finales de línea a LF
├── .gitignore          # Excluye .godot/ y /android/
└── README.md           # Esta guía
```

Godot genera la carpeta `.godot/` al importar el proyecto. Contiene datos locales y caché; está excluida de Git. El archivo `icon.svg.import` sí forma parte del repositorio.

## Cómo funciona el menú

Una escena `.tscn` describe un árbol de nodos y sus propiedades. Esta escena solo usa nodos de interfaz integrados en Godot:

```text
MainMenu (Control)
└── CenterContainer
    └── VBoxContainer
        ├── Logo (TextureRect)
        ├── PLayButton (Button): "Juega ya"
        └── InstrucctionsButton (Button): "Instrucciones"
```

- `MainMenu` ocupa el espacio disponible de la ventana.
- `CenterContainer` centra el contenido.
- `VBoxContainer` coloca el logo y los botones en una columna, con separación de 20 píxeles.
- `Logo` carga `res://icon.svg`. El prefijo `res://` apunta a la raíz del proyecto.
- Los botones tienen un tamaño mínimo de 250 × 60 píxeles. Sus nombres de nodo son exactamente `PLayButton` e `InstrucctionsButton`, aunque tengan errores de escritura.

La configuración de escalado usa `canvas_items` y aspecto `expand`. La configuración de física 3D menciona Jolt, pero la escena actual solo contiene interfaz y no usa física.

## Cambios habituales

| Quiero… | Dónde hacerlo |
| --- | --- |
| Cambiar los textos de los botones | Abrir `Scenes/main_menu.tscn`, seleccionar el botón y editar `Text` en el Inspector. |
| Cambiar el logo del menú | Seleccionar `Logo` y asignar otra textura. Actualmente comparte `icon.svg` con el icono del proyecto. |
| Ajustar el espacio entre elementos | Seleccionar `VBoxContainer` y editar `Theme Overrides > Constants > Separation`. |
| Dar una acción a los botones | Añadir un script al menú y conectar la señal `pressed` de cada botón a una función. |
| Crear el juego o las instrucciones | Crear las escenas correspondientes e implementar la navegación desde el menú. Aún no existen. |

## Problemas frecuentes

| Problema | Qué revisar |
| --- | --- |
| PowerShell no reconoce `godot` | Usa la ruta real del ejecutable con `$godot` y `&`, como en los ejemplos. |
| PowerShell no encuentra el ejecutable de ejemplo | Cambia `C:\Herramientas\Godot\Godot.exe` por la ubicación y nombre reales del `.exe`. |
| Godot no encuentra el proyecto | Ejecuta los comandos desde la carpeta que contiene `project.godot`, o cambia `--path .` por la ruta de esa carpeta. |
| F5 pide una escena principal | Selecciona `Scenes/main_menu.tscn` o abre esa escena y usa F6. |
| Los botones no cambian de pantalla | Es el estado actual: faltan scripts, conexiones y escenas de destino. |
| El logo no aparece o hay errores de importación | Abre el proyecto en el editor y espera a que termine de importar; también puedes usar el comando `--editor --import`. |
| El editor avisa de una versión distinta | Comprueba `--version` y compara con la versión 4.7 declarada por el proyecto. Coordina cualquier cambio de versión con el equipo. |

## Verificación y próximos pasos

Esta guía se preparó revisando `project.godot` y `Scenes/main_menu.tscn`. No se pudo probar la ejecución con Godot: no se encontró un comando `godot` o `godot4` disponible en el PATH del entorno de revisión.

Para continuar el desarrollo, falta configurar la escena principal, implementar las acciones del menú y crear las escenas de juego e instrucciones. Tampoco hay pruebas automatizadas ni configuraciones de exportación (`export_presets.cfg`) en el repositorio.

Referencias: [comandos oficiales de Godot](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html) y [escenas y ejecución desde el editor](https://docs.godotengine.org/en/stable/getting_started/step_by_step/nodes_and_scenes.html).
