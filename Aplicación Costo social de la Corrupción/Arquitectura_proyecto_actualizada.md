# Proyecto: Costo Social de la Corrupción en Chile
## Arquitectura del proyecto — actualizada Sesión 3 (marzo 2026)

---

## Descripción general

Aplicación web desarrollada en R Shiny, publicable en GitHub Pages, que visualiza el costo social de los cinco casos de corrupción más significativos en términos económicos de la historia reciente de Chile. El proyecto traduce montos defraudados en beneficios sociales concretos no entregados, ajustados por inflación según el IPC del INE. Tiene carácter exploratorio, educativo y ciudadano, y busca constituir una defensa de la democracia al mostrar las consecuencias reales de la corrupción en la vida de las personas.

---

## Principio rector del proyecto

**Regla de foco:** El objetivo principal es visualizar cuántos beneficios sociales no se entregaron por causa de la corrupción. Cada nueva idea que se agregue al proyecto debe evaluarse contra este objetivo. Si una adición no contribuye directamente a ese propósito o genera trabajo desproporcionado respecto a su aporte, se descarta o se deja para una versión futura. Las ideas en standby se registran en la sección correspondiente al final de este documento.

---

## Estado del proyecto

- [x] Arquitectura de la interfaz definida
- [x] Casos de corrupción seleccionados
- [x] Áreas sociales y subáreas definidas
- [x] Fuente IPC definida y verificada (calculadora oficial INE, año base diciembre 2025)
- [x] Fichas de los 5 casos completas con montos ajustados verificados
- [x] Fuentes por área mapeadas y verificadas (Sesiones 7–12)
- [x] Decisiones metodológicas y editoriales de áreas cerradas (Sesión 3)
- [ ] Textos de impacto redactados (~150–180 párrafos)
- [ ] Código R Shiny desarrollado
- [ ] Publicación en GitHub Pages

---

## Arquitectura de la interfaz

### Elementos fijos

- **Título** del proyecto
- **Bajada** que explica el propósito, el carácter exploratorio e hipotético de los escenarios, y el ajuste por inflación
- **Párrafo de conclusión** al final: posicionamiento del proyecto como defensa de la democracia

### Elementos interactivos

Dos listas desplegables independientes:

1. **Selector de caso de corrupción** → despliega descripción breve del caso (4-5 líneas), incluyendo involucrados
2. **Selector de área social** → despliega las 5 subáreas correspondientes

### Estructura de cada subárea

Cada subárea contiene cuatro elementos en este orden:

1. **Título** de la subárea
2. **Párrafo de contexto** — estático, describe la problemática estructural del país en esa subárea, sin mencionar involucrados
3. **Gráfico** — dinámico, cambia según el caso seleccionado
4. **Párrafo de impacto** — dinámico, vincula el monto del caso con la subárea en lenguaje ciudadano accesible

### Secciones finales de la app (en orden)

1. Párrafo de conclusión — defensa de la democracia
2. Bibliografía y fuentes
3. Apéndice — Tablas de involucrados por caso _(formato a definir antes de codificación)_

---

## Decisiones metodológicas

### Montos

- Se utiliza **revisión sistemática de fuentes** para casos con montos disputados: se documentan el mínimo judicial, el máximo periodístico y el promedio utilizado
- Todos los montos se **ajustan por IPC acumulado del INE** usando la calculadora oficial (https://calculadoraipc.ine.cl), ingresando $1.000 pesos desde el año de referencia del caso hasta **diciembre 2025**
- Se usa **diciembre 2025** como año de referencia universal por ser el año cerrado más reciente con dato completo disponible
- El factor INE tiene precedencia metodológica sobre cualquier cálculo alternativo, porque el INE utiliza empalme entre bases históricas
- Los montos son la base de todos los cálculos de impacto social

### Factores IPC verificados — tabla completa

| Caso | Período | Factor INE | Monto base | Monto ajustado dic. 2025 |
|---|---|---|---|---|
| Corfo-Inverlink | dic. 2003 → dic. 2025 | ×2,364 | $85.000 MM CLP | ~$200.940 MM CLP |
| Pacogate | dic. 2017 → dic. 2025 | ×1,478 | $28.348 MM CLP | ~$41.898 MM CLP |
| SQM | dic. 2011 → dic. 2025 | ×1,773 | ~$7.615 MM CLP | ~$13.500 MM CLP |
| Caso Penta | dic. 2014 → dic. 2025 | ×1,620 | $10.000 MM CLP | ~$16.200 MM CLP |
| Milicogate / FAMAE | dic. 2012 → dic. 2025 | ×1,747 | $6.100 MM CLP | ~$10.657 MM CLP |

### Tipos de dato por subárea

Hay tres tipos de dato con distinto nivel de precisión:

- **Costo unitario directo** — ej: costo de construir una vivienda SERVIU (fuente: BIP / MINVU)
- **Costo por beneficiario** — ej: costo anual de un postnatal masculino ampliado (fuente: SUSESO + INE)
- **Costo de oportunidad indirecto** — ej: brecha de inversión en I+D respecto a la meta del 1% del PIB (fuente: OCDE + ANID)

### Disclaimers diferenciados

Se utilizan tres niveles de advertencia metodológica:

- **"Dato estimado"** — monto sin sentencia firme o con cifras disputadas entre fuentes, o costo unitario construido a partir de presupuesto total dividido entre beneficiarios estimados
- **"Escenario proyectado"** — cálculo basado en estimaciones demográficas, comparadas o en proporciones presupuestarias indirectas
- **"Política hipotética"** — subárea basada en proyecciones internacionales sin política nacional implementada

### Textos

Se utiliza la **opción 1: párrafos escritos manualmente** para el párrafo de impacto de cada combinación caso-área, con el fin de mantener calidad narrativa y permitir disclaimers diferenciados. Esto implica aproximadamente 150–180 textos cortos en total (5 casos × 6 áreas × 5 subáreas).

---

## Decisiones metodológicas y editoriales cerradas en Sesión 3

Las siguientes decisiones fueron tomadas en la Sesión 3 y no deben reabrirse salvo hallazgo de nueva evidencia relevante.

### Decisión 1 — Área Pensiones: Deuda previsional (subárea 3)
Se mantiene el dato de $16 billones / 315.000 empleadores / 2,4 millones de trabajadores (AAFP, 2024). Se agrega nota en los textos de impacto: "La nueva cotización patronal del 1% vigente desde agosto de 2025 puede haber modificado el stock de morosos; no existe cifra oficial 2025 publicada al cierre de esta versión." Nivel de disclaimer: **"Escenario proyectado"**.

### Decisión 2 — Área Seguridad: Costo de reinserción (subárea 4)
Se usa la estimación indirecta de ~$5.250.000/persona/año (proporción del presupuesto de Gendarmería sobre beneficiarios de 2017). El dato de beneficiarios activos actualizados no está disponible en línea. El argumento central —que la reinserción reduce la reincidencia al 22,2% con programa CET— no depende del costo unitario exacto. Nivel de disclaimer: **"Escenario proyectado"**.

### Decisión 3 — Área Vivienda: Costo por familia en campamentos (subárea 4)
Se mantiene la estimación de US$6.000 MM como costo total de proveer solución habitacional a las 120.584 familias en campamento (~$46.800.000 por familia), derivando un costo unitario de $46.800.000 por familia. Se agrega nota explícita: "Estimación ministerial MINVU citada en medios; no se identificó el documento fuente original." Nivel de disclaimer: **"Escenario proyectado"**.

### Decisión 4 — Área Vivienda: Mejoramiento básico (subárea 5)
Se usa el Programa Habitabilidad Rural (120 UF ≈ $4.740.000) como proxy del costo de mejoramiento básico también en contexto urbano. El mejoramiento básico —techo, piso, muro— tiene costos de materiales y mano de obra similares en ambos contextos; la diferencia es el terreno, que no entra en el cálculo de mejoramiento. Se usa solo el nivel de mejoramiento básico, sin extender a mejoras de mayor envergadura. Nivel de disclaimer: **"Dato estimado"**.

### Decisión 5 — Área Género: Subsidio postnatal masculino (subárea 5)
Se usa $5.683/día como cota conservadora (vigente desde mayo 2023, SUSESO). El subsidio se reajusta automáticamente con cambios al ingreso mínimo; el monto post-reajuste julio 2024 no fue verificado pero la variación estimada es de 5–8%, lo que subestima levemente el alcance calculado. Nivel de disclaimer: **"Política hipotética"** (aplica al postnatal masculino ampliado como política, independientemente del subsidio base).

---

## Casos de corrupción seleccionados

| # | Caso | Monto base | Monto ajustado dic. 2025 | Período | Complejidad disclaimer |
|---|---|---|---|---|---|
| 1 | Corfo-Inverlink | $85.000 MM CLP | ~$200.940 MM CLP | 2003 | Baja — bien documentado |
| 2 | Pacogate / Fraude Carabineros | $28.348 MM CLP | ~$41.898 MM CLP | 2006–2017 | Media — proceso activo |
| 3 | SQM | ~$7.615 MM CLP (US$14,7 MM) | ~$13.500 MM CLP | 2008–2014 | Alta — evasión tributaria; impunidad judicial casi total en Chile |
| 4 | Caso Penta | $10.000 MM CLP | ~$16.200 MM CLP | 2014 | Media — recuperado solo porque hubo investigación |
| 5 | Milicogate / FAMAE | $6.100 MM CLP (causa madre) | ~$10.657 MM CLP | 2010–2014 | Alta — absuelto principal imputado; causa militar abierta |

> **Nota editorial:** El ranking incluye cuatro casos en democracia y uno militar/institucional. Esto se aborda editorialmente en el párrafo de conclusión, que posiciona el proyecto como defensa de la democracia y no como crítica a ella.

> **Nota de conexión entre casos:** Los casos SQM y Penta están relacionados a través de personajes comunes, en particular Pablo Wagner, quien recibía pagos de Penta mientras ejercía como subsecretario de Minería y favoreció a SQM en la licitación del litio en el mismo período. Esta conexión se documenta en las fichas de ambos casos y se abordará editorialmente en la app.

---

## Áreas sociales y subáreas — con costos unitarios de referencia

### 1. Educación

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | I+D — matriz productiva y absorción de técnicos y profesionales | Comparativo vs. presupuesto ANID ($438.561 MM, 2024) | Costo de oportunidad indirecto | Escenario proyectado |
| 2 | Becas universitarias | $1.150.000/año (Beca Juan Gómez Millas) | Costo por beneficiario | Dato estimado |
| 3 | Jardines infantiles JUNJI | ~$1.200 MM por jardín estándar (80–100 niños) | Costo unitario directo | Dato estimado |
| 4 | Liceos técnico-profesionales — equipamiento | ~$80 MM por liceo (Programa MINEDUC 2022–2024) | Costo unitario directo | Dato estimado |
| 5 | Infraestructura escolar rural | ~$423 MM por establecimiento (Fondo conservación MINEDUC 2024) | Costo unitario directo | Dato estimado |

### 2. Salud

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | Medicamentos de alto costo / enfermedades raras (LRS) | ~$7.500.000/paciente/año | Costo por beneficiario | Dato estimado |
| 2 | Salud mental ambulatoria (COSAM) | ~$1.304 MM por centro | Costo unitario directo | Dato estimado |
| 3 | Operaciones no realizadas por espera | ~$800.000 por cirugía electiva | Costo por beneficiario | Dato estimado |
| 4 | Salud dental pública | ~$65.000 por alta odontológica integral (AOI) | Costo por beneficiario | Dato estimado |
| 5 | Equipamiento UCI | ~$17.500.000 por cama UCI completa → expresado como múltiplo de la capacidad pública | Costo unitario directo | Dato estimado |

### 3. Pensiones

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | Pensión básica para trabajadores informales | $2.780.784/año (PGU vigente feb. 2026, 65–81 años) | Costo por beneficiario | Dato estimado |
| 2 | Brecha de género — compensación por cuidados no remunerados | ~$1.200.000/año (BAC al tope, 2,5 UF/mes) | Costo por beneficiario | Dato estimado |
| 3 | Deuda previsional — cotizaciones no pagadas por empleadores | Argumento narrativo vs. $16 billones de deuda total (AAFP, 2024) | Costo de oportunidad indirecto | Escenario proyectado |
| 4 | PGU ampliada para adultos mayores en pobreza | $2.780.784/año (PGU vigente feb. 2026) | Costo por beneficiario | Dato estimado |
| 5 | Jóvenes sin pensión futura — cotización en empleos precarios | ~$600.000/año (10% sobre sueldo mínimo $500.000) | Costo por beneficiario | Escenario proyectado |

### 4. Seguridad

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | Dotación Carabineros | ~$33.200.000/año por carabinero (costo promedio del sistema) | Costo por beneficiario | Dato estimado |
| 2 | Ciberdelito y delitos económicos (PDI) | ~$30.000.000/año por investigador especializado | Costo por beneficiario | Dato estimado |
| 3 | Infraestructura penitenciaria — reducción del hacinamiento | ~$65.000.000/plaza nueva (promedio Plan Maestro y La Laguna) | Costo unitario directo | Dato estimado |
| 4 | Centros de reinserción | ~$5.250.000/persona/año | Costo por beneficiario | Escenario proyectado |
| 5 | Fiscales especializados — ECOH | ~$38.800.000/año por profesional; o comparativo vs. presupuesto ECOH ($12.197 MM, 2025) | Costo por beneficiario / comparativo | Dato estimado |

### 5. Vivienda

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | Viviendas sociales SERVIU (DS49) | 800 UF = ~$31.600.000 por vivienda (subsidio base al Estado) | Costo unitario directo | Dato estimado |
| 2 | Lista de espera SERVIU — tiempo acortado | ~$600.800 MM/año de programa (19.000 subsidios × $31,6 MM) → expresado en meses adicionales financiados | Costo de oportunidad indirecto | Escenario proyectado |
| 3 | Subsidios de arriendo (DS52) | 170 UF = ~$6.712.000 por familia (8 años) | Costo por beneficiario | Dato estimado |
| 4 | Campamentos — solución habitacional | ~$46.800.000/familia (est. ministerial US$6.000 MM ÷ 120.584 familias) | Costo unitario directo | Escenario proyectado |
| 5 | Mejoramiento de viviendas básico | 120 UF = ~$4.740.000 por vivienda (Programa Habitabilidad Rural como proxy) | Costo por beneficiario | Dato estimado |

### 6. Género

| # | Subárea | Costo unitario | Tipo | Disclaimer |
|---|---|---|---|---|
| 1 | Política nacional de cuidados | ~$912.000/año por cuidadora (estipendio dependencia severa) | Costo por beneficiario | Dato estimado |
| 2 | Pensiones alimenticias — persecución institucional | ~$30.000.000/año por funcionario Tribunal de Familia | Costo por beneficiario | Dato estimado |
| 3 | Casas de acogida VIF (Residencias Transitorias) | ~$300.000.000 por residencia (habilitación + primer año operación) | Costo unitario directo | Dato estimado |
| 4 | Acceso a la justicia — persecución penal VIF | ~$30.000.000/año por profesional especializado SernamEG | Costo por beneficiario | Dato estimado |
| 5 | Postnatal masculino ampliado | $170.490 por padre (30 días × $5.683/día mínimo SUSESO) | Costo por beneficiario | Política hipotética |

---

## Diseño visual

- **Colores:** paleta pastel — tonos terracota, verde salvia, azul pizarra, durazno, sobre fondo crema o blanco roto
- **Estilo:** accesible para público general, impactante sin ser agresivo, legible en móvil y desktop
- **Tecnología:** R Shiny, publicado en GitHub Pages

---

## Fuentes

### Fuentes de casos de corrupción

- Contraloría General de la República
- Poder Judicial de Chile (sentencias)
- CIPER Chile
- El Mercurio, La Tercera, El Mostrador, The Clinic, BioBioChile, Ex-Ante
- Interferencia (especialmente para Pacogate)

### Fuentes de costos unitarios por área

- Banco Integrado de Proyectos (BIP) — Ministerio de Desarrollo Social
- MINVU — costos vivienda social (DS49, DS52, Habitabilidad Rural)
- MINSAL — Ley Ricarte Soto, lista de espera, salud dental
- JUNAEB / JUNJI — becas y jardines infantiles
- SUSESO — datos previsionales y subsidios
- INE — IPC histórico y datos demográficos
- ANID — inversión en I+D y becas doctorales
- OCDE — datos comparados (I+D, postnatal, pensiones)
- SernamEG / MinMujeryEG — programas de género y VIF
- Gendarmería / DIPRES — reinserción penitenciaria
- Fiscalía de Chile — ECOH y Fiscalía Supraterritorial
- PDI — brigadas de ciberdelito y delitos económicos
- Superintendencia de Pensiones — PGU y reforma previsional 2025

### Fuente IPC

- Calculadora oficial INE: https://calculadoraipc.ine.cl
- Año base de referencia: diciembre 2025
- Metodología: ingresar $1.000 pesos desde el año de referencia del caso hasta diciembre 2025; el resultado dividido por 1.000 es el factor multiplicador

---

## Ideas en standby _(no incorporar hasta completar el proyecto base)_

### Gráfico de redes de conexiones entre casos

**Idea:** Apartado adicional llamado "La red detrás de los casos" con visualización interactiva de conexiones entre personajes de distintos casos (Penta-SQM-Wagner).

**Tecnología sugerida:** `visNetwork` o `networkD3` en R Shiny.

**Estado:** Standby. Evaluar en versión 2.0.

**Justificación:** Trabajo adicional significativo que puede desviar el foco del objetivo principal.

---

## Notas pendientes

- [ ] Actualizar fichas de áreas con decisiones de Sesión 3 incorporadas (Pensiones, Seguridad, Vivienda, Género)
- [ ] Verificar subsidio postnatal actualizado en SUSESO antes de redactar textos de Género subárea 5
- [ ] Definir formato del apéndice de involucrados antes de la codificación
- [ ] Redactar párrafo de conclusión (conviene hacerlo último, tras completar todos los textos de impacto)
