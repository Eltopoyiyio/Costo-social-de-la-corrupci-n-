# Estado del proyecto — 12 de marzo de 2026

**Proyecto:** Costo Social de la Corrupción en Chile
**Tecnología:** R Shiny → GitHub Pages
**Objetivo principal:** Visualizar cuántos beneficios sociales no se entregaron por causa de la corrupción. Cada decisión nueva se evalúa contra este objetivo antes de incorporarse.

---

## Lo que se completó hoy

Las cinco fichas de casos están cerradas con montos base, factores IPC verificados en la calculadora oficial del INE y montos ajustados a pesos de diciembre 2025.

| # | Caso | Factor INE | Monto base | Monto ajustado dic. 2025 |
|---|---|---|---|---|
| 1 | Corfo-Inverlink | ×2,364 | $85.000 MM CLP | ~$200.940 MM CLP |
| 2 | Pacogate | ×1,478 | $28.348 MM CLP | ~$41.898 MM CLP |
| 3 | SQM | ×1,773 | ~$7.615 MM CLP | ~$13.500 MM CLP |
| 4 | Caso Penta | ×1,620 | $10.000 MM CLP | ~$16.200 MM CLP |
| 5 | Milicogate | ×1,747 | $6.100 MM CLP | ~$10.657 MM CLP |

**Año base universal para todos los ajustes:** diciembre 2025
**Fuente IPC:** calculadora oficial INE (https://calculadoraipc.ine.cl), ingresando $1.000 pesos desde el año de referencia del caso hasta diciembre 2025.

---

## Archivos generados (deben estar en Obsidian, carpeta 01_Casos)

- `Corfo-Inverlink.md`
- `Pacogate-Fraude-Carabineros.md`
- `Caso-SQM.md`
- `Caso-Penta.md`
- `Milicogate-FAMAE.md`

---

## Decisiones metodológicas cerradas

**Casos SQM y Penta:** No son sustracción directa sino evasión tributaria y financiamiento político ilegal. El argumento del proyecto es que ese dinero nunca llegó al fisco y solo fue recuperado porque hubo una investigación judicial que pudo no haber ocurrido. Se usa ese encuadre en los disclaimers.

**Caso Penta — monto base:** $10.000 MM CLP (total pagado por Penta al fisco incluyendo impuestos, intereses y reajustes). Disclaimer: fue recuperado solo porque los pillaron.

**Caso Milicogate — monto base:** $6.100 MM CLP (causa madre, indagatoria judicial 2019). La arista FAMAE (~US$83 MM) no se incorpora por no tener cierre judicial. Se menciona en el disclaimer como daño potencialmente mayor.

**Fuente-Alba:** Absuelto por lavado de activos en mayo 2024, ratificado por Corte Suprema en febrero 2026. El tribunal acreditó la malversación base pero la Fiscalía no logró probar el lavado posterior. La causa militar sigue abierta. Esto se explica con cuidado en la ficha y en la app.

**Disclaimers diferenciados (regla general del proyecto):**
- "Dato estimado" — monto sin sentencia firme o cifras disputadas
- "Escenario proyectado" — estimaciones demográficas o comparadas
- "Política hipotética" — proyecciones internacionales sin política nacional implementada

---

## Próximos pasos (en orden)

### Paso 1 — Revisar notas pendientes de las 5 fichas
Cada ficha tiene una sección "Notas pendientes" al final. Revisarlas en orden antes de dar por cerrada la fase de casos.

Pendientes conocidos:
- Confirmar tipo de cambio promedio 2008–2014 para SQM con datos del Banco Central (afecta la conversión USD → CLP)
- Confirmar si Ena Von Baer tuvo formalización posterior o solo declaró como testigo (Penta)
- Verificar si hay condenas adicionales en Milicogate tras las primeras dos sentencias de febrero 2020
- Verificar estado procesal de Oviedo en Milicogate (formalizado por lavado de activos sobre $240 MM)
- Confirmar si hay aristas activas del Caso Penta después de 2022

### Paso 2 — Actualizar el documento de arquitectura
Incorporar la tabla completa de casos con montos ajustados verificados y marcar la fase de fichas como completada en el checklist de estado del proyecto.

### Paso 3 — Mapeo de fuentes de costos unitarios por área social
Seis áreas, cinco subáreas cada una. Fuentes principales a consultar: BIP/MDS, MINVU, MINSAL, JUNJI, SUSESO, INE, ANID, OCDE, SernamEG.

---

## Ideas en standby (no incorporar hasta completar el proyecto base)

**Gráfico de redes Penta-SQM-Wagner:** Apartado "La red detrás de los casos" con visualización interactiva de conexiones entre personajes. Tecnología sugerida: `visNetwork` o `networkD3`. Evaluar en versión 2.0.

---

## Nota sobre continuidad entre chats

Al inicio del próximo chat, pegar este archivo como contexto. Mencionar que venimos de completar las 5 fichas y que el siguiente paso es revisar notas pendientes antes de actualizar la arquitectura. Sin eso, el chat nuevo parte desde cero.
