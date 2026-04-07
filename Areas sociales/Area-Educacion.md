# Área 1: Educación — Fuentes y costos unitarios

**Sesión:** 7
**Estado:** ✅ Fuentes mapeadas — costos unitarios verificados
**Fuente IPC de referencia:** calculadora oficial INE, diciembre 2025

---

## Resumen de subáreas y tipo de dato

| #   | Subárea                                                         | Tipo de dato                   | Nivel de precisión   | Argumento visual                                                     |
| --- | --------------------------------------------------------------- | ------------------------------ | -------------------- | -------------------------------------------------------------------- |
| 1   | I+D — matriz productiva y absorción de técnicos y profesionales | Costo de oportunidad indirecto | Escenario proyectado | B — N unidades (% presupuesto ANID)                                  |
| 2   | Becas universitarias                                            | Costo por beneficiario         | Dato estimado        | B — N becas anuales                                                  |
| 3   | Jardines infantiles JUNJI                                       | Costo unitario directo         | Dato estimado        | A/B — contraste vs. costo anual de igualar financiamiento parvulario |
| 4   | Liceos técnico-profesionales — equipamiento e infraestructura   | Costo unitario directo         | Dato estimado        | B — N liceos equipados                                               |
| 5   | Infraestructura escolar rural                                   | Costo unitario directo         | Dato estimado        | A/B — Corfo ≥15% del déficit estimado                                |

**Cambios respecto a versión anterior:** Subárea 4 reemplaza "Profesores de refuerzo". Subárea 1 reformulada: el argumento ya no es "fuga de cerebros/doctorados" sino la incapacidad de Chile de generar una matriz productiva que absorba técnicos y profesionales por falta de inversión en I+D.

---

## Subárea 1 — I+D y matriz productiva: Chile no puede absorber a sus propios técnicos y profesionales

**Tipo de dato:** Costo de oportunidad indirecto
**Nivel de disclaimer:** "Escenario proyectado" — la relación entre subinversión en I+D y falta de empleos cualificados está documentada pero no es atribuible directamente a un monto específico de corrupción

### Argumento central

Chile invierte el 0,39% de su PIB en I+D — una de las cifras más bajas de la OCDE — lo que se traduce en una matriz productiva simple, concentrada en materias primas, que no genera suficientes empleos cualificados para absorber a los técnicos y profesionales que el propio sistema educativo forma. El problema no es solo que los investigadores emigren: es que un técnico en automatización industrial o un ingeniero en energías renovables formado en Chile tiene pocas opciones de trabajo de calidad en el país, porque las empresas que los necesitarían no existen o son escasas.

El argumento de impacto no es aritmético sino comparativo: el dinero desviado en [caso] representa una fracción significativa del presupuesto total con que Chile financia toda su investigación científica y tecnológica (ANID, $438.561 MM en 2024). Es la inversión que no ocurrió y que habría podido contribuir a diversificar la economía.

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Gasto en I+D Chile 2022 | 0,39% del PIB = MM$1.031.448 | Encuesta I+D 2022, Minciencia + INE |
| Promedio OCDE en I+D | 2,72% del PIB | OCDE / Minciencia |
| Meta Gobierno Boric | 1% del PIB | Minciencia |
| Brecha Chile vs. meta 1% del PIB | ~0,61% del PIB (~MM$1.600.000 aprox.) | Cálculo sobre PIB 2022 |
| Presupuesto ANID 2024 | $438.561 MM CLP | ANID — cierre presupuestario 2024 |
| Investigadores en Chile | ~1,1 por cada 1.000 personas laboralmente activas | Minciencia / U. Chile |
| Total investigadores EJC (2022) | ~2.513 (equivalentes jornada completa) | Encuesta I+D 2022, Minciencia |
| Costo beca doctoral ANID — Doctorado Nacional (manutención) | Máximo $7.800.000/año | ANID — Bases Doctorado Nacional 2025 |
| Costo beca doctoral ANID — Doctorado Nacional (arancel) | Máximo $2.700.000/año | ANID — Bases Doctorado Nacional 2025 |
| **Costo total beca doctoral ANID por becario/año** | **Hasta $10.500.000/año** (manutención + arancel) | ANID — Bases Doctorado Nacional 2025 |

### Argumento de impacto para la app

El gráfico muestra el monto del caso en relación con el presupuesto total de ANID ($438.561 MM en 2024) — la agencia que financia toda la investigación científica y tecnológica del país. Chile lleva más de una década invirtiendo menos del 0,4% de su PIB en I+D, mientras el promedio OCDE triplica esa cifra. Esa subinversión no es abstracta: se traduce en una economía que sigue dependiendo del cobre y los recursos naturales, y que no genera los empleos cualificados que los técnicos y profesionales chilenos necesitan para desarrollarse en el país.

**Datos para construir el gráfico:**
- Presupuesto total ANID 2024: $438.561 MM
- Corfo ($200.940 MM) = 46% del presupuesto ANID → argumento potente
- Milicogate ($10.657 MM) = 2,4% del presupuesto ANID → se expresa como porcentaje
- Brecha anual Chile vs. meta 1% PIB: ~$1.600.000 MM — dato de contexto narrativo, no barra principal
- Chile tiene ~900 liceos TP; en un tercio, los docentes reportan mínima o nula disponibilidad de equipamiento

**Disclaimer obligatorio:** "Escenario proyectado. La relación entre subinversión en I+D y falta de empleos cualificados está documentada por Minciencia y la OCDE, pero no es posible atribuir directamente empleos no creados a un monto específico de corrupción."

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| Encuesta I+D 2022 — Minciencia | Gasto total I+D sube a 0,39% del PIB; MM$1.031.448; 2.513 investigadores EJC | [ver nota](https://minciencia.gob.cl/noticias/encuesta-2022-de-id-del-minciencia-y-el-ine-gasto-total-en-id-sube-de-036-a-039-del-pib/) |
| Minciencia — inversión 0,34% PIB (2020) | Diez años sin variación; caída MM$14.938 respecto a 2019 | [ver nota](https://www.minciencia.gob.cl/noticias/inversion-total-de-investigacion-y-desarrollo-en-chile-se-mantiene-en-un-034-del-pib-y-completa-diez-anos-sin-mayores-variaciones/) |
| U. de Chile — columna vicerrector I+D | 0,36% del PIB; 1,1 investigadores por cada 1.000 activos; meta 1% | [ver columna](https://uchile.cl/noticias/216757/columna-de-opinion-del-vicerrector-christian-gonzalez-billault) |
| ANID — cierre presupuestario 2024 | Presupuesto 2024: $438.561 MM; ejecución 99,34% | [ver nota](https://anid.cl/anid-cierra-el-ano-2024-con-una-ejecucion-presupuestaria-del-9934/) |
| Minciencia — Fondo de Investigación Universidades (FIU) | Hasta $3.000 MM por universidad/año en etapa 2; meta 1% del PIB | [ver nota](https://www.minciencia.gob.cl/noticias/el-nuevo-fondo-de-investigacion-para-universidades-que-presentamos-hoy-pavimenta-el-camino-hacia-el-1-en-id/) |
| Diario Financiero — I+D 0,39% | Confirmación encuesta 2022; brecha OCDE | [ver nota](https://www.df.cl/df-lab/innovacion-y-startups/gasto-en-id-sube-pero-sigue-lejos-de-la-meta-del-gobierno-y-promedio-ocde) |
| ANID — Bases Concursales Doctorado Nacional 2025 | Manutención máx. $7.800.000/año + arancel máx. $2.700.000/año = hasta $10.500.000/año por becario; duración máxima 4 años | [ver bases](https://s3.amazonaws.com/documentos.anid.cl/BecasChile/2025/DoctoradoNacional/Bases_Doctorado_Nacional_2025_Lectura_Obligatoria.pdf) |

---

## Subárea 2 — Becas universitarias

**Tipo de dato:** Costo por beneficiario
**Nivel de disclaimer:** "Dato estimado" — los montos de becas son fijos por ley y bien documentados

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Beca Bicentenario | Financia el arancel de referencia completo (varía por carrera e institución) | Mineduc / FUAS |
| Beca Juan Gómez Millas | Hasta $1.150.000/año | FUAS / portal beneficiosestudiantiles.cl |
| Beca Excelencia Técnica | Hasta $900.000/año | FUAS |
| Beca Excelencia Académica | Hasta $1.150.000/año | FUAS |
| Beca de Alimentación (BAES) | $45.000/mes × 10 meses = $450.000/año | JUNAEB / Cooperativa ene. 2024 |
| Beca Presidente de la República (enseñanza media) | ~$750.000 anuales (6,2 UTM × 10 cuotas) | JUNAEB / tramitarcl.com 2025 |
| **Costo unitario de referencia para la app** | **$1.150.000/año** (Beca JGM o BEA — costo al fisco por estudiante/año) | FUAS 2025 |

**Nota metodológica:** Para los cálculos de impacto se recomienda usar el costo de la Beca Juan Gómez Millas ($1.150.000/año) como proxy del costo promedio al Estado por beca universitaria de arancel. Es la beca más representativa fuera de Bicentenario, con monto definido y citado en fuente oficial. Permite calcular: "el dinero del [caso] equivale a X becas universitarias anuales".

**Ejemplo de cálculo:**
- Corfo-Inverlink ajustado ($200.940 MM) ÷ $1.150.000 = ~174.730 becas universitarias anuales
- Milicogate ajustado ($10.657 MM) ÷ $1.150.000 = ~9.267 becas universitarias anuales

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| FUAS — portal oficial 2025–2026 | Lista completa de becas y montos; Bicentenario, JGM, BEA, Excelencia Técnica | [ver portal](https://fuas.cl/beneficios.html) |
| Portal Beneficios Estudiantiles — Beca Bicentenario | Requisitos, financiamiento arancel de referencia, CRUCH acreditadas | [ver ficha](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-bicentenario-bb) |
| Ayuda Mineduc — Beca Bicentenario | Descripción oficial actualizada 2026 | [ver ficha](https://www.ayudamineduc.cl/ficha/beca-bicentenario-6) |
| JUNAEB — BAES | Beca de Alimentación $45.000/mes desde 2024 | [ver página](https://www.junaeb.cl/beca-alimentacion-la-educacion-superior) |
| Cooperativa — BAES 2024 | Confirmación alza a $45.000 mensual desde 2024 | [ver nota](https://cooperativa.cl/noticias/pais/educacion/beneficios/cual-sera-el-monto-de-la-tarjeta-junaeb-en-2024/2023-10-16/214853.html) |
| tramitarcl.com — BPR 2025 | Beca Presidente República: ~$750.000 anuales, pago en cuotas mensuales | [ver ficha](https://tramitarcl.com/tramite/beneficios/beca-junaeb) |

---

## Subárea 3 — Jardines infantiles JUNJI

**Tipo de dato:** Costo unitario directo (construcción de establecimiento)
**Nivel de disclaimer:** "Dato estimado" — los costos de construcción son proyectos reales del BIP/JUNJI, bien documentados

### Datos clave

| Concepto | Valor | Referencia |
|---|---|---|
| Jardín rural pequeño (24 niños, 1 piso) — Punitaqui, 2023 | $828.930.942 | JUNJI Coquimbo, dic. 2023 |
| Jardín mediano urbano (80–96 niños, 2 pisos) — Villa Caupolicán, Temuco | $1.183.504.984 | JUNJI Araucanía |
| Jardín mediano con sala cuna (90 niños) — Principito, La Serena, 2023 | $1.910.748.355 | JUNJI Coquimbo, may. 2023 |
| Jardín con sala cuna (109 niños) — Centinela II, Talcahuano (nuevo proyecto) | +$1.600.000.000 | BioBioChile Investiga, nov. 2023 |
| Jardín grande con sala cuna (192 niños) — El Alto, Arica | $3.320.838.000 | CORE Arica, abr. 2022 |
| Reposición total jardín pequeño VTF — Pichi Ayen, Tirúa, 2023 | $610.289.203 | JUNJI Biobío, dic. 2023 |
| Costo total gobierno Boric en infraestructura parvularia | $120.118.146.000 (miles de pesos) | Revista de Educación, 2024 |
| **Costo unitario de referencia para la app** | **~$1.200 MM por jardín estándar** (capacidad 80–100 niños) | Promedio proyectos JUNJI 2022–2024 |

**Nota metodológica:** Se usa $1.200 MM como costo unitario de referencia por ser el promedio representativo de jardines medianos urbano-rurales en el período 2022–2024, con capacidad de 80–100 niños. Los costos varían significativamente según región (más caro en extremos) y capacidad. Para zonas rurales aisladas, el costo por niño puede ser hasta 3 veces mayor.

**Ejemplo de cálculo:**
- Corfo-Inverlink ajustado ($200.940 MM) ÷ $1.200 MM = ~167 jardines infantiles JUNJI
- Pacogate ajustado ($41.898 MM) ÷ $1.200 MM = ~35 jardines

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| JUNJI Coquimbo — Principito, La Serena | $1.910 MM para 90 niños, 899 m², 2023 | [ver nota](https://www.junji.gob.cl/casi-dos-mil-millones-de-pesos-destina-junji-para-la-reposicion-del-jardin-principito/) |
| JUNJI Coquimbo — Las Ramadas, Punitaqui | $828 MM para 24 niños, 1 piso, rural, 2023 | [ver nota](https://junji.cl/junji-invertira-mas-de-800-millones-de-pesos-en-la-construccion-de-nuevo-jardin-infantil-en-punitaqui/) |
| JUNJI Arica — El Alto | $3.320 MM para 192 niños, 1.255 m², 4 salas cuna | [ver nota](https://www.junji.cl/core-aprueba-3-mil-trescientos-millones-de-pesos-para-proyecto-junji-en-el-alto/) |
| BioBioChile Investiga — Centinela II, Talcahuano | Nuevo proyecto +$1.600 MM para 109 niños; historia de jardines sin terminar | [ver nota](https://www.biobiochile.cl/especial/bbcl-investiga/noticias/reportajes/2023/11/26/como-junji-pago-mil-millones-de-pesos-a-contratista-por-jardines-infantiles-que-nunca-se-construyeron.shtml) |
| Revista de Educación — inversión gobierno Boric | $120.118 MM total en infraestructura parvularia; jardín Mackay Coyhaique: $1.222 MM | [ver nota](https://www.revistadeeducacion.cl/de-integra-y-junji-jardines-infantiles-publicos-modernos-y-sustentables/) |
| Acción Educar — Educación Parvularia: institucionalidad y financiamiento (2024) | Presupuesto JUNJI reducido dos años consecutivos; financiamiento VTF más desfavorecido | [ver documento](https://accioneducar.cl/wp-content/uploads/2024/01/Educacion-parvularia-institucionalidad-y-financiamiento.pdf) |

---

## Subárea 4 — Liceos técnico-profesionales — equipamiento e infraestructura

**Tipo de dato:** Costo unitario directo (equipamiento por liceo TP)
**Nivel de disclaimer:** "Dato estimado" — el costo por liceo se calcula sobre el programa oficial de equipamiento MINEDUC 2022–2024

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Liceos TP en Chile | ~900 establecimientos | MINEDUC / Secretaría Ejecutiva TP |
| Estudiantes en educación media TP | ~44% de la matrícula total de enseñanza media | MINEDUC, 2024 |
| Matrícula educación superior TP (CFT + IP) 2024 | 571.300 personas (44% del total de pregrado) | MINEDUC, ago. 2024 |
| Inversión programa equipamiento TP 2022–2024 | $21.600 MM para 270 liceos | MINEDUC, sep. 2024 |
| **Costo promedio por liceo equipado (2022–2024)** | **~$80 MM por liceo** (=$21.600 MM ÷ 270 liceos) | Cálculo sobre datos MINEDUC |
| Inversión programa equipamiento TP 2024–2025 | $7.000 MM para nueva convocatoria | MINEDUC, sep. 2024 |
| Inversión programa equipamiento TP 2023 | $8.000 MM para 349 establecimientos = ~$22,9 MM/liceo | MINEDUC / Subsecretaría Educación, ene. 2024 |
| Liceos sin equipamiento suficiente (estimación docentes) | ~33% de los liceos TP (~300 establecimientos) | Estudio CIDE / diagnóstico MINEDUC |
| **Costo de referencia — equipar un liceo TP estándar** | **~$80 MM** (costo real del programa; insuficiente según diagnóstico) | MINEDUC 2022–2024 |
| **Costo de referencia — equipamiento mínimo adecuado por liceo** | **~$150–$200 MM** (estimación: duplicar inversión actual para cumplir estándar decreto 240) | Estimación sobre brecha diagnóstica |

**Nota metodológica:** El costo por liceo del programa oficial ($80 MM) es el dato más directamente verificable. Sin embargo, el propio diagnóstico del MINEDUC indica que es insuficiente para cumplir el equipamiento mínimo establecido en el decreto 240. Para el argumento de impacto se usa $80 MM como costo mínimo (lo que el Estado actualmente gasta por liceo) y $150–200 MM como costo suficiente. El argumento de impacto puede plantearse de dos formas: (a) N liceos que se habrían podido equipar al nivel actual del programa; (b) N liceos que se habrían podido equipar con un estándar adecuado.

**Conexión con subárea 1 (I+D):** El arco narrativo es: los liceos TP no tienen equipamiento para formar técnicos de calidad (subárea 4) → aunque los formaran bien, no hay una matriz productiva que los absorba porque Chile no invierte en I+D (subárea 1). Son las dos caras del mismo problema estructural.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $80 MM = ~2.512 liceos equipados al nivel actual del programa → supera el total de liceos TP del país (~900); se expresa como: "se habría podido equipar todos los liceos TP de Chile casi 3 veces"
- Pacogate ($41.898 MM) ÷ $80 MM = ~524 liceos → más de la mitad de todos los liceos TP del país
- Milicogate ($10.657 MM) ÷ $80 MM = ~133 liceos → casi la mitad de los que tienen déficit de equipamiento (~300)

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| MINEDUC — Programa Equipamiento TP 2024 | $7.000 MM para 2024–2025; dirigido a municipales y particulares subvencionados; adquisición de talleres, laboratorios y equipamiento especialidades | [ver nota](https://www.mineduc.cl/mineduc-abre-concurso-para-que-liceos-tecnico-profesionales-postulen-a-fondos-para-mejorar-el-equipamiento-de-sus-especialidades/) |
| MINEDUC — 82 años educación TP (ago. 2024) | $21.600 MM para 270 liceos entre 2022 y 2024; 571.300 estudiantes en educación superior TP; 56,2% de la matrícula de 1° año en CFT o IP | [ver nota](https://www.mineduc.cl/presidente-conmemora-los-82-anos-de-la-educacion-tecnico-profesional/) |
| Subsecretaría Educación — hitos 2023 | $8.000 MM para 349 establecimientos TP en 2023; "uno de los desafíos es reforzar la modalidad técnica" | [ver nota](https://www.mineduc.cl/los-hitos-de-gestion-de-la-subsecretaria-de-educacion-en-2023/) |
| MINEDUC — diagnóstico TP (Biblioteca Digital) | En un tercio de los liceos los docentes perciben mínima o nula disponibilidad de equipos, herramientas y materiales para las especialidades; precariedad más acentuada en establecimientos municipales | [ver PDF](https://bibliotecadigital.mineduc.cl/bitstream/handle/20.500.12365/18281/E12-0035.pdf) |

---

## Subárea 5 — Infraestructura escolar rural

**Tipo de dato:** Costo unitario directo (conservación y construcción)
**Nivel de disclaimer:** "Dato estimado" — rango basado en proyectos reales del MINEDUC 2022–2024

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Fondo de conservación infraestructura escolar 2024 | $52.868 MM para 125 establecimientos | MINEDUC, jul. 2024 |
| **Costo promedio conservación por establecimiento 2024** | **~$423 MM** (=$52.868÷125) | Cálculo sobre datos MINEDUC |
| Inversión infraestructura 2022–2023 (reposición + conservación) | $224.000 MM para múltiples establecimientos | MINEDUC |
| Plan estratégico infraestructura escolar (largo plazo) | +USD 500 MM (~$460.000 MM) para ~2.000 establecimientos | MINEDUC / infraestructuraescolar.cl |
| Fondo de infraestructura de emergencia 2023 | $85.000 MM para reparaciones urgentes | MINEDUC, 2023 |
| Subvención mensual por alumno — rural con piso mínimo (<17 alumnos) | ~$307.000/mes | Acción Educar / MINEDUC |
| Subvención mensual por alumno — urbano promedio | ~$193.000/mes | Acción Educar / MINEDUC |
| **Costo unitario de referencia — conservación escuela rural** | **~$423 MM por establecimiento** | MINEDUC 2024 |
| **Costo unitario de referencia — construcción escuela rural nueva** | **~$1.500–$2.500 MM por establecimiento** | Estimación sobre plan estratégico |

**Nota metodológica:** Para esta subárea se distingue entre proyectos de conservación (~$423 MM promedio) y proyectos de construcción nueva (~$1.500–$2.500 MM). Para los textos de impacto se recomienda usar el costo de conservación (~$423 MM) porque es más tangible y tiene fuente directa verificable. El disclaimer señala que los costos de construcción nueva varían significativamente según región y superficie.

**Ejemplo de cálculo:**
- Corfo-Inverlink ajustado ($200.940 MM) ÷ $423 MM = ~475 escuelas rurales con conservación completa
- SQM ajustado ($13.500 MM) ÷ $423 MM = ~32 escuelas rurales con conservación completa

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| MINEDUC — adjudicación conservaciones 2024 | $52.868 MM para 125 establecimientos; 39.000 estudiantes beneficiados | [ver nota](https://www.mineduc.cl/53-mil-millones-para-mejorar-la-infraestructura-de-125-establecimientos/) |
| MINEDUC — conservaciones 2023 | $85.000 MM para reparaciones urgentes como parte del Plan de Reactivación Educativa; criterio de ruralidad como priorización | [ver convocatoria](https://www.mineduc.cl/proyectos-de-conservacion-de-infraestructura-2023/) |
| MINEDUC — infraestructura escolar (plan estratégico) | +USD 500 MM para ~2.000 establecimientos priorizados; catastro nacional de infraestructura | [ver plan](https://infraestructuraescolar.mineduc.cl/plan-estrategico/plan/) |
| Acción Educar — Financiamiento educación escolar Chile (2023) | Subvenciones rurales: $307.000/mes por alumno con piso mínimo; 2.790 establecimientos con incremento por ruralidad; 510 con piso mínimo (<17 alumnos) | [ver documento](https://accioneducar.cl/wp-content/uploads/2023/11/Financiamiento-de-la-educacion-escolar-en-Chile.pdf) |

---

## Notas metodológicas del área

1. **Tipos de cálculo por subárea:** I+D es el único caso de **costo de oportunidad indirecto** — argumento comparativo, no aritmético. Becas universitarias usa **costo por beneficiario**. Jardines JUNJI, Liceos TP e infraestructura escolar usan **costo unitario directo**.

2. **Arco narrativo entre subáreas 1 y 4:** I+D y Liceos TP cuentan la misma historia desde dos ángulos. Los liceos TP no tienen equipamiento para formar buenos técnicos (subárea 4); y aunque los formaran bien, no hay una matriz productiva que los absorba porque Chile no invierte en I+D (subárea 1). Esto debe reflejarse en el párrafo de contexto de ambas subáreas en la app.

3. **Liceos TP — el número supera el total del sistema para casos grandes:** Para Corfo ($200.940 MM ÷ $80 MM = ~2.512 liceos), el número supera el total de liceos TP del país. En ese caso el argumento se reformula como "se habría podido equipar todos los liceos TP de Chile casi 3 veces". Esta es la misma lógica que UCI en Salud: no es un problema, es el punto.

4. **Jardines JUNJI — hallazgo de contraste:** El costo anual de igualar el financiamiento parvulario entre modalidades JUNJI AD y VTF es ~$200.900 MM (Acción Educar, 2024). Eso hace que Corfo-Inverlink casi cubra ese costo completo — argumento tipo A para ese caso específico.

5. **Variable a ajustar según caso:** El rango entre Corfo ($200.940 MM) y Milicogate ($10.657 MM) es un factor ~19. Todos los cálculos deben resultar en números comprensibles para el público general.

---

## Notas pendientes

- [x] ~~Verificar arancel de referencia promedio Beca Bicentenario para al menos dos carreras tipo~~ — **Verificado marzo 2026.** El arancel de referencia es fijado anualmente por el Mineduc por carrera e institución mediante decreto; los valores están disponibles en el portal interactivo beneficiosestudiantiles.cl/aranceles-de-referencia (no consultable directamente por búsqueda). Los rangos documentados en fuentes secundarias confiables son: Ingeniería Civil ~$3.200.000/año (tope CAE en universidades estatales); Pedagogía ~$2.000.000/año (tope CAE en universidades privadas con baja acreditación); promedio universidades 2012 fue $2.103.469 (DIPRES). Para los textos de impacto se mantiene la Beca JGM ($1.150.000) como costo de referencia por ser el monto más directamente citable. El arancel Bicentenario se puede usar como referencia alternativa para carreras específicas si se consulta el portal directamente. Fuente: informe DIPRES sobre aranceles de referencia; portal Ingresa.cl; Informe de Cálculo Aranceles Regulados 2026, Mineduc (publicado marzo 2025).
- [x] ~~Confirmar si ANID publica el costo total promedio de una Beca Chile doctoral~~ — **Confirmado con fuente primaria.** Bases Concursales Doctorado Nacional ANID 2025 establecen: manutención máximo $7.800.000/año + arancel máximo $2.700.000/año = **hasta $10.500.000/año por becario** por hasta 4 años. Fuente: Bases Concursales Doctorado Nacional 2025, ANID (Decreto Supremo N°335/10 y modificaciones). Dato incorporado en la tabla de I+D y en el argumento de impacto.
- [x] ~~Para I+D: definir si el argumento de impacto es "investigadores financiados" o "brecha respecto a meta del 1% del PIB"~~ — **Resuelto.** El argumento correcto es comparativo (brecha de inversión), no aritmético. I+D es costo de oportunidad indirecto: no se divide el monto del caso por un costo unitario. Ver sección "Argumento de impacto" de la subárea 1.
