# Liberation Builder Helper

Mod para Arma 3 que facilita la construcción de misiones KP Liberation, permitiendo agregar classnames de items, vehículos y unidades directamente desde el editor 3DEN y ACE Arsenal a los arrays de los archivos `custom.sqf`.

## Características

- **Integración con 3DEN Editor**: Menú dedicado para agregar objetos seleccionados a categorías específicas
- **Auto-detección**: Detecta automáticamente el tipo de objeto (infantería, vehículo, aeronave, etc.)
- **Panel de Gestión**: Interfaz completa para ver, buscar, agregar y eliminar classnames
- **Soporte de Costos**: Input de costos (supplies, ammo, fuel) para categorías que lo requieren
- **Integración ACE Arsenal**: Exporta loadouts completos con un atajo de teclado
- **Exportación SQF**: Genera código compatible con KP Liberation listo para pegar en `custom.sqf`
- **Persistencia**: Los datos se guardan automáticamente entre sesiones
- **Multilenguaje**: Soporta Inglés y Español

## Requisitos

- **Arma 3** (v2.00+)
- **CBA_A3** (Community Base Addons) - Requerido
- **ACE3** - Opcional (para integración con Arsenal)

## Instalación

### Opción 1: Steam Workshop
*(Próximamente)*

### Opción 2: Manual
1. Descarga o clona este repositorio
2. Empaqueta `@LiberationBuilder/addons/main/` como PBO usando PBO Manager
3. Copia la carpeta `@LiberationBuilder` a tu directorio de Arma 3
4. Activa el mod en el launcher de Arma 3

## Uso

### En el Editor 3DEN

#### Menú Principal (Tools > Liberation Builder)
- **Add to BLUFOR/OPFOR/Resistance/Civilians/Arsenal**: Submenús con categorías específicas
- **Open Management Panel**: Abre el panel de gestión completo
- **Export All Presets**: Exporta todos los datos al portapapeles

#### Menú Contextual (Click derecho en objetos)
- **Add (Auto-detect)**: Detecta automáticamente la categoría del objeto
- **Add to Category...**: Permite seleccionar manualmente la categoría

### Panel de Gestión

1. **Preset**: Selecciona el preset (BLUFOR, OPFOR, Resistance, Civilians, Arsenal)
2. **Category**: Selecciona la categoría dentro del preset
3. **Search**: Filtra classnames por texto
4. **Lista**: Muestra classnames con sus costos (si aplica)
5. **Botones**:
   - `Add Manual`: Agregar classname manualmente
   - `Remove`: Eliminar seleccionado
   - `Export`: Exportar preset actual
   - `Clear All`: Limpiar categoría
   - `Close`: Cerrar panel

### Integración ACE Arsenal

Mientras estés en ACE Arsenal, presiona **Ctrl+Shift+E** para exportar todos los items del loadout actual a las categorías correspondientes del Arsenal.

## Categorías Soportadas

### BLUFOR (formato con costos)
| Variable | Descripción |
|----------|-------------|
| `infantry_units` | Unidades de infantería |
| `light_vehicles` | Vehículos ligeros |
| `heavy_vehicles` | Vehículos pesados (tanques, APCs) |
| `air_vehicles` | Aeronaves |
| `static_vehicles` | Armas estáticas |
| `buildings` | Edificios construibles |
| `support_vehicles` | Vehículos de soporte |

### BLUFOR (valores individuales)
| Variable | Descripción |
|----------|-------------|
| `crewman_classname` | Tripulante |
| `pilot_classname` | Piloto |
| `FOB_typename` | Edificio FOB |
| `Arsenal_typename` | Objeto Arsenal |
| ... | (ver todas en el panel) |

### OPFOR (arrays simples)
`militia_squad`, `opfor_vehicles`, `opfor_choppers`, `opfor_air`, etc.

### Resistance
`KP_liberation_guerilla_units`, `KP_liberation_guerilla_vehicles`, uniformes, chalecos, etc.

### Civilians
`civilians`, `civilian_vehicles`

### Arsenal
`GRLIB_arsenal_weapons`, `GRLIB_arsenal_magazines`, `GRLIB_arsenal_items`, `GRLIB_arsenal_backpacks`

## Formato de Exportación

El mod genera código SQF compatible con KP Liberation:

```sqf
// Formato con costos [classname, supplies, ammo, fuel]
infantry_units = [
    ["B_Soldier_F",10,0,0],
    ["B_Soldier_AR_F",15,5,0]
];

// Formato simple (array de strings)
militia_squad = [
    "O_Soldier_F",
    "O_Soldier_AR_F"
];

// Variables individuales
crewman_classname = "B_crew_F";
```

## Estructura del Proyecto

```
@LiberationBuilder/
├── mod.cpp                 # Metadatos del mod
└── addons/
    └── main/
        ├── $PBOPREFIX$     # Prefijo: x\lbh\addons\main
        ├── config.cpp      # Configuración principal
        ├── script_component.hpp
        ├── XEH_preInit.sqf
        ├── XEH_postInit.sqf
        ├── stringtable.xml
        ├── functions/      # 24 funciones SQF
        └── ui/
            ├── defines.hpp
            └── dialogs.hpp
```

## Compilación

### Con PBO Manager (recomendado)
1. Click derecho en `@LiberationBuilder/addons/main/`
2. Seleccionar "Pack into PBO"
3. El archivo `main.pbo` se creará en `addons/`

### Con Arma 3 Tools
```cmd
AddonBuilder.exe "ruta\@LiberationBuilder\addons\main" "ruta\output" -packonly
```

### Con armake2 (Linux/macOS)
```bash
armake2 pack @LiberationBuilder/addons/main @LiberationBuilder/addons/main.pbo
```

## Publicación en Steam Workshop

1. Compila el PBO
2. Abre Arma 3 Launcher → MODS → WORKSHOP → PUBLISH
3. Selecciona la carpeta `@LiberationBuilder`
4. Completa título, descripción y tags
5. Publica

### Actualizaciones
- Launcher: MODS → WORKSHOP → Tu mod → UPDATE
- O con SteamCMD para automatización

## Contribuir

1. Fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcion`)
3. Commit de tus cambios (`git commit -m 'Agregar nueva función'`)
4. Push a la rama (`git push origin feature/nueva-funcion`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT.

## Créditos

- Desarrollado para uso con [KP Liberation](https://github.com/KillahPotatoes/KP-Liberation)
- Requiere [CBA_A3](https://github.com/CBATeam/CBA_A3)
- Integración opcional con [ACE3](https://github.com/acemod/ACE3)
