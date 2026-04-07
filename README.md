# Costo Social de la Corrupción en Chile

> **¿Qué habría podido hacer Chile con el dinero que se robaron?**

Una aplicación interactiva construida en R/Shiny que traduce los montos defraudados en cinco grandes casos de corrupción chilena a beneficios sociales concretos no entregados: tratamientos médicos, jardines infantiles, pensiones, viviendas, y más.

---

## ¿Qué hace esta app?

Entre 2003 y 2017, cinco casos de corrupción le costaron al Estado chileno más de **$283.000 millones de pesos** (a valores de diciembre de 2025). Esta aplicación permite explorar ese número de forma concreta:

- Selecciona un **caso de corrupción** (Corfo-Inverlink, Pacogate, Caso SQM, Caso Penta, Milicogate)
- Selecciona un **área social** (Salud, Educación, Pensiones, Seguridad, Vivienda, Género)
- La app calcula cuántas unidades de ese beneficio habrían podido financiarse con el dinero defraudado

Además incluye:
- Reseñas detalladas de cada caso con sus montos ajustados por IPC
- Contexto estructural por área social
- Red interactiva de relaciones de poder entre los involucrados en los casos Penta y SQM
- Registro de los actores involucrados en cada caso (condenas, estados procesales, cercanías políticas)
- Sección metodológica con criterios de selección, ajuste por inflación y niveles de advertencia de cada estimación

---

## Casos analizados

| Caso | Monto base | Ajuste IPC | Monto dic. 2025 |
|------|-----------|------------|-----------------|
| Corfo-Inverlink | $85.000 MM | ×2,364 | ~$200.940 MM |
| Pacogate | $28.348 MM | ×1,478 | ~$41.898 MM |
| Caso SQM | ~$7.615 MM | ×1,773 | ~$13.500 MM |
| Caso Penta | $10.000 MM | ×1,620 | ~$16.200 MM |
| Milicogate | $6.100 MM | ×1,747 | ~$10.657 MM |

> Todos los montos ajustados con la calculadora oficial del IPC del INE (calculadoraipc.ine.cl).

---

## Áreas sociales cubiertas

La app incluye 30 subáreas distribuidas en 6 grandes áreas:

- **Salud** — Ley Ricarte Soto, salud mental (COSAM), listas de espera quirúrgicas, salud dental pública, equipamiento UCI
- **Educación** — Becas universitarias, jardines JUNJI, liceos TP, infraestructura escolar rural, I+D y matriz productiva
- **Pensiones** — PGU para trabajadores informales y adultos mayores, brecha de género (BAC), deuda previsional, jóvenes sin cotización
- **Seguridad** — Dotación de Carabineros, delitos económicos PDI, infraestructura penitenciaria, centros de reinserción, Fiscalía Supraterritorial
- **Vivienda** — Viviendas sociales DS49, lista de espera SERVIU, subsidios de arriendo DS52, campamentos, mejoramiento de viviendas
- **Género** — Sistema nacional de cuidados, pensiones alimenticias, casas de acogida VIF, acceso a justicia, postnatal masculino

---

## Librerías utilizadas

```r
library(shiny)        # Framework de la aplicación web
library(bslib)        # Temas y componentes Bootstrap
library(bsicons)      # Íconos Bootstrap
library(tidyverse)    # Manipulación de datos
library(tidyr)        # Transformación de datos
library(shinyWidgets) # Widgets adicionales para Shiny
library(plotly)       # Gráficos interactivos
library(visNetwork)   # Red de relaciones interactiva
library(rsconnect)    # Deploy en shinyapps.io
```

---

## Cómo correr la app localmente

**Requisitos:** R (≥ 4.1) y RStudio (recomendado)

```r
# 1. Instalar dependencias
install.packages(c(
  "shiny", "bslib", "bsicons", "tidyverse",
  "tidyr", "shinyWidgets", "plotly", "visNetwork", "rsconnect"
))

# 2. Clonar este repositorio y correr la app
shiny::runApp("app.R")
```

---

## Metodología

Los cálculos se basan en tres decisiones metodológicas principales:

1. **Selección de casos**: se priorizaron los cinco casos con mayor impacto económico documentado, con montos verificables en fuentes judiciales, periodísticas e investigativas. Representan distintos tipos de corrupción: sustracción directa de fondos públicos, evasión tributaria y financiamiento político ilegal.

2. **Ajuste por inflación**: todos los montos están en pesos de diciembre de 2025, ajustados con la calculadora oficial del IPC del INE.

3. **Niveles de advertencia por subárea**:
   - **Dato estimado**: costo unitario documentado en fuente oficial. Mayor nivel de confianza.
   - **Escenario proyectado**: basado en estimaciones demográficas o comparaciones internacionales.
   - **Política hipotética**: la subárea describe una política que aún no existe en Chile.

> Esta aplicación tiene carácter exploratorio, educativo y ciudadano. Los escenarios son hipotéticos y no afirman que el dinero recuperado se habría destinado necesariamente a estos fines.

---

## Fuentes de datos

Los costos unitarios de cada subárea se construyeron a partir de fuentes oficiales chilenas. A continuación se listan las principales por área:

### Salud
MINSAL, FONASA, Ley Ricarte Soto (MINSAL), Ministerio de Salud (informes de lista de espera), DIPRES, OMS.

### Educación
MINEDUC, JUNJI, ANID, Corfo, OCDE (Education at a Glance), Banco Mundial.

### Pensiones
Superintendencia de Pensiones, ChileAtiende, Subsecretaría de Previsión Social, OCDE, CIES UDD, Gobierno de Chile (Reforma Previsional 2025).

### Seguridad
Carabineros de Chile, PDI, Gendarmería, Fiscalía de Chile, DIPRES, Ministerio de Justicia, MOP, CEP Chile, IPP UNAB, LyD.

### Vivienda
MINVU (Centro de Estudios), SERVIU Metropolitano, INE (Censo 2024, Casen 2024), TECHO Chile, ChileAtiende, Red Vivienda y Ciudad.

### Género
SernamEG, Poder Judicial, Cámara de Diputados (Boletín 16905-31 Sistema Nacional de Cuidados), ChileAtiende, BCN, INE (ENUT 2015), OCDE.

### Casos de corrupción
CIPER Chile, La Tercera, BioBioChile, Cooperativa, El Mostrador, The Clinic, Poder Judicial TV, BCN, Wikipedia (referencias secundarias), Weibel (2016) *Traición a la patria*.

---

## Advertencia

Esta aplicación no es un análisis de política pública formal. Es un ejercicio ciudadano de visualización. La complejidad del proceso presupuestario, las negociaciones políticas y los plazos de ejecución hacen imposible garantizar que cualquier monto recuperado se habría destinado directamente a las subáreas aquí descritas. Lo que sí ilustra, con datos verificables, es la magnitud de lo que se perdió en términos de posibilidades concretas.

---

*Desarrollado con R y Shiny. Datos actualizados a diciembre de 2025.*

## Copyright and Use

© 2026 Cristian Salinas Ochoa. All rights reserved.

This repository is public for viewing purposes only.
No permission is granted to copy, modify, redistribute,
or use this code without prior written authorization.
