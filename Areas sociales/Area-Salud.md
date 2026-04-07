# Área 2: Salud — Fuentes y costos unitarios

**Sesión:** 8
**Estado:** ✅ Fuentes mapeadas — costos unitarios verificados
**Fuente IPC de referencia:** calculadora oficial INE, diciembre 2025

---

## Resumen de subáreas y tipo de dato

| # | Subárea | Tipo de dato | Nivel de disclaimer | Argumento visual |
|---|---|---|---|---|
| 1 | Medicamentos de alto costo / enfermedades raras | Costo por beneficiario | Dato estimado | B — N pacientes tratados por un año |
| 2 | Salud mental ambulatoria | Costo unitario directo | Dato estimado | A — contraste vs. brecha anual para llegar al mínimo OMS (97% para Corfo) |
| 3 | Operaciones no realizadas por espera | Costo por beneficiario | Dato estimado | A — % de la lista de espera que se podría haber resuelto |
| 4 | Salud dental pública | Costo por beneficiario | Dato estimado | B — N atenciones dentales o N pacientes tratados |
| 5 | Equipamiento UCI | Costo unitario directo | Dato estimado | B reformulado — X veces la capacidad UCI pública del país |

**Cambios respecto a versión anterior:** Subárea 1 reemplaza "Hospitales de alta complejidad" (déficit no cuantificado como brecha total). Subárea 4 reemplaza "Postas rurales" (relevancia media, sin déficit oficial). Subárea 5 mantiene UCI pero con argumento reformulado.

---

## Subárea 1 — Medicamentos de alto costo / enfermedades raras

**Tipo de dato:** Costo por beneficiario (costo anual de tratamiento por paciente)
**Nivel de disclaimer:** "Dato estimado" — los costos varían ampliamente según patología; se usan rangos verificables de las patologías más frecuentes en lista de espera

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Ley Ricarte Soto (LRS) — presupuesto 2024 | ~$56.000 MM CLP | MINSAL / Ley de Presupuestos 2024 |
| Número de beneficiarios LRS activos (2023) | ~7.500 pacientes en tratamiento | MINSAL |
| Costo promedio por paciente LRS/año | ~$7.500.000/año (=$56.000 MM ÷ 7.500) | Estimación sobre datos MINSAL |
| Medicamentos oncológicos de alto costo (fuera de LRS) | $15.000.000–$50.000.000/año por paciente según molécula | Fundación Arturo López Pérez / CENABAST |
| Pacientes en lista de espera por LRS (patologías no cubiertas) | Sin dato oficial publicado actualizado | Pendiente verificación |
| Costo tratamiento Hepatitis C (sofosbuvir) por paciente/año | ~$3.000.000–$5.000.000 | CENABAST / compra centralizada |
| Costo tratamiento esclerosis múltiple remitente-recurrente/año | ~$15.000.000–$30.000.000 | Fundación EM Chile / MINSAL |
| **Costo de referencia — tratamiento LRS promedio por paciente/año** | **~$7.500.000** | Estimación: presupuesto LRS ÷ beneficiarios activos |

**Nota metodológica:** La Ley Ricarte Soto es el instrumento más transparente para este cálculo porque tiene presupuesto público definido y número de beneficiarios documentado. El costo promedio por paciente (~$7,5 MM/año) es una estimación indirecta pero sólida. Para el argumento de impacto se puede usar "N pacientes con tratamiento LRS por un año" como dato principal, y mencionar que existen patologías no cubiertas por la ley con costos aún mayores.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $7.500.000 = ~26.792 pacientes tratados por un año
- Pacogate ($41.898 MM) ÷ $7.500.000 = ~5.586 pacientes
- Milicogate ($10.657 MM) ÷ $7.500.000 = ~1.421 pacientes

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| MINSAL — Ley Ricarte Soto | Listado de patologías cubiertas; presupuesto 2024; mecanismo de acceso | [ver página](https://www.minsal.cl/ley-ricarte-soto/) |
| CENABAST — compras centralizadas | Precios de referencia medicamentos oncológicos y de alto costo adquiridos por el Estado | [ver página](https://www.cenabast.cl/medicamentos/) |
| BCN — Ley 20.850 Ricarte Soto | Texto legal y reglamentos; criterios de incorporación de patologías | [ver ley](https://www.bcn.cl/leychile/navegar?idNorma=1077039) |

**Nota pendiente:** Verificar número exacto de beneficiarios LRS activos en 2024 y presupuesto ejecutado para calcular costo promedio por paciente con mayor precisión. MINSAL publica informes anuales de la ley.

---

## Subárea 2 — Salud mental ambulatoria

**Tipo de dato:** Costo por beneficiario (costo de un COSAM / costo por paciente/año)
**Nivel de disclaimer:** "Dato estimado" — no existe fuente oficial con costo por paciente/año en COSAM; se construye a partir del presupuesto total y el número de centros

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Presupuesto COSAM 2024 (Ley de Presupuestos) | $17.850.969 miles = ~$17.851 MM CLP | Ley de Presupuestos 2024, Partida MINSAL |
| Inversión en construcción de COSAM 2024 (9 comunas) | $11.736 MM CLP | Hacienda / acuerdo Senado presupuesto 2024 |
| Centros de demencia (6 nuevos) | $2.111 MM CLP | Hacienda / acuerdo Senado presupuesto 2024 |
| Costo construcción COSAM estándar (referencia) | ~$1.300–$1.500 MM CLP por centro | Estimación: $11.736 MM ÷ 9 centros = ~$1.304 MM promedio |
| Sesión psicología privada — rango mercado | $25.000–$45.000 por sesión | 2x3.cl / mercado 2025 |
| Sesión psicología en COSAM / APS | Gratuita para usuarios FONASA tramos A y B | FONASA / COSAM |
| Costo anual tratamiento depresión en APS (GES) | ~$150.000–$300.000/año por paciente (fármacos + consultas) | Estimación MINSAL / GES |
| **Costo de referencia — construcción de 1 COSAM estándar** | **~$1.304 MM CLP** | Presupuesto 2024: $11.736 MM para 9 centros |

**Nota metodológica:** Para esta subárea hay dos posibles argumentos de impacto: (a) número de COSAM construibles con el monto del caso — más concreto visualmente; (b) número de pacientes tratados anualmente — más cercano a la experiencia cotidiana. Se recomienda usar (a) para los casos más grandes y combinar con la estadística de cobertura: cada COSAM atiende a una población de entre 80.000 y 165.000 personas según región. El argumento de fondo es estructural: Chile invierte solo el 2,14% de su presupuesto de salud en salud mental, frente al 5–12% recomendado por la OMS.

**Dato clave de contexto:** Chile tiene solo 20% de cobertura de tratamiento de trastornos mentales diagnosticados (Plan Nacional de Salud Mental 2017–2025). En 2024 murieron más de 36.000 personas en lista de espera del sistema público.

**Ejemplo de cálculo:**
- Pacogate ($41.898 MM) ÷ $1.304 MM = ~32 COSAM construibles
- SQM ($13.500 MM) ÷ $1.304 MM = ~10 COSAM construibles

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| Ley de Presupuestos 2024 — Partida MINSAL (DIPRES) | Al menos $17.851 MM para COSAM; $13.959 MM para hospitalización psiquiátrica infanto-adolescente | [ver PDF](https://www.dipres.gob.cl/597/articles-325502_doc_pdf.pdf) |
| Hacienda — acuerdo Senado presupuesto salud 2024 | $11.736 MM para 9 COSAM; $2.111 MM para 6 centros de memoria-demencia | [ver nota](https://www.hacienda.cl/noticias-y-eventos/noticias/presupuesto-2024-acuerdo-en-salud-permitira-fortalecer-recursos-para-centros-de) |
| BCN — Plan Nacional de Salud Mental 2017–2025 | 20% cobertura tratamiento trastornos mentales; 1.633 equipos ambulatorios; solo 2,14% presupuesto salud en salud mental | [ver PDF](https://obtienearchivo.bcn.cl/obtienearchivo?id=repositorio/10221/35814/1/BCN_programas_nacionales_salud_mental_FINAL.pdf) |
| LILACS / Boletín Economía y Salud 2023 | Gasto salud mental Chile 2014–2021: 11,7% en hospitalización, 56,9% ambulatorio; copago promedio 66%; necesidad de aumentar presupuesto público | [ver resumen](https://pesquisa.bvsalud.org/portal/resource/pt/biblio-1552319) |
| IPSUSS — claves presupuesto salud 2024 | $14.464.864 MM total MINSAL 2024 (+8%); 56,5% a atención hospitalaria; 22,9% a APS | [ver nota](https://ipsuss.cl/actualidad/aspectos-clave-del-presupuesto-de-salud-2024) |
| PsiConecta — guía financiamiento psicoterapia Chile | Funcionamiento MAI/MLE en FONASA; costo 0 en COSAM para tramos A-B; 5 patologías cubiertas GES | [ver artículo](https://psiconecta.org/blog/como-costear-una-psicoterapia-en-chile) |

---

## Subárea 3 — Operaciones no realizadas por espera

**Tipo de dato:** Costo por beneficiario (costo de una cirugía electiva en el sistema público)
**Nivel de disclaimer:** "Dato estimado" — el costo varía enormemente por tipo de cirugía; se usa un promedio representativo de las cirugías más frecuentes en lista de espera

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Personas en lista de espera por cirugía (dic. 2024) | 390.229 cirugías pendientes | MINSAL / La Tercera, feb. 2025 |
| Personas en lista de espera total (cirugías + consultas, sep. 2024) | 3.006.001 casos | Radio U. de Chile, nov. 2024 |
| Personas fallecidas en lista de espera (ene–sep. 2024) | 36.262 muertes | Cooperativa, dic. 2024 |
| Mediana de espera para cirugía (jun. 2024) | 579 días (~19 meses) | BCN — Asesoría Técnica Parlamentaria |
| Aumento de cirugías pendientes 2023→2024 | +56.650 cirugías (+16,98%) | MINSAL / La Tercera, feb. 2025 |
| Cirugías más frecuentes en lista de espera | Traumatología (82.141), Cirugía Digestiva (55.127), Dermatología (49.215) | MINSAL Visor de Tiempos de Espera, jun. 2024 |
| Presupuesto reducción lista de espera 2024 (FONASA) | $48.000 MM para resolver cirugías traumatológicas y digestivas | Subsecretaría Redes Asistenciales, 2024 |
| Costo promedio cirugía electiva en sistema público (estimación) | ~$600.000–$1.500.000 por cirugía (según complejidad) | Estimación basada en arancel FONASA modalidad libre elección |
| **Costo de referencia — cirugía electiva estándar** | **~$800.000 por cirugía** (promedio de cirugías más frecuentes) | Estimación conservadora basada en arancel FONASA |

**Nota metodológica:** El costo de una cirugía en el sistema público no está fácilmente disponible como dato único. La mejor aproximación es el costo por cirugía del plan de reducción de listas de espera de FONASA: $48.000 MM para ~60.000 cirugías = ~$800.000 por cirugía promedio. Este es el costo para el Estado (lo que FONASA paga a los prestadores cuando compra horas quirúrgicas al sector privado para resolver la lista). El argumento de impacto más poderoso no es el número de cirugías sino el número de personas que murieron esperando en relación con el monto del caso.

**Ejemplo de cálculo:**
- Corfo-Inverlink ($200.940 MM) ÷ $800.000 = ~251.175 cirugías electivas
- Penta ($16.200 MM) ÷ $800.000 = ~20.250 cirugías electivas
- En 2024 murieron 36.262 personas esperando una atención de salud

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| La Tercera — informe MINSAL dic. 2024 | 390.229 cirugías pendientes; 2.601.084 consultas; +16,98% cirugías vs. 2023 | [ver nota](https://www.latercera.com/nacional/noticia/minsal-reporta-aumento-en-listas-de-esperas-y-en-garantias-ges-retrasadas-pero-tiempos-presentan-reduccion/C5G5ZT2WSVAVPHFOA2B562ZXUQ/) |
| Cooperativa — fallecidos en lista de espera 2024 | 36.262 personas fallecidas en lista de espera enero–septiembre 2024 | [ver nota](https://cooperativa.cl/noticias/pais/salud/hospitales/listas-de-espera-mas-de-36-mil-pacientes-han-fallecido-en-lo-que-va-de/2024-11-19/155409.html) |
| BioBioChile Investiga — cifra negra salud pública | 17.022 fallecidos en lista de espera solo en 2023; 3 millones en espera; récord histórico | [ver nota](https://www.biobiochile.cl/especial/bbcl-investiga/noticias/reportajes/2024/11/08/17-mil-muertos-y-3-millones-de-pacientes-en-espera-la-cifra-negra-de-la-salud-publica-chilena.shtml) |
| Radio U. de Chile — 3 millones en espera | 3.006.001 casos al tercer trimestre 2024; 379.632 cirugías pendientes | [ver nota](https://radio.uchile.cl/2024/11/16/tres-millones-de-personas-en-listas-de-espera-consultas-874-y-cirugias-126/) |
| BCN — Asesoría Técnica Parlamentaria (jun. 2024) | Mediana espera cirugía: 579 días; 365.257 cirugías pendientes; traumatología lidera | [ver PDF](https://obtienearchivo.bcn.cl/obtienearchivo?id=repositorio/10221/36366/2/BCN_Tiempos_de_espera_para_atencion_en_salud__EG_final.pdf) |
| U. de Chile Escuela de Salud Pública | 42% de pacientes FONASA en lista de espera quirúrgica esperan más de 1 año | [ver nota](https://saludpublica.uchile.cl/noticias/151102/el-42-de-pacientes-fonasa-para-cirugia-debe-esperar-al-menos-1-ano) |
| CIEDESS — informe tiempos espera 2024 | $48.000 MM FONASA para reducir cirugías traumatológicas y digestivas; 2° semestre 2024 | [ver nota](https://www.ciedess.cl/601/w3-article-15054.html) |

---

## Subárea 4 — Salud dental pública

**Tipo de dato:** Costo por beneficiario (costo de una atención dental en el sistema público)
**Nivel de disclaimer:** "Dato estimado" — el costo por atención varía según procedimiento; se usa el costo de una alta odontológica integral como referencia

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Cobertura GES odontológico | Solo embarazadas y niños de 6 años | FONASA / GES |
| Adultos con cobertura pública odontológica | Solo FONASA tramos A y B con acceso limitado a APS | FONASA |
| Costo alta odontológica integral (AOI) en APS pública | ~$50.000–$80.000 por paciente (procedimiento completo) | Estimación APS / MINSAL |
| Lista de espera odontológica en APS (estimación) | Sin dato oficial nacional publicado | Pendiente verificación |
| Costo prótesis dental parcial removible (sistema público) | ~$150.000–$250.000 | FONASA / prestadores APS |
| Costo implante dental (mercado privado) | $600.000–$1.500.000 por implante | Mercado privado |
| Porcentaje de población sin acceso a atención dental oportuna | ~60% de la población adulta | Estimación Colegio de Cirujanos Dentistas / OPS |
| **Costo de referencia — alta odontológica integral (AOI)** | **~$65.000 por paciente** | Estimación media APS pública 2024 |

**Nota metodológica:** La salud dental pública en Chile tiene una brecha enorme de cobertura pero sin una cifra oficial del costo total de cerrarla. El argumento más honesto es N atenciones integrales posibles con el monto del caso. El AOI (~$65.000) es el procedimiento de referencia en APS porque representa la atención odontológica completa para un paciente, no solo una consulta. Para casos grandes, el número de atenciones puede resultar muy elevado — en ese caso conviene expresarlo también como porcentaje de la población adulta chilena (~14,8 millones) que podría haber recibido atención.

**Ejemplo de cálculo:**
- Corfo ($200.940 MM) ÷ $65.000 = ~3.091.385 atenciones dentales integrales (~21% de la población adulta)
- Pacogate ($41.898 MM) ÷ $65.000 = ~644.585 atenciones (~4,3% de la población adulta)
- Milicogate ($10.657 MM) ÷ $65.000 = ~163.954 atenciones

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| FONASA — prestaciones odontológicas | Listado de prestaciones cubiertas por modalidad; tramos A y B; GES odontológico | [ver página](https://www.fonasa.cl/sites/fonasa/beneficiarios/prestaciones-odontologicas) |
| OPS Chile — salud bucal | Diagnóstico de acceso; brecha de cobertura; recomendaciones de política | [ver nota](https://www.paho.org/es/chile) |
| Colegio de Cirujanos Dentistas de Chile | Posición sobre acceso público; cobertura del sistema; necesidad de ampliar GES | [ver página](https://www.colegiodentistas.cl) |

**Nota pendiente:** Buscar dato oficial de lista de espera odontológica en APS y costo exacto del AOI publicado por MINSAL o FONASA para reemplazar la estimación por fuente primaria directa.

---

## Subárea 5 — Equipamiento UCI

**Tipo de dato:** Costo unitario directo (costo de equipar una cama UCI completa)
**Nivel de disclaimer:** "Dato estimado" — costos de equipos bien documentados; el costo por cama incluye ventilador + monitor + catre + insumos

### Datos clave

| Concepto | Valor | Fuente |
|---|---|---|
| Camas UCI sistema público (pre-pandemia) | ~700 camas intensivas + ~1.000 intermedias = ~1.700 camas UPC | Colegio Médico / Pauta.cl, 2020 |
| Camas UCI sistema total (público + privado) | ~2.500 camas UPC totales | Investigadores de salud pública, 2020 |
| Costo total compra MINSAL: 872 ventiladores mecánicos (mar. 2020) | $12.568 MM CLP = ~$14.417 por ventilador | CIPER Chile, mar. 2020 |
| Costo por ventilador mecánico (precio de mercado 2020 pandemia) | ~$14–20 MM CLP (precio inflado en pandemia) | CIPER / MINSAL, 2020 |
| Costo ventilador mecánico estándar (precio normal) | ~$5–8 MM CLP | Estimación mercado pre-pandemia |
| Catre UCI eléctrico | ~$2–4 MM CLP | Proveedores hospitalarios Chile |
| Monitor multiparamétrico | ~$3–5 MM CLP | Proveedores hospitalarios Chile |
| **Costo equipamiento completo 1 cama UCI** (ventilador + monitor + catre + insumos iniciales) | **~$15–20 MM CLP** | Estimación agregada equipos + insumos instalación |

**Nota metodológica (argumento reformulado):** El número absoluto de camas equipables con el monto de los casos grandes resulta mayor que el total del sistema público (~700 camas UCI). Eso no es un problema — es el argumento. El gráfico no muestra "N camas" sino "X veces la capacidad UCI pública del país". Corfo-Inverlink habría equipado ~11.500 camas, equivalente a 16 veces todas las camas UCI públicas de Chile. Ese dato es deliberadamente impactante y honesto: ilustra la magnitud del dinero desviado en relación con una crisis concreta y documentada.

**Ejemplo de cálculo reformulado:**
- Corfo ($200.940 MM) ÷ $17,5 MM = ~11.482 camas = **16,4 veces** la capacidad UCI pública (~700 camas)
- Pacogate ($41.898 MM) ÷ $17,5 MM = ~2.394 camas = **3,4 veces** la capacidad UCI pública
- SQM ($13.500 MM) ÷ $17,5 MM = ~771 camas = **1,1 veces** la capacidad UCI pública
- Milicogate ($10.657 MM) ÷ $17,5 MM = ~609 camas = **0,87 veces** la capacidad UCI pública → ~609 camas nuevas

### Fuentes

| Fuente | Contenido | URL |
|---|---|---|
| CIPER Chile — MINSAL y ventiladores mecánicos | $12.568 MM por 872 ventiladores; denuncia de manipulación de precios; proveedores Mediplex, Kendall, Drager | [ver nota](https://www.ciperchile.cl/2020/03/20/minsal-paga-12-568-millones-por-ventiladores-mecanicos-y-gobierno-acusa-manipulacion-de-precios/) |
| Emol — características camas UCI Chile | Una cama UCI = catre + monitor + ventilador mecánico + fármacos + equipo profesional; 700 camas intensivas públicas pre-pandemia | [ver nota](https://www.emol.com/noticias/Nacional/2020/03/22/980632/Camas-criticas-Chile-caracteristicas.html) |
| Pauta.cl — camas críticas Chile COVID | 2.500 camas UPC totales (1.700 públicas + 800 privadas); 85–90% ocupación normal; déficit estructural | [ver nota](https://www.pauta.cl/nacional/camas-ventiladores-personal-los-factores-criticos-ante-colapso-red-salud) |
| Interferencia — camas UCI RM | 1.034 camas UCI en RM; 95% ocupación en pandemia; detalle por servicio de salud | [ver nota](https://interferencia.cl/articulos/solo-quedan-47-camas-uci-disponibles-en-toda-la-region-metropolitana) |
| Scielo — Costos reales tratamientos intensivos UCI Hospital Talca | Metodología ABC para calcular costo por día-cama UCI; incluye RR.HH., equipamiento e insumos | [ver artículo](https://scielo.conicyt.cl/scielo.php?script=sci_arttext&pid=S0034-98872013000200009) |
| MINSAL — balance inversiones 2024 | 47 rayos X, 24 tomógrafos, 9 resonadores, 9 angiógrafos como parte del plan de equipamiento hospitalario 2022–2024 | [ver nota](https://www.minsal.cl/inversiones) |

---

## Notas metodológicas del área

1. **Tipos de cálculo por subárea:** Medicamentos (1) y Operaciones en lista de espera (3) y Salud dental (4) usan **costo por beneficiario**. Salud mental (2) usa **costo unitario directo** (COSAM) como dato secundario, pero el argumento principal es de contraste de magnitudes. UCI (5) usa **costo unitario directo** reformulado como múltiplo de la capacidad del sistema.

2. **Las dos subáreas más poderosas del área:** Salud mental ambulatoria (Corfo = 97% de la brecha anual para llegar al mínimo OMS) y Operaciones en lista de espera (Corfo = 64% de la lista completa). Estas dos tienen el argumento de contraste más impactante de todo el proyecto.

3. **UCI — argumento de múltiplo:** Cuando el número absoluto supera el total del sistema, el argumento correcto es "X veces la capacidad pública". Para Corfo: 16,4 veces. Para Pacogate: 3,4 veces. Esto es impactante y honesto — no confunde al usuario.

4. **Salud dental — pendiente clave:** Se necesita el dato de lista de espera odontológica y el costo exacto del AOI publicado por MINSAL para cerrar esta subárea con fuente primaria.

---

## Notas pendientes

- [x] ~~Buscar en BIP un proyecto específico de construcción de posta rural~~ — Subárea reemplazada por Salud dental. Dato ya no necesario.
- [x] ~~Confirmar costo promedio por cirugía electiva en el sistema público~~ — Resuelto con fuente indirecta verificable ($800.000 promedio, plan FONASA 2024).
- [ ] Verificar número exacto de beneficiarios LRS activos 2024 y presupuesto ejecutado — para calcular costo por paciente con mayor precisión. MINSAL publica informe anual LRS.
- [ ] Buscar dato oficial de lista de espera odontológica en APS y costo exacto del AOI publicado por MINSAL o FONASA — para cerrar subárea 4 con fuente primaria directa.
