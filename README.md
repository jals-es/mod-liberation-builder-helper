# Liberation Builder Helper

Mod para Arma 3 que facilita la construcción de presets para misiones KP Liberation, permitiendo agregar classnames de items, vehículos y unidades directamente desde el editor 3DEN a los arrays de los archivos `custom.sqf`.

## Características

- **Integración con 3DEN Editor**: Menú dedicado en Tools > Liberation Builder
- **Auto-detección**: Detecta automáticamente el tipo de objeto (infantería, vehículo, aeronave, etc.)
- **Panel de Gestión**: Interfaz completa para ver, buscar, agregar y eliminar classnames
- **Soporte de Costos**: Input de costos (supplies, ammo, fuel) para categorías BLUFOR
- **Múltiples Objetos**: Añade varios objetos a la vez con diálogo de costos secuencial
- **Export Wizard**: Asistente para exportar presets directamente a carpetas de misión KP Liberation
- **Exportación SQF**: Genera código compatible con KP Liberation listo para pegar en `custom.sqf`
- **Persistencia**: Los datos se guardan automáticamente en el perfil entre sesiones

## Requisitos

- **Arma 3** (v2.00+)
- **CBA_A3** (Community Base Addons) - Requerido

## Instalación

### Opción 1: Steam Workshop
Suscríbete al mod en Steam Workshop (ID: 3655694577)

### Opción 2: Manual
1. Descarga la última release desde GitHub
2. Extrae la carpeta `@LiberationBuilder` a tu directorio de Arma 3
3. Activa el mod en el launcher de Arma 3

---

## Guía de Uso

### 1. Menú Principal (Tools > Liberation Builder)

Accede al menú desde **Tools > Liberation Builder** en el editor 3DEN.

#### Opciones del Menú:

| Opción | Descripción |
|--------|-------------|
| **Open Management Panel** | Abre el panel de gestión principal |
| **Export All Presets** | Exporta todos los presets al portapapeles en formato SQF |
| **Save to Mission...** | Abre el Export Wizard para guardar en una misión KP Liberation |
| **Add to BLUFOR** | Submenú con categorías BLUFOR (Infantry, Vehicles, etc.) |
| **Add to OPFOR** | Submenú con categorías OPFOR |
| **Add to Resistance** | Submenú con categorías de guerrilla |
| **Add to Civilians** | Submenú con categorías civiles |
| **Add to Arsenal** | Submenú con categorías de arsenal |
| **Clear All Data...** | Elimina TODOS los datos guardados (con confirmación) |

---

### 2. Añadir Objetos desde el Editor

#### Método Rápido (Menú)
1. Selecciona uno o más objetos en el editor 3DEN
2. Ve a **Tools > Liberation Builder > Add to [PRESET] > [CATEGORY]**
3. Si la categoría requiere costos (BLUFOR vehicles, infantry, etc.), aparecerá un diálogo para cada objeto
4. Introduce los valores de Supplies, Ammo y Fuel
5. Click en **OK** para añadir

#### Añadir Múltiples Objetos
Cuando seleccionas varios objetos y los añades a una categoría con costos:
- Aparece un diálogo de costos para el primer objeto
- Al confirmar, aparece automáticamente el diálogo para el siguiente
- Continúa hasta añadir todos los objetos
- Puedes cancelar en cualquier momento

---

### 3. Panel de Gestión

Abre el panel con **Tools > Liberation Builder > Open Management Panel**

#### Controles del Panel:

| Control | Función |
|---------|---------|
| **Preset** | Selecciona el preset (BLUFOR, OPFOR, Resistance, Civilians, Arsenal) |
| **Category** | Selecciona la categoría dentro del preset |
| **Search** | Filtra la lista por texto |
| **Lista** | Muestra los classnames guardados con sus costos (si aplica) |

#### Botones:

| Botón | Acción |
|-------|--------|
| **Add Manual** | Abre un diálogo para escribir un classname manualmente |
| **Remove** | Elimina el classname seleccionado de la lista |
| **Export** | Exporta el preset actual al portapapeles |
| **Clear All** | Elimina todos los classnames de la categoría actual |
| **Close** | Cierra el panel |

#### Añadir Classname Manualmente:
1. Selecciona el Preset y Categoría deseados
2. Click en **Add Manual**
3. Escribe el classname (ej: `B_Soldier_F`)
4. Click en **OK**
5. Si la categoría requiere costos, aparecerá el diálogo de costos

---

### 4. Export Wizard (Save to Mission)

El Export Wizard te guía para exportar los presets a una misión KP Liberation existente.

#### Cómo usar:
1. Ve a **Tools > Liberation Builder > Save to Mission...**
2. Introduce la ruta de tu misión KP Liberation (ej: `D:\Arma3\Missions\KP_Liberation.Altis`)
3. El wizard validará que sea una misión KP Liberation válida
4. Verás una tabla con todos los presets y el número de items en cada uno
5. Para cada preset:
   - Click en **Copy** para copiar el contenido al portapapeles
   - Click en **Open** para abrir la carpeta del archivo destino
6. Pega el contenido en el archivo `custom.sqf` correspondiente

#### Archivos de destino:

| Preset | Archivo |
|--------|---------|
| BLUFOR | `presets/blufor/custom.sqf` |
| OPFOR | `presets/opfor/custom.sqf` |
| Resistance | `presets/resistance/custom.sqf` |
| Civilians | `presets/civilians/custom.sqf` |
| Arsenal | `arsenal_presets/custom.sqf` |

---

### 5. Exportar al Portapapeles

#### Exportar Todo:
- **Tools > Liberation Builder > Export All Presets**
- Copia todos los presets formateados al portapapeles
- Pégalo en tus archivos `custom.sqf`

#### Exportar Preset Individual:
1. Abre el Panel de Gestión
2. Selecciona el Preset deseado
3. Click en **Export**
4. El contenido se copia al portapapeles

---

### 6. Limpiar Datos

#### Limpiar una Categoría:
1. Abre el Panel de Gestión
2. Selecciona el Preset y Categoría
3. Click en **Clear All**
4. Confirma la acción

#### Limpiar TODOS los Datos:
1. Ve a **Tools > Liberation Builder > Clear All Data...**
2. Aparece un diálogo de confirmación con advertencia
3. Click en **OK** para eliminar todos los datos de todos los presets
4. Esta acción no se puede deshacer

---

## Categorías Soportadas

### BLUFOR

#### Con Costos (supplies, ammo, fuel):
| Variable | Descripción |
|----------|-------------|
| `infantry_units` | Unidades de infantería |
| `light_vehicles` | Vehículos ligeros |
| `heavy_vehicles` | Vehículos pesados (tanques, APCs) |
| `air_vehicles` | Aeronaves |
| `static_vehicles` | Armas estáticas |
| `buildings` | Edificios construibles |
| `support_vehicles` | Vehículos de soporte |

#### Squads (arrays simples):
| Variable | Descripción |
|----------|-------------|
| `blufor_squad_inf_light` | Squad ligero |
| `blufor_squad_inf` | Squad infantería |
| `blufor_squad_at` | Squad anti-tanque |
| `blufor_squad_aa` | Squad anti-aéreo |
| `blufor_squad_recon` | Squad reconocimiento |
| `blufor_squad_para` | Squad paracaidista |

#### Variables Individuales:
| Variable | Descripción |
|----------|-------------|
| `crewman_classname` | Tripulante |
| `pilot_classname` | Piloto |
| `FOB_typename` | Edificio FOB |
| `FOB_box_typename` | Caja FOB |
| `FOB_truck_typename` | Camión FOB |
| `Arsenal_typename` | Objeto Arsenal |
| `Respawn_truck_typename` | Camión respawn |
| `huron_typename` | Helicóptero de carga |
| `KP_liberation_little_bird_classname` | Little Bird |
| `KP_liberation_boat_classname` | Bote |
| `KP_liberation_truck_classname` | Camión logístico |

### OPFOR

#### Arrays:
`militia_squad`, `militia_vehicles`, `opfor_vehicles`, `opfor_vehicles_low_intensity`, `opfor_battlegroup_vehicles`, `opfor_battlegroup_vehicles_low_intensity`, `opfor_troup_transports`, `opfor_choppers`, `opfor_air`, `opfor_arty`, `opfor_static_aa`, `opfor_radar`, `opfor_ships`, `opfor_big_ships`, `elite_vehicles`

#### Variables Individuales:
`opfor_officer`, `opfor_squad_leader`, `opfor_rifleman`, `opfor_rpg`, `opfor_medic`, `opfor_sniper`, `opfor_grenadier`, `opfor_machinegunner`, `opfor_heavygunner`, `opfor_marksman`, `opfor_sharpshooter`, `opfor_aa`, `opfor_at`, `opfor_engineer`, `opfor_paratrooper`, `opfor_pilot`, `opfor_crew`

### Resistance
`KP_liberation_guerilla_units`, `KP_liberation_guerilla_vehicles`, uniformes (3 tiers), chalecos (3 tiers), cascos (3 tiers), `KP_liberation_guerilla_facegear`

### Civilians
`civilians`, `civilian_vehicles`

### Arsenal
`GRLIB_arsenal_weapons`, `GRLIB_arsenal_magazines`, `GRLIB_arsenal_items`, `GRLIB_arsenal_backpacks`

---

## Formato de Exportación

El mod genera código SQF compatible con KP Liberation:

```sqf
// Formato con costos [classname, supplies, ammo, fuel]
infantry_units = [
    ["B_Soldier_F", 10, 0, 0],
    ["B_Soldier_AR_F", 15, 5, 0]
];

// Formato simple (array de strings)
militia_squad = [
    "O_Soldier_F",
    "O_Soldier_AR_F"
];

// Variables individuales
crewman_classname = "B_crew_F";
pilot_classname = "B_Helipilot_F";
```

---

## Persistencia de Datos

- Los datos se guardan automáticamente en `profileNamespace`
- Persisten entre sesiones de Arma 3
- Son independientes de la misión que estés editando
- Se eliminan solo con "Clear All Data" o manualmente

---

## Problemas Conocidos

- La integración con ACE Arsenal está en desarrollo y no disponible en esta versión
- El menú contextual (click derecho) puede no aparecer en algunas configuraciones

---

## Changelog

### v0.2.0.0
- Añadido Export Wizard para guardar directamente en misiones KP Liberation
- Añadido diálogo de entrada de texto para "Add Manual"
- Añadido soporte para múltiples objetos con cola de diálogos de costos
- Añadida opción "Clear All Data" para limpiar todos los presets
- Corregido bug donde solo se añadía el primer objeto al seleccionar múltiples
- Integración ACE Arsenal deshabilitada temporalmente

### v0.1.0.0
- Release inicial
- Panel de gestión funcional
- Menú 3DEN con submenús por preset
- Exportación al portapapeles
- Persistencia en profileNamespace

---

## Contribuir

1. Fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcion`)
3. Commit de tus cambios (`git commit -m 'Agregar nueva función'`)
4. Push a la rama (`git push origin feature/nueva-funcion`)
5. Abre un Pull Request

---

## Licencia

Este proyecto está bajo la licencia MIT.

## Créditos

- Desarrollado para uso con [KP Liberation](https://github.com/KillahPotatoes/KP-Liberation)
- Requiere [CBA_A3](https://github.com/CBATeam/CBA_A3)
