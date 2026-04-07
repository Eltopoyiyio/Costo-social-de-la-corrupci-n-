# Área 5: Vivienda — Fuentes y costos unitarios

**Sesión:** 11
**Estado:** ✅ Fuentes mapeadas — costos unitarios verificados
**Fuente IPC de referencia:** calculadora oficial INE, diciembre 2025
**Nota editorial:** El déficit habitacional total de Chile ($17+ billones) hace que todos los casos de corrupción representen fracciones mínimas del problema. Todas las subáreas van a B (N unidades concretas). El argumento narrativo central no es "esto resuelve el problema" sino "esto es lo que no ocurrió": viviendas que no se construyeron, arriendos que no se subsidiaron, familias que siguen esperando.

---

## Contexto general — déficit habitacional Chile 2024

| Concepto | Dato | Fuente |
|---|---|---|
| Déficit cuantitativo total (Censo 2024) | 491.904 viviendas requeridas | Centro de Estudios MINVU / INE, dic. 2025 |
| Componentes del déficit cuantitativo | Hogares allegados: 188.355 / Hacinamiento no ampliable: 127.196 / Núcleos allegados hacinados: 103.611 / Viviendas irrecuperables: 72.642 | Centro de Estudios MINVU, 2025 |
| Déficit cualitativo (Casen 2024) | 1.239.815 viviendas requieren mejoramiento | Centro de Estudios MINVU / Casen 2024 |
| Reducción del déficit cuantitativo vs. Censo 2002 | -33,7% (de 741.832 a 491.904 requerimientos) | MINVU / INE, nov. 2025 |
| Hogares arrendatarios (Censo 2024) | 26,2% de los hogares — cifra más alta de la serie histórica | INE, may. 2025 |
| Familias en campamentos (Catastro 2024-2025) | 120.584 familias en 1.428 campamentos | TECHO Chile, abr. 2025 |
| Plan de Emergencia Habitacional — avance oct. 2025 | 229.262 viviendas terminadas o entregadas (88% de meta de 260.000) | MINVU, nov. 2025 |

---

## Resumen de subáreas y tipo de dato

| # | Subárea | Tipo de dato | Nivel de disclaimer | Argumento visual |
|---|---|---|---|---|
| 1 | Viviendas sociales SERVIU (DS49) | Costo unitario directo | Dato estimado | B — N viviendas sociales construibles |
| 2 | Lista de espera SERVIU — tiempo de espera acortado | Costo de oportunidad indirecto | Escenario proyectado | B reformulado — meses adicionales del programa financiados |
| 3 | Subsidios de arriendo (DS52) | Costo por beneficiario | Dato estimado | B — N familias con subsidio de arriendo por 8 años |
| 4 | Campamentos — familias que construyeron donde el Estado no llegó | Costo unitario directo | Dato estimado | B — N familias con solución habitacional |
| 5 | Mejoramiento de campamentos y viviendas deterioradas | Costo por beneficiario | Dato estimado | B — N viviendas mejoradas |

**Orden narrativo:** De la solución ideal (DS49) a la realidad más cruda (mejoramiento). El arco cuenta: la solución que debió llegar (1) → el Estado que no alcanza (2) → el arriendo insostenible mientras se espera (3) → las familias que construyeron donde pudieron (4) → dignificar lo que existe mientras llega la solución definitiva (5).

**Nota de arquitectura (pendiente para repaso general):** Esta área requiere un párrafo introductorio a nivel de área — antes de las subáreas — que prepare al lector para la escala del problema. El déficit habitacional es tan masivo que ningún caso individual lo resuelve. Eso no debilita el argumento; lo hace más honesto. Sin ese párrafo introductorio, el usuario puede salir con una sensación equivocada al ver los números pequeños de la lista de espera.

---

## Subárea 1 — Viviendas sociales SERVIU (DS49)

**Tipo de dato:** Costo unitario directo (subsidio estatal por vivienda)
**Nivel de disclaimer:** "Dato estimado" — el subsidio DS49 cubre el costo completo para el Estado; el precio final de la vivienda incluye el aporte del postulante (mínimo 10 UF)

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Subsidio base DS49 (Fondo Solidario de Elección de Vivienda) | 800 UF | SERVIU Metropolitano |
| Tope de vivienda comprable con DS49 | 950–1.400 UF (~$34–50 MM) según región | MINVU / déficitcero.cl |
| Tope de vivienda comprable con DS49 en RM | 950 UF (~$34 MM) | ChileAtiende |
| Tope de vivienda en regiones extremas | 1.400 UF (~$50 MM) | MINVU |
| Ahorro mínimo requerido al postulante | 10 UF (~$395.000) | ChileAtiende |
| Subsidios complementarios adicionales (por discapacidad, ruralidad, etc.) | Hasta 200 UF adicionales | MINVU |
| UF referencia dic. 2025 | ~$39.500 | SII / CMF |
| **Costo al Estado por vivienda DS49 (subsidio base)** | **800 UF = ~$31.600.000** | SERVIU / MINVU 2025 |
| **Costo total vivienda DS49 (tope RM)** | **950 UF = ~$37.525.000** | ChileAtiende 2025 |

**Argumento de impacto:** El dinero del [caso] equivale a N viviendas sociales entregadas sin deuda a familias del 40% más vulnerable del país.

**Ejemplo de cálculo (usando subsidio base 800 UF = $31.600.000):**
- Corfo ($200.940 MM) ÷ $31.600.000 = ~6.359 viviendas sociales
- Pacogate ($41.898 MM) ÷ $31.600.000 = ~1.326 viviendas
- SQM ($13.500 MM) ÷ $31.600.000 = ~427 viviendas
- Milicogate ($10.657 MM) ÷ $31.600.000 = ~337 viviendas

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| SERVIU Metropolitano — DS49 | Subsidio base 800 UF; tope vivienda RM 950 UF; sin crédito hipotecario; 40% más vulnerable | [ver página](https://serviumetropolitana.minvu.gob.cl/fondo-solidario-de-eleccion-de-vivienda-ds49/) |
| MINVU — DS49 construcción | Subsidio base y complementarios; modalidades de construcción nueva | [ver página](https://www.minvu.gob.cl/beneficio/vivienda/subsidio-para-construir-una-vivienda-de-hasta-950-uf-ds49/) |
| déficitcero.cl — DS49 completo | Tope vivienda 1.300–1.400 UF según región; modalidades colectivas e individuales; ahorro mínimo 10 UF | [ver nota](https://redviviendayciudad.cl/subsidios-habitacionales/el-ds49-en-que-consiste-requisitos-y-los-llamados-abiertos-a-la-fecha) |
| MINVU — Plan Emergencia Habitacional | 229.262 viviendas entregadas al 88% de avance de meta; urgencia del déficit | [ver nota](https://www.minvu.gob.cl/noticia/ministro-montes-destaca-la-reduccion-del-337-del-deficit-habitacional-a-partir-de-datos-del-censo-2024-en-comparacion-con-los-resultados-de-2002/) |

---

## Subárea 2 — Lista de espera SERVIU — tiempo de espera acortado

**Tipo de dato:** Costo de oportunidad indirecto (tiempo adicional de programa financiado)
**Nivel de disclaimer:** "Escenario proyectado" — no existe cifra oficial del stock acumulado de familias esperando; el argumento se basa en el costo anual del programa al ritmo de entrega actual

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Subsidios DS49 entregados en 2025 | 50.000 a nivel nacional | MINVU |
| Subsidios DS49 presupuestados para 2026 | 19.000 a nivel nacional (reducción significativa) | MINVU / Circular N°5 2026 |
| Déficit habitacional total (Censo 2024) | 491.904 viviendas | Centro de Estudios MINVU 2025 |
| Años para resolver el déficit al ritmo de 2026 | ~25,9 años (491.904 ÷ 19.000) | Cálculo sobre datos MINVU |
| Costo anual del programa DS49 al ritmo de 2026 | ~$600.800 MM (19.000 × $31.600.000) | Estimación: subsidios × costo unitario |
| Registro oficial de familias en lista de espera | **No existe** — SERVIU no publica stock acumulado | — |
| **Costo de referencia** | **$600.800 MM/año** de programa DS49 | Estimación sobre datos MINVU 2026 |

**Argumento de impacto:** No es "cuántas personas beneficiadas" sino "cuánto tiempo antes habrían llegado las viviendas". El monto del caso financia N meses adicionales del programa — tiempo en que más familias habrían dejado de esperar. Para los casos más pequeños el tiempo es de días; para los más grandes, meses. Esa pequeñez es el argumento: el problema habitacional es tan masivo que ni toda la corrupción del proyecto juntas financia un año más del programa.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ ($600.800 MM/12) = ~4,0 meses adicionales del programa
- Pacogate ($41.898 MM) → ~0,84 meses (~25 días adicionales)
- SQM ($13.500 MM) → ~8 días adicionales
- Milicogate ($10.657 MM) → ~6 días adicionales

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| MINVU — Circular N°5 2026 | 19.000 subsidios DS49 para 2026; reducción desde 50.000 en 2025; distribución regional | [ver circular](https://www.minvu.gob.cl/circular-5-2026-ds49/) |
| Centro de Estudios MINVU — Censo 2024 | Déficit cuantitativo 491.904 viviendas; composición por componentes | [ver nota](https://centrodeestudios.minvu.gob.cl/deficit-habitacional-censo-2024/) |

---

## Subárea 3 — Subsidios de arriendo (DS52)

**Tipo de dato:** Costo por beneficiario (costo total del subsidio por familia en 8 años)
**Nivel de disclaimer:** "Dato estimado" — el monto es exacto; la variación está en la duración del uso y en el tope mensual según región

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Subsidio total DS52 | 170 UF (~$6.712.000) | MINVU / ChileAtiende |
| Tope mensual DS52 (RM y regiones extremas) | 4,9 UF (~$193.000/mes) | MINVU, oct. 2025 |
| Tope mensual DS52 (resto del país) | 4,2 UF (~$166.000/mes) | ChileAtiende |
| Plazo máximo de uso | 8 años (consecutivo o fragmentado) | SERVIU / ChileAtiende |
| Tope de vivienda arrendable (RM) | 13 UF (~$513.000/mes) | MINVU, oct. 2025 |
| Tope de vivienda arrendable (resto) | 11 UF (~$434.000/mes) | ChileAtiende |
| Hogares arrendatarios Chile (Censo 2024) | 26,2% — cifra más alta de la serie histórica | INE, may. 2025 |
| Presupuesto arriendo en MINVU 2025 | ~4% del presupuesto total MINVU | La Tercera |
| **Costo total DS52 por familia (8 años)** | **170 UF = ~$6.712.000** | MINVU / ChileAtiende 2025 |

**Argumento de impacto:** El dinero del [caso] equivale al subsidio de arriendo completo de N familias durante 8 años — estabilidad habitacional mientras esperan una solución definitiva. El 26,2% de los hogares chilenos arriendan, la cifra más alta de la historia, y el DS52 apenas alcanza para 6.000–8.500 familias por llamado.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $6.712.000 = ~29.938 familias con subsidio de arriendo por 8 años
- Pacogate ($41.898 MM) ÷ $6.712.000 = ~6.242 familias
- SQM ($13.500 MM) ÷ $6.712.000 = ~2.012 familias
- Milicogate ($10.657 MM) ÷ $6.712.000 = ~1.588 familias

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| ChileAtiende — DS52 | Subsidio total 170 UF; tope 4,2 UF/mes; plazo 8 años; requisitos | [ver ficha](https://www.chileatiende.gob.cl/fichas/29888-subsidio-de-arriendo-de-vivienda) |
| MINVU — apertura llamado oct. 2025 | Subsidio total 170 UF ($6.712.000); tope RM 4,9 UF ($193.000/mes); vivienda hasta 13 UF ($513.000/mes) | [ver nota](https://www.minvu.gob.cl/noticia/minvu-anuncia-la-apertura-del-llamado-de-2025-al-subsidio-de-arriendo-regular/) |
| SERVIU Metropolitano — DS52 | Condiciones completas; restricciones por región; uso flexible | [ver página](https://serviumetropolitana.minvu.gob.cl/subsidio-de-arriendo-ds-52/) |
| INE — Censo 2024 tenencia | 26,2% arrendatarios (aumento de 83 pp vs. 2002); 61,1% propietarios | [ver nota](https://www.ine.gob.cl/sala-de-prensa/prensa/general/noticia/2025/05/30/censo-2024-el-61-1-de-los-hogares-residen-en-una-vivienda-propia-y-el-26-2-en-una-vivienda-arrendada) |

---

## Subárea 4 — Familias en campamentos — respuesta al abandono del Estado

**Tipo de dato:** Costo unitario directo (costo combinado de terreno + vivienda por familia)
**Nivel de disclaimer:** "Dato estimado" — el costo total varía según localización; la cifra de US$6.000 MM es estimación ministerial, no presupuesto detallado

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Familias en campamentos (Catastro TECHO Chile 2024-2025) | 120.584 familias en 1.428 campamentos | TECHO Chile, abr. 2025 |
| Campamentos nuevos desde 2022 | 341 polígonos nuevos identificados | MINVU / Catastro 2024 |
| Aumento familias 2022→2024 | +6.697 familias (+5,8%) | TECHO Chile 2025 |
| Campamentos con amenaza de desalojo | Al menos 229 campamentos | TECHO Chile 2025 |
| Costo estimado para proveer solución habitacional a todas las familias | US$6.000 MM (~$5.640.000 MM) | MINVU (estimación ministerial) |
| **Costo por familia con solución habitacional** | **~$46.800.000** ($5.640.000 MM ÷ 120.584 familias) | Estimación: total MINVU ÷ familias |
| Costo expropiación terrenos (mega-toma San Antonio) | ~$0,25 UF/m² → $11.000 MM para 110 ha | BioBioChile / MINVU dic. 2025 |

**Nota editorial:** Los campamentos no son el problema — son la consecuencia. Son la respuesta de familias que construyeron con sus propias manos lo que el Estado no pudo proveer a tiempo. Muchas de esas familias están inscritas en la lista de espera SERVIU; no "se saltaron la fila", construyeron donde pudieron mientras esperaban. El argumento de impacto debe reflejar eso: el dinero del [caso] habría podido proveer una solución habitacional digna a N familias que hoy viven en campamentos — no porque los campamentos sean "malos", sino porque esas familias merecían una respuesta que no llegó.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $46.800.000 = ~4.294 familias (~3,6% del total en campamentos)
- Pacogate ($41.898 MM) ÷ $46.800.000 = ~895 familias
- Milicogate ($10.657 MM) ÷ $46.800.000 = ~228 familias

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| TECHO Chile — Catastro Nacional 2024-2025 (UAH) | 120.584 familias; 1.428 campamentos; +5,8% vs. 2022; 229 con amenaza de desalojo | [ver nota](https://www.uahurtado.cl/extension/noticias-universitarias/techo-chile-presenta-en-la-uah-el-catastro-nacional-de-campamentos-2024-2025/) |
| TECHO Chile — Catastro 2024-2025 (resumen PDF) | Metodología; distribución regional; perfil socioeconómico; propuestas de política | [ver PDF](https://cl.techo.org/wp-content/uploads/sites/9/2025/04/CN24-25-resumen_eje.pdf) |
| BioBioChile Investiga — expropiaciones mega-tomas | $11.000 MM para 110 ha en San Antonio; costo de terrenos como componente clave del precio de erradicación | [ver nota](https://www.biobiochile.cl/especial/bbcl-investiga/noticias/articulos/2025/12/13/efecto-san-antonio-cuanto-costaria-al-fisco-expropiar-otras-mega-tomas-erigidas-en-terrenos-privados.shtml) |
| Centro de Estudios MINVU — análisis catastros | Diferencias metodológicas MINVU vs. TECHO Chile; ambos muestran crecimiento sostenido | [ver nota](https://centrodeestudios.minvu.gob.cl/centro-de-estudios-del-minvu-presenta-analisis-comparado-sobre-campamentos-ante-comision-del-senado/) |

---

## Subárea 5 — Mejoramiento de viviendas deterioradas

**Tipo de dato:** Costo por beneficiario (costo del programa de mejoramiento por vivienda)
**Nivel de disclaimer:** "Dato estimado" — varía según la intervención; se usa el Programa Habitabilidad Rural como referencia verificable

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Viviendas en déficit cualitativo (Casen 2024) | 1.239.815 viviendas requieren mejoramiento | Centro de Estudios MINVU / Casen 2024 |
| Programa Habitabilidad Rural — subsidio máximo | Hasta 120 UF (~$4.740.000) por vivienda | MINVU — ficha oficial |
| Programa de mejoramiento básico urbano | ~$3–5 MM por vivienda (techo, piso, muro) | Estimación MINVU / BIP |
| **Costo de referencia — mejoramiento básico** | **~$4.740.000** (120 UF, Programa Habitabilidad Rural MINVU) | MINVU — ficha oficial |

**Argumento de impacto:** Para las familias ya en campamento que no pueden acceder aún a una solución definitiva, el mejoramiento in situ devuelve dignidad: techo que no se llueve, piso firme, muro que aísla. El dinero del [caso] equivale al mejoramiento básico de N viviendas — soluciones inmediatas que no reemplazan la vivienda definitiva pero sí mejoran la vida de las personas mientras llega.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $4.740.000 = ~42.392 viviendas mejoradas
- Pacogate ($41.898 MM) ÷ $4.740.000 = ~8.840 viviendas mejoradas
- SQM ($13.500 MM) ÷ $4.740.000 = ~2.848 viviendas mejoradas
- Milicogate ($10.657 MM) ÷ $4.740.000 = ~2.249 viviendas mejoradas

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| MINVU — Programa Habitabilidad Rural | Subsidio de hasta 120 UF para mejoramiento de viviendas rurales deterioradas; requisitos; cobertura nacional | [ver página](https://www.minvu.gob.cl/beneficio/vivienda/mejoramiento-de-vivienda-en-sectores-rurales/) |
| Casen 2024 — déficit cualitativo | 1.239.815 viviendas requieren mejoramiento; 17,7% del total del parque habitacional | [ver nota](https://centrodeestudios.minvu.gob.cl/casen-2024-cifra-en-405-552-la-necesidad-de-nuevas-viviendas/) |
| Centro de Estudios MINVU — Casen 2022 | 1.263.576 viviendas en déficit cualitativo; concentradas en primeros dos quintiles | [ver nota](https://centrodeestudios.minvu.gob.cl/minvu-entrega-cifra-oficial-del-deficit-habitacional-552-046-requerimientos/) |

---

## Notas metodológicas del área

1. **Todas las subáreas van a B o a costo de oportunidad indirecto:** El déficit total de vivienda hace que los montos de corrupción sean fracciones mínimas. La subárea 2 (lista de espera) es la única con argumento de tiempo en vez de unidades — y esa pequeñez es deliberada: ilustra la magnitud del problema habitacional mejor que cualquier número.

2. **Párrafo introductorio del área (pendiente):** Esta área necesita un párrafo de introducción general antes de las subáreas que prepare al lector para ver números pequeños. Sin ese contexto, la lista de espera (6 días para Milicogate) puede leerse como debilidad del argumento en vez de como revelación de la escala del problema.

3. **Campamentos — lenguaje editorial:** Usar siempre "solución habitacional" en vez de "erradicación". Los campamentos son consecuencia, no causa. Las familias no "invaden" — responden al abandono estatal. Este lenguaje debe estar en los párrafos de contexto e impacto de la app.

4. **Subárea 4 vs. 5 — campamentos vs. mejoramiento:** El costo por familia en campamento (~$46,8 MM) es ~10 veces mayor que el mejoramiento básico (~$4,7 MM). Eso puede mostrarse visualmente para ilustrar el espectro: solución definitiva vs. solución inmediata.

---

## Notas pendientes

- [ ] Verificar con fuente primaria directa del MINVU la estimación de US$6.000 MM para proveer solución habitacional a todas las familias en campamentos — la cifra circula en medios pero no se encontró el documento original del ministerio
- [ ] Buscar en BIP proyectos de mejoramiento en campamentos urbanos específicos para complementar el Programa Habitabilidad Rural (que es rural) con un costo unitario urbano verificable
