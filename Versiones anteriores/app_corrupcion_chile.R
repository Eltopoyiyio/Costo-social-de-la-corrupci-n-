library(shiny)
library(bslib)
library(tidyverse)
library(shinyWidgets)
library(bsicons)
library(plotly)

# ==============================================================================
# 1. DATOS MAESTROS
# ==============================================================================

# --- Casos de Corrupción ---
tabla_casos <- tibble::tribble(
  ~id,           ~nombre,            ~monto_mm,  ~resena,

  "inverlink",   "Corfo-Inverlink",   200940,
  "En febrero de 2003, el holding financiero Inverlink —liderado por el empresario Eduardo Monasterio— sustrajo $85.000 millones en depósitos a plazo de CORFO con la complicidad de Javier Moya, tesorero de la institución. El fraude salió a la luz por accidente: la secretaria del presidente del Banco Central filtró información reservada a Inverlink, y un correo enviado por error destapó toda la trama. El escándalo salpicó al gobierno de Ricardo Lagos a través de Gonzalo Rivas —su yerno y vicepresidente ejecutivo de CORFO—, quien renunció asumiendo responsabilidad política. Monasterio falleció en 2015 sin cumplir condena efectiva. Veinte años después, CORFO ha recuperado $55.696 millones; el resto se disputa aún en tribunales civiles. Ajustado por inflación a pesos de diciembre de 2025, el monto sustraído equivale a $200.940 millones.",

  "pacogate",    "Pacogate",          41898,
  "Entre 2006 y 2017, una red de oficiales enquistada en la Dirección de Finanzas de Carabineros malversó más de $28.000 millones mediante tres mecanismos: desvíos desde cuentas de remuneraciones, desahucios y asignaciones hacia cuentas personales de más de 130 funcionarios reclutados. BancoEstado alertó sobre irregularidades en 2015, pero el mando institucional ignoró la señal durante dos años. El caso fue reconocido públicamente en marzo de 2017 por el entonces general director Bruno Villalobos —quien hoy enfrenta cargos por malversación de gastos reservados. En octubre de 2024, el exgeneral director Eduardo Gordon fue condenado a tres años y un día de libertad vigilada. Los juicios contra los generales directores González Jure y Villalobos continúan. Ajustado por inflación, el monto de la causa madre equivale a $41.898 millones a pesos de diciembre de 2025.",

  "sqm",         "Caso SQM",          13500,
  "Entre 2008 y 2014, la empresa minera SQM —controlada por Julio Ponce Lerou, yerno del dictador Augusto Pinochet— pagó US$14,7 millones a través de boletas y facturas por servicios que nunca se prestaron, con el objetivo de financiar ilegalmente campañas y partidos políticos de todo el espectro, desde la UDI hasta el PS. El dinero fue declarado como gasto empresarial deducible de impuestos: nunca tributó, nunca llegó al fisco. El caso fue reconocido por la propia SQM ante la justicia de Estados Unidos en 2017. En Chile, terminó en impunidad casi total: en octubre de 2025 un tribunal absolvió a los ocho principales acusados —entre ellos el exlíder de la UDI Pablo Longueira y el excandidato presidencial Marco Enríquez-Ominami. El fisco recuperó apenas $4.600 millones de los más de $13.500 millones que nunca tributaron.",

  "penta",       "Caso Penta",        16200,
  "En agosto de 2014, el Servicio de Impuestos Internos denunció al Grupo Penta —controlado por Carlos Délano y Carlos Lavín, amigos personales del expresidente Sebastián Piñera— por el uso masivo de boletas y facturas ideológicamente falsas para reducir su carga tributaria y financiar ilegalmente campañas políticas, principalmente de la UDI. En total, Penta pagó cerca de $10.000 millones en impuestos adeudados, intereses y reajustes —dinero que solo fue recuperado porque hubo una investigación judicial que pudo no haber ocurrido. Délano y Lavín fueron condenados a cuatro años de libertad vigilada y completaron su condena en 2022 tras un curso de ética en la Universidad Adolfo Ibáñez. El político más prominente condenado fue el exsenador y expresidente de la UDI Jovino Novoa. Iván Moreira fue sobreseído tras pagar una multa de $35 millones. Ajustado por inflación, el monto equivale a $16.200 millones a pesos de diciembre de 2025.",

  "milicogate",  "Milicogate",        10657,
  "Entre 2010 y 2014, un grupo de oficiales y suboficiales del Ejército de Chile desvió más de $6.100 millones de la Ley Reservada del Cobre —un fondo secreto que entregaba el 10% de las ventas de Codelco a las Fuerzas Armadas sin control del Congreso ni de la Contraloría— mediante boletas y facturas falsas de proveedores confabulados. El dinero se gastó en casinos, propiedades y vehículos de lujo. El caso fue destapado en 2015 por el periodista Mauricio Weibel en The Clinic, a partir de grabaciones secretas realizadas por los propios militares. El excomandante en jefe Juan Miguel Fuente-Alba fue absuelto en mayo de 2024 por lavado de activos —absolución ratificada por la Corte Suprema en febrero de 2026— aunque el tribunal acreditó el delito base de malversación. Las únicas condenas efectivas recayeron en los eslabones más bajos: el excabo Juan Carlos Cruz fue condenado a 12 años de presidio. El escándalo contribuyó directamente a la derogación de la Ley Reservada del Cobre en 2019. Ajustado por inflación, el monto equivale a $10.657 millones a pesos de diciembre de 2025."
)

# --- Estructura de áreas y subáreas ---
# costo_unitario_mm: en millones de pesos dic. 2025
# unidad: etiqueta singular para el cálculo
# disclaimer: nivel metodológico

tabla_subareas <- tibble::tribble(
  ~area,        ~area_id,    ~subarea,                                         ~subarea_id,         ~costo_unitario_mm,  ~unidad,                         ~disclaimer,

  # Salud
  "Salud",      "salud",     "Medicamentos de alto costo (Ley Ricarte Soto)",  "lrs",               7.5,                 "tratamientos anuales",          "Dato estimado",
  "Salud",      "salud",     "Salud mental ambulatoria (COSAM)",               "cosam",             1304.0,              "centros construidos",           "Dato estimado",
  "Salud",      "salud",     "Operaciones en lista de espera",                 "operaciones",       0.8,                 "cirugías electivas",            "Dato estimado",
  "Salud",      "salud",     "Salud dental pública",                           "dental",            0.065,               "atenciones dentales integrales","Dato estimado",
  "Salud",      "salud",     "Equipamiento UCI",                               "uci",               17.5,                "camas UCI completas",           "Dato estimado",

  # Educación
  "Educación",  "educacion", "I+D y matriz productiva",                        "id",                438561.0,            "presupuesto ANID (referencia)", "Escenario proyectado",
  "Educación",  "educacion", "Becas universitarias",                           "becas",             1.15,                "becas universitarias anuales",  "Dato estimado",
  "Educación",  "educacion", "Jardines infantiles JUNJI",                      "junji",             1200.0,              "jardines infantiles",           "Dato estimado",
  "Educación",  "educacion", "Liceos técnico-profesionales",                   "liceos_tp",         80.0,                "liceos TP equipados",           "Dato estimado",
  "Educación",  "educacion", "Infraestructura escolar rural",                  "rural",             423.0,               "escuelas rurales con conservación","Dato estimado",

  # Pensiones
  "Pensiones",  "pensiones", "Pensión para trabajadores informales (PGU)",     "pgu_informal",      2.780784,            "trabajadores con PGU por un año","Dato estimado",
  "Pensiones",  "pensiones", "Brecha de género en pensiones (BAC)",            "bac",               1.2,                 "mujeres con compensación anual","Dato estimado",
  "Pensiones",  "pensiones", "Deuda previsional de empleadores",               "deuda_prev",        16000000.0,          "deuda total de empleadores (referencia)","Escenario proyectado",
  "Pensiones",  "pensiones", "PGU para adultos mayores en pobreza",            "pgu_adultos",       2.780784,            "adultos mayores con PGU por un año","Dato estimado",
  "Pensiones",  "pensiones", "Jóvenes sin cotización futura",                  "jovenes_cot",       0.6,                 "jóvenes con un año de cotización garantizada","Escenario proyectado",

  # Seguridad
  "Seguridad",  "seguridad", "Dotación de Carabineros",                        "carabineros",       33.2,                "carabineros en terreno por un año","Dato estimado",
  "Seguridad",  "seguridad", "Ciberdelito y delitos económicos (PDI)",         "pdi",               30.0,                "investigadores especializados por un año","Dato estimado",
  "Seguridad",  "seguridad", "Infraestructura penitenciaria",                  "carceles",          65.0,                "plazas penitenciarias nuevas",  "Dato estimado",
  "Seguridad",  "seguridad", "Centros de reinserción",                         "reinsercion",       5.25,                "personas en reinserción por un año","Escenario proyectado",
  "Seguridad",  "seguridad", "Fiscales especializados (ECOH)",                 "ecoh",              12197.0,             "presupuesto ECOH (referencia)", "Dato estimado",

  # Vivienda
  "Vivienda",   "vivienda",  "Viviendas sociales SERVIU (DS49)",               "ds49",              31.6,                "viviendas sociales DS49",       "Dato estimado",
  "Vivienda",   "vivienda",  "Lista de espera SERVIU",                         "lista_espera",      600800.0,            "programa DS49 anual (referencia)","Escenario proyectado",
  "Vivienda",   "vivienda",  "Subsidios de arriendo (DS52)",                   "ds52",              6.712,               "familias con subsidio 8 años",  "Dato estimado",
  "Vivienda",   "vivienda",  "Familias en campamentos",                        "campamentos",       46.8,                "familias con solución habitacional","Escenario proyectado",
  "Vivienda",   "vivienda",  "Mejoramiento de viviendas",                      "mejoramiento",      4.74,                "viviendas mejoradas",           "Dato estimado",

  # Género
  "Género",     "genero",    "Política nacional de cuidados",                  "cuidados",          0.912,               "cuidadoras con estipendio anual","Dato estimado",
  "Género",     "genero",    "Pensiones alimenticias",                         "alimentos",         30.0,                "funcionarios en Tribunales de Familia por un año","Dato estimado",
  "Género",     "genero",    "Casas de acogida VIF",                           "acogida",           300.0,               "Residencias Transitorias habilitadas","Dato estimado",
  "Género",     "genero",    "Acceso a la justicia VIF",                       "justicia_vif",      30.0,                "profesionales especializados VIF por un año","Dato estimado",
  "Género",     "genero",    "Postnatal masculino ampliado",                   "postnatal",         0.17049,             "padres con postnatal de 30 días","Política hipotética"
)

# ==============================================================================
# 2. TEXTOS NARRATIVOS
# ==============================================================================

# Contextos de área (estáticos)
contextos_area <- list(
  salud = "Chile gasta el 9,3% de su PIB en salud, pero la mitad de esa inversión la hacen las propias familias de su bolsillo. El sistema público —que cubre al 79% de la población a través de FONASA— enfrenta una crisis estructural documentada en cada plan ministerial de la última década: listas de espera que superan el año y medio, hospitales con equipamiento insuficiente, y una salud mental que recibe apenas el 2,1% del presupuesto sectorial cuando la OMS recomienda al menos el 10%. En 2024, más de 36.000 personas murieron mientras esperaban una atención en el sistema público.",

  educacion = "Chile invierte casi el 5,5% de su PIB en educación, pero los resultados revelan una brecha estructural que el dinero solo no explica. Los estudiantes del sistema público aprenden en condiciones radicalmente distintas según la comuna donde nacieron: escuelas rurales con infraestructura deteriorada, liceos técnico-profesionales sin equipamiento para enseñar las especialidades que dictan, y una inversión en investigación y desarrollo que lleva más de una década estancada en menos del 0,4% del PIB —cuando el promedio de la OCDE triplica esa cifra. El sistema forma técnicos y profesionales que luego no encuentran empleos de calidad, porque la economía que los debería absorber nunca se diversificó.",

  pensiones = "El sistema de pensiones chileno es uno de los debates más largos y dolorosos de la política nacional. Creado en 1981 bajo la dictadura de Pinochet, el modelo de capitalización individual funciona razonablemente bien para quienes cotizan de forma constante a lo largo de su vida laboral, pero falla profundamente para quienes no pueden hacerlo. En Chile, 3,3 millones de personas no cotizan, el 37% de los trabajadores opera en la informalidad, y las mujeres acumulan en promedio 9 años menos de cotizaciones que los hombres. La Reforma Previsional de 2025 es un avance real. Pero llegó tarde para millones de personas, y su alcance sigue siendo insuficiente para quienes nunca pudieron cotizar.",

  seguridad = "Chile vive un momento de inflexión en materia de seguridad. El crimen organizado transnacional se instaló en el país aprovechando vacíos institucionales que se acumularon durante décadas: una dotación policial insuficiente, un sistema penitenciario con hacinamiento al 147%, cárceles que funcionan como centros de reclutamiento criminal, y una institucionalidad de persecución del delito económico y organizado que llegó tarde y con recursos escasos. Parte del dinero que debió fortalecer al Estado en estos años fue desviado —en algunos casos, por las propias instituciones que debían proteger a la ciudadanía.",

  vivienda = "Chile tiene un déficit de casi 492.000 viviendas —familias que viven hacinadas, allegadas o en condiciones irrecuperables. Si se suman las viviendas que requieren mejoramiento urgente, el número supera 1,7 millones. En 2024 había 120.584 familias viviendo en campamentos —la cifra más alta en décadas. El 26,2% de los hogares arrienda, el porcentaje más alto de la historia. Ninguno de los casos de corrupción que analiza este proyecto habría resuelto el déficit habitacional de Chile por sí solo. Pero cada peso que no llegó es una familia que siguió esperando.",

  genero = "La desigualdad de género en Chile no es un problema de actitudes individuales: es un problema estructural con costos económicos medibles. Las mujeres trabajan en promedio 21 horas más a la semana que los hombres —en cuidados no remunerados que el sistema económico necesita pero no paga. Esa carga determina sus trayectorias laborales, sus cotizaciones previsionales y su autonomía económica. Y cuando la desigualdad económica se convierte en dependencia, la violencia encuentra terreno. En 2024 hubo 50 femicidios y más de 132.000 casos policiales por violencia intrafamiliar."
)

# Contextos de subárea (estáticos)
contextos_subarea <- list(
  lrs = "En Chile, tener una enfermedad rara o una condición de alto costo puede significar la ruina económica de una familia entera. La Ley Ricarte Soto, creada en 2015, fue el primer intento del Estado de garantizar tratamientos para enfermedades como la esclerosis múltiple, la hepatitis C o ciertos tipos de cáncer poco frecuentes. Hoy cubre cerca de 7.500 pacientes con un presupuesto de $56.000 millones al año —aproximadamente $7.500.000 por paciente anual. Sin embargo, decenas de patologías siguen fuera de la ley, y quienes las padecen deben costear tratamientos de hasta $50 millones al año o directamente no acceder a ellos.",

  cosam = "Chile dedica apenas el 2,1% de su presupuesto de salud a la salud mental, cuando la OMS recomienda al menos un 10%. El resultado es un sistema que solo logra cubrir el 20% de los trastornos mentales diagnosticados. Los Centros de Salud Mental Comunitaria (COSAM) son la columna vertebral de la atención ambulatoria pública: equipos de psicólogos, psiquiatras y trabajadores sociales que atienden de forma gratuita. En 2024, el gobierno financió la construcción de 9 nuevos COSAM con $11.736 millones. Construir un COSAM estándar cuesta aproximadamente $1.304 millones.",

  operaciones = "A fines de 2024, había 390.229 cirugías pendientes en el sistema público chileno. Son personas que ya tienen el diagnóstico, ya tienen la indicación médica, y llevan esperando un promedio de 579 días —casi 19 meses— para entrar a un pabellón. Ese año, más de 36.000 personas murieron mientras esperaban una atención de salud. En 2024 el Estado destinó $48.000 millones para reducir la lista, lo que permite costear aproximadamente $800.000 por cirugía electiva promedio.",

  dental = "La salud dental es uno de los grandes ausentes de la salud pública chilena. La cobertura garantizada del sistema solo alcanza a embarazadas y niños de 6 años. Se estima que cerca del 60% de la población adulta no tiene acceso oportuno a atención dental. Una alta odontológica integral (AOI) —el procedimiento completo que incluye diagnóstico, extracción, obturación y control— cuesta aproximadamente $65.000 en el sistema público para quienes logran acceder. Las consecuencias van mucho más allá de lo estético: la salud bucal está directamente relacionada con enfermedades cardiovasculares, diabetes y calidad de vida.",

  uci = "Antes de la pandemia, Chile tenía alrededor de 700 camas de Unidad de Cuidados Intensivos en el sistema público. Cuando llegó el COVID-19, el país descubrió en tiempo real lo que los especialistas advertían desde hacía años: el sistema público tenía una capacidad crítica insuficiente. Equipar una cama UCI completa —ventilador mecánico, monitor multiparamétrico, catre eléctrico e insumos— cuesta aproximadamente $17,5 millones. El déficit estructural de camas críticas no desapareció con la pandemia.",

  id = "Chile lleva más de diez años invirtiendo menos del 0,4% de su PIB en investigación y desarrollo —una de las cifras más bajas de la OCDE, cuyo promedio supera el 2,7%. La agencia que financia toda la investigación científica y tecnológica de Chile —ANID— operó con un presupuesto de $438.561 millones en 2024. Esa subinversión se traduce en una economía que sigue dependiendo del cobre y los recursos naturales, y que no genera los empleos cualificados que sus propios técnicos e ingenieros necesitan para desarrollarse en el país.",

  becas = "En Chile, el acceso a la educación superior sigue siendo profundamente desigual. La Beca Juan Gómez Millas entrega hasta $1.150.000 al año para cubrir aranceles en universidades acreditadas. Para muchos estudiantes de primera generación universitaria, cada peso del sistema de becas es la diferencia entre continuar o abandonar.",

  junji = "La educación parvularia es la inversión con mayor retorno comprobado en el ciclo educativo: cada peso invertido en los primeros años de vida reduce significativamente las brechas de aprendizaje que luego son casi imposibles de cerrar. Construir un jardín infantil JUNJI estándar —con capacidad para 80 a 100 niños— cuesta aproximadamente $1.200 millones, y puede costar hasta $3.300 millones en zonas extremas.",

  liceos_tp = "El 44% de los estudiantes de educación media en Chile estudia en liceos técnico-profesionales. En un tercio de esos liceos —unos 300 establecimientos— los docentes reportan mínima o nula disponibilidad de equipamiento para enseñar las especialidades que dictan. El programa oficial de equipamiento del Ministerio de Educación invierte aproximadamente $80 millones por liceo.",

  rural = "En Chile hay miles de escuelas rurales que educan a los niños más alejados de los centros urbanos. El Fondo de Conservación de Infraestructura Escolar destinó en 2024 $52.868 millones para atender a 125 establecimientos —un promedio de $423 millones por escuela. El catastro del Ministerio identifica cerca de 2.000 establecimientos que requieren intervención urgente.",

  pgu_informal = "En Chile hay 3,3 millones de personas que trabajan sin cotizar. Cuando lleguen a la vejez, su única red de protección será la Pensión Garantizada Universal (PGU): $231.732 al mes para quienes tienen entre 65 y 81 años, y $250.275 para quienes superan los 82. La reforma previsional de 2025 amplió la cobertura de la PGU, pero no resuelve el problema de fondo: una persona que no cotizó durante su vida activa dependerá exclusivamente del Estado para sobrevivir en la vejez.",

  bac = "Las mujeres chilenas se jubilan con pensiones significativamente más bajas que los hombres, porque tienen en promedio 9 años menos de cotizaciones —pasaron esos años cuidando a hijos, padres o familiares, trabajo que el sistema previsional nunca reconoció económicamente. La reforma de 2025 introdujo el Beneficio por Años Cotizados (BAC), que en su tope máximo suma hasta $100.000 mensuales adicionales a la pensión de una mujer con 25 años de cotizaciones.",

  deuda_prev = "Hay una forma de robo que ocurre todos los meses en Chile: empleadores que descuentan las cotizaciones previsionales del sueldo de sus trabajadores y luego no las transfieren a las AFP. A 2024, 315.000 empleadores tenían deuda previsional acumulada con 2,4 millones de trabajadores. La deuda total supera los $16 billones. Son $16.000.000 millones en cotizaciones que ya salieron del bolsillo de los trabajadores y nunca llegaron a su cuenta de ahorro.",

  pgu_adultos = "La Pensión Garantizada Universal llegó para garantizar un piso mínimo a quienes más lo necesitan: adultos mayores que llegaron a la vejez sin ahorros suficientes. Hoy la PGU entrega $231.732 mensuales para quienes tienen entre 65 y 81 años, y $250.275 para los mayores de 82. Más de 2,4 millones de personas la reciben. Su monto apenas supera la línea de pobreza.",

  jovenes_cot = "La crisis previsional que hoy viven los adultos mayores se está gestando ahora en la generación joven. Entre 2024 y 2025 hubo 112.000 jóvenes de entre 18 y 34 años que dejaron de estar ocupados en el sector formal. Cada año sin cotizar a los 25 equivale a perder más pensión futura que tres años sin cotizar a los 50. Una persona que empieza a cotizar 10 años más tarde puede perder entre el 30% y el 40% de su pensión final.",

  carabineros = "Chile tiene 2,29 carabineros por cada 100.000 habitantes —por debajo del promedio internacional de 2,80. En 2025, el gobierno anunció la incorporación de 1.300 carabineros adicionales, la mayor expansión en años. El costo de sostener un carabinero en terreno —incluyendo remuneración, equipamiento y todos los costos institucionales— equivale a aproximadamente $33.200.000 al año.",

  pdi = "Los delitos más costosos para el Estado y la democracia no son los que se cometen con violencia: son los que se cometen con boletas falsas, transferencias electrónicas y redes de testaferros. Chile creó la Jefatura Nacional de Cibercrimen de la PDI (Jenaciber) en 2022, y tiene brigadas de investigación de delitos económicos en todas las regiones. El costo de mantener un investigador especializado en estas unidades es aproximadamente $30.000.000 al año.",

  carceles = "A diciembre de 2025, había 62.323 personas privadas de libertad en establecimientos con capacidad para 42.437. El hacinamiento hace imposible clasificar a los internos por perfil criminológico y convierte las cárceles en espacios donde las organizaciones criminales reclutan y consolidan poder. Construir una plaza penitenciaria nueva cuesta aproximadamente $65.000.000 según el Plan Maestro de Infraestructura Penitenciaria.",

  reinsercion = "La reinserción social es la única intervención que realmente reduce la criminalidad a largo plazo —y es también la que recibe menos recursos dentro del presupuesto de seguridad. Las personas que participan en programas de reinserción con empleo y educación tienen tasas de reincidencia de alrededor del 22%, frente al 50-60% de quienes salen sin ningún programa. La reinserción recibe apenas el 10% del presupuesto de Gendarmería.",

  ecoh = "El Equipo Conjunto contra el Crimen Organizado y Homicidios (ECOH) opera con 314 profesionales en 10 regiones, con un presupuesto de $12.197 millones anuales. Son las unidades que persiguen exactamente los tipos de delitos que analiza este proyecto: fraude tributario, financiamiento político ilegal, malversación de fondos públicos. Cada profesional cuesta aproximadamente $38.800.000 al año.",

  ds49 = "El Fondo Solidario de Elección de Vivienda —DS49— es el principal instrumento del Estado para entregar viviendas sin deuda al 40% más vulnerable. El subsidio base es de 800 UF —aproximadamente $31.600.000. El postulante debe aportar un ahorro mínimo de solo 10 UF. En 2026, el Ministerio de Vivienda tiene presupuesto para 19.000 subsidios DS49. Con un déficit de 492.000 viviendas y ese ritmo de entrega, resolver el déficit tomaría más de 25 años.",

  lista_espera = "No existe una cifra oficial del número de familias en lista de espera habitacional en Chile. Lo que sí existe es el déficit: 492.000 viviendas requeridas, y 19.000 subsidios DS49 disponibles para 2026. El costo anual de operar el programa DS49 al ritmo de 2026 es aproximadamente $600.800 millones. Los montos de los casos de corrupción de este proyecto son fracciones de esa cifra —lo que revela la escala del problema habitacional de Chile.",

  ds52 = "El 26,2% de los hogares chilenos arrienda —el porcentaje más alto de la historia del país. El Subsidio de Arriendo DS52 entrega 170 UF en total —aproximadamente $6.712.000— para que una familia pueda complementar el pago de su arriendo durante hasta 8 años, con un aporte mensual de hasta $193.000 en la Región Metropolitana. Cada llamado del DS52 tiene cupos limitados que se agotan rápidamente frente a una demanda que crece cada año.",

  campamentos = "En Chile hay 120.584 familias viviendo en 1.428 campamentos. Muchas de esas familias están inscritas en la lista de espera de SERVIU —no se saltaron la fila, construyeron donde pudieron mientras esperaban. Desde 2022, los campamentos han crecido en 341 nuevos polígonos y más de 6.000 familias adicionales. Proveer una solución habitacional definitiva a todas las familias en campamento costaría aproximadamente $46.800.000 por familia.",

  mejoramiento = "El déficit cualitativo de vivienda en Chile supera el millón doscientas mil unidades: viviendas habitadas que presentan problemas estructurales, de habitabilidad o de saneamiento. El Programa de Habitabilidad Rural ofrece hasta 120 UF —aproximadamente $4.740.000— para reparaciones básicas. Un techo reparado puede hacer la diferencia entre una familia que puede dormir seca en invierno y una que no.",

  cuidados = "En Chile hay 1.194.273 personas que realizan labores de cuidado: cuidan a personas mayores, a personas con discapacidad, a enfermos crónicos. El 80% son mujeres. Trabajan 41 horas semanales en esa labor —sin remuneración, sin previsión, sin reconocimiento legal. En 2026, el presupuesto del sistema de cuidados alcanza los $151.587 millones. Uno de sus instrumentos concretos es el estipendio para cuidadoras de personas con dependencia severa: aproximadamente $912.000 al año.",

  alimentos = "En Chile hay 238.724 deudores de pensiones alimenticias registrados —el 96% son hombres. Esos deudores tienen una deuda con sus hijos: $2.496.135 millones —$2,5 billones— ordenados pagar por los tribunales y no pagados. Hay 329.000 niños y niñas que no reciben la pensión que la ley les garantiza. En 2024, el gobierno destinó $11.000 millones para contratar más funcionarios en Tribunales de Familia. Cuesta aproximadamente $30.000.000 al año sostener a un funcionario especializado en esta materia.",

  acogida = "Cuando una mujer decide salir de una situación de violencia, necesita dos cosas de forma inmediata: un lugar seguro donde estar y una persona que la acompañe. Las Residencias Transitorias del SernamEG son ese primer lugar. En 2025, hay 35 Residencias Transitorias activas en todo el país, 8 en la Región Metropolitana. En 2024 se registraron más de 132.000 casos policiales por VIF y 50 femicidios. Habilitar y operar una Residencia Transitoria durante su primer año cuesta aproximadamente $300 millones.",

  justicia_vif = "En Chile, solo el 8,3% de las denuncias por delitos sexuales termina en condena. Las listas de espera para atención reparatoria en el sistema SernamEG superan los 12 meses. Los Centros de Atención Especializada en Violencias de Género —24 nuevos inaugurados en 2024— son parte de la respuesta: equipos de profesionales especializados que acompañan a las víctimas y facilitan el acceso a la justicia. Sostener a un profesional especializado en VIF cuesta aproximadamente $30.000.000 al año.",

  postnatal = "Chile otorga actualmente 5 días de postnatal masculino pagado. El promedio de la OCDE es de 8 semanas. Suecia implementó el permiso parental compartido en 1974. En los países donde esta política existe con carácter obligatorio, la tasa de adopción por parte de los padres supera el 70%. En Chile, hay un proyecto de ley en tramitación que propone ampliar el postnatal masculino a 30 días propios obligatorios. Aún no es ley. Financiar 30 días de postnatal para un padre en el sueldo mínimo cuesta $170.490."
)

# Párrafos de impacto por combinación caso × subárea
# Formato: impactos_texto[["subarea_id"]][["caso_id"]]
impactos_texto <- list(

  lrs = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen al tratamiento completo de 26.792 pacientes con enfermedades de alto costo durante un año —3,5 veces el total de personas que hoy cubre la Ley Ricarte Soto. Con ese dinero el Estado habría podido triplicar la cobertura actual de la ley y aún sobrarían recursos.",
    pacogate  = "Los $41.898 millones malversados en Carabineros equivalen al tratamiento anual de 5.586 pacientes con enfermedades de alto costo —casi el 75% del total de personas que hoy cubre la Ley Ricarte Soto. Con ese monto el Estado habría podido expandir significativamente la cobertura de la ley durante un año completo, incorporando patologías que hoy están en lista de espera de evaluación.",
    sqm       = "Los $13.500 millones que SQM pagó ilegalmente a políticos de todo el espectro equivalen al tratamiento anual de 1.800 pacientes con enfermedades de alto costo. Con el equivalente a lo que una empresa minera destinó a comprar voluntades políticas, el Estado habría podido garantizar durante un año que 1.800 familias no tuvieran que elegir entre pagar el arriendo y comprar el medicamento.",
    penta     = "Los $16.200 millones que el Grupo Penta evadió en impuestos equivalen al tratamiento anual de 2.160 pacientes con enfermedades de alto costo. Ese dinero solo fue recuperado porque hubo una investigación judicial que pudo no haber ocurrido. Los pacientes con enfermedades que no están en la Ley Ricarte Soto siguen esperando.",
    milicogate = "Los $10.657 millones desviados de los fondos secretos del Ejército equivalen al tratamiento anual de 1.421 pacientes con enfermedades de alto costo. Mientras generales en retiro gastaban esos fondos en casinos y propiedades, más de un millar de personas no podían acceder a tratamientos que el Estado debería haber garantizado."
  ),

  cosam = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían permitido construir 154 COSAM. En 2024 el gobierno construyó 9 con $11.736 millones, considerado un avance notable. Con el monto del Caso Inverlink se habrían podido construir 17 veces esa cantidad: una red capaz de transformar el acceso a la salud mental en Chile de forma estructural.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la construcción de 32 COSAM —más de tres veces lo que el gobierno logró construir con el presupuesto especial de 2024. Con cada uno de esos centros atiende a una población de entre 80.000 y 165.000 personas.",
    sqm       = "Los $13.500 millones que SQM no pagó en impuestos habrían financiado la construcción de 10 COSAM —prácticamente lo mismo que el gobierno de Boric pudo financiar en 2024 con todo el presupuesto especial de salud mental.",
    penta     = "Los $16.200 millones evadidos por el Grupo Penta habrían financiado la construcción de 12 COSAM. El dinero que Délano y Lavín nunca hubieran devuelto sin una investigación judicial habría alcanzado para construir esos 9 centros y tres más.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la construcción de 8 COSAM —casi el equivalente completo al presupuesto especial con que el gobierno de Gabriel Boric construyó 9 centros de salud mental en 2024."
  ),

  operaciones = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 251.175 cirugías en el sistema público —el 64% de toda la lista de espera quirúrgica de 2024. Cabe recalcar que durante 2024 murieron 36.262 personas esperando una atención de salud.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 52.372 cirugías —el equivalente al 13,4% de toda la lista de espera quirúrgica de 2024. El gobierno destinó $48.000 millones ese año para reducir esa misma lista. Lo que se robaron dentro de la institución policial era casi el monto completo de ese esfuerzo especial.",
    sqm       = "Los $13.500 millones que nunca tributaron equivalen a 16.875 cirugías en el sistema público. Son personas que hoy esperan 19 meses para entrar a un pabellón, con diagnóstico en mano y sin fecha.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 20.250 cirugías que no se realizaron.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen a 13.321 cirugías en el sistema público."
  ),

  dental = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 3.091.385 atenciones dentales integrales —equivalente al 21% de toda la población adulta chilena recibiendo atención completa en un año.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 644.585 atenciones dentales integrales —más de medio millón de personas que hoy no tienen acceso a atención dental en el sistema público.",
    sqm       = "Los $13.500 millones que SQM nunca tributó equivalen a 207.692 atenciones dentales integrales. Más de 200.000 personas habrían podido recibir atención odontológica completa con el dinero que una empresa minera destinó a comprar influencia política durante seis años.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 249.231 atenciones dentales integrales. Un cuarto de millón de personas que hoy no tienen acceso oportuno a un dentista en el sistema público habrían podido ser atendidas con el dinero que el Grupo Penta evadió en impuestos.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen a 163.954 atenciones dentales integrales. Casi 164.000 personas: ese es el costo de que un grupo de oficiales haya usado los fondos reservados de la nación para gastos personales durante cuatro años."
  ),

  uci = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían equipado 11.482 camas UCI —16,4 veces la capacidad total de camas intensivas del sistema público antes de la pandemia. El dinero robado a CORFO habría alcanzado para multiplicar por dieciséis la capacidad crítica del sistema público.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían equipado 2.394 camas UCI —3,4 veces la capacidad total del sistema público antes de la pandemia. Cuando los hospitales colapsaron y los médicos tenían que decidir quién entraba a la UCI y quién no, ese dinero ya estaba en cuentas paralelas de oficiales de Carabineros.",
    sqm       = "Los $13.500 millones no tributados por SQM habrían equipado 771 camas UCI —prácticamente el equivalente completo a la capacidad instalada del sistema público antes del COVID-19.",
    penta     = "Los $16.200 millones del Caso Penta habrían equipado 926 camas UCI —más de lo que el sistema público tenía disponible antes de la pandemia. Ese dinero existió, fue al fisco solo porque hubo una investigación judicial, y llegó demasiado tarde para equipar lo que faltaba.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían equipado 609 camas UCI en el sistema público. En cambio, ese dinero financió gastos en casinos, propiedades y vehículos de lujo para un grupo de oficiales."
  ),

  id = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO representan el 46% del presupuesto total de ANID en 2024 —la agencia que financia toda la investigación científica y tecnológica de Chile. Casi la mitad del presupuesto anual con que el Estado intenta sostener la ciencia del país fue sustraída de una sola institución en un solo fraude.",
    pacogate  = "Los $41.898 millones malversados en Carabineros equivalen al 9,6% del presupuesto anual de ANID. Con ese monto se habrían podido financiar aproximadamente 3.990 años de becas doctorales para investigadores chilenos.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen al 3,1% del presupuesto anual de ANID. El dinero que una empresa minera destinó a comprar influencia política habría podido financiar 1.286 becas doctorales de un año para los investigadores que Chile dice necesitar y que sistemáticamente no puede retener.",
    penta     = "Los $16.200 millones del Caso Penta equivalen al 3,7% del presupuesto anual de ANID. El mismo monto habría podido financiar 1.543 becas doctorales o un conjunto significativo de proyectos de investigación aplicada que hoy no existen.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen al 2,4% del presupuesto anual de ANID. Los fondos secretos que oficiales del Ejército destinaban a casinos y propiedades representan más del doble de lo que ANID destina en promedio a cada uno de los 45 centros de investigación que financia en todo el país."
  ),

  becas = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 174.730 becas universitarias anuales —suficiente para becar a todos los estudiantes de primera generación universitaria de Chile durante más de un año.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 36.433 becas universitarias anuales. Son más de 36.000 jóvenes que habrían podido estudiar un año más sin endeudarse.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 11.739 becas universitarias anuales. Más de once mil estudiantes habrían podido acceder o mantenerse en la educación superior con el dinero que una empresa minera destinó a boletas falsas.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 14.087 becas universitarias anuales. El Grupo Penta pagó multas, completó cursos de ética y cumplió condenas en libertad. Los 14.000 estudiantes que habrían podido beneficiarse con esos recursos no tienen curso que recuperar ni condena que cumplir.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 9.267 becas universitarias anuales. Más de 9.000 jóvenes que hoy estudian con deuda o que abandonaron la universidad por razones económicas habrían podido tener una trayectoria diferente."
  ),

  junji = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 167 jardines infantiles JUNJI de capacidad estándar —suficiente para que más de 15.000 niños de los sectores más vulnerables tuvieran acceso a educación parvularia de calidad. En 2024, el gobierno de Boric destinó $120.118 millones a infraestructura parvularia en todo su mandato. Con el monto del Caso Inverlink se habría podido superar ese esfuerzo completo.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 35 jardines infantiles JUNJI —con capacidad para unos 3.000 niños de los sectores más vulnerables.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 11 jardines infantiles JUNJI —capacidad para más de 900 niños en sus primeros años de vida. Once comunidades que hoy no tienen jardín habrían podido tenerlo.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 13 jardines infantiles JUNJI. La brecha de acceso a educación parvularia se instala en los primeros años de vida y define trayectorias educativas enteras.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 9 jardines infantiles JUNJI. En las zonas rurales donde más se necesitan estos jardines, el costo puede superar los $2.000 millones por establecimiento. Aun así, ese dinero habría alcanzado para llevar educación parvularia a comunidades que hoy no la tienen."
  ),

  liceos_tp = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían equipado 2.512 liceos técnico-profesionales —casi tres veces el total de liceos TP del país (~900 establecimientos). Los 300 establecimientos con déficit crítico de equipamiento habrían sido cubiertos seis veces y media.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían equipado 524 liceos técnico-profesionales —más de la mitad de todos los liceos TP del país. Con ese monto se habría podido resolver casi completamente el déficit de equipamiento en los 300 establecimientos con déficit crítico.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían equipado 169 liceos técnico-profesionales —más de la mitad de los establecimientos con déficit crítico de equipamiento. Son jóvenes que estudian automatización industrial, enfermería o gastronomía en liceos donde no hay equipos para practicar lo que se enseña.",
    penta     = "Los $16.200 millones del Caso Penta habrían equipado 202 liceos técnico-profesionales —dos tercios de todos los establecimientos con déficit crítico identificado por el propio Ministerio de Educación.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían equipado 133 liceos técnico-profesionales —casi la mitad de los establecimientos con déficit crítico de equipamiento."
  ),

  rural = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la conservación completa de 475 escuelas rurales —casi cuatro veces lo que el Estado pudo atender con el Fondo de Conservación de 2024. La diferencia entre una escuela rural con conservación y una sin ella no es estética: es la diferencia entre poder aprender y no poder hacerlo.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la conservación completa de 99 escuelas rurales —casi el equivalente completo al esfuerzo del Estado en 2024, que alcanzó para 125 establecimientos con $52.868 millones.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado la conservación de 32 escuelas rurales. Son 32 comunidades donde los niños estudiarían en mejores condiciones, donde los techos no gotean y donde la calefacción funciona en invierno.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la conservación de 38 escuelas rurales. Cada una de esas escuelas representa una comunidad entera, cuya única opción educativa es ese establecimiento.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la conservación de 25 escuelas rurales. Es el caso con el monto más pequeño de este proyecto, pero el argumento no cambia: cada una de esas 25 escuelas existe, tiene nombre, tiene niños, y tiene necesidades de mantención que el Estado no ha podido financiar."
  ),

  pgu_informal = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la Pensión Garantizada Universal para 72.260 trabajadores informales durante un año entero —personas que llegarán a la vejez sin ningún ahorro previsional propio. La PGU actual cubre a 2,4 millones de personas. El dinero robado a CORFO habría podido ampliar esa cobertura en un 3% durante un año, o garantizar pensiones para todos los trabajadores informales de una región completa.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la PGU para 15.067 trabajadores informales durante un año. Son personas que hoy trabajan sin red de protección y que en la vejez dependerán completamente del Estado.",
    sqm       = "Los $13.500 millones que SQM nunca tributó habrían financiado la PGU para 4.855 trabajadores informales durante un año. El dinero que una empresa minera destinó a comprar influencia política habría podido garantizar ese piso a casi 5.000 personas.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la PGU para 5.826 trabajadores informales durante un año. Délano y Lavín cumplieron su condena. Los 5.826 trabajadores que habrían podido recibir una pensión con ese dinero solo tienen una vejez que financiar con recursos que no alcanzarán.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la PGU para 3.832 trabajadores informales durante un año."
  ),

  bac = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el Beneficio por Años Cotizados en su tope máximo para 167.450 mujeres pensionadas durante un año —$100.000 mensuales adicionales para cada una. Son mujeres que cotizaron toda su vida laboral mientras también cargaban con el trabajo de cuidados no remunerado que el sistema nunca reconoció.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el BAC al tope para 34.915 mujeres pensionadas durante un año. Son más de 34.000 mujeres que cotizaron durante décadas, cuidaron familias sin remuneración, y llegan a la vejez con pensiones menores que sus pares hombres.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el BAC al tope para 11.250 mujeres pensionadas durante un año. La brecha de género en pensiones es la diferencia entre una mujer mayor que puede pagar sus gastos básicos y una que no puede.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el BAC al tope para 13.500 mujeres pensionadas durante un año. La reforma de 2025 es un avance. Pero el dinero que Délano y Lavín evadieron habría podido adelantar o ampliar ese beneficio para 13.500 mujeres que lo necesitaban antes.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el BAC al tope para 8.881 mujeres pensionadas durante un año. Casi 9.000 mujeres que cotizaron toda su vida y llegan a la vejez con pensiones menores por los años que dedicaron a cuidar a otros."
  ),

  deuda_prev = list(
    inverlink = "Los $200.940 millones del Caso Inverlink representan el 1,3% de la deuda previsional total que empleadores le deben a sus trabajadores en Chile —$16 billones acumulados en cotizaciones descontadas del sueldo pero nunca transferidas. Son formas distintas del mismo fenómeno: dinero que pertenecía a otros y fue apropiado por quienes tenían el poder de hacerlo.",
    pacogate  = "Los $41.898 millones del Pacogate representan el 0,26% de la deuda previsional total que los empleadores le deben a 2,4 millones de trabajadores chilenos. Corrupción institucional y deuda previsional: dos formas de apropiarse de lo que le pertenece a otros.",
    sqm       = "Los $13.500 millones del Caso SQM equivalen a las cotizaciones impagadas de aproximadamente 15.000 trabajadores durante un año a sueldo mínimo. La deuda previsional no es una abstracción financiera: es la pensión futura de millones de personas que ya pagaron y cuyo empleador simplemente se quedó con el dinero.",
    penta     = "Los $16.200 millones del Caso Penta son equivalentes a las cotizaciones anuales de aproximadamente 18.000 trabajadores a sueldo mínimo. El Grupo Penta evadió impuestos sistemáticamente durante años antes de ser descubierto. Los empleadores con deuda previsional hacen lo mismo, a escala masiva, con las cotizaciones de sus trabajadores.",
    milicogate = "Los $10.657 millones del Milicogate equivalen a las cotizaciones anuales de aproximadamente 11.840 trabajadores a sueldo mínimo. El Milicogate es el caso más pequeño de este proyecto. La deuda previsional de empleadores es $16 billones. Las dos situaciones comparten el mismo principio."
  ),

  pgu_adultos = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la PGU completa para 72.260 adultos mayores durante un año —personas que llegaron a la vejez sin pensión propia y que hoy dependen de ese apoyo para cubrir sus necesidades básicas.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la PGU para 15.067 adultos mayores durante un año. El Estado tiene el deber de garantizarles ese piso mínimo. El dinero que se desvió dentro de la institución policial habría podido cumplir ese deber con 15.000 de ellas.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado la PGU para 4.855 adultos mayores durante un año. El tribunal que absolvió a los principales acusados en octubre de 2025 argumentó vicios del proceso. Los 4.855 adultos mayores no tienen vicios procesales que invocar.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la PGU para 5.826 adultos mayores durante un año. Casi 6.000 personas que llegaron a la vejez sin ahorros propios habrían podido recibir los $231.732 mensuales que el Estado les debe.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la PGU para 3.832 adultos mayores durante un año. Casi 4.000 personas mayores que viven con $231.732 al mes: eso es lo que el dinero gastado en casinos y propiedades de lujo habría podido financiar."
  ),

  jovenes_cot = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían garantizado un año de cotizaciones previsionales a 334.900 jóvenes en empleos precarios o informales. Cada año de cotización perdido a los 25 equivale a perder tres años de pensión en la vejez.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían garantizado un año de cotizaciones a 69.830 jóvenes en situación de precariedad laboral. Son jóvenes que hoy trabajan sin contrato, sin cotizaciones, construyendo un futuro previsional que se hace cada vez más difícil de alcanzar.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían garantizado un año de cotizaciones a 22.500 jóvenes en empleos informales. El dinero que una empresa minera destinó a financiar ilegalmente la política habría podido protegerlos durante un año.",
    penta     = "Los $16.200 millones del Caso Penta habrían garantizado un año de cotizaciones a 27.000 jóvenes en situación de informalidad laboral.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían garantizado un año de cotizaciones a 17.762 jóvenes en empleos precarios. Casi 18.000 jóvenes que hoy trabajan sin cotizar, acumulando lagunas que se traducirán en pensiones bajas décadas después."
  ),

  carabineros = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen al costo de sostener 6.053 carabineros en terreno durante un año —el 13% de la dotación actual. Es casi cinco veces la cantidad de nuevos carabineros que el gobierno logró incorporar en 2025 con un gran esfuerzo presupuestario.",
    pacogate  = "Los $41.898 millones malversados dentro de Carabineros equivalen al costo de sostener 1.262 carabineros en terreno durante un año. La institución creada para dar seguridad desvió el dinero que habría podido pagar el sueldo de más de 1.200 de sus propios funcionarios.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen al costo de sostener 407 carabineros en terreno durante un año. En comunas donde la dotación efectiva ha caído en un 27% en los últimos años, ese número no es abstracto.",
    penta     = "Los $16.200 millones del Caso Penta equivalen al costo de sostener 488 carabineros en terreno durante un año. Casi 500 funcionarios que habrían podido estar en terreno, cumpliendo la función para la que el Estado los forma y remunera.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen al costo de sostener 321 carabineros en terreno durante un año. Es el equivalente a la dotación completa de Carabineros en varias comunas medianas del país."
  ),

  pdi = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.698 investigadores especializados en ciberdelito y delitos económicos durante un año. Son las unidades que investigan exactamente el tipo de delito que protagonizó el Caso Inverlink: fraude financiero sofisticado, apropiación de recursos públicos, redes de complicidades institucionales.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.397 investigadores especializados en delitos económicos durante un año. El Pacogate fue descubierto en parte gracias a una alerta del BancoEstado que el propio mando de Carabineros ignoró durante dos años.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 450 investigadores especializados en delitos económicos durante un año. El Caso SQM involucró a más de 180 personas, 1.425 boletas falsas y seis años de financiamiento político ilegal.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 540 investigadores especializados en delitos económicos durante un año. Fue el fiscal Carlos Gajardo quien, investigando el Penta, detectó irregularidades que lo llevaron a abrir la investigación del SQM.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 355 investigadores especializados en delitos económicos durante un año. El Milicogate fue destapado por periodistas de The Clinic, no por el Estado."
  ),

  carceles = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 3.091 plazas penitenciarias nuevas —el 15,5% del déficit actual de 19.886 plazas. Tres mil plazas nuevas habrían permitido comenzar a clasificar internos por perfil criminológico, separar a los detenidos por primera vez de los reincidentes organizados, y crear las condiciones mínimas para que la reinserción sea posible.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 644 plazas penitenciarias nuevas —el 3,2% del déficit actual. Con el monto del Pacogate se habrían podido construir más de la mitad de un establecimiento del tamaño del Complejo La Laguna en Talca.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 208 plazas penitenciarias nuevas. El crimen organizado crece dentro de las cárceles en parte porque el Estado no tiene la infraestructura para clasificar a los internos y aislar a los líderes de las bandas.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 249 plazas penitenciarias nuevas. El hacinamiento al 147% significa que las cárceles públicas tienen casi 50% más personas de las que pueden albergar en condiciones dignas.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 164 plazas penitenciarias nuevas. Cada plaza penitenciaria nueva es la diferencia entre un sistema que puede clasificar, separar y rehabilitar, y uno que simplemente contiene la criminalidad."
  ),

  reinsercion = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado programas de reinserción para 38.274 personas durante un año —más del doble de todas las personas que hoy acceden a programas de acompañamiento en Gendarmería. La reinserción no es un gasto: es la política de seguridad con mayor retorno comprobado.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado programas de reinserción para 7.981 personas durante un año. Cada persona que accede a un programa de reinserción tiene la mitad de probabilidad de volver a delinquir.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado programas de reinserción para 2.571 personas durante un año. Es el único tipo de política de seguridad que funciona de verdad a largo plazo.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado programas de reinserción para 3.086 personas durante un año. Délano y Lavín cumplieron su condena en un programa psicosocial en la Universidad Adolfo Ibáñez. Las 3.086 personas que habrían podido acceder a reinserción con ese dinero no tienen universidad privada que los acompañe.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado programas de reinserción para 2.030 personas durante un año. Más de 2.000 personas que salen de la cárcel sin red de apoyo habrían podido tener un programa de acompañamiento."
  ),

  ecoh = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen a 16,5 veces el presupuesto anual del ECOH. El dinero robado en un solo caso de corrupción habría podido financiar 16 años completos del equipo de fiscales más especializado de Chile.",
    pacogate  = "Los $41.898 millones malversados en Carabineros equivalen a 3,4 veces el presupuesto anual del ECOH. El dinero que se desvió dentro de Carabineros habría podido financiar más de tres años completos del equipo especializado en perseguir exactamente ese tipo de delito.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen a 1,1 veces el presupuesto anual del ECOH. El dinero que una empresa minera destinó ilegalmente a financiar la política chilena durante seis años alcanzaría para financiar un año completo del equipo que hoy persigue el crimen organizado.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 1,3 veces el presupuesto anual del ECOH. Fue el fiscal Carlos Gajardo —un fiscal solo, investigando el Penta— quien destapó también el Caso SQM. Con el dinero evadido se habría podido financiar más de un año completo del equipo de 314 profesionales que hoy hace ese mismo trabajo.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen al 87% del presupuesto anual del ECOH —casi un año completo de financiamiento del equipo de fiscales especializados en crimen organizado. El Milicogate fue destapado por periodistas. El Estado no tenía, en ese momento, la capacidad institucional para detectar ese tipo de fraude dentro de sus propias fuerzas armadas."
  ),

  ds49 = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.359 viviendas sociales DS49 —entregadas sin deuda a familias del 40% más vulnerable. Es más de un tercio de todos los subsidios DS49 que el gobierno tiene presupuestados para entregar durante todo el año 2026.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.326 viviendas sociales DS49. El monto del Pacogate habría podido aumentar el plan anual del gobierno en un 7% en un solo año.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 427 viviendas sociales DS49. Son 427 familias que hoy siguen en lista de espera, allegadas o en campamentos.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 513 viviendas sociales DS49. Más de 500 familias que hoy esperan en la lista de SERVIU habrían podido recibir su subsidio y comenzar a construir su vivienda.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 337 viviendas sociales DS49. Trescientas treinta y siete familias con subsidio completo, sin deuda, con la posibilidad real de tener una vivienda propia."
  ),

  lista_espera = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 4 meses adicionales del programa DS49 al ritmo actual de entrega. El número puede parecer pequeño frente a un déficit de 492.000 viviendas. Eso no es una debilidad del argumento: es la revelación honesta de la escala del problema habitacional de Chile.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 25 días adicionales del programa DS49. Tres semanas y media más de subsidios habitacionales entregados a las familias más vulnerables del país.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen a 8 días adicionales del programa DS49. Ocho días en que el Estado habría podido seguir entregando subsidios habitacionales.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 9 días adicionales del programa DS49. La corrupción no solo roba dinero, roba tiempo.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen a 6 días adicionales del programa DS49. Frente a un déficit habitacional que tomaría 25 años en resolverse, seis días pueden parecer insignificantes. No lo son para las familias que ese tiempo habrían podido dejar de esperar."
  ),

  ds52 = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el subsidio de arriendo completo para 29.938 familias durante 8 años —casi $193.000 mensuales de aporte durante ocho años para que puedan pagar el arriendo mientras esperan una solución habitacional definitiva.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el subsidio de arriendo completo para 6.242 familias durante 8 años. Más de 6.000 familias que hoy arriendan gastando más del 30% de su ingreso habrían podido tener ese apoyo.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el subsidio de arriendo completo para 2.012 familias durante 8 años.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el subsidio de arriendo completo para 2.414 familias durante 8 años —el tiempo que muchas familias esperan en la lista de vivienda social.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el subsidio de arriendo completo para 1.588 familias durante 8 años. Casi 1.600 familias con estabilidad habitacional durante ocho años."
  ),

  campamentos = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la solución habitacional definitiva para 4.294 familias en campamentos —el 3,6% del total de familias que hoy viven en asentamientos informales. Para esas 4.294 familias habría sido la diferencia entre vivir en un campamento y tener una vivienda propia.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la solución habitacional para 895 familias en campamentos. Casi 900 familias con acceso precario a agua, sin calefacción, con riesgo de desalojo, habrían podido recibir una vivienda definitiva.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado la solución habitacional para 288 familias en campamentos. El dinero que SQM destinó a comprar influencia política durante seis años habría podido ser la respuesta que 288 familias esperan desde hace años.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la solución habitacional para 346 familias en campamentos. Solo en 2024 se identificaron 341 nuevos campamentos en todo el país.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la solución habitacional para 228 familias en campamentos. Doscientas veintiocho familias que construyeron sus casas con sus propias manos porque el Estado no llegó."
  ),

  mejoramiento = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el mejoramiento básico de 42.392 viviendas deterioradas —el 3,5% del déficit cualitativo total. Son decenas de miles de familias durmiendo más abrigadas, con techos que no gotean, en condiciones un poco más dignas.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el mejoramiento básico de 8.840 viviendas deterioradas. Casi 9.000 familias con un techo reparado, un piso mejorado, condiciones básicas de habitabilidad.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el mejoramiento básico de 2.848 viviendas deterioradas. Casi 3.000 familias con mejoras concretas en sus condiciones de habitabilidad.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el mejoramiento básico de 3.418 viviendas deterioradas. Más de 3.000 familias con un techo que no se llueve, con pisos mejorados, con condiciones mínimas de dignidad habitacional.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el mejoramiento básico de 2.249 viviendas deterioradas. Más de 2.000 familias con mejoras básicas en sus condiciones de habitabilidad."
  ),

  cuidados = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen al 132% del presupuesto anual 2026 del sistema de cuidados. El dinero robado a CORFO supera el presupuesto total con que Chile financia toda su política nacional de cuidados en un año. Medido en estipendios individuales, habría alcanzado para 220.330 cuidadoras.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el estipendio de cuidados para 45.942 cuidadoras durante un año. Son mujeres que cuidan a sus madres con Alzheimer, a sus hijos con discapacidad severa, a sus parejas con enfermedades crónicas —sin remuneración, sin previsión, sin reconocimiento.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el estipendio de cuidados para 14.802 cuidadoras durante un año. Casi 15.000 mujeres que hoy cuidan a familiares con dependencia severa, sin remuneración y sin apoyo del Estado.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el estipendio de cuidados para 17.763 cuidadoras durante un año. Casi 18.000 mujeres que realizan trabajo de cuidados no remunerado habrían podido recibir un reconocimiento económico mínimo.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el estipendio de cuidados para 11.685 cuidadoras durante un año. Más de 11.000 mujeres que cuidan sin descanso y sin remuneración."
  ),

  alimentos = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.698 funcionarios adicionales en Tribunales de Familia durante un año —funcionarios cuyo único trabajo sería perseguir activamente la deuda de $2,5 billones que 238.724 deudores le deben a 329.000 niños. En 2024, el gobierno contrató más funcionarios con $11.000 millones. El monto de Inverlink habría multiplicado ese esfuerzo por 18.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.397 funcionarios adicionales en Tribunales de Familia durante un año. Son personas cuyo trabajo sería hacer que 329.000 niños reciban la pensión que un tribunal ya ordenó pagar.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 450 funcionarios adicionales en Tribunales de Familia durante un año. El problema no es la ley —la ley que crea el Registro de Deudores Alimentarios existe desde 2022. El problema es la capacidad del Estado para ejecutarla.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 540 funcionarios adicionales en Tribunales de Familia durante un año. El Estado persiguió a Délano y Lavín con años de investigación y recursos fiscales. Perseguir a los deudores alimentarios requiere el mismo tipo de voluntad y recursos.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 355 funcionarios adicionales en Tribunales de Familia durante un año. Trescientos cincuenta y cinco funcionarios más trabajando para que 329.000 niños reciban lo que un tribunal ya dijo que les corresponde."
  ),

  acogida = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían permitido habilitar 670 Residencias Transitorias —19 veces las 35 que existen hoy en todo el país. El número revela la magnitud de lo que el Estado podría haber construido: una red de acogida capaz de responder a la violencia contra las mujeres en todos los territorios del país.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían permitido habilitar 140 Residencias Transitorias —cuatro veces las que existen hoy en el país. Carabineros es una de las instituciones que deriva a las mujeres a esas residencias cuando responde a llamados por violencia intrafamiliar.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían permitido habilitar 45 Residencias Transitorias —más que las 35 que existen hoy en todo Chile. Con el dinero que una empresa minera destinó a financiar ilegalmente la política durante seis años, el Estado habría podido aumentar en un 29% su capacidad de acogida.",
    penta     = "Los $16.200 millones del Caso Penta habrían permitido habilitar 54 Residencias Transitorias —un 54% más que las 35 actuales. Para una mujer que decide salir de una situación de violencia, la existencia de una residencia disponible en su región puede ser la diferencia entre salir y quedarse.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían permitido habilitar 36 Residencias Transitorias —prácticamente duplicar las que existen hoy en el país."
  ),

  justicia_vif = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.698 profesionales especializados en VIF durante un año —el tipo de profesional que acompaña a una mujer desde la denuncia hasta la sentencia. Con solo el 8,3% de las denuncias por delitos sexuales terminando en condena, la capacidad de acompañamiento especializado es exactamente lo que falta.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.397 profesionales especializados en VIF durante un año. Más de 1.300 profesionales que habrían podido acompañar a víctimas de violencia intrafamiliar a través de un proceso judicial que hoy muchas abandonan por falta de apoyo.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 450 profesionales especializados en VIF durante un año. Con el dinero que SQM destinó a financiar ilegalmente la política, el Estado habría podido dar ese apoyo a cientos de víctimas más.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 540 profesionales especializados en VIF durante un año. Solo el 8,3% de las denuncias por delitos sexuales termina en condena. Eso no significa que el 91,7% sea falso: significa que el sistema no tiene la capacidad de acompañar a las víctimas.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 355 profesionales especializados en VIF durante un año. Más de 350 personas cuyo trabajo sería acompañar a víctimas de violencia intrafamiliar a través de un proceso judicial al que muchas renuncian por falta de apoyo."
  ),

  postnatal = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el postnatal masculino ampliado de 1.178.700 padres —30 días completos de subsidio. Son más de un millón de padres que habrían podido tomar un mes de postnatal, cuidar a sus hijos recién nacidos, y permitir que sus parejas tomaran las decisiones laborales que quisieran tomar.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el postnatal masculino ampliado de 245.750 padres. La redistribución de la carga de cuidados no es solo un beneficio para los padres: es la política que más directamente reduce la penalización laboral que sufren las mujeres por ser madres.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el postnatal masculino ampliado de 79.180 padres. En los países donde esta política existe con carácter obligatorio, la tasa de adopción por parte de los padres supera el 70%.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el postnatal masculino ampliado de 95.050 padres. Casi 100.000 padres con un mes de postnatal propio: una política hipotética, pero con evidencia internacional contundente.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el postnatal masculino ampliado de 62.510 padres. Este es el único escenario hipotético de este proyecto: una política que no existe aún, calculada con el dinero que tampoco existió porque fue desviado."
  )
)

# ==============================================================================
# 3. CONFIGURACIÓN ESTÉTICA
# ==============================================================================

mi_tema <- bs_theme(
  version = 5,
  bg = "#FDFCF0",
  fg = "#4B3621",
  primary = "#8B4513",
  base_font = font_google("Spectral"),
  heading_font = font_google("Playfair Display")
)

colores_area <- c(
  "Salud"      = "#C17A5A",
  "Educación"  = "#6B8E6B",
  "Pensiones"  = "#5A7A8E",
  "Seguridad"  = "#8E6B5A",
  "Vivienda"   = "#8E8A5A",
  "Género"     = "#8E5A7A"
)

# ==============================================================================
# 4. UI
# ==============================================================================

ui <- page_fluid(
  theme = mi_tema,
  lang = "es",

  tags$head(
    tags$style(HTML("
      body { background-color: #FDFCF0; color: #4B3621; }
      .container-main { max-width: 960px; margin: 0 auto; padding: 60px 20px; }

      .resena-box {
        background-color: #F5F4E6;
        border-left: 4px solid #8B4513;
        padding: 20px 25px;
        margin: 20px 0;
      }
      .resena-monto {
        font-family: 'Playfair Display', serif;
        font-size: 1.5rem;
        color: #8B4513;
        margin-bottom: 10px;
      }

      .area-contexto {
        background-color: #F0EFE3;
        border-radius: 4px;
        padding: 20px 25px;
        margin-bottom: 30px;
        font-style: italic;
        color: #5a4a35;
      }

      .subarea-bloque {
        margin-bottom: 50px;
        padding-bottom: 40px;
        border-bottom: 1px solid #E5E4D0;
      }
      .subarea-bloque:last-child { border-bottom: none; }

      .subarea-titulo {
        font-family: 'Playfair Display', serif;
        font-size: 1.3rem;
        color: #4B3621;
        margin-bottom: 12px;
      }
      .subarea-contexto {
        color: #6a5a45;
        margin-bottom: 18px;
        line-height: 1.7;
      }
      .subarea-impacto {
        background-color: #F5F4E6;
        border-left: 3px solid #8B4513;
        padding: 15px 20px;
        margin-top: 18px;
        line-height: 1.75;
      }
      .disclaimer-badge {
        display: inline-block;
        font-size: 0.72rem;
        background-color: #E8E4D0;
        color: #8B6050;
        border-radius: 3px;
        padding: 2px 8px;
        margin-bottom: 10px;
        letter-spacing: 0.03em;
      }

      .section-title {
        font-family: 'Playfair Display', serif;
        margin-top: 60px;
        margin-bottom: 30px;
        border-bottom: 1px solid #E5E4D0;
        padding-bottom: 10px;
      }
      .accordion-button {
        background-color: #FDFCF0 !important;
        font-family: 'Playfair Display', serif;
        font-size: 1.1rem;
        color: #4B3621 !important;
      }
      hr { border-top: 1px solid #E5E4D0; opacity: 0.6; }

      .metodo-tabla { font-size: 0.88em; }
      .metodo-tabla th { color: #8B4513; font-weight: 600; }
    "))
  ),

  div(class = "container-main",

    # --- ENCABEZADO ---
    div(class = "text-center mb-5",
      h1("Costo Social de la Corrupción en Chile",
         style = "font-family:'Playfair Display'; font-size:2.6rem; color:#4B3621;"),
      p("¿Qué habría podido hacer Chile con el dinero que se robaron?",
        class = "lead", style = "color:#8B4513;")
    ),

    # --- PRESENTACIÓN ---
    div(id = "presentacion",
      p("Entre 2003 y 2017, cinco casos de corrupción le costaron al Estado chileno más de",
        tags$strong("$283.000 millones de pesos a valores de diciembre de 2025."),
        "No es un número abstracto. Es el equivalente a miles de tratamientos médicos que no se entregaron, a jardines infantiles que no se construyeron, a pensiones que no alcanzaron, a viviendas sociales que no llegaron, a profesionales especializados que el Estado no pudo contratar."),
      p("Esta aplicación traduce esos montos en beneficios sociales concretos no entregados.
        No afirma que el dinero recuperado se habría destinado necesariamente a estos fines:
        la política pública es más compleja que una transferencia directa.
        Lo que sí afirma es que la corrupción tiene un costo real, medible, y que ese costo
        lo pagan las personas más vulnerables del país.")
    ),

    br(),

    # --- METODOLOGÍA (acordeón) ---
    accordion(
      open = FALSE,
      accordion_panel(
        title = "Metodología y criterios del proyecto",
        icon = bs_icon("gear-wide-connected"),

        h5("¿Cómo se calcularon estos números?", style = "font-family:'Playfair Display'; color:#8B4513;"),
        p("Esta aplicación traduce los montos defraudados en cada caso de corrupción a beneficios sociales concretos que no se entregaron. Los cálculos se basan en tres decisiones metodológicas principales: la selección de los casos, el ajuste por inflación, y la selección de los costos unitarios de cada subárea."),

        h6("Selección de casos", style = "color:#8B4513; margin-top:16px;"),
        p("Se seleccionaron los cinco casos de corrupción con mayor impacto económico documentado en la historia reciente de Chile. Se priorizaron casos con montos verificables en fuentes judiciales, periodísticas e investigativas, y que representaran distintos tipos de corrupción: sustracción directa de fondos públicos (Corfo-Inverlink, Pacogate, Milicogate), evasión tributaria (Caso Penta), y financiamiento político ilegal mediante evasión de impuestos (Caso SQM). En los casos con montos disputados, se documenta el mínimo judicial, el máximo periodístico y el valor utilizado como base."),

        h6("Ajuste por inflación (IPC)", style = "color:#8B4513; margin-top:16px;"),
        p("Todos los montos están expresados en pesos de diciembre de 2025. El ajuste se realizó utilizando la calculadora oficial del IPC del INE (calculadoraipc.ine.cl). El factor multiplicador se obtuvo ingresando $1.000 pesos desde el año de referencia de cada caso hasta diciembre de 2025. El INE utiliza empalme entre distintas bases históricas, por lo que este factor tiene precedencia metodológica sobre cualquier cálculo alternativo."),

        div(class = "metodo-tabla",
          tags$table(class = "table table-sm",
            tags$thead(tags$tr(
              tags$th("Caso"), tags$th("Año ref."), tags$th("Factor IPC"),
              tags$th("Monto base"), tags$th("Monto ajustado dic. 2025")
            )),
            tags$tbody(
              tags$tr(tags$td("Corfo-Inverlink"), tags$td("2003"), tags$td("×2,364"),
                      tags$td("$85.000 MM"), tags$td("~$200.940 MM")),
              tags$tr(tags$td("Pacogate"), tags$td("2017"), tags$td("×1,478"),
                      tags$td("$28.348 MM"), tags$td("~$41.898 MM")),
              tags$tr(tags$td("Caso SQM"), tags$td("2011"), tags$td("×1,773"),
                      tags$td("~$7.615 MM"), tags$td("~$13.500 MM")),
              tags$tr(tags$td("Caso Penta"), tags$td("2014"), tags$td("×1,620"),
                      tags$td("$10.000 MM"), tags$td("~$16.200 MM")),
              tags$tr(tags$td("Milicogate"), tags$td("2012"), tags$td("×1,747"),
                      tags$td("$6.100 MM"), tags$td("~$10.657 MM"))
            )
          )
        ),

        h6("Costos unitarios y niveles de advertencia", style = "color:#8B4513; margin-top:16px;"),
        p("Cada subárea utiliza un costo de referencia construido a partir de fuentes oficiales chilenas (MINVU, MINSAL, FONASA, JUNJI, ANID, Gendarmería, Fiscalía, SernamEG, Superintendencia de Pensiones, entre otras). Los cálculos se etiquetan con uno de tres niveles:"),
        tags$ul(
          tags$li(tags$strong("Dato estimado:"), " el costo unitario está documentado en fuente oficial. Es el nivel de mayor confianza dentro de los escenarios hipotéticos."),
          tags$li(tags$strong("Escenario proyectado:"), " el cálculo se basa en estimaciones demográficas, comparaciones internacionales o proporciones presupuestarias indirectas."),
          tags$li(tags$strong("Política hipotética:"), " la subárea se basa en una política que aún no existe en Chile. Los cálculos son válidos como ejercicio de imaginación política.")
        ),
        p(tags$em("Esta aplicación tiene carácter exploratorio, educativo y ciudadano. Los escenarios que presenta son hipotéticos: no afirman que el dinero recuperado se habría destinado necesariamente a los fines que se describen, sino que ilustran la magnitud de lo que se perdió en términos de posibilidades concretas."))
      )
    ),

    # --- SECCIÓN PRINCIPAL ---
    h2("¿Cuánto cuesta la corrupción?", class = "section-title"),

    p("Selecciona un caso de corrupción y un área social para ver qué no se pudo construir, entregar o financiar con ese dinero."),

    div(class = "mb-4",
      fluidRow(
        column(6,
          selectInput("caso_sel", "Caso de corrupción:",
                      choices = setNames(tabla_casos$id, tabla_casos$nombre),
                      width = "100%")
        ),
        column(6,
          selectInput("area_sel", "Área social:",
                      choices = unique(tabla_subareas$area),
                      width = "100%")
        )
      )
    ),

    # Reseña dinámica del caso
    uiOutput("resena_dinamica"),

    br(),

    # Contexto del área (estático según área seleccionada)
    uiOutput("contexto_area"),

    # Subáreas dinámicas
    uiOutput("subareas_dinamicas"),

    # --- CONCLUSIÓN ---
    h2("La democracia tiene un costo", class = "section-title"),
    div(id = "conclusion",
      p("Los cinco casos que analiza este proyecto no son excepciones: son el registro documentado de lo que ocurre cuando las instituciones fallan, cuando el dinero público no llega a donde debe llegar y cuando la impunidad es la norma más que la excepción."),
      p("No son solo números. Son tratamientos médicos que no se entregaron, jardines infantiles que no se construyeron, pensiones que no alcanzaron, mujeres que no tuvieron dónde ir, jóvenes que no pudieron estudiar. La corrupción no es un crimen sin víctimas: sus víctimas son las personas más vulnerables, las que más necesitan al Estado y las que menos pueden reemplazarlo con recursos propios."),
      p("Este proyecto es una defensa de la democracia. No porque la democracia sea perfecta —estos casos ocurrieron en democracia, y en varios de ellos la impunidad fue también un producto del sistema democrático. Sino porque la democracia es el único sistema que permite nombrar lo que pasó, investigarlo, documentarlo y exigir que no vuelva a ocurrir. Eso es exactamente lo que hace esta aplicación.")
    ),

    # --- FUENTES ---
    h2("Fuentes", class = "section-title"),
    div(id = "fuentes", style = "font-size: 0.85em; color: #6c757d; line-height: 1.8;",
      tags$p(tags$strong("Casos de corrupción:"), " CIPER Chile, La Tercera, El Mostrador, The Clinic, Cooperativa, BioBioChile, Interferencia, Wikipedia (con fuentes primarias), Poder Judicial de Chile, Contraloría General de la República."),
      tags$p(tags$strong("Salud:"), " MINSAL (Ley Ricarte Soto, lista de espera), FONASA, CENABAST, BCN (Plan Nacional Salud Mental), Hacienda (presupuesto COSAM 2024), DIPRES."),
      tags$p(tags$strong("Educación:"), " ANID (presupuesto 2024, bases concursales), Minciencia (Encuesta I+D 2022), JUNJI, MINEDUC (Programa Equipamiento TP, Fondo Conservación Infraestructura)."),
      tags$p(tags$strong("Pensiones:"), " ChileAtiende (PGU, BAC, CEV), Superintendencia de Pensiones, AAFP (informalidad), Reforma Previsional Ley 21.735 (2025)."),
      tags$p(tags$strong("Seguridad:"), " Carabineros de Chile, PDI (Jenaciber), Gendarmería, Fiscalía de Chile (ECOH), MOP (concesión La Laguna), Ministerio de Interior."),
      tags$p(tags$strong("Vivienda:"), " MINVU (DS49, DS52, Habitabilidad Rural), SERVIU Metropolitano, INE (Censo 2024), TECHO Chile (Catastro 2024-2025), Centro de Estudios MINVU."),
      tags$p(tags$strong("Género:"), " MinMujeryEG, SernamEG, ChileAtiende (Residencias Transitorias), SUSESO (subsidio postnatal), Ministerio de Justicia (Ley 21.484), CIEDESS."),
      tags$p(tags$strong("IPC:"), " Calculadora oficial INE — calculadoraipc.ine.cl. Año base universal: diciembre 2025.")
    ),

    div(class = "text-center mt-5 py-5",
      hr(),
      p("Auditoría Ciudadana · Chile 2026", style = "font-size: 0.8em; color: #8B4513;")
    )
  )
)

# ==============================================================================
# 5. SERVER
# ==============================================================================

server <- function(input, output, session) {

  # Datos reactivos del caso seleccionado
  caso_actual <- reactive({
    tabla_casos %>% filter(id == input$caso_sel)
  })

  monto_actual <- reactive({
    caso_actual()$monto_mm
  })

  # Reseña dinámica
  output$resena_dinamica <- renderUI({
    caso <- caso_actual()
    monto_fmt <- format(round(caso$monto_mm), big.mark = ".", scientific = FALSE)
    div(class = "resena-box",
      div(class = "resena-monto",
          paste0("Monto ajustado a pesos de diciembre 2025: $", monto_fmt, " millones")
      ),
      p(caso$resena)
    )
  })

  # Contexto del área
  output$contexto_area <- renderUI({
    area_id <- tabla_subareas$area_id[tabla_subareas$area == input$area_sel][1]
    texto <- contextos_area[[area_id]]
    if (!is.null(texto)) {
      div(class = "area-contexto", p(texto))
    }
  })

  # Subáreas dinámicas con gráfico + textos
  output$subareas_dinamicas <- renderUI({
    monto <- monto_actual()
    caso_id <- input$caso_sel
    area_sel <- input$area_sel
    area_id  <- tabla_subareas$area_id[tabla_subareas$area == area_sel][1]
    color_area <- colores_area[area_sel]

    df <- tabla_subareas %>%
      filter(area == area_sel) %>%
      mutate(
        equiv = monto / costo_unitario_mm,
        equiv_fmt = case_when(
          equiv >= 1e6 ~ paste0(format(round(equiv / 1e6, 1), big.mark = "."), "M"),
          equiv >= 1e3 ~ paste0(format(round(equiv / 1e3, 0), big.mark = "."), "K"),
          TRUE         ~ format(round(equiv, 0), big.mark = ".")
        )
      )

    # Construir un bloque por subárea
    bloques <- lapply(1:nrow(df), function(i) {
      row       <- df[i, ]
      sid       <- row$subarea_id
      contexto  <- contextos_subarea[[sid]]
      impacto   <- impactos_texto[[sid]][[caso_id]]
      disc      <- row$disclaimer

      # Color del badge
      badge_color <- switch(disc,
        "Dato estimado"       = "#d4edda",
        "Escenario proyectado"= "#fff3cd",
        "Política hipotética" = "#f8d7da",
        "#E8E4D0"
      )
      badge_text_color <- switch(disc,
        "Dato estimado"       = "#155724",
        "Escenario proyectado"= "#856404",
        "Política hipotética" = "#721c24",
        "#8B6050"
      )

      div(class = "subarea-bloque",
        div(class = "subarea-titulo", row$subarea),
        div(class = "subarea-contexto", p(contexto)),

        # Gráfico de barra única
        plotlyOutput(paste0("grafico_", sid), height = "90px"),

        # Texto de impacto
        if (!is.null(impacto)) {
          tagList(
            tags$span(class = "disclaimer-badge",
                      style = paste0("background-color:", badge_color, "; color:", badge_text_color, ";"),
                      disc),
            div(class = "subarea-impacto", p(impacto))
          )
        }
      )
    })

    do.call(tagList, bloques)
  })

  # Generar gráficos individuales por subárea
  observe({
    area_sel <- input$area_sel
    caso_id  <- input$caso_sel
    monto    <- monto_actual()
    color_area <- as.character(colores_area[area_sel])

    df <- tabla_subareas %>%
      filter(area == area_sel) %>%
      mutate(equiv = monto / costo_unitario_mm)

    lapply(1:nrow(df), function(i) {
      row <- df[i, ]
      sid <- row$subarea_id
      local({
        sid_local   <- sid
        equiv_local <- row$equiv
        unidad_local <- row$unidad
        label_local  <- if (equiv_local >= 1e6) {
          paste0(format(round(equiv_local / 1e6, 1), big.mark = "."), " millones de ", unidad_local)
        } else if (equiv_local >= 1e3) {
          paste0(format(round(equiv_local), big.mark = "."), " ", unidad_local)
        } else {
          paste0(format(round(equiv_local, 1), big.mark = "."), " ", unidad_local)
        }

        output[[paste0("grafico_", sid_local)]] <- renderPlotly({
          plot_ly(
            x = equiv_local,
            y = 0,
            type = "bar",
            orientation = "h",
            text = label_local,
            textposition = "outside",
            marker = list(color = color_area),
            hoverinfo = "text",
            hovertext = label_local
          ) %>%
            layout(
              xaxis = list(visible = FALSE, showgrid = FALSE),
              yaxis = list(visible = FALSE, showgrid = FALSE),
              margin = list(l = 0, r = 120, t = 5, b = 5),
              paper_bgcolor = "rgba(0,0,0,0)",
              plot_bgcolor  = "rgba(0,0,0,0)",
              font = list(family = "Spectral", color = "#4B3621", size = 13)
            ) %>%
            config(displayModeBar = FALSE)
        })
      })
    })
  })
}

# ==============================================================================
shinyApp(ui, server)
