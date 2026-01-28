# Liberation Mission Builder Helper - Mod para Arma 3

## Descripcion del Proyecto

Mod para Arma 3 que facilita la construccion de misiones Liberation, permitiendo agregar classnames de items, vehiculos y unidades directamente desde el editor y el arsenal de ACE a los arrays correspondientes de los archivos custom.sqf.

## Estructura del Proyecto

```
mod-make-liberation/
├── CLAUDE.md                 # Este archivo - contexto para Claude
├── plan.md                   # Plan de implementacion y prompt inicial
└── @LiberationBuilder/       # Carpeta del mod (PBO)
    ├── mod.cpp               # Metadatos del mod
    └── addons/
        └── main/
            ├── $PBOPREFIX$           # x\lbh\addons\main
            ├── config.cpp            # CfgPatches, CfgFunctions, Cfg3DEN
            ├── script_component.hpp  # Macros del componente
            ├── XEH_preInit.sqf       # Inicializacion CBA
            ├── XEH_postInit.sqf      # Post-inicializacion
            ├── stringtable.xml       # Traducciones ES/EN
            ├── functions/            # 24 funciones SQF
            │   ├── fn_init.sqf
            │   ├── fn_loadData.sqf
            │   ├── fn_saveData.sqf
            │   ├── fn_showNotification.sqf
            │   ├── fn_addClassname.sqf
            │   ├── fn_removeClassname.sqf
            │   ├── fn_hasClassname.sqf
            │   ├── fn_detectObjectType.sqf
            │   ├── fn_getCategories.sqf
            │   ├── fn_addSelectedObjects.sqf
            │   ├── fn_openPanel.sqf
            │   ├── fn_onPresetChanged.sqf
            │   ├── fn_onCategoryChanged.sqf
            │   ├── fn_onSearchChanged.sqf
            │   ├── fn_refreshList.sqf
            │   ├── fn_removeSelected.sqf
            │   ├── fn_clearCategory.sqf
            │   ├── fn_addManualClassname.sqf
            │   ├── fn_openCostDialog.sqf
            │   ├── fn_confirmCost.sqf
            │   ├── fn_openCategorySelect.sqf
            │   ├── fn_confirmCategory.sqf
            │   ├── fn_exportPreset.sqf
            │   ├── fn_formatCostArray.sqf
            │   ├── fn_formatSimpleArray.sqf
            │   ├── fn_arsenalInit.sqf
            │   ├── fn_arsenalExport.sqf
            │   └── fn_parseLoadout.sqf
            └── ui/
                ├── defines.hpp       # Controles base UI
                └── dialogs.hpp       # Dialogos del mod
```

## Referencia: KP Liberation

El proyecto de referencia esta en `../kp_liberation_DEVKIT/`. Los archivos de preset definen:

### Formatos de Arrays

1. **Formato "cost"** - `[classname, supplies, ammo, fuel]`:
   - `infantry_units`, `light_vehicles`, `heavy_vehicles`, `air_vehicles`
   - `static_vehicles`, `buildings`, `support_vehicles`

2. **Formato "simple"** - Arrays de strings:
   - `militia_squad`, `opfor_vehicles`, `civilians`, `civilian_vehicles`
   - `GRLIB_arsenal_weapons`, `GRLIB_arsenal_magazines`, etc.

3. **Formato "single"** - Variables individuales:
   - `FOB_typename`, `crewman_classname`, `pilot_classname`, etc.

## Tecnologias

- **Lenguaje**: SQF (Arma 3 scripting)
- **Configuracion**: config.cpp (formato clase de Arma)
- **UI**: Arma 3 Dialog system
- **Persistencia**: profileNamespace
- **Dependencias**: CBA_A3 (requerido), ACE3 (opcional)
- **Empaquetado**: PBO (Packed Bohemia Object)

## Comandos Utiles

```bash
# Empaquetar addon (requiere Arma 3 Tools)
# Se usa AddonBuilder o armake2

# Validar sintaxis SQF
# sqfvm --parse archivo.sqf
```

## Convenciones

- Prefijo de funciones: `LBH_fnc_`
- Prefijo de variables globales: `LBH_`
- Comentarios en ingles en el codigo
- Documentacion en espanol
- IDDs de dialogos: 58001-58003

## Uso del Mod

1. **Editor 3DEN**: Tools > Liberation Builder
   - Add to BLUFOR/OPFOR/Resistance/Civilians/Arsenal
   - Open Management Panel
   - Export All Presets

2. **Menu contextual**: Click derecho en objetos seleccionados
   - Add (Auto-detect)
   - Add to Category...

3. **Panel de gestion**:
   - Seleccionar preset y categoria
   - Buscar classnames
   - Añadir manual, eliminar, exportar

4. **ACE Arsenal**: Ctrl+Shift+E para exportar loadout actual

## Notas para Claude

1. Los datos se guardan en `profileNamespace` con clave `LBH_savedData`
2. La exportacion copia al portapapeles en formato SQF compatible con KP Liberation
3. La deteccion automatica usa `isKindOf` y herencia de clases
4. El mod requiere CBA_A3 para Event Handlers extendidos
