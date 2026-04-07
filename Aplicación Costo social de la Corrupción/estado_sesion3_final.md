# Estado del proyecto — Sesión 3 (marzo 2026)

**Proyecto:** Costo Social de la Corrupción en Chile
**Tecnología:** R Shiny → GitHub Pages
**Objetivo principal:** Visualizar cuántos beneficios sociales no se entregaron por causa de la corrupción. Cada decisión nueva se evalúa contra este objetivo antes de incorporarse.

---

## Lo que se completó en esta sesión

### Revisión de las seis fichas de áreas sociales
Se revisaron todas las notas pendientes abiertas en las fichas de Educación, Salud, Pensiones, Seguridad, Vivienda y Género. De 12 notas abiertas:

- **3 cerradas con dato verificado**
- **5 resueltas con decisión metodológica/editorial**
- **4 que permanecen sin dato primario accesible** (no bloqueantes — todas tienen estimación proxy usable con disclaimer)

### Dato actualizado — PGU beneficiarios
La ficha de Pensiones tenía "más de 3 millones" como beneficiarios de PGU (en realidad era el total del sistema previsional). Dato corregido: **2.404.000 beneficiarios PGU activos** (Superintendencia de Pensiones, feb. 2026).

### Dato actualizado — Residencias Transitorias activas
La ficha de Género no tenía número exacto. Dato incorporado: **35 Residencias Transitorias activas**, 8 en la Región Metropolitana (SernamEG, directora, El Mostrador, abril 2024).

### Cinco decisiones metodológicas y editoriales cerradas

| # | Área | Decisión | Resolución |
|---|---|---|---|
| 1 | Pensiones | Deuda previsional: ¿usar dato 2024? | ✅ Mantener dato 2024 ($16 billones / 315.000 empleadores) con nota sobre cotización patronal nueva. Nivel: Escenario proyectado. |
| 2 | Seguridad | Reinserción: ¿usar estimación indirecta? | ✅ Usar ~$5.250.000/persona/año con disclaimer. Nivel: Escenario proyectado. |
| 3 | Vivienda | Campamentos: ¿mantener estimación US$6.000 MM? | ✅ Mantener con nota explícita de que es estimación ministerial sin documento fuente identificado. Nivel: Escenario proyectado. |
| 4 | Vivienda | Mejoramiento: ¿usar proxy rural para urbano? | ✅ Usar Habitabilidad Rural (120 UF ≈ $4.740.000) como proxy. Solo mejoramiento básico. Nivel: Dato estimado. |
| 5 | Género | Postnatal: ¿mantener $5.683/día? | ✅ Mantener como cota conservadora con nota sobre posible reajuste post julio 2024. Nivel: Política hipotética (aplica a la subárea completa). |

### Arquitectura actualizada
La arquitectura del proyecto fue reescrita completa para reflejar el estado real al cierre de Sesión 3: fichas de los 5 casos completas, fuentes de las 6 áreas mapeadas, costos unitarios de referencia documentados por subárea, y decisiones metodológicas incorporadas.

---

## Tabla de montos — completa y verificada

| # | Caso | Factor INE | Monto base | Monto ajustado dic. 2025 |
|---|---|---|---|---|
| 1 | Corfo-Inverlink | ×2,364 | $85.000 MM CLP | ~$200.940 MM CLP |
| 2 | Pacogate | ×1,478 | $28.348 MM CLP | ~$41.898 MM CLP |
| 3 | SQM | ×1,773 | ~$7.615 MM CLP | ~$13.500 MM CLP |
| 4 | Caso Penta | ×1,620 | $10.000 MM CLP | ~$16.200 MM CLP |
| 5 | Milicogate | ×1,747 | $6.100 MM CLP | ~$10.657 MM CLP |

**Fuente IPC:** calculadora oficial INE (https://calculadoraipc.ine.cl), año base universal diciembre 2025.

---

## Tabla de costos unitarios — referencia rápida para redacción

| Área | Subárea | Costo unitario de referencia | Disclaimer |
|---|---|---|---|
| Educación | I+D | Comparativo vs. presupuesto ANID $438.561 MM | Escenario proyectado |
| Educación | Becas universitarias | $1.150.000/año (Beca JGM) | Dato estimado |
| Educación | Jardines JUNJI | ~$1.200 MM/jardín | Dato estimado |
| Educación | Liceos TP | ~$80 MM/liceo | Dato estimado |
| Educación | Infraestructura rural | ~$423 MM/establecimiento | Dato estimado |
| Salud | LRS — enfermedades raras | ~$7.500.000/paciente/año | Dato estimado |
| Salud | Salud mental (COSAM) | ~$1.304 MM/centro | Dato estimado |
| Salud | Operaciones en espera | ~$800.000/cirugía | Dato estimado |
| Salud | Salud dental | ~$65.000/AOI | Dato estimado |
| Salud | UCI | ~$17.500.000/cama → múltiplo | Dato estimado |
| Pensiones | PGU informales | $2.780.784/año | Dato estimado |
| Pensiones | Brecha género (BAC) | ~$1.200.000/año | Dato estimado |
| Pensiones | Deuda previsional | Argumento narrativo vs. $16 billones | Escenario proyectado |
| Pensiones | PGU adultos mayores | $2.780.784/año | Dato estimado |
| Pensiones | Jóvenes informales | ~$600.000/año | Escenario proyectado |
| Seguridad | Carabineros | ~$33.200.000/año | Dato estimado |
| Seguridad | Ciberdelito PDI | ~$30.000.000/año | Dato estimado |
| Seguridad | Plazas penitenciarias | ~$65.000.000/plaza | Dato estimado |
| Seguridad | Reinserción | ~$5.250.000/persona/año | Escenario proyectado |
| Seguridad | Fiscales ECOH | ~$38.800.000/año o vs. presupuesto $12.197 MM | Dato estimado |
| Vivienda | DS49 | ~$31.600.000/vivienda (800 UF) | Dato estimado |
| Vivienda | Lista de espera | ~$600.800 MM/año → meses financiados | Escenario proyectado |
| Vivienda | DS52 arriendo | ~$6.712.000/familia (170 UF, 8 años) | Dato estimado |
| Vivienda | Campamentos | ~$46.800.000/familia | Escenario proyectado |
| Vivienda | Mejoramiento básico | ~$4.740.000/vivienda (120 UF) | Dato estimado |
| Género | Cuidados | ~$912.000/año por cuidadora | Dato estimado |
| Género | Pensiones alimenticias | ~$30.000.000/año por funcionario | Dato estimado |
| Género | Residencias Transitorias | ~$300.000.000/residencia (est.) | Dato estimado |
| Género | Persecución penal VIF | ~$30.000.000/año por profesional | Dato estimado |
| Género | Postnatal masculino | $170.490/padre (30 días × $5.683) | Política hipotética |

---

## Pendientes que permanecen sin dato primario (no bloqueantes)

Estos cuatro datos no están disponibles en línea. Todos tienen estimación proxy usable. No son bloqueantes para la redacción.

| Dato | Fuente correcta | Proxy actual |
|---|---|---|
| Beneficiarios activos LRS 2024 y presupuesto ejecutado | MINSAL — Informe anual LRS | ~7.500 pacientes / ~$7,5 MM/año (estimación indirecta) |
| Presupuesto Rehabilitación y Reinserción Gendarmería DIPRES 2024 | DIPRES — partida Gendarmería | ~$5.250.000/persona/año (estimación proporcional) |
| Costo unitario Residencia Transitoria SernamEG | DIPRES — partida SernamEG | ~$300 MM (habilitación + operación año 1) |
| Presupuesto VIF SernamEG 2026 | Ley de Presupuestos 2026 DIPRES | Tendencia documentada: $73.189 MM (2023) → $151.587 MM (2026 todo el sistema de cuidados) |

---

## Próximos pasos (en orden)

### Paso 1 — Verificación rápida antes de redactar (opcional pero recomendable)
Tres consultas puntuales que cierran los últimos datos menores antes de la redacción:
- Subsidio postnatal actualizado post julio 2024 en SUSESO (1 consulta)
- Costo exacto del AOI odontológico en FONASA o MINSAL (1 consulta)
- Presupuesto VIF SernamEG 2026 en Ley de Presupuestos DIPRES (1 consulta)

### Paso 2 — Redacción de textos de impacto (~150–180 párrafos)
Con todos los costos unitarios definidos, comenzar la redacción. El orden sugerido:
1. **Salud** — argumentos más potentes (lista de espera, UCI), datos bien verificados
2. **Pensiones** — PGU y reforma 2025 bien documentadas, argumento humano directo
3. **Educación** — arco narrativo I+D + TP requiere cuidado en la redacción
4. **Seguridad** — ironía editorial ECOH requiere tono preciso
5. **Vivienda** — párrafo introductorio del área pendiente; escribirlo primero
6. **Género** — más subáreas con estimaciones proxy; disclaimers más elaborados

### Paso 3 — Codificación R Shiny
Una vez que los textos estén redactados y revisados, comenzar la implementación.

### Paso 4 — Párrafo de conclusión
Redactar último, cuando todos los textos de impacto estén completos y la perspectiva del proyecto esté clara.

---

## Nota sobre continuidad entre chats

Al inicio de la Sesión 4, cargar este archivo y la Arquitectura actualizada como contexto. Mencionar que venimos de cerrar las 5 decisiones metodológicas de Sesión 3, que los costos unitarios están todos definidos, y que el siguiente paso es la redacción de textos de impacto. Sugerir comenzar por Salud o Pensiones.
