library(tidyr)
library(shiny)
library(bslib)
library(tidyverse)
library(shinyWidgets)
library(bsicons)
library(plotly)
library(visNetwork)

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

# escala_referencia_mm: total scale of the problem in MM pesos (for 2-bar chart)
# NA = use 5-case comparison chart instead
tabla_subareas <- tibble::tribble(
  ~area,        ~area_id,    ~subarea,                                         ~subarea_id,         ~costo_unitario_mm,  ~unidad,                         ~disclaimer,              ~escala_mm,   ~escala_label,

  # Salud
  "Salud",      "salud",     "Medicamentos de alto costo (Ley Ricarte Soto)",  "lrs",               7.5,                 "tratamientos anuales",          "Dato estimado",              56000,        "Presupuesto total Ley Ricarte Soto (2024)",
  "Salud",      "salud",     "Salud mental ambulatoria (COSAM)",               "cosam",             1304.0,              "centros construidos",           "Dato estimado",              119712,       "Brecha para llegar al mínimo OMS: diferencia entre 2,1% y 10% del presupuesto MINSAL",
  "Salud",      "salud",     "Operaciones en lista de espera",                 "operaciones",       0.8,                 "cirugías electivas",            "Dato estimado",              312183,       "Lista de espera quirúrgica total (390.229 cirugías × $0,8 MM)",
  "Salud",      "salud",     "Salud dental pública",                           "dental",            0.065,               "atenciones dentales integrales","Dato estimado",              591500,       "60% de la población adulta sin acceso (~9,1M personas × $65.000)",
  "Salud",      "salud",     "Equipamiento UCI",                               "uci",               17.5,                "camas UCI completas",           "Dato estimado",              12250,        "Capacidad UCI pública total (700 camas × $17,5 MM)",

  # Educación
  "Educación",  "educacion", "Becas universitarias",                           "becas",             1.15,                "becas universitarias anuales",  "Dato estimado",              97750,        "Estudiantes en zona gris sin asignación confirmada (85.000 × $1,15 MM)",
  "Educación",  "educacion", "Jardines infantiles JUNJI",                      "junji",             1200.0,              "jardines infantiles",           "Dato estimado",              120118,       "Inversión total gobierno Boric en infraestructura parvularia",
  "Educación",  "educacion", "Liceos técnico-profesionales",                   "liceos_tp",         80.0,                "liceos TP equipados",           "Dato estimado",              24000,        "Costo de equipar los ~300 liceos TP con déficit crítico",
  "Educación",  "educacion", "Infraestructura escolar rural",                  "rural",             423.0,               "escuelas rurales con conservación","Dato estimado",            460000,       "Plan estratégico infraestructura escolar (~2.000 establecimientos)",
  "Educación",  "educacion", "I+D y matriz productiva",                        "id",                0.912,               "empresas que innovaron con apoyo público",        "Escenario proyectado",   498000,       "Presupuesto combinado ANID + Corfo innovación 2024 (~$498.000 MM)",

  # Pensiones
  "Pensiones",  "pensiones", "Pensión para trabajadores informales (PGU)",     "pgu_informal",      2.780784,            "trabajadores con PGU por un año","Dato estimado",             9178587,      "Costo anual PGU para todos los trabajadores informales (3,3M × $2,78 MM)",
  "Pensiones",  "pensiones", "Brecha de género en pensiones (BAC)",            "bac",               1.2,                 "mujeres con compensación anual","Dato estimado",              960000,       "Costo anual BAC para las ~800.000 mujeres beneficiadas",
  "Pensiones",  "pensiones", "Deuda previsional de empleadores",               "deuda_prev",        900.0,               "trabajadores con deuda previsional recuperada","Escenario proyectado", 283500000,   "Deuda previsional total ($16 billones ÷ $900.000 costo unitario estimado de recuperación)",
  "Pensiones",  "pensiones", "PGU para adultos mayores en pobreza",            "pgu_adultos",       2.780784,            "adultos mayores con PGU por un año","Dato estimado",           6683964,      "Costo anual PGU para todos los beneficiarios actuales (2,4M × $2,78 MM)",
  "Pensiones",  "pensiones", "Jóvenes sin cotización futura",                  "jovenes_cot",       0.6,                 "trabajadores informales con un año de cotización","Escenario proyectado", 1980000,     "Costo de garantizar un año de cotizaciones a los 3,3M de trabajadores informales",

  # Seguridad
  "Seguridad",  "seguridad", "Dotación de Carabineros",                        "carabineros",       33.2,                "carabineros en terreno por un año","Dato estimado",            1512000,      "Presupuesto total Carabineros 2025",
  "Seguridad",  "seguridad", "Delitos económicos sin investigar (PDI)",         "pdi",               5.0,                 "casos de delitos económicos investigados",        "Escenario proyectado",   30000,        "Casos estimados sin cubrir por crecimiento de demanda 2025 (proyección no oficial)",
  "Seguridad",  "seguridad", "Infraestructura penitenciaria",                  "carceles",          65.0,                "plazas penitenciarias nuevas",  "Dato estimado",              1292590,      "Costo total para cerrar déficit de 19.886 plazas",
  "Seguridad",  "seguridad", "Centros de reinserción",                         "reinsercion",       5.25,                "personas en reinserción por un año","Dato estimado",           273000,       "Costo de cubrir a los 52.000 egresos anuales sin programa (× $5,25 MM)",
  "Seguridad",  "seguridad", "Fiscalía Supraterritorial",                      "ecoh",              78.5,                "fiscales y funcionarios financiados por un año", "Dato estimado",          7691,         "Presupuesto en régimen Fiscalía Supraterritorial ($7.691 MM)",

  # Vivienda
  "Vivienda",   "vivienda",  "Viviendas sociales SERVIU (DS49)",               "ds49",              31.6,                "viviendas sociales DS49",       "Dato estimado",              15544064,     "Costo de resolver el déficit total (491.904 viviendas × $31,6 MM)",
  "Vivienda",   "vivienda",  "Lista de espera SERVIU",                         "lista_espera",      600800.0,            "meses adicionales del programa DS49",             "Escenario proyectado",   7209600,      "Costo de resolver el déficit completo al ritmo actual (12 meses × 25 años)",
  "Vivienda",   "vivienda",  "Subsidios de arriendo (DS52)",                   "ds52",              6.712,               "familias con subsidio 8 años",  "Dato estimado",              4678368,      "Costo de cubrir a todos los hogares arrendatarios (696.000 × $6,712 MM)",
  "Vivienda",   "vivienda",  "Familias en campamentos",                        "campamentos",       46.8,                "familias con solución habitacional","Escenario proyectado",   5643331,      "Costo estimado solución habitacional para todas las familias en campamentos",
  "Vivienda",   "vivienda",  "Mejoramiento de viviendas",                      "mejoramiento",      4.74,                "viviendas mejoradas",           "Dato estimado",              5877123,      "Costo de mejorar todas las viviendas en déficit cualitativo (1,24M × $4,74 MM)",

  # Género
  "Género",     "genero",    "Política nacional de cuidados",                  "cuidados",          0.912,               "cuidadoras con estipendio anual","Dato estimado",             151587,       "Presupuesto total sistema de cuidados 2026",
  "Género",     "genero",    "Pensiones alimenticias",                         "alimentos",         30.0,                "funcionarios en Tribunales de Familia por un año","Escenario proyectado", 66540, "Funcionarios necesarios según Plan de Fortalecimiento PJ 2030 (2.218 × $30 MM)",
  "Género",     "genero",    "Casas de acogida VIF",                           "acogida",           300.0,               "Residencias Transitorias habilitadas","Dato estimado",        10500,        "Costo de 35 Residencias Transitorias actuales × $300 MM",
  "Género",     "genero",    "Acceso a la justicia VIF",                       "justicia_vif",      30.0,                "profesionales especializados VIF por un año","Dato estimado",   2783700,      "Costo de acompañar a las ~92.789 mujeres VIF sin apoyo (× $30 MM)",
  "Género",     "genero",    "Postnatal masculino ampliado",                   "postnatal",         0.17049,             "padres con postnatal de 30 días","Política hipotética",       22164,        "Costo anual estimado si todos los padres tomaran postnatal ampliado"
)

# ==============================================================================
# 2. TEXTOS NARRATIVOS
# ==============================================================================

# Contextos de área (estáticos)
contextos_area <- list(
  salud = "Chile gasta el 9,3% de su PIB en salud, pero la mitad de esa inversión la hacen las propias familias de su bolsillo. El sistema público —que cubre al 79% de la población a través de FONASA— enfrenta una crisis estructural documentada en cada plan ministerial de la última década: listas de espera que superan el año y medio, hospitales con equipamiento insuficiente, y una salud mental que recibe apenas el 2,1% del presupuesto sectorial cuando la OMS recomienda al menos el 10%.",

  educacion = "Chile invierte casi el 5,5% de su PIB en educación, pero los resultados revelan una brecha estructural que el dinero solo no explica. Los estudiantes del sistema público aprenden en condiciones radicalmente distintas según la comuna donde nacieron: escuelas rurales con infraestructura deteriorada, liceos técnico-profesionales sin equipamiento para enseñar las especialidades que dictan, y una inversión en investigación y desarrollo que lleva más de una década estancada en menos del 0,4% del PIB —cuando el promedio de la OCDE triplica esa cifra. El sistema forma técnicos y profesionales que luego no encuentran empleos de calidad, porque la economía que los debería absorber nunca se diversificó.",

  pensiones = "El sistema de pensiones chileno es uno de los debates más largos y dolorosos de la política nacional. Creado en 1981 bajo la dictadura de Pinochet, el modelo de capitalización individual funciona razonablemente bien para quienes cotizan de forma constante a lo largo de su vida laboral, pero falla profundamente para quienes no pueden hacerlo. En Chile, 3,3 millones de personas no cotizan, el 37% de los trabajadores opera en la informalidad, y las mujeres acumulan en promedio 9 años menos de cotizaciones que los hombres. La Reforma Previsional de 2025 es un avance real. Pero llegó tarde para millones de personas, y su alcance sigue siendo insuficiente para quienes nunca pudieron cotizar.",

  seguridad = "Chile vive un momento de inflexión en materia de seguridad. El crimen organizado transnacional se instaló en el país aprovechando vacíos institucionales que se acumularon durante décadas: una dotación policial insuficiente, un sistema penitenciario con hacinamiento al 147%, cárceles que funcionan como centros de reclutamiento criminal, y una institucionalidad de persecución del delito económico y organizado que llegó tarde y con recursos escasos. Parte del dinero que debió fortalecer al Estado en estos años fue desviado —en algunos casos, por las propias instituciones que debían proteger a la ciudadanía.",

  vivienda = "Chile tiene un déficit de casi 492.000 viviendas —familias que viven hacinadas, allegadas o en condiciones irrecuperables. Si se suman las viviendas que requieren mejoramiento urgente, el número supera 1,7 millones. En 2024 había 120.584 familias viviendo en campamentos —la cifra más alta en décadas. El 26,2% de los hogares arrienda, el porcentaje más alto de la historia. Spoiler: la magnitud de la crisis de vivienda es tal, que ninguno de los montos defraudados por los casos de corrupción aquí analizados hubiese cerrado alguna de las brechas. Todos los montos presentados, representan fracciones ínfimas de la crisis.",

  genero = "La desigualdad de género en Chile es un problema estructural con costos económicos medibles. Las mujeres trabajan en promedio 21 horas más a la semana que los hombres —en cuidados no remunerados que el sistema económico necesita pero no paga. Esa carga determina sus trayectorias laborales, sus cotizaciones previsionales y su autonomía económica. Y cuando la desigualdad económica se convierte en dependencia, la violencia encuentra terreno. En 2024 hubo 50 femicidios y más de 132.000 casos policiales por violencia intrafamiliar."
)

# Contextos de subárea (estáticos)
contextos_subarea <- list(
  lrs = "En Chile, tener una enfermedad rara o una condición de alto costo puede significar la ruina económica de una familia entera. La Ley Ricarte Soto, creada en 2015, fue el primer intento del Estado de garantizar tratamientos para enfermedades como la esclerosis múltiple, la hepatitis C o ciertos tipos de cáncer poco frecuentes. Hoy cubre cerca de 7.500 pacientes con un presupuesto de $56.000 millones al año —aproximadamente $7.500.000 por paciente anual. Sin embargo, decenas de patologías siguen fuera de la ley, y quienes las padecen deben costear tratamientos de hasta $50 millones al año o directamente no acceder a ellos.",

  cosam = "Chile dedica apenas el 2,1% de su presupuesto de salud a la salud mental, cuando la OMS recomienda al menos un 10%. El resultado es un sistema que solo logra cubrir el 20% de los trastornos mentales diagnosticados. Los Centros de Salud Mental Comunitaria (COSAM) son la columna vertebral de la atención ambulatoria pública: equipos de psicólogos, psiquiatras y trabajadores sociales que atienden de forma gratuita. En 2024, el gobierno financió la construcción de 9 nuevos COSAM con $11.736 millones. Construir un COSAM estándar cuesta aproximadamente $1.304 millones.",

  operaciones = "A fines de 2024, había 390.229 cirugías pendientes en el sistema público chileno. Son personas que ya tienen el diagnóstico, ya tienen la indicación médica, y llevan esperando un promedio de 579 días —casi 19 meses— para entrar a un pabellón. Ese año, más de 36.000 personas murieron mientras esperaban una atención de salud. En 2024 el Estado destinó $48.000 millones para reducir la lista, lo que permite costear aproximadamente $800.000 por cirugía electiva promedio.",

  dental = "La salud dental es uno de los grandes ausentes de la salud pública chilena. La cobertura garantizada del sistema solo alcanza a embarazadas y niños de 6 años. Se estima que cerca del 60% de la población adulta no tiene acceso oportuno a atención dental. Una alta odontológica integral (AOI) —el procedimiento completo que incluye diagnóstico, extracción, obturación y control— cuesta aproximadamente $65.000 en el sistema público para quienes logran acceder. Las consecuencias van mucho más allá de lo estético: la salud bucal está directamente relacionada con enfermedades cardiovasculares, diabetes y calidad de vida.",

  uci = "Antes de la pandemia, Chile tenía alrededor de 700 camas de Unidad de Cuidados Intensivos en el sistema público. Cuando llegó el COVID-19, el país descubrió en tiempo real lo que los especialistas advertían desde hacía años: el sistema público tenía una capacidad crítica insuficiente. Equipar una cama UCI completa —ventilador mecánico, monitor multiparamétrico, catre eléctrico e insumos— cuesta aproximadamente $17,5 millones.",

  id = "Aun si se hubieran financiado todas las becas, construido todos los jardines, equipado todos los liceos y reparado todas las escuelas rurales, seguiría pendiente la pregunta más estructural de la educación chilena: ¿hay una economía capaz de absorber a los profesionales y técnicos que ese sistema forma? Chile lleva más de una década invirtiendo menos del 0,4% de su PIB en investigación y desarrollo —el promedio OCDE triplica esa cifra. El resultado es una matriz productiva concentrada en materias primas que no genera los empleos calificados que sus propios graduados necesitan. El 19% de los trabajadores chilenos está sobrecalificado para el puesto que ocupa; el 35% trabaja en un área distinta a la que estudió. Esos sectores que los absorberían no se crean solos: requieren inversión pública sostenida en I+D. En 2024, el Estado destinó ~$498.000 millones a través de ANID y Corfo para financiar investigación e innovación. Es la inversión con que Chile intenta construir la economía que sus propios graduados necesitan para desarrollarse aquí.",

  becas = "En Chile, el acceso a la educación superior sigue siendo profundamente desigual. La Beca Juan Gómez Millas entrega hasta $1.150.000 al año para cubrir aranceles en universidades acreditadas. Para muchos estudiantes de primera generación universitaria, cada peso del sistema de becas es la diferencia entre continuar o abandonar.",

  junji = "La educación parvularia es la inversión con mayor retorno comprobado en el ciclo educativo: cada peso invertido en los primeros años de vida reduce significativamente las brechas de aprendizaje que luego son casi imposibles de cerrar. Construir un jardín infantil JUNJI estándar —con capacidad para 80 a 100 niños— cuesta aproximadamente $1.200 millones, y puede costar hasta $3.300 millones en zonas extremas.",

  liceos_tp = "El 44% de los estudiantes de educación media en Chile estudia en liceos técnico-profesionales. En un tercio de esos liceos —unos 300 establecimientos— los docentes reportan mínima o nula disponibilidad de equipamiento para enseñar las especialidades que dictan. El programa oficial de equipamiento del Ministerio de Educación invierte aproximadamente $80 millones por liceo.",

  rural = "En Chile hay miles de escuelas rurales que educan a los niños más alejados de los centros urbanos. El Fondo de Conservación de Infraestructura Escolar destinó en 2024 $52.868 millones para atender a 125 establecimientos —un promedio de $423 millones por escuela. El catastro del Ministerio identifica cerca de 2.000 establecimientos que requieren intervención urgente.",

  pgu_informal = "En Chile hay hoy 2,4 millones de adultos mayores que reciben la Pensión Garantizada Universal (PGU) —el piso mínimo que el Estado garantiza a quienes llegaron a la vejez sin pensión propia o con una pensión insuficiente. Son personas que trabajaron toda su vida en la informalidad, en empleos sin contrato, cuidando hijos o enfermos sin remuneración. La PGU les entrega $231.732 al mes —apenas sobre la línea de pobreza— y la reforma previsional de 2025 la ampliará gradualmente a $250.000. Para financiarla, el Estado gasta más de $6,6 billones al año. La PGU, lejos de ser un beneficio extraordinario, es la consecuencia inevitable de un sistema que durante décadas no pudo —o no quiso— formalizar el trabajo de millones de personas.",

  bac = "Las mujeres chilenas se jubilan con pensiones significativamente más bajas que los hombres, porque tienen en promedio 9 años menos de cotizaciones —pasaron esos años cuidando a hijos, padres o familiares, trabajo que el sistema previsional nunca reconoció económicamente. La reforma de 2025 introdujo el Beneficio por Años Cotizados (BAC), que en su tope máximo suma hasta $100.000 mensuales adicionales a la pensión de una mujer con 25 años de cotizaciones.",

  deuda_prev = "Hay una forma de robo que ocurre todos los meses en Chile: empleadores que descuentan las cotizaciones previsionales del sueldo de sus trabajadores y luego no las transfieren a las AFP. A 2024, 315.000 empleadores tenían deuda previsional acumulada con 2,4 millones de trabajadores. La deuda total supera los $16 billones. Son $16.000.000 millones en cotizaciones que ya salieron del bolsillo de los trabajadores y nunca llegaron a su cuenta de ahorro.",

  pgu_adultos = "La Pensión Garantizada Universal llegó para garantizar un piso mínimo a quienes más lo necesitan: adultos mayores que llegaron a la vejez sin ahorros suficientes. Hoy la PGU entrega $231.732 mensuales para quienes tienen entre 65 y 81 años, y $250.275 para los mayores de 82. Más de 2,4 millones de personas la reciben. Su monto apenas supera la línea de pobreza.",

  jovenes_cot = "Cada mes que un trabajador joven pasa sin cotizar no es un mes neutro: es una deuda previsional que se acumula con interés compuesto invertido. Una persona que empieza a cotizar a los 35 en vez de a los 25 puede perder entre el 30% y el 40% de su pensión final —no porque cotice menos años, sino porque el período de mayor rendimiento del capital son los primeros. En Chile hay 3,3 millones de personas que hoy no están cotizando, la mayoría jóvenes en empleos a honorarios, sin contrato o en trabajo doméstico. La reforma previsional de 2025 creó incentivos para formalizar, pero no resuelve la brecha acumulada de quienes llevan años sin cotizar. Garantizar un año de cotizaciones a un trabajador en sueldo mínimo cuesta $600.000.",

  carabineros = "Chile tiene 2,29 carabineros por cada 100.000 habitantes —por debajo del promedio internacional de 2,80. En 2025, el gobierno anunció la incorporación de 1.300 carabineros adicionales, la mayor expansión en años. El costo de sostener un carabinero en terreno —incluyendo remuneración, equipamiento y todos los costos institucionales— equivale a aproximadamente $33.200.000 al año.",

  pdi = "Los delitos más costosos para el Estado y la democracia no son los que se cometen con violencia: son los que se cometen con boletas falsas, transferencias electrónicas y redes de testaferros. La Brigada Investigadora de Delitos Económicos (BRIDEC) de la PDI investigó alrededor de 40.000 causas en 2024 —y los delitos económicos crecieron un 32% solo en el primer trimestre de 2025. La Brigada Investigadora de Delitos Funcionarios, que persigue específicamente la corrupción pública, tiene apenas 17 oficiales en todo el país. El costo de investigar un caso de delito económico es aproximadamente $5.000.000.",

  carceles = "A diciembre de 2025, había 62.323 personas privadas de libertad en establecimientos con capacidad para 42.437. El hacinamiento hace imposible clasificar a los internos por perfil criminológico y convierte las cárceles en espacios donde las organizaciones criminales reclutan y consolidan poder. Construir una plaza penitenciaria nueva cuesta aproximadamente $65.000.000 según el Plan Maestro de Infraestructura Penitenciaria.",

  reinsercion = "Construir más cárceles es una medida efectiva para reducir el hacinamiento carcelario y establecer medidas mínimas de seguridad y orden, pero no son un factor determinante para disminuir la reincidencia. Cada año egresan del sistema penitenciario cerrado aproximadamente 52.000 personas. De ellas, la gran mayoría sale sin acceso a un programa adecuado de reinserción. La reincidencia en Chile se estima entre el 42,9% y el 50,5% según el informe Juntos por la Reinserción 2025. Las personas que sí participan en programas con empleo y educación tienen tasas de reincidencia de alrededor del 22%. La reinserción recibe apenas el 10% del presupuesto de Gendarmería, y sostener a una persona en un programa de reinserción durante un año cuesta aproximadamente $5.250.000.",

  ecoh = "Chile aprobó en 2024 la creación de la Fiscalía Supraterritorial: una unidad especializada con 35 fiscales y 63 funcionarios de apoyo, diseñada para perseguir delitos que cruzan fronteras regionales y que el sistema fiscal regular no tiene capacidad de investigar —crimen organizado transnacional, narcotráfico de gran escala, trata de personas. Su presupuesto en régimen es de $7.691 millones al año. Financiar a uno de sus fiscales o funcionarios cuesta aproximadamente $78.500.000 al año. Es una institución nueva, que llegó tarde, y que opera con los recursos que el Estado logró destinarle.",

  ds49 = "El Fondo Solidario de Elección de Vivienda —DS49— es el principal instrumento del Estado para entregar viviendas sin deuda al 40% más vulnerable. El subsidio base es de 800 UF —aproximadamente $31.600.000. El postulante debe aportar un ahorro mínimo de solo 10 UF. En 2026, el Ministerio de Vivienda tiene presupuesto para 19.000 subsidios DS49. Con un déficit de 492.000 viviendas y ese ritmo de entrega, resolver el déficit tomaría más de 25 años.",

  lista_espera = "No existe una cifra oficial del número de familias en lista de espera habitacional en Chile. Lo que sí existe es el déficit: 492.000 viviendas requeridas, y 19.000 subsidios DS49 disponibles para 2026. El costo anual de operar el programa DS49 al ritmo de 2026 es aproximadamente $600.800 millones.",

  ds52 = "El 26,2% de los hogares chilenos arrienda —el porcentaje más alto de la historia del país. El Subsidio de Arriendo DS52 entrega 170 UF en total —aproximadamente $6.712.000— para que una familia pueda complementar el pago de su arriendo durante hasta 8 años, con un aporte mensual de hasta $193.000 en la Región Metropolitana. Cada llamado del DS52 tiene cupos limitados que se agotan rápidamente frente a una demanda que crece cada año.",

  campamentos = "En Chile hay 120.584 familias viviendo en 1.428 campamentos. Muchas de esas familias están inscritas en la lista de espera de SERVIU, es decir, construyeron donde pudieron mientras esperaban su turno para recibir un subsidio. Desde 2022, los campamentos han crecido en 341 nuevos polígonos y más de 6.000 familias adicionales. Proveer una solución habitacional definitiva a todas las familias en campamento costaría aproximadamente $46.800.000 por familia.",

  mejoramiento = "El déficit cualitativo de vivienda en Chile supera el millón doscientas mil unidades: viviendas habitadas que presentan problemas estructurales, de habitabilidad o de saneamiento. El Programa de Habitabilidad Rural ofrece hasta 120 UF —aproximadamente $4.740.000— para reparaciones básicas. Un techo reparado puede hacer la diferencia entre una familia que puede dormir seca en invierno y una que no.",

  cuidados = "En Chile hay 1.194.273 personas que realizan labores de cuidado: cuidan a personas mayores, a personas con discapacidad, a enfermos crónicos. El 80% son mujeres. Trabajan 41 horas semanales en esa labor —sin remuneración, sin previsión, sin reconocimiento legal. En 2026, el presupuesto del sistema de cuidados alcanza los $151.587 millones. Uno de sus instrumentos concretos es el estipendio para cuidadoras de personas con dependencia severa: aproximadamente $912.000 al año.",

  alimentos = "En Chile hay 238.724 personas registradas como deudoras de pensiones alimenticias —el 96% son hombres. El dinero que los tribunales ya ordenaron pagar y que sigue sin transferirse suma $2,5 billones. Detrás de esa cifra hay mujeres que asumen solas el costo de criar mientras el Estado no tiene la capacidad de cobrar lo que la justicia ya resolvió. La brecha es institucional. El Plan de Fortalecimiento del Poder Judicial 2030 estima que se necesitan 2.218 funcionarios adicionales a nivel nacional para absorber la carga actual de los tribunales de primera instancia. Sostener a un funcionario especializado en Tribunales de Familia cuesta aproximadamente $30.000.000 al año.",

  acogida = "Cuando una mujer decide salir de una situación de violencia, necesita dos cosas de forma inmediata: un lugar seguro donde estar y una persona que la acompañe. Las Residencias Transitorias del SernamEG son ese primer lugar. En 2025, hay 35 Residencias Transitorias activas en todo el país, 8 en la Región Metropolitana. En 2024 se registraron más de 132.000 casos policiales por VIF y 50 femicidios. Habilitar y operar una Residencia Transitoria durante su primer año cuesta aproximadamente $300 millones.",

  justicia_vif = "En Chile, solo el 8,3% de las denuncias por delitos sexuales termina en condena. Las listas de espera para atención reparatoria en el sistema SernamEG superan los 12 meses. Los Centros de Atención Especializada en Violencias de Género —24 nuevos inaugurados en 2024— son parte de la respuesta: equipos de profesionales especializados que acompañan a las víctimas y facilitan el acceso a la justicia. Sostener a un profesional especializado en VIF cuesta aproximadamente $30.000.000 al año.",

  postnatal = "Chile otorga actualmente 5 días de postnatal masculino pagado. El promedio de la OCDE es de 8 semanas. Suecia implementó el permiso parental compartido en 1974. En los países donde esta política existe con carácter obligatorio, la tasa de adopción por parte de los padres supera el 70%. En Chile, hay un proyecto de ley en tramitación que propone ampliar el postnatal masculino a 30 días propios obligatorios. Aún no es ley. Financiar 30 días de postnatal para un padre en el sueldo mínimo cuesta $170.490."
)

# Párrafos de impacto por combinación caso × subárea
# Formato: impactos_texto[["subarea_id"]][["caso_id"]]
impactos_texto <- list(

  lrs = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen al tratamiento completo de 26.792 pacientes con enfermedades de alto costo durante un año —3,5 veces el total de personas que hoy cubre la Ley Ricarte Soto. En otras palabras, con ese dinero el Estado habría podido triplicar la cobertura actual de la ley y aún sobrarían recursos.",
    pacogate  = "Los $41.898 millones malversados en Carabineros equivalen al tratamiento anual de 5.586 pacientes con enfermedades de alto costo —casi el 75% del total de personas que hoy cubre la Ley Ricarte Soto. Con ese monto el Estado habría podido expandir significativamente la cobertura de la ley durante un año completo, incorporando patologías que hoy están en lista de espera de evaluación.",
    sqm       = "Los $13.500 millones que SQM pagó ilegalmente a políticos de todo el espectro equivalen al tratamiento anual de 1.800 pacientes con enfermedades de alto costo. Con el equivalente a lo que una empresa minera destinó a comprar voluntades políticas, el Estado habría podido garantizar durante un año que 1.800 familias no tuvieran que elegir entre pagar el arriendo y comprar el medicamento.",
    penta     = "Los $16.200 millones que el Grupo Penta evadió en impuestos equivalen al tratamiento anual de 2.160 pacientes con enfermedades de alto costo. Ese dinero solo fue recuperado porque hubo una investigación judicial que pudo no haber ocurrido. Los pacientes con enfermedades que no están en la Ley Ricarte Soto siguen esperando.",
    milicogate = "Los $10.657 millones desviados de los fondos secretos del Ejército equivalen al tratamiento anual de 1.421 pacientes con enfermedades de alto costo. Con lo gastado en propiedades por parte de generales en retiro, se pudo haber garantizado el acceso a tratamientos de alto costo a más de mil personas que hoy están esperando."
  ),

  cosam = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían permitido construir 154 COSAM. En 2024 el gobierno construyó 9 con $11.736 millones, considerado un avance notable. Con el monto del Caso Inverlink se habrían podido construir 17 veces esa cantidad: una red capaz de transformar el acceso a la salud mental en Chile de forma estructural.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la construcción de 32 COSAM —más de tres veces lo que el gobierno logró construir con el presupuesto especial de 2024. Cada uno de esos centros atiende a una población de entre 80.000 y 165.000 personas.",
    sqm       = "Los $13.500 millones que SQM no pagó en impuestos habrían financiado la construcción de 10 COSAM —prácticamente lo mismo que el gobierno de Boric pudo financiar en 2024 con todo el presupuesto especial de salud mental.",
    penta     = "Los $16.200 millones evadidos por el Grupo Penta habrían financiado la construcción de 12 COSAM. En 2024 el Estado invirtió $11.736 millones para construir 9 centros de salud mental. El dinero que Délano y Lavín nunca hubieran devuelto sin una investigación judicial habría alcanzado para construir esos 9 centros y tres más.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la construcción de 8 COSAM —casi el equivalente completo al presupuesto especial con que el gobierno construyó 9 centros de salud mental en 2024."
  ),

  operaciones = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 251.175 cirugías en el sistema público —el 64% de toda la lista de espera quirúrgica de 2024. En 2024 murieron 36.262 personas esperando una atención de salud.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 52.372 cirugías —el equivalente al 13,4% de toda la lista de espera quirúrgica de 2024. El gobierno destinó $48.000 millones ese año para reducir esa misma lista. Lo que se robaron dentro de la institución policial era casi el monto completo de ese esfuerzo especial.",
    sqm       = "Los $13.500 millones que nunca tributaron equivalen a 16.875 cirugías en el sistema público. Son casi 17.000 personas que hoy esperan 19 meses para entrar a un pabellón, con diagnóstico en mano y sin fecha.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 20.250 cirugías que no se realizaron. Con el dinero que Penta evadió en impuestos se pudo haber evitado mas de la mitad de las 36.262 de personas que esperaban recibir una atención en 2024.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen a 13.321 cirugías en el sistema público. Son personas que hoy llevan meses esperando con dolor, con movilidad reducida, o con una condición que se agrava mientras el sistema no tiene presupuesto para atenderlas más rápido."
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
    inverlink = "Aun si los $200.940 millones sustraídos de CORFO hubieran financiado todas las becas, jardines, liceos y escuelas rurales que se analizaron antes —y habrían alcanzado para eso y más— seguiría pendiente la pregunta de fondo: ¿hay una economía que absorba a esos graduados? El monto robado representa el 40% del presupuesto combinado ANID-Corfo para I+D e innovación en un año. Son los recursos que no estuvieron disponibles para los sectores que habrían generado los empleos calificados que Chile no tiene.",
    pacogate  = "Aun si los $41.898 millones malversados en Carabineros hubieran financiado becas, jardines y conservación de escuelas rurales —que habrían alcanzado para buena parte de eso— el problema de fondo seguiría intacto. Ese monto equivale al 8,4% del presupuesto combinado ANID-Corfo para I+D. Chile tiene más trabajadores sobrecalificados que el promedio OCDE porque la economía no generó los sectores que los absorberían. Cambiar eso requiere exactamente el tipo de inversión que el Pacogate hizo imposible.",
    sqm       = "Aun si los $13.500 millones que SQM nunca tributó hubieran financiado escuelas rurales y liceos equipados —y habrían alcanzado para decenas—, el problema estructural seguiría ahí. Ese monto equivale al 2,7% del presupuesto ANID-Corfo. Una empresa que extrae recursos naturales de Chile y que prefirió financiar ilegalmente la política en vez de tributar, le quitó al Estado los recursos con que construye la economía que permitiría que sus propios trabajadores tuvieran empleos de calidad.",
    penta     = "Aun si los $16.200 millones del Caso Penta hubieran financiado jardines infantiles, becas universitarias y equipamiento de liceos TP —que habrían alcanzado para todo eso— la pregunta del empleo calificado seguiría sin respuesta. Ese monto equivale al 3,3% del presupuesto ANID-Corfo. El 35% de los trabajadores chilenos trabaja en un área distinta a la que estudió. Detrás de ese número hay años de subinversión en los sectores que habrían generado esos empleos.",
    milicogate = "Aun si los $10.657 millones desviados de los fondos del Ejército hubieran financiado escuelas rurales y liceos técnicos —que habrían alcanzado para varios—, el piso estructural no cambiaría: Chile invierte menos del 0,4% de su PIB en I+D. Ese monto equivale al 2,1% del presupuesto ANID-Corfo. Equivale también a más del doble del programa completo de Capital Humano para la Innovación de Corfo, que en 2024 financió 72 proyectos de innovación en todo el país."
  ),

  becas = list(
    inverlink = "En 2024, cerca de 85.000 estudiantes cumplían todos los requisitos académicos y socioeconómicos para una beca universitaria del Estado, pero no la recibieron porque el presupuesto no alcanzó. Los $200.940 millones sustraídos de CORFO habrían financiado la beca completa de esos 85.000 estudiantes durante dos años seguidos —con $9.470 millones de sobra.",
    pacogate  = "En 2024, cerca de 85.000 estudiantes cumplían todos los requisitos para una beca universitaria pero no la recibieron por falta de cupos. Los $41.898 millones malversados en Carabineros habrían financiado la beca anual de 36.433 de esos estudiantes —el 43% de los que se quedaron sin financiamiento.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 11.739 becas universitarias anuales. Más de once mil estudiantes habrían podido acceder o mantenerse en la educación superior con el dinero que una empresa minera destinó a boletas falsas.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 14.087 becas universitarias anuales. El Grupo Penta pagó multas, completó cursos de ética y cumplió condenas en libertad. Los 14.000 estudiantes que habrían podido beneficiarse con esos recursos no tienen curso que recuperar ni condena que cumplir.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 9.267 becas universitarias anuales. Más de 9.000 jóvenes que hoy estudian con deuda o que abandonaron la universidad por razones económicas habrían podido tener una trayectoria diferente."
  ),

  junji = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 167 jardines infantiles JUNJI de capacidad estándar —suficiente para que más de 15.000 niños de los sectores más vulnerables tuvieran acceso a educación parvularia de calidad. En 2024, el gobierno de Boric destinó $120.118 millones a infraestructura parvularia en todo su mandato. Con el monto del Caso Inverlink se habría podido superar ese esfuerzo completo.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 35 jardines infantiles JUNJI —con capacidad para unos 3.000 niños de los sectores más vulnerables.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 11 jardines infantiles JUNJI —capacidad para más de 900 niños en sus primeros años de vida. Once comunidades que hoy no tienen jardín habrían podido tenerlo.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 13 jardines infantiles JUNJI.",
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
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la conservación completa de 475 escuelas rurales —casi cuatro veces lo que el Estado pudo atender con el Fondo de Conservación de 2024. La diferencia entre una escuela rural con conservación y una sin ella representa la diferencia entre poder aprender y no poder hacerlo.",
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
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el Beneficio por Años Cotizados en su tope máximo para 167.450 mujeres pensionadas durante un año —$100.000 mensuales adicionales para cada una.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el BAC al tope para 34.915 mujeres pensionadas durante un año. Son más de 34.000 mujeres que cotizaron durante décadas, cuidaron familias sin remuneración, y llegan a la vejez con pensiones menores que sus pares hombres.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el BAC al tope para 11.250 mujeres pensionadas durante un año. La brecha de género en pensiones es la diferencia entre una mujer mayor que puede pagar sus gastos básicos y una que no puede.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el BAC al tope para 13.500 mujeres pensionadas durante un año. La reforma de 2025 es un avance. Pero el dinero que Délano y Lavín evadieron habría podido adelantar o ampliar ese beneficio para 13.500 mujeres que lo necesitaban antes.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el BAC al tope para 8.881 mujeres pensionadas durante un año. Casi 9.000 mujeres que cotizaron toda su vida y llegan a la vejez con pensiones menores por los años que dedicaron a cuidar a otros."
  ),

  deuda_prev = list(
    inverlink = "Los $200.940 millones del Caso Inverlink representan el 1,3% de la deuda previsional total que empleadores le deben a sus trabajadores en Chile —$16 billones acumulados en cotizaciones descontadas del sueldo pero nunca transferidas. Son formas distintas del mismo fenómeno: dinero que pertenecía a otros y fue apropiado por quienes tenían el poder de hacerlo.",
    pacogate  = "Los $41.898 millones del Pacogate representan el 0,26% de la deuda previsional total que los empleadores le deben a 2,4 millones de trabajadores chilenos. Corrupción institucional y deuda previsional: dos formas de apropiarse de lo que le pertenece a otros.",
    sqm       = "Los $13.500 millones del Caso SQM equivalen a las cotizaciones impagadas de aproximadamente 15.000 trabajadores durante un año a sueldo mínimo. La deuda previsional es la pensión futura de millones de personas que ya pagaron y cuyo empleador simplemente se quedó con el dinero.",
    penta     = "Los $16.200 millones del Caso Penta son equivalentes a las cotizaciones anuales de aproximadamente 18.000 trabajadores a sueldo mínimo. El Grupo Penta evadió impuestos sistemáticamente durante años antes de ser descubierto. Los empleadores con deuda previsional hacen lo mismo, a escala masiva, con las cotizaciones de sus trabajadores.",
    milicogate = "Los $10.657 millones del Milicogate equivalen a las cotizaciones anuales de aproximadamente 11.840 trabajadores a sueldo mínimo."
  ),

  pgu_adultos = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la PGU completa para 72.260 adultos mayores durante un año —personas que llegaron a la vejez sin pensión propia y que hoy dependen de ese apoyo para cubrir sus necesidades básicas.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la PGU para 15.067 adultos mayores durante un año. El Estado tiene el deber de garantizarles ese piso mínimo. El dinero que se desvió dentro de la institución policial habría podido cumplir ese deber con 15.000 de ellas.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado la PGU para 4.855 adultos mayores durante un año. El tribunal que absolvió a los principales acusados en octubre de 2025 argumentó vicios del proceso. Los 4.855 adultos mayores no tienen vicios procesales que invocar.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la PGU para 5.826 adultos mayores durante un año. Casi 6.000 personas que llegaron a la vejez sin ahorros propios habrían podido recibir los $231.732 mensuales que el Estado garantiza.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la PGU para 3.832 adultos mayores durante un año. Casi 4.000 personas mayores que viven con $231.732 al mes: eso es lo que el dinero gastado en casinos y propiedades de lujo habría podido financiar."
  ),

  jovenes_cot = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían garantizado un año de cotizaciones a 334.900 trabajadores informales. Para un trabajador de 25 años, ese año de cotizaciones no vale $600.000: vale entre $2 y $4 millones de pensión futura.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían garantizado un año de cotizaciones a 69.830 trabajadores jóvenes en situación informal.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían garantizado un año de cotizaciones a 22.500 trabajadores informales. Una empresa que extrae recursos naturales de Chile prefirió financiar ilegalmente la política —y privó a esas 22.500 personas del año de cotización de mayor impacto en su pensión futura.",
    penta     = "Los $16.200 millones del Caso Penta habrían garantizado un año de cotizaciones a 27.000 trabajadores jóvenes en situación informal.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían garantizado un año de cotizaciones a 17.762 trabajadores informales jóvenes."
  ),

  carabineros = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO equivalen al costo de sostener 6.053 carabineros en terreno durante un año —el 13% de la dotación actual. Es casi cinco veces la cantidad de nuevos carabineros que el gobierno logró incorporar en 2025 con un gran esfuerzo presupuestario.",
    pacogate  = "Los $41.898 millones malversados dentro de Carabineros equivalen al costo de sostener 1.262 carabineros en terreno durante un año. La institución creada para dar seguridad desvió el dinero que habría podido pagar el sueldo de más de 1.200 de sus propios funcionarios.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen al costo de sostener 407 carabineros en terreno durante un año. En comunas donde la dotación efectiva ha caído en un 27% en los últimos años.",
    penta     = "Los $16.200 millones del Caso Penta equivalen al costo de sostener 488 carabineros en terreno durante un año. Casi 500 funcionarios que habrían podido estar en terreno, cumpliendo la función para la que el Estado los forma y remunera.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen al costo de sostener 321 carabineros en terreno durante un año. Es el equivalente a la dotación completa de Carabineros en varias comunas medianas del país."
  ),

  pdi = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado la investigación de 40.188 casos de delitos económicos —prácticamente el total de causas que la BRIDEC investigó en todo 2024. La Brigada Investigadora de Delitos Funcionarios, que persigue específicamente la corrupción pública, tiene hoy 17 oficiales en todo el país. El Caso Inverlink es exactamente el tipo de delito que esa unidad debería perseguir.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado la investigación de 8.380 casos de delitos económicos. El Pacogate fue descubierto gracias a una alerta del BancoEstado que el propio mando de Carabineros ignoró durante dos años —no por una investigación proactiva de la PDI. Con más capacidad institucional para perseguir este tipo de delito, la historia habría podido ser distinta.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado la investigación de 2.700 casos de delitos económicos. Los delitos económicos crecieron un 32% en el primer trimestre de 2025. La Brigada de Delitos Funcionarios que investiga la corrupción pública tiene 17 oficiales para todo Chile.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado la investigación de 3.240 casos de delitos económicos. Fue un solo fiscal —Carlos Gajardo— quien investigando el Penta detectó el Caso SQM. Con más capacidad institucional especializada, casos como estos no dependerían de un fiscal que mira en la dirección correcta.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado la investigación de 2.131 casos de delitos económicos. El Milicogate fue destapado por periodistas, no por el Estado. La Brigada de Delitos Funcionarios que debería perseguir este tipo de fraude institucional tiene 17 oficiales en todo el país."
  ),

  carceles = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 3.091 plazas penitenciarias nuevas —el 15,5% del déficit actual de 19.886 plazas. Tres mil plazas nuevas habrían permitido comenzar a clasificar internos por perfil criminológico, separar a los detenidos por primera vez de los reincidentes organizados, y crear las condiciones mínimas para que la reinserción sea posible.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 644 plazas penitenciarias nuevas —el 3,2% del déficit actual. Con el monto del Pacogate se habrían podido construir más de la mitad de un establecimiento del tamaño del Complejo La Laguna en Talca.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 208 plazas penitenciarias nuevas. El crimen organizado crece dentro de las cárceles en parte porque el Estado no tiene la infraestructura para clasificar a los internos y aislar a los líderes de las bandas.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 249 plazas penitenciarias nuevas. El hacinamiento al 147% significa que las cárceles públicas tienen casi 50% más personas de las que pueden albergar en condiciones dignas.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 164 plazas penitenciarias nuevas. Cada plaza penitenciaria nueva es la diferencia entre un sistema que puede clasificar, separar y rehabilitar, y uno que simplemente contiene la criminalidad."
  ),

  reinsercion = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado programas de reinserción para 38.274 personas durante un año —más del doble de todas las personas que hoy acceden a programas de acompañamiento en Gendarmería. La reinserción es la política de seguridad con mayor retorno comprobado.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado programas de reinserción para 7.981 personas durante un año.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado programas de reinserción para 2.571 personas durante un año.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado programas de reinserción para 3.086 personas durante un año. Délano y Lavín cumplieron su condena en un programa psicosocial en la Universidad Adolfo Ibáñez. Las 3.086 personas que habrían podido acceder a reinserción con ese dinero no tienen universidad privada que los acompañe.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado programas de reinserción para 2.030 personas durante un año. Más de 2.000 personas que salen de la cárcel sin red de apoyo habrían podido tener un programa de acompañamiento."
  ),

  ecoh = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 2.560 fiscales y funcionarios de la Fiscalía Supraterritorial durante un año —26 veces la dotación completa de la institución. La Fiscalía Supraterritorial existe desde 2024, tiene 98 personas, y su presupuesto en régimen es de $7.691 millones. El Estado tardó décadas en crear esta capacidad institucional. El dinero del Caso Inverlink habría podido financiarla durante 26 años seguidos.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 534 fiscales y funcionarios de la Fiscalía Supraterritorial durante un año —más de cinco veces su dotación actual. La Fiscalía persigue delitos que cruzan fronteras regionales y que el sistema regular no puede investigar. Existe desde 2024. El Pacogate operó durante once años antes de que el Estado tuviera una institución de ese tipo.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 172 fiscales y funcionarios de la Fiscalía Supraterritorial durante un año —prácticamente el doble de su dotación actual de 98 personas. Con ese refuerzo, la institución habría podido expandirse a las regiones donde aún no opera.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 206 fiscales y funcionarios de la Fiscalía Supraterritorial durante un año —más del doble de su dotación actual. La Fiscalía fue aprobada por unanimidad en la Cámara. El Estado sabía que la necesitaba. Tardó años en crearla y la creó con los recursos que pudo.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 136 fiscales y funcionarios de la Fiscalía Supraterritorial durante un año —casi 40% más que su dotación actual de 98 personas. La Fiscalía fue creada para perseguir delitos que el sistema regular no alcanza a cubrir. El Milicogate fue destapado por periodistas, no por el Estado. La capacidad institucional para detectar ese tipo de fraude dentro de las propias fuerzas armadas aún está en construcción."
  ),

  ds49 = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.359 viviendas sociales DS49 —entregadas sin deuda a familias del 40% más vulnerable. Es más de un tercio de todos los subsidios DS49 que el gobierno tiene presupuestados para entregar durante todo el año 2026.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.326 viviendas sociales DS49. El monto del Pacogate habría podido aumentar el plan anual del gobierno en un 7% en un solo año.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 427 viviendas sociales DS49. Son 427 familias que hoy siguen en lista de espera, allegadas o en campamentos.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 513 viviendas sociales DS49. Más de 500 familias que hoy esperan en la lista de SERVIU habrían podido recibir su subsidio y comenzar a construir su vivienda.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 337 viviendas sociales DS49. Trescientas treinta y siete familias con subsidio completo, sin deuda, con la posibilidad real de tener una vivienda propia."
  ),

  lista_espera = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 4 meses adicionales del programa DS49 al ritmo actual de entrega. El número puede parecer pequeño frente a un déficit de 492.000 viviendas. Pero así de grande es la escala del problema habitacional de Chile.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 25 días adicionales del programa DS49. Tres semanas y media más de subsidios habitacionales entregados a las familias más vulnerables del país.",
    sqm       = "Los $13.500 millones que SQM no tributó equivalen a 8 días adicionales del programa DS49. Ocho días en que el Estado habría podido seguir entregando subsidios habitacionales.",
    penta     = "Los $16.200 millones del Caso Penta equivalen a 9 días adicionales del programa DS49. La corrupción no solo roba dinero, roba tiempo.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército equivalen a 6 días adicionales del programa DS49."
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
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.698 funconarios adicionales en Tribunales de Familia durante un año. En 2024, el gobierno contrató más funcionarios con $11.000 millones. El monto de Inverlink habría multiplicado ese esfuerzo por 18.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.397 funcionarios adicionales en Tribunales de Familia durante un año. Son personas cuyo trabajo sería cobrar activamente la deuda de $2,5 billones que mujeres en Chile esperan recibir —dinero que un tribunal ya ordenó pagar y que el Estado no tiene capacidad de hacer efectivo.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 450 funcionarios adicionales en Tribunales de Familia durante un año. El Registro de Deudores Alimentarios existe desde 2022. Lo que falta es la capacidad institucional para ejecutarlo: funcionarios que conviertan las resoluciones judiciales en dinero real en las cuentas de mujeres que cargan solas con el costo de criar.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 540 funcionarios adicionales en Tribunales de Familia durante un año. Hay mujeres que llevan años con una resolución judicial que les da la razón y que aun así no reciben el dinero. La diferencia entre una sentencia y un depósito bancario es capacidad del Estado.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 355 funcionarios adicionales en Tribunales de Familia durante un año. Trescientas cincuenta y cinco personas cuyo trabajo sería acortar la distancia entre lo que la justicia ordenó y lo que las mujeres efectivamente reciben."
  ),

  acogida = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían permitido habilitar 670 Residencias Transitorias —19 veces las 35 que existen hoy en todo el país. El número revela la magnitud de lo que el Estado podría haber construido: una red de acogida capaz de responder a la violencia contra las mujeres en todos los territorios del país.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían permitido habilitar 140 Residencias Transitorias —cuatro veces las que existen hoy en el país. Carabineros es una de las instituciones que deriva a las mujeres a esas residencias cuando responde a llamados por violencia intrafamiliar.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían permitido habilitar 45 Residencias Transitorias —más que las 35 que existen hoy en todo Chile. Con el dinero que una empresa minera destinó a financiar ilegalmente la política durante seis años, el Estado habría podido aumentar en un 29% su capacidad de acogida.",
    penta     = "Los $16.200 millones del Caso Penta habrían permitido habilitar 54 Residencias Transitorias —un 54% más que las 35 actuales. Para una mujer que decide salir de una situación de violencia, la existencia de una residencia disponible en su región puede ser la diferencia entre salir y quedarse.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían permitido habilitar 36 Residencias Transitorias —prácticamente duplicar las que existen hoy en el país."
  ),

  justicia_vif = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado 6.698 profesionales especializados en VIF durante un año —el tipo de profesional que acompaña a una mujer desde la denuncia hasta la sentencia.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado 1.397 profesionales especializados en VIF durante un año. Más de 1.300 profesionales que habrían podido acompañar a víctimas de violencia intrafamiliar a través de un proceso judicial que hoy muchas abandonan por falta de apoyo.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado 450 profesionales especializados en VIF durante un año. Con el dinero que SQM destinó a financiar ilegalmente la política, el Estado habría podido dar ese apoyo a cientos de víctimas más.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado 540 profesionales especializados en VIF durante un año.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado 355 profesionales especializados en VIF durante un año. Más de 350 personas cuyo trabajo sería acompañar a víctimas de violencia intrafamiliar a través de un proceso judicial al que muchas renuncian por falta de apoyo."
  ),

  postnatal = list(
    inverlink = "Los $200.940 millones sustraídos de CORFO habrían financiado el postnatal masculino ampliado de 1.178.700 padres —30 días completos de subsidio. Son más de un millón de padres que habrían podido tomar un mes de postnatal, cuidar a sus hijos recién nacidos, y permitir que sus parejas tomaran las decisiones laborales que quisieran tomar.",
    pacogate  = "Los $41.898 millones malversados en Carabineros habrían financiado el postnatal masculino ampliado de 245.750 padres. La redistribución de la carga de cuidados no es solo un beneficio para los padres: es la política que más directamente reduce la penalización laboral que sufren las mujeres por ser madres.",
    sqm       = "Los $13.500 millones que SQM no tributó habrían financiado el postnatal masculino ampliado de 79.180 padres. En los países donde esta política existe con carácter obligatorio, la tasa de adopción por parte de los padres supera el 70%.",
    penta     = "Los $16.200 millones del Caso Penta habrían financiado el postnatal masculino ampliado de 95.050 padres. Casi 100.000 padres con un mes de postnatal propio.",
    milicogate = "Los $10.657 millones desviados de los fondos del Ejército habrían financiado el postnatal masculino ampliado de 62.510 padres."
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
  "Salud"      = "#E24B4A",
  "Educación"  = "#185FA5",
  "Pensiones"  = "#EF9F27",
  "Seguridad"  = "#8B5E3C",
  "Vivienda"   = "#1D9E75",
  "Género"     = "#7F77DD"
)

# Darker stroke colours per area (for SVG symbol borders)
colores_stroke <- c(
  "Salud"      = "#A32D2D",
  "Educación"  = "#0C447C",
  "Pensiones"  = "#854F0B",
  "Seguridad"  = "#5C3A20",
  "Vivienda"   = "#0F6E56",
  "Género"     = "#3C3489"
)

# SVG path/shape definitions for each area symbol (centred in 200x220 box)
svg_simbolo <- function(area, fill_color, stroke_color, fill_pct = NULL, show_ghost = FALSE) {
  # fill_pct: 0-1 for type A (proportional fill bottom-up)
  # show_ghost = TRUE: light grey ghost for type B background icon
  ghost_fill   <- if (show_ghost) "#E5E3DC" else fill_color
  ghost_stroke <- if (show_ghost) "#CDCBC2" else stroke_color
  ghost_opacity <- if (show_ghost) "0.55" else "1"

  # Animation id (unique per call based on random suffix to avoid CSS conflicts)
  anim_id <- paste0("fill_", gsub("[^a-z]", "", tolower(area)), "_", sample(1000:9999, 1))

  # Clip height for type A (bottom-up fill)
  clip_y  <- if (!is.null(fill_pct)) round(220 * (1 - min(fill_pct, 1))) else 0
  clip_h  <- 220 - clip_y

  clip_block <- if (!is.null(fill_pct)) {
    paste0(
      '<defs>',
      '<clipPath id="cp_', anim_id, '">',
      '<rect x="0" y="', clip_y, '" width="200" height="', clip_h, '"/>',
      '</clipPath>',
      '</defs>'
    )
  } else ""

  # ── Shape paths (centred in 200x220 viewBox) ────────────────────────────────
  shapes <- switch(area,

    "Salud" = {
      # Thick cross
      paste0(
        '<path d="M72,40 h56 v52 h52 v56 h-52 v52 h-56 v-52 h-52 v-56 h52 Z" ',
        'fill="', ghost_fill, '" stroke="', ghost_stroke, '" stroke-width="5" ',
        'stroke-linejoin="round" opacity="', ghost_opacity, '"/>'
      )
    },

    "Educación" = {
      # Open book (thick)
      paste0(
        # back cover
        '<rect x="20" y="30" width="160" height="175" rx="8" fill="', ghost_fill, '" ',
        'stroke="', ghost_stroke, '" stroke-width="5" opacity="', ghost_opacity, '"/>',
        # spine
        '<rect x="20" y="30" width="26" height="175" rx="6" fill="', ghost_stroke, '" opacity="', ghost_opacity, '"/>',
        # pages
        '<rect x="46" y="40" width="127" height="155" rx="3" fill="white" opacity="0.85"/>',
        # text lines
        '<line x1="62" y1="72" x2="162" y2="72" stroke="', ghost_fill, '" stroke-width="5" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        '<line x1="62" y1="96" x2="162" y2="96" stroke="', ghost_fill, '" stroke-width="5" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        '<line x1="62" y1="120" x2="162" y2="120" stroke="', ghost_fill, '" stroke-width="5" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        '<line x1="62" y1="144" x2="140" y2="144" stroke="', ghost_fill, '" stroke-width="3" stroke-linecap="round" opacity="0.4"/>',
        '<line x1="62" y1="164" x2="150" y2="164" stroke="', ghost_fill, '" stroke-width="3" stroke-linecap="round" opacity="0.4"/>'
      )
    },

    "Pensiones" = {
      # Gold coin with $ sign
      paste0(
        # outer circle
        '<circle cx="100" cy="110" r="88" fill="', ghost_fill, '" stroke="', ghost_stroke, '" stroke-width="5" opacity="', ghost_opacity, '"/>',
        # inner ring
        '<circle cx="100" cy="110" r="68" fill="none" stroke="', ghost_stroke, '" stroke-width="4" opacity="', ghost_opacity, '"/>',
        # $ vertical bar top
        '<line x1="100" y1="48" x2="100" y2="68" stroke="white" stroke-width="8" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # $ vertical bar bottom
        '<line x1="100" y1="152" x2="100" y2="172" stroke="white" stroke-width="8" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # $ top arc
        '<path d="M120,75 Q138,75 138,92 Q138,110 100,110" fill="none" stroke="white" stroke-width="10" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # $ bottom arc
        '<path d="M80,145 Q62,145 62,128 Q62,110 100,110" fill="none" stroke="white" stroke-width="10" stroke-linecap="round" opacity="', ghost_opacity, '"/>'
      )
    },

    "Seguridad" = {
      # Balance/scales (thick)
      paste0(
        # central pole
        '<line x1="100" y1="24" x2="100" y2="175" stroke="', ghost_fill, '" stroke-width="14" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # horizontal beam
        '<line x1="28" y1="58" x2="172" y2="58" stroke="', ghost_fill, '" stroke-width="14" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # left chain
        '<line x1="38" y1="58" x2="30" y2="112" stroke="', ghost_fill, '" stroke-width="8" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # right chain
        '<line x1="162" y1="58" x2="170" y2="112" stroke="', ghost_fill, '" stroke-width="8" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # left plate
        '<ellipse cx="28" cy="120" rx="40" ry="14" fill="', ghost_fill, '" opacity="', ghost_opacity, '"/>',
        # right plate
        '<ellipse cx="172" cy="120" rx="40" ry="14" fill="', ghost_fill, '" opacity="', ghost_opacity, '"/>',
        # base
        '<path d="M84,175 L116,175 L110,198 L90,198 Z" fill="', ghost_fill, '" opacity="', ghost_opacity, '"/>',
        '<line x1="72" y1="198" x2="128" y2="198" stroke="', ghost_fill, '" stroke-width="10" stroke-linecap="round" opacity="', ghost_opacity, '"/>'
      )
    },

    "Vivienda" = {
      # House (thick, solid)
      paste0(
        # roof
        '<path d="M100,22 L18,94 L182,94 Z" fill="', ghost_fill, '" stroke="', ghost_stroke, '" stroke-width="5" stroke-linejoin="round" opacity="', ghost_opacity, '"/>',
        # body
        '<rect x="32" y="92" width="136" height="110" rx="4" fill="', ghost_fill, '" stroke="', ghost_stroke, '" stroke-width="5" opacity="', ghost_opacity, '"/>',
        # door
        '<rect x="72" y="148" width="56" height="54" rx="5" fill="', ghost_stroke, '" opacity="', ghost_opacity, '"/>',
        # left window
        '<rect x="44" y="114" width="36" height="30" rx="4" fill="white" opacity="0.7"/>',
        # right window
        '<rect x="120" y="114" width="36" height="30" rx="4" fill="white" opacity="0.7"/>'
      )
    },

    "Género" = {
      # Venus symbol (thick stroke-based)
      paste0(
        # circle
        '<circle cx="100" cy="90" r="70" fill="none" stroke="', ghost_fill, '" stroke-width="20" opacity="', ghost_opacity, '"/>',
        # vertical line down
        '<line x1="100" y1="160" x2="100" y2="210" stroke="', ghost_fill, '" stroke-width="20" stroke-linecap="round" opacity="', ghost_opacity, '"/>',
        # horizontal crossbar
        '<line x1="64" y1="190" x2="136" y2="190" stroke="', ghost_fill, '" stroke-width="20" stroke-linecap="round" opacity="', ghost_opacity, '"/>'
      )
    }
  )

  if (is.null(shapes)) shapes <- paste0('<circle cx="100" cy="110" r="80" fill="', ghost_fill, '" opacity="', ghost_opacity, '"/>')

  # For type A: render ghost + coloured overlay with clipPath
  if (!is.null(fill_pct) && !show_ghost) {
    # ghost layer (full grey)
    ghost_shapes <- switch(area,
      "Salud"      = paste0('<path d="M72,40 h56 v52 h52 v56 h-52 v52 h-56 v-52 h-52 v-56 h52 Z" fill="#D3D1C7" stroke="#B4B2A9" stroke-width="5" stroke-linejoin="round"/>'),
      "Educación"  = paste0('<rect x="20" y="30" width="160" height="175" rx="8" fill="#D3D1C7" stroke="#B4B2A9" stroke-width="5"/><rect x="20" y="30" width="26" height="175" rx="6" fill="#B4B2A9"/>'),
      "Pensiones"  = paste0('<circle cx="100" cy="110" r="88" fill="#D3D1C7" stroke="#B4B2A9" stroke-width="5"/><circle cx="100" cy="110" r="68" fill="none" stroke="#B4B2A9" stroke-width="4"/><line x1="100" y1="48" x2="100" y2="68" stroke="white" stroke-width="8" stroke-linecap="round"/><line x1="100" y1="152" x2="100" y2="172" stroke="white" stroke-width="8" stroke-linecap="round"/><path d="M120,75 Q138,75 138,92 Q138,110 100,110" fill="none" stroke="white" stroke-width="10" stroke-linecap="round"/><path d="M80,145 Q62,145 62,128 Q62,110 100,110" fill="none" stroke="white" stroke-width="10" stroke-linecap="round"/>'),
      "Seguridad"  = paste0('<line x1="100" y1="24" x2="100" y2="175" stroke="#D3D1C7" stroke-width="14" stroke-linecap="round"/><line x1="28" y1="58" x2="172" y2="58" stroke="#D3D1C7" stroke-width="14" stroke-linecap="round"/><line x1="38" y1="58" x2="30" y2="112" stroke="#D3D1C7" stroke-width="8" stroke-linecap="round"/><line x1="162" y1="58" x2="170" y2="112" stroke="#D3D1C7" stroke-width="8" stroke-linecap="round"/><ellipse cx="28" cy="120" rx="40" ry="14" fill="#D3D1C7"/><ellipse cx="172" cy="120" rx="40" ry="14" fill="#D3D1C7"/><path d="M84,175 L116,175 L110,198 L90,198 Z" fill="#D3D1C7"/><line x1="72" y1="198" x2="128" y2="198" stroke="#D3D1C7" stroke-width="10" stroke-linecap="round"/>'),
      "Vivienda"   = paste0('<path d="M100,22 L18,94 L182,94 Z" fill="#D3D1C7" stroke="#B4B2A9" stroke-width="5" stroke-linejoin="round"/><rect x="32" y="92" width="136" height="110" rx="4" fill="#D3D1C7" stroke="#B4B2A9" stroke-width="5"/>'),
      "Género"     = paste0('<circle cx="100" cy="90" r="70" fill="none" stroke="#D3D1C7" stroke-width="20"/><line x1="100" y1="160" x2="100" y2="210" stroke="#D3D1C7" stroke-width="20" stroke-linecap="round"/><line x1="64" y1="190" x2="136" y2="190" stroke="#D3D1C7" stroke-width="20" stroke-linecap="round"/>'),
      paste0('<circle cx="100" cy="110" r="80" fill="#D3D1C7"/>')
    )

    paste0(
      '<svg width="200" height="220" viewBox="0 0 200 220" xmlns="http://www.w3.org/2000/svg">',
      clip_block,
      ghost_shapes,
      '<g clip-path="url(#cp_', anim_id, ')">', shapes, '</g>',
      '</svg>'
    )
  } else {
    paste0(
      '<svg width="200" height="220" viewBox="0 0 200 220" xmlns="http://www.w3.org/2000/svg">',
      shapes,
      '</svg>'
    )
  }
}

# ── Helper: format number ─────────────────────────────────────────────────────
fmt_num_r <- function(x) {
  if (x >= 1e6)      paste0(format(round(x / 1e6, 1), big.mark = "."), "M")
  else if (x >= 1e3) format(round(x), big.mark = ".")
  else               format(round(x, 1), big.mark = ".")
}


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
        p(tags$em("Esta aplicación tiene carácter exploratorio, educativo y ciudadano. Se reafirma que los escenarios que presenta son hipotéticos: no afirman que el dinero recuperado se habría destinado necesariamente a los fines que se describen, sino que ilustran la magnitud de lo que se perdió en términos de posibilidades concretas."))
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


    br(),

    # --- PARA LOS CHISMOSOS ---
    accordion(
      open = FALSE,
      accordion_panel(
        title = "Para los chismosos y la gente que tiene mala memoria",
        icon = bs_icon("eye"),

        p(style = "color:#6a5a45; margin-bottom:24px;",
          "La mala memoria es uno de los lujos que la corrupción más agradece. Esta sección existe para no permitírselo. ",
          "Los cinco casos que analiza este proyecto involucraron a decenas de personas: empresarios, ",
          "militares, políticos, funcionarios públicos y operadores. Muchos cumplieron condenas mínimas ",
          "o fueron sobreseídos. Algunos ocupan hoy cargos públicos o privados. Esta sección registra ",
          "quiénes estuvieron involucrados, qué rol cumplieron y qué pasó con ellos."
        ),

        accordion(
          open = FALSE,
          multiple = TRUE,

          # ── INVERLINK ──────────────────────────────────────────────────────
          accordion_panel(
            title = "Corfo-Inverlink",
            tags$div(style = "overflow-x:auto;",
              tags$table(class = "table table-sm", style = "font-size:0.83em;",
                tags$thead(style = "background-color:#F5F4E6;",
                  tags$tr(tags$th("Nombre"), tags$th("Rol"), tags$th("Condena"), tags$th("Cercanía política"))
                ),
                tags$tbody(
                  tags$tr(tags$td(tags$strong("Eduardo Monasterio Lara")),
                    tags$td("Presidente del holding Inverlink. Cabeza de la operación. Falleció en 2015 sin cumplir condena."),
                    tags$td("541 días remisión condicional"), tags$td("Empresario financiero.")),
                  tags$tr(tags$td(tags$strong("Enzo Bertinelli Villagra")),
                    tags$td("Gerente General de Inverlink. Receptor de información privilegiada del Banco Central. Relación sentimental con Pamela Andrada."),
                    tags$td("5 años de presidio"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Ignacio Wulf Hitschfeld")),
                    tags$td("Ejecutivo clave del holding. Partícipe de las operaciones fraudulentas."),
                    tags$td("5 años de presidio"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Francisco Edwards Braun")),
                    tags$td("Ejecutivo de Inverlink."),
                    tags$td("5 años de presidio"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Javier Moya Cucurella")),
                    tags$td("Tesorero de CORFO. Robó documentos de depósitos a plazo y los entregó a Inverlink."),
                    tags$td("800 días presidio + 5 años y un día (malversación)"), tags$td("Funcionario público.")),
                  tags$tr(tags$td(tags$strong("Pamela Andrada")),
                    tags$td("Secretaria del presidente del Banco Central. Filtró información reservada. Su error al reenviar un mail destapó el caso."),
                    tags$td("Condena en arista Banco Central"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Juan Pablo Prieto Viviani")),
                    tags$td("Ejecutivo de BBVA Corredora de Bolsa. Intermediario en operaciones trianguladas."),
                    tags$td("541 días remisión condicional"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Gino Tirapegui Palomino")),
                    tags$td("Ejecutivo de Scotiabank. Intermediario. Scotiabank pagó $3.000 MM extrajudicialmente."),
                    tags$td("541 días remisión condicional"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Gonzalo Rivas")),
                    tags$td("Vicepresidente ejecutivo de CORFO. Yerno del presidente Ricardo Lagos. Renunció por responsabilidad política. Sin formalización."),
                    tags$td("Sin condena"), tags$td(tags$strong("DC / Lagos. Hoy trabaja en el BID."))),
                  tags$tr(tags$td(tags$strong("Carlos Massad")),
                    tags$td("Presidente del Banco Central. Descubrió el caso, pero el escándalo comprometió su gestión. Renunció."),
                    tags$td("Sin condena"), tags$td(tags$strong("DC. Cercano al gobierno de Lagos."))),
                  tags$tr(tags$td(tags$strong("Álvaro Clarke")),
                    tags$td("Superintendente de Valores y Seguros (SVS). Renunció tras el escándalo."),
                    tags$td("Sin condena"), tags$td("Cercano al gobierno de Lagos.")),
                  tags$tr(tags$td(tags$strong("Álvaro García")),
                    tags$td("Exministro de Economía (gobierno de Frei). Procesado por complicidad en estafa. Habría pedido al alcalde de Viña del Mar no retirar un depósito de $1.500 MM en Inverlink."),
                    tags$td("Procesado, no condenado"), tags$td(tags$strong("PPD. Ministro de Frei. Nombrado en gobierno de Boric.")))
                )
              )
            )
          ),

          # ── PACOGATE ──────────────────────────────────────────────────────
          accordion_panel(
            title = "Pacogate",
            tags$div(style = "overflow-x:auto;",
              tags$table(class = "table table-sm", style = "font-size:0.83em;",
                tags$thead(style = "background-color:#F5F4E6;",
                  tags$tr(tags$th("Nombre"), tags$th("Rol"), tags$th("Estado"), tags$th("Contexto"))
                ),
                tags$tbody(
                  tags$tr(tags$td(tags$strong("Héctor Nail Becerra")),
                    tags$td("Coronel. Principal reclutador y organizador del fraude en la Unidad de Intendencia. Distribuía el dinero malversado."),
                    tags$td("Condenado en juicio oral"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Jaime Paz Meneses")),
                    tags$td("Coronel. Liderazgo ejecutivo de la asociación ilícita. Impartía instrucciones sobre montos a sustraer."),
                    tags$td("Condenado en juicio oral"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Fernando Pérez Barría")),
                    tags$td("Coronel. Malversó a lo menos $1.002 MM. Mayor número de préstamos irregulares del Fondo Habitacional (13 préstamos, $137,5 MM)."),
                    tags$td("Condenado en juicio oral"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Francisco Estrada Castro")),
                    tags$td("Capitán. Uno de los oficiales ejecutores en la cadena de mando del fraude."),
                    tags$td("Condenado"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Marcela Cuevas")),
                    tags$td("Capitán. Departamento de Relaciones Públicas. Cómplice de Gordon en arista gastos reservados."),
                    tags$td(tags$strong("Condenada (nov. 2024): 2 años, reclusión parcial")), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Eduardo Gordon Valcárcel")),
                    tags$td("General director de Carabineros (2008–2011). El uniformado de mayor rango condenado hasta la fecha."),
                    tags$td(tags$strong("Condenado (oct. 2024): 3 años y un día, libertad vigilada")),
                    tags$td("Gestión bajo Concertación y primer Piñera.")),
                  tags$tr(tags$td(tags$strong("Flavio Echeverría Cortez")),
                    tags$td("General. Exjefe de la Unidad de Intendencia. Ignoró la alerta del BancoEstado en 2015. Solicitado: 15 años y un día."),
                    tags$td("Juicio pendiente (acusado)"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Raúl Albayay Tapia")),
                    tags$td("Teniente coronel. Excontador jefe del Departamento de Finanzas. Intentó eludir arresto devolviendo $70 MM."),
                    tags$td("Procesado, juicio pendiente"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Iván Whipple Mejías")),
                    tags$td("General. Exdirector de finanzas de Carabineros. Acusado de 5 delitos reiterados de malversación. Fiscalía pide 15 años y un día."),
                    tags$td("Juicio pendiente (acusado)"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Gustavo González Jure")),
                    tags$td("General director (2011–2015). 9 delitos de malversación y 4 de falsificación. Fiscalía pide 24 años."),
                    tags$td("Juicio pendiente (acusado)"), tags$td("Gestión bajo segundo Piñera.")),
                  tags$tr(tags$td(tags$strong("Bruno Villalobos Krumm")),
                    tags$td("General director (2015–2018). Reconoció el fraude públicamente en 2017. También acusado de malversación de gastos reservados. Fiscalía pide 24 años."),
                    tags$td("Juicio pendiente (acusado)"), tags$td("Gestión bajo segunda Bachelet y Piñera.")),
                  tags$tr(tags$td(tags$strong("Hugo Zúñiga Pailamilla")),
                    tags$td("Civil. Exjefe Dirección de Presupuestos del Ministerio de Hacienda. La trama alcanzó más allá de Carabineros."),
                    tags$td("Acusado, proceso activo"), tags$td("Funcionario público.")),
                  tags$tr(tags$td(tags$strong("Juan Munieres")),
                    tags$td("Civil. Exfuncionario de la Contraloría. Depósitos irregulares por $300 MM a través de terceros."),
                    tags$td("Acusado, proceso activo"), tags$td("Exfuncionario de Contraloría."))
                )
              )
            )
          ),

          # ── SQM ───────────────────────────────────────────────────────────
          accordion_panel(
            title = "Caso SQM",
            tags$div(style = "overflow-x:auto;",
              tags$table(class = "table table-sm", style = "font-size:0.83em;",
                tags$thead(style = "background-color:#F5F4E6;",
                  tags$tr(tags$th("Nombre"), tags$th("Rol"), tags$th("Estado"), tags$th("Cercanía política"))
                ),
                tags$tbody(
                  tags$tr(tags$td(tags$strong("Julio Ponce Lerou")),
                    tags$td("Controlador y presidente de SQM. Yerno de Augusto Pinochet. Beneficiario del sistema de financiamiento político."),
                    tags$td("Sin formalización"), tags$td(tags$strong("Conexión directa con la dictadura militar."))),
                  tags$tr(tags$td(tags$strong("Patricio Contesse González")),
                    tags$td("Gerente general de SQM por 25 años. Ejecutor directo del 97% de los pagos ilegales."),
                    tags$td(tags$strong("Absuelto octubre 2025")), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Giorgio Martelli")),
                    tags$td("Operador y recaudador político. Canalizó fondos de SQM hacia campañas de Frei y Bachelet. Monto recibido: +$342 MM."),
                    tags$td("800 días pena cumplida en libertad + multa ~$3 MM"), tags$td(tags$strong("DC / PS. Operador de la Concertación."))),
                  tags$tr(tags$td(tags$strong("Clara Bensan")),
                    tags$td("Contadora. Gestionó boletas falsas vinculadas a la campaña presidencial de Frei."),
                    tags$td("Condena en juicio abreviado"), tags$td("Ligada a DC.")),
                  tags$tr(tags$td(tags$strong("Pablo Zalaquett")),
                    tags$td("Exalcalde de Santiago. Receptor indirecto de fondos para campaña senatorial 2013. También involucrado en Caso Penta."),
                    tags$td("Condena en juicio abreviado"), tags$td(tags$strong("UDI. Exalcalde de Santiago."))),
                  tags$tr(tags$td(tags$strong("Pablo Longueira")),
                    tags$td("Identificado por el DOJ de EE.UU. como 'funcionario chileno 2'. Receptor de pagos directos."),
                    tags$td(tags$strong("Absuelto octubre 2025")), tags$td(tags$strong("UDI. Exsenador, exministro de Economía."))),
                  tags$tr(tags$td(tags$strong("Marco Enríquez-Ominami")),
                    tags$td("Receptor de pagos canalizados a través de la Fundación Progresa."),
                    tags$td(tags$strong("Absuelto octubre 2025")), tags$td(tags$strong("PRO. Candidato presidencial 2009 y 2013."))),
                  tags$tr(tags$td(tags$strong("Jaime Orpis")),
                    tags$td("Identificado por el DOJ de EE.UU. como 'funcionario chileno 1'."),
                    tags$td(tags$strong("Absuelto octubre 2025")), tags$td(tags$strong("UDI. Senador."))),
                  tags$tr(tags$td(tags$strong("Pablo Wagner")),
                    tags$td("Identificado por el DOJ como 'funcionario chileno 3'. Su cuñada recibió pagos para la campaña de Joaquín Lavín. Nodo de conexión con el Caso Penta."),
                    tags$td(tags$strong("Absuelto octubre 2025")), tags$td(tags$strong("UDI. Exsubsecretario de Minería."))),
                  tags$tr(tags$td(tags$strong("Rodrigo Peñailillo")),
                    tags$td("Exministro del Interior (Bachelet II). El SII no presentó querella. Encabezó las presiones sobre el SII en 2015 para frenar la investigación."),
                    tags$td("Sin formalización"), tags$td(tags$strong("PPD. Exministro del Interior."))),
                  tags$tr(tags$td(tags$strong("Alberto Arenas")),
                    tags$td("Exministro de Hacienda (Bachelet II). Co-encabezó las presiones al SII junto a Peñailillo."),
                    tags$td("Sin formalización"), tags$td(tags$strong("PS. Exministro de Hacienda."))),
                  tags$tr(tags$td(tags$strong("Fulvio Rossi")),
                    tags$td("Exsenador. La Corte Suprema rechazó su desafuero en 2018."),
                    tags$td("Sin condena"), tags$td(tags$strong("PS. Exsenador."))),
                  tags$tr(tags$td(tags$strong("Jorge Pizarro")),
                    tags$td("Vicepresidente del Senado. Sus hijos Jorge y Benjamín Pizarro Cristi escaparon del proceso por inacción del SII."),
                    tags$td("Sin formalización (él ni sus hijos)"), tags$td(tags$strong("DC. Vicepresidente del Senado."))),
                  tags$tr(tags$td(tags$strong("Harold Correa")),
                    tags$td("Exjefe de gabinete del exministro Nicolás Eyzaguirre. El SII no presentó querella."),
                    tags$td("Sin formalización"), tags$td(tags$strong("PPD.")))
                )
              )
            )
          ),

          # ── PENTA ─────────────────────────────────────────────────────────
          accordion_panel(
            title = "Caso Penta",
            tags$div(style = "overflow-x:auto;",
              tags$table(class = "table table-sm", style = "font-size:0.83em;",
                tags$thead(style = "background-color:#F5F4E6;",
                  tags$tr(tags$th("Nombre"), tags$th("Rol"), tags$th("Estado"), tags$th("Cercanía política"))
                ),
                tags$tbody(
                  tags$tr(tags$td(tags$strong("Carlos Alberto Délano Abbott")),
                    tags$td("Controlador del Grupo Penta. Principal organizador. Amigo personal declarado de Sebastián Piñera."),
                    tags$td("4 años libertad vigilada + multa $857 MM. Cumplida julio 2022. Curso de ética en la UAI."),
                    tags$td(tags$strong("Empresario. Donante histórico UDI y RN. Amigo personal de Piñera."))),
                  tags$tr(tags$td(tags$strong("Carlos Eugenio Lavín García-Huidobro")),
                    tags$td("Controlador del Grupo Penta. Coorganizador junto a Délano."),
                    tags$td("4 años libertad vigilada + multa $857 MM. Cumplida julio 2022."),
                    tags$td("Sin militancia conocida. Empresario.")),
                  tags$tr(tags$td(tags$strong("Hugo Bravo López")),
                    tags$td("Exgerente general de Penta. Quien reveló ante la Fiscalía los pagos a políticos UDI. Fue él quien destapó el caso al declarar."),
                    tags$td("Condena en procedimiento abreviado"), tags$td("Sin militancia conocida. Ejecutivo corporativo.")),
                  tags$tr(tags$td(tags$strong("Marcos Castro")),
                    tags$td("Exgerente de Penta. Ejecutor contable del sistema de boletas falsas."),
                    tags$td("Condena en procedimiento abreviado"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Orlando Carvajal")),
                    tags$td("Contador. Primera condena del caso (antes que Novoa): 5 años libertad vigilada por fraude tributario y soborno."),
                    tags$td("5 años libertad vigilada. Primera sentencia del caso."), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Jovino Novoa Vásquez")),
                    tags$td("Exsenador y expresidente de la UDI. Facilitó 17 boletas falsas a Penta entre 2008 y 2013. Firmó mensualmente en el Centro de Reinserción Social de Ñuñoa."),
                    tags$td("3 años presidio menor, pena remitida + multa $7,6 MM. Cumplida marzo 2019."),
                    tags$td(tags$strong("UDI. Expresidente del partido."))),
                  tags$tr(tags$td(tags$strong("Pablo Wagner Rodríguez")),
                    tags$td("Exsubsecretario de Minería (2010–2012). Recibió $66 MM de Penta a través de boletas a nombre de su cuñada mientras ejercía el cargo."),
                    tags$td("2 años pena remitida + 3 años inhabilitación."),
                    tags$td(tags$strong("UDI. Renunció a militancia en enero 2015."))),
                  tags$tr(tags$td(tags$strong("Iván Moreira Barros")),
                    tags$td("Senador UDI. Facilitó boletas falsas por $35 MM para campaña senatorial 2013."),
                    tags$td("Sobreseído (febrero 2019) tras suspensión condicional + multa $35 MM."),
                    tags$td(tags$strong("UDI. Senador."))),
                  tags$tr(tags$td(tags$strong("Laurence Golborne Riveros")),
                    tags$td("Exministro de Obras Públicas y ex precandidato presidencial. Penta financió su campaña presidencial."),
                    tags$td("Suspensión condicional (sept. 2019) + pago $11,4 MM. Sobreseído al año."),
                    tags$td(tags$strong("UDI. Exministro de Piñera. Precandidato presidencial."))),
                  tags$tr(tags$td(tags$strong("Felipe De Mussy Hiriart")),
                    tags$td("Diputado UDI. Imputado por financiamiento irregular."),
                    tags$td("Salida alternativa. Sobreseído."), tags$td(tags$strong("UDI. Diputado."))),
                  tags$tr(tags$td(tags$strong("Pablo Zalaquett Said")),
                    tags$td("Exalcalde de Santiago. Receptor de fondos canalizados a través de empresas vinculadas. También involucrado en Caso SQM."),
                    tags$td("Salida alternativa."), tags$td(tags$strong("UDI. Exalcalde de Santiago."))),
                  tags$tr(tags$td(tags$strong("Alberto Cardemil Herrera")),
                    tags$td("Exdiputado RN. Penta habría financiado su campaña a través de dos abogados como intermediarios."),
                    tags$td("Salida alternativa."), tags$td(tags$strong("RN. Exdiputado."))),
                  tags$tr(tags$td(tags$strong("Alberto Undurraga Vicuña")),
                    tags$td("Diputado DC. La Fundación Ciudad Justa, que presidió, recibió pagos de Penta por un estudio."),
                    tags$td("Sin formalización. Desvinculado del caso."),
                    tags$td(tags$strong("DC. Diputado. Posterior ministro de Obras Públicas de Bachelet II."))),
                  tags$tr(tags$td(tags$strong("Ena Von Baer Jahn")),
                    tags$td("Senadora UDI. Mencionada en correos como beneficiaria. Citada a declarar. Negó irregularidades."),
                    tags$td("Sin formalización."), tags$td(tags$strong("UDI. Senadora."))),
                  tags$tr(tags$td(tags$strong("Andrés Velasco Brañes")),
                    tags$td("Ex precandidato presidencial. PDI allanó su domicilio. Declaró ante Fiscalía."),
                    tags$td("Sin formalización."), tags$td(tags$strong("Independiente. Ex precandidato presidencial."))),
                  tags$tr(tags$td(tags$strong("Ernesto Silva Méndez")),
                    tags$td("Extimonel de la UDI. Renunció a la directiva en marzo 2015."),
                    tags$td("Sin formalización."), tags$td(tags$strong("UDI. Extimonel del partido.")))
                )
              )
            )
          ),

          # ── MILICOGATE ────────────────────────────────────────────────────
          accordion_panel(
            title = "Milicogate",
            tags$div(style = "overflow-x:auto;",
              tags$table(class = "table table-sm", style = "font-size:0.83em;",
                tags$thead(style = "background-color:#F5F4E6;",
                  tags$tr(tags$th("Nombre"), tags$th("Rol"), tags$th("Estado"), tags$th("Contexto"))
                ),
                tags$tbody(
                  tags$tr(tags$td(tags$strong("Juan Carlos Cruz")),
                    tags$td("Cabo del Departamento de Apoyo y Planificación Financiera. Ejecutor clave del sistema de facturas falsas. Gastó más de $140 MM en el casino Monticello."),
                    tags$td(tags$strong("12 años de presidio (febrero 2020)")), tags$td("Suboficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Liliana Villagrán Vásquez")),
                    tags$td("Exsargento. Parte de la red de ejecución del fraude en la misma unidad que Cruz."),
                    tags$td(tags$strong("10 años y un día de presidio (febrero 2020)")), tags$td("Suboficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Clovis Montero")),
                    tags$td("Exteniente coronel. Extesorero del Estado Mayor. Delató a sus superiores en 11 páginas manuscritas. Fue procesado pese a declarar."),
                    tags$td("Procesado / condena en tramitación"), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Raúl Fuentes Quintanilla")),
                    tags$td("Civil. Proveedor externo del Ejército. Principal ejecutor de la emisión de facturas falsas."),
                    tags$td("Procesado / condena en tramitación"), tags$td("Sin militancia conocida.")),
                  tags$tr(tags$td(tags$strong("Juan Miguel Fuente-Alba Poblete")),
                    tags$td("Excomandante en jefe del Ejército (2010–2014). El imputado de mayor rango. Fiscalía acusó desvío de ~$7.000 MM para uso personal."),
                    tags$td(tags$strong("Absuelto mayo 2024. Ratificado Corte Suprema febrero 2026. Causa militar abierta.")),
                    tags$td("Asumió en los albores del primer gobierno de Piñera.")),
                  tags$tr(tags$td(tags$strong("Anita María Pinochet")),
                    tags$td("Esposa de Fuente-Alba. Acusada de blanquear el dinero defraudado. Apodada 'la Lucía chica' por la prensa."),
                    tags$td(tags$strong("Absuelta mayo 2024. Ratificado Corte Suprema febrero 2026.")),
                    tags$td("Apellido vinculado a la familia del dictador.")),
                  tags$tr(tags$td(tags$strong("Héctor Ureta Chinchón")),
                    tags$td("General en retiro. Excomandante de la División de Mantenimiento. Primer general de alto rango procesado."),
                    tags$td("Procesado. Causa activa en justicia militar."), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Antonio Cordero Kehr")),
                    tags$td("General en retiro. Comando de Apoyo a la Fuerza (CAF) 2011–2014. Procesado por incumplimiento de deberes militares."),
                    tags$td("Procesado. Libertad provisional concedida por Corte Marcial."), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Jorge Salas Kurte")),
                    tags$td("General en retiro. Comando de Apoyo a la Fuerza. Exjefe de escoltas de Pinochet y de su esposa Lucía Hiriart."),
                    tags$td("Procesado. Libertad provisional."),
                    tags$td(tags$strong("Vínculos directos a la familia Pinochet."))),
                  tags$tr(tags$td(tags$strong("Miguel Muñoz Farías")),
                    tags$td("General en retiro. Pertenecía al Comando de Apoyo a la Fuerza (CAF). Procesado."),
                    tags$td("Procesado. Libertad provisional."), tags$td("Oficial de carrera.")),
                  tags$tr(tags$td(tags$strong("Humberto Oviedo Arriagada")),
                    tags$td("General. Sucesor de Fuente-Alba como comandante en jefe (2014–2018). Formalizado por lavado de activos sobre $240 MM."),
                    tags$td("Formalizado. Proceso activo."),
                    tags$td("Su gestión abarcó el segundo gobierno de Bachelet y parte del segundo de Piñera."))
                )
              )
            )
          )
        )
      )
    ),

    br(),

    # --- PODER Y RELACIONES TÓXICAS ---
    accordion(
      open = FALSE,
      accordion_panel(
        title = "Poder y relaciones tóxicas",
        icon = bs_icon("diagram-3-fill"),

        # ── Párrafos narrativos ──────────────────────────────────────────────
        div(style = "margin-bottom: 28px;",
          p(style = "color:#4B3621; line-height:1.8; margin-bottom:16px;",
            "Todos conocemos relaciones tóxicas. La cultura popular tiene sus clásicos: la princesa Diana y el príncipe Carlos, Bella y Edward —seamos honestos—, o esa entre tú, el café y las notificaciones del celular que nadie termina de cortar. Pero si hay una relación cuya toxicidad debería preocuparnos antes que afecte a todos, es la que se establece entre el poder político y el poder económico. Los casos Penta y SQM revelaron un sistema de intercambio entre el poder económico y el poder político que funcionaba con reglas propias, no escritas y con participantes de todos los partidos."
          ),
          p(style = "color:#4B3621; line-height:1.8; margin-bottom:16px;",
            "Lo que destaparon estos casos fue una red de relaciones entre el poder económico, el poder político y el poder judicial que funcionaba con lógicas propias, invisibles para la ciudadanía. Pablo Wagner salía de Penta para entrar al gobierno de Piñera, y mientras era subsecretario de Minería seguía recibiendo pagos de Penta y asesorando a la familia Délano sobre cómo presentar el proyecto Dominga al mismo ministerio que él encabezaba. Jorge Abbott llegó a Fiscal Nacional después de reunirse en secreto con senadores UDI para negociar salidas procesales a imputados del Caso Penta. Manuel Guerra, el fiscal que manejaba esas causas, coordinaba con el abogado Luis Hermosilla qué hacer con los casos. Andrés Chadwick, exministro del interior y socio de Hermosilla, aparecía en esos chats como contacto clave. Estos son solo algunos de los casos documentados."
          )
        ),

        # ── Leyenda de colores ───────────────────────────────────────────────
        div(style = "display:flex; flex-wrap:wrap; gap:12px; margin-bottom:16px; align-items:center;",
          tags$span(style = "font-size:0.8rem; color:#8a7a6a; margin-right:4px;", "Grupos:"),
          tags$span(style = "background:#D97B2A; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Penta"),
          tags$span(style = "background:#2C9E6B; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "SQM"),
          tags$span(style = "background:#2A7BD9; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Chile Vamos"),
          tags$span(style = "background:#D43B3B; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Nueva Mayoría"),
          tags$span(style = "background:#7B3FA8; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Red Judicial"),
          tags$span(style = "background:#8B7355; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Entorno empresarial"),
          tags$span(style = "background:#4A7A9B; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Caso Audios"),
          tags$span(style = "background:#6B6B6B; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Independiente"),
          tags$span(style = "background:#B8860B; color:white; padding:3px 10px; border-radius:12px; font-size:0.78rem;", "Contexto histórico")
        ),
        p(style = "font-size:0.78rem; color:#aaa; margin-bottom:18px;",
          "Haz clic en un nodo para ver información del personaje. Puedes arrastrar los nodos para reorganizar la red. Las conexiones muestran hechos documentados periodística o judicialmente. No todas implican condena ni responsabilidad penal."
        ),

        # ── Red visNetwork ───────────────────────────────────────────────────
        fluidRow(
          column(8,
            visNetworkOutput("red_poder", height = "600px")
          ),
          column(4,
            uiOutput("panel_nodo")
          )
        ),

        # ── Párrafo de cierre ────────────────────────────────────────────────
        div(style = "margin-top:32px; border-top:1px solid #E5E4D0; padding-top:24px;",
          p(style = "color:#4B3621; line-height:1.8; font-style:italic;",
            "Ninguno de los actores de esta red firmó un pacto. La cohesión venía de una estructura formada en décadas de proximidad entre personas que se conocen, se deben favores, comparten intereses y comparten la convicción implícita de que las reglas que aplican a los demás no aplican necesariamente a ellos. El Caso Audios demostró que la red seguía activa: Hermosilla, Chadwick, Abbott, Guerra —nombres que ya cruzaban los expedientes de Penta y SQM— volvían a aparecer, esta vez en mensajes de WhatsApp."
          )
        )
      )
    ),

    br(),

    # --- CONCLUSIÓN ---
    h2("La democracia tiene un costo. No actuar, también.", class = "section-title"),
    div(id = "conclusion",
      p("El objetivo de este proyecto es traducir el daño de la corrupción en términos concretos. Eso se ha logrado: cada peso defraudado se midió contra treinta realidades distintas del país. Pero los números revelaron algo más, de manera involuntaria: la magnitud de las crisis sociales que el Estado enfrenta es tan grande que ninguno de estos casos —ni todos juntos— habría bastado para cerrar alguna de las principales brechas. La corrupción no explica la crisis habitacional, ni la de salud mental, ni la de pensiones. Pero las agrava. Y en un Estado con recursos escasos, cada peso desviado es un peso que no llegó a quien más lo necesitaba."),
      p("Hablar del costo económico de la corrupción sin hablar de sus protagonistas puede volverse una abstracción cómoda. La última encuesta CEP (septiembre-octubre 2025) indica que el 29% de los encuestados considera el autoritarismo preferible en algunas circunstancias. No es posible afirmar que la corrupción es el único factor que explica esa tendencia, pero es uno de sus pilares: el desencanto se construye sobre la percepción, muchas veces fundada, de que las reglas no se aplican de manera igual para todos. Como quedó documentado en la sección anterior, en 3 de los 5 casos analizados la mayoría de los principales imputados no eran políticos: eran empresarios, ejecutivos, contadores, oficiales. No son todos políticos. Pero tienen algo en común: son poderosos."),
      p("Este proyecto también se erige como una defensa de la democracia. No porque la democracia sea perfecta —estos casos ocurrieron en democracia, y en varios de ellos la impunidad fue también un producto de fallas en el sistema democrático. Pero la democracia es el único sistema que permite nombrar lo que pasó, investigarlo, documentarlo y exigir que no vuelva a ocurrir. Solo en democracia, con fiscalización ciudadana activa, es posible ejercer presión para que los responsables respondan. No actuar porque el resultado parezca incierto es ser cómplice, por omisión, del costo que esa inacción transfiere a quienes menos pueden asumirlo.")
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
      p("Auditoría Ciudadana · Cristián Salinas · Chile 2026", style = "font-size: 0.8em; color: #8B4513;")
    )
  )
)

# ==============================================================================
# 4b. DATOS DE LA RED DE PODER
# ==============================================================================

red_colores <- c(
  penta         = "#D97B2A",
  sqm           = "#2C9E6B",
  chilevamos    = "#2A7BD9",
  nuevamayoria  = "#D43B3B",
  judicial      = "#7B3FA8",
  empresarial   = "#8B7355",
  independiente = "#6B6B6B",
  contexto      = "#B8860B"
)

red_grupos_label <- c(
  penta         = "Penta",
  sqm           = "SQM",
  chilevamos    = "Chile Vamos",
  nuevamayoria  = "Nueva Mayoria",
  judicial      = "Red Judicial",
  empresarial   = "Entorno empresarial",
  independiente = "Independiente",
  contexto      = "Contexto histórico"
)

red_nodos <- tibble::tribble(
  ~id,             ~label,                  ~grupo,          ~rol,                                                                                                                                                                                                                                                ~conexion,                                                                                                                                                                                                                                                                                          ~estado,

  # ── PENTA ───────────────────────────────────────────────────────────────────
  "delano",        "Carlos\nDelano",         "penta",         "Controlador del Grupo Penta. Principal organizador del sistema de boletas falsas para financiamiento político ilegal. Dueño del 85% de Andes Iron, titular del proyecto minero Dominga.",                                                          "Amigo personal declarado de Sebastian Pinera. Contrato a Pablo Wagner como asesor de Dominga mientras era subsecretario de Minería. La familia Delano le pidio a Wagner que los ayudara a presentar el proyecto ante el Ministerio de Minería.",                                                           "Condenado 2018: 4 años libertad vigilada + multa $857 MM. Condena cumplida julio 2022 tras curso de etica en la UAI.",
  "lavin",         "Carlos\nLavin",          "penta",         "Controlador del Grupo Penta junto a Delano. Coorganizador del sistema de financiamiento político ilegal.",                                                                                                                                         "Socio directo de Delano en el holding financiero. Junto a Delano financiaron campañas principalmente de la UDI a traves de boletas ideológicamente falsas.",                                                                                                                                               "Condenado 2018: 4 años libertad vigilada + multa $857 MM. Condena cumplida julio 2022.",
  "bravo",         "Hugo\nBravo (+)",        "penta",         "Exgerente general de Penta. Delato a sus superiores ante la Fiscalia, revelando los pagos a políticos UDI. Principal informante del fiscal Gajardo.",                                                                                              "Su declaración ante la Fiscalia fue el hito que destapo el entramado político completo del caso.",                                                                                                                                                                                                        "Fallecio en 2017 antes del juicio abreviado.",
  "castro",        "Marcos\nCastro",         "penta",         "Exgerente de Penta. Ejecutor contable del sistema de boletas falsas.",                                                                                                                                                                             "Ejecutor directo del sistema de facturas ideológicamente falsas que financiaban la política.",                                                                                                                                                                                                             "Condena en procedimiento abreviado.",
  "carvajal",      "Orlando\nCarvajal",      "penta",         "Contador del grupo. Primera condena del caso: 5 años libertad vigilada por fraude tributario y soborno.",                                                                                                                                          "Primer condenado del Caso Penta, antes incluso que Novoa. Ejecutor contable en los escalones medios del sistema.",                                                                                                                                                                                        "5 años libertad vigilada.",
  "alvarez",       "Ivan\nAlvarez",          "penta",         "Exfuncionario del SII. Reconocio cargos de delitos tributarios, cohecho y lavado de activos.",                                                                                                                                                     "Punto de contacto entre el grupo empresarial y el Servicio de Impuestos Internos. Su participación ilustra como el sistema de corrupcion penetraba en los organismos fiscalizadores del Estado.",                                                                                                         "Condenado a 5 años de libertad vigilada intensiva.",

  # ── SQM ─────────────────────────────────────────────────────────────────────
  "ponce",         "Julio\nPonce Lerou",     "sqm",           "Controlador y presidente de SQM. Yerno del dictador Augusto Pinochet. Obtuvo el control de SQM durante la dictadura a traves de privatizaciónes cuestionadas y del Caso Cascadas.",                                                               "El Caso Cascadas (2013) reveló que Ponce Lerou usó sociedades instrumentales para manipular el precio de las acciónes de SQM en bolsa, transfiriendo riqueza desde los acciónistas minoritarios (incluidos trabajadores de la empresa) hacia si mismo. Ese esquema le permitio consolidar su control sobre SQM y acumular el poder que luego uso para financiar ilegalmente la política.",  "Sin formalización en la causa principal de SQM. Multado por la CMF en el Caso Cascadas. Renunció a la presidencia de SQM en 2015.",
  "contesse",      "Patricio\nContesse",     "sqm",           "Exgerente general de SQM por 25 años. Ejecutor directo del 97% de los pagos ilegales a políticos.",                                                                                                                                                "Declaró en 2018 que estimo necesario apoyar la actividad política bajo cierto marco que iba más allá del Servel. Fue el operador ejecutivo del sistema que distribuia los fondos a todo el espectro político.",                                                                                            "Absuelto en octubre de 2025. Desvinculado de SQM.",

  # ── ENTORNO EMPRESARIAL ──────────────────────────────────────────────────────
  "cruzat",        "Manuel\nCruzat",         "empresarial",   "Empresario. Mentor de Delano, Lavin y Bravo, a quienes hizo clases en la UC, recluto para sus empresas y de quienes luego fue competidor.",                                                                                                        "Involucrado en contratos forward con Penta. Declaró ante la Fiscalia. Su figura ilustra los lazos entre las élites económicas que anteceden y moldean a los protagonistas de los casos.",                                                                                                                  "Declaró ante la Fiscalia. Sin condena en las causas vinculadas a Penta.",
  "pinera",        "Sebastian\nPinera (+)",  "empresarial",   "Expresidente de Chile (2010-2014 y 2018-2022). Amigo personal declarado de Carlos Delano. Fallecio en febrero de 2024.",                                                                                                                           "Los chats de Guerra y Hermosilla lo mencionan en relación a Dominga y Penta. Una sociedad suya tenia un contrato forward con Penta desde 2009. Convocó a Pablo Wagner como subsecretario de Minería. Llamó a Jorge Abbott al cargo de Fiscal Nacional.",                                                   "Nuñca formalizado. Fallecio el 6 de febrero de 2024.",
  "dominga",       "Proyecto\nDominga",      "empresarial",   "Proyecto minero de la familia Delano (Andes Iron), ubicado en la Region de Coquimbo. Requeria aprobacion ambiental del Estado.",                                                                                                                   "Pablo Wagner, mientras era subsecretario de Minería pagado con fondos de Penta, asesoro a la familia Delano sobre como presentar el proyecto Dominga ante el Ministerio de Minería. El proyecto fue aprobado en primera instancia en 2017 y rechazado en segunda. Los chats del Caso Audios mencionan a Pinera en relación con el proyecto.",                                                               "Proyecto sin aprobacion ambiental definitiva. Conexion documentada en el Caso Audios.",

  # ── CHILE VAMOS ─────────────────────────────────────────────────────────────
  "novoa",         "Jovino\nNovoa",          "chilevamos",    "Exsenador y expresidente de la UDI. Decidia a que candidatos del partido asignar los fondos de Penta. Facilitó 17 boletas falsas entre 2008 y 2013.",                                                                                              "Figura histórica del gremialismo y ex secretario general del gobierno de Pinochet. Su condena en Penta fue negociada en reunion secreta entre Abbott, Larraín y Zumelzu.",                                                                                                                                "Condenado Caso Penta: 3 años presidió menor pena remitida + multa $7,6 MM. Firmó mensualmente en CRS de Nuñoa. Condena cumplida marzo 2019.",
  "wagner",        "Pablo\nWagner",          "chilevamos",    "Exsubsecretario de Minería del primer gobierno de Pinera (2010-2012). Recibió $66 MM de Penta mientras ejercia el cargo. Nodo central de la conexión Penta-SQM-Dominga.",                                                                          "Recibió pagos de Penta mientras era subsecretario. Identificado por el DOJ de EE.UU. como funcionario chileno 3 en el caso SQM. Asesoro a la familia Delano sobre como presentar el proyecto minero Dominga al Ministerio que el mismo encabezaba.",                                                      "Condenado caso Penta 2018: 2 años pena remitida + 3 años inhabilitacion cargos públicos. Absuelto caso SQM octubre 2025.",
  "moreira",       "Ivan\nMoreira",          "chilevamos",    "Senador UDI. Solicitó financiamiento a Penta por correo para su campaña senatorial de 2013 ($35 MM en boletas falsas).",                                                                                                                           "Su salida del caso fue negociada directamente: Abbott instruyo a Guerra para resolver su situacion procesal favorablemente, en el marco de los contactos con Larraín.",                                                                                                                                    "Sobreseido febrero 2019 tras suspension condiciónal + multa $35 MM.",
  "golborne",      "Laurence\nGolborne",     "chilevamos",    "Exministro de Obras Publicas y ex precandidato presidencial UDI. Penta financio su campaña presidencial.",                                                                                                                                         "Ex ministro de Pinera y figura visible del partido. Su candidatura presidencial fue uno de los destinos del financiamiento ilegal de Penta.",                                                                                                                                                              "Suspension condiciónal (sept. 2019) + pago $11,4 MM. Sobreseido al ano.",
  "demussy",       "Felipe\nDe Mussy",       "chilevamos",    "Diputado UDI. Imputado por financiamiento irregular proveniente de Penta.",                                                                                                                                                                        "Parte del grupo de políticos UDI que recibian financiamiento del holding de Delano y Lavin.",                                                                                                                                                                                                              "Salida alternativa. Sobreseido.",
  "zalaquett",     "Pablo\nZalaquett",       "chilevamos",    "Exalcalde de Santiago. Receptor de fondos en Penta y condenado en juicio abreviado en SQM.",                                                                                                                                                       "Uno de los pocos personajes que aparece condenado en ambos casos, lo que ilustra la imbricacion de las dos redes de financiamiento.",                                                                                                                                                                      "Condena en juicio abreviado (SQM). Salida alternativa (Penta).",
  "cardemil",      "Alberto\nCardemil",      "chilevamos",    "Exdiputado RN. Penta habria financiado su campaña a traves de dos abogados como intermediarios.",                                                                                                                                                   "Receptor de financiamiento de Penta canalizado a traves de intermediarios, lo que muestra que la red no se limitaba a la UDI.",                                                                                                                                                                            "Salida alternativa.",
  "vonbaer",       "Ena Von\nBaer",          "chilevamos",    "Senadora UDI. Mencionada en correos del caso como beneficiaria de financiamiento de Penta.",                                                                                                                                                        "Su nombre aparece en la correspondencia interna de Penta como destinataria de financiamiento. Citada a declarar.",                                                                                                                                                                                        "Sin formalización. Nego irregularidades.",
  "esilva",        "Ernesto\nSilva",         "chilevamos",    "Extimonel de la UDI. Su partido fue el principal receptor del financiamiento ilegal de Penta.",                                                                                                                                                     "Presidió la UDI en el periodo en que el financiamiento de Penta era un mecanismo normalizado dentro del partido.",                                                                                                                                                                                        "Renunció a la directiva en marzo 2015. Sin formalización.",
  "larrainH",      "Hernan\nLarraín",        "chilevamos",    "Exsenador UDI. Ministro de Justicia del segundo gobierno de Pinera. Organizo la reunion secreta con Abbott en la oficina de Zumelzu para negociar el juicio abreviado de Novoa. Posteriormente pidio a Abbott resolver el caso de Moreira.",       "Nodo clave entre el partido, los imputados y el Fiscal Nacional. Su rol muestra como la negociación política sobre causas judiciales activas operaba en privado, fuera de cualquier control instituciónal.",                                                                                             "Sin condena. Los hechos estan documentados en los chats del Caso Audios (Hermosilla-Guerra).",
  "zumelzu",       "Mario\nZumelzu",         "chilevamos",    "Abogado UDI. Su oficina fue el lugar de la reunion secreta entre Abbott y Larraín donde se negoció el juicio abreviado de Novoa.",                                                                                                                  "Facilitador logistico de la reunion clave entre el poder político y el poder judicial. Su oficina fue el espacio fisico donde se gestiono una causa activa en privado.",                                                                                                                                   "Sin condena.",
  "chadwick",      "Andres\nChadwick",       "chilevamos",    "Exministro del Interior del segundo gobierno de Pinera. Amigo intimo y socio de Luis Hermosilla.",                                                                                                                                                  "Hermosilla le transfirio $229 millones tras dejar el cargo de ministro, presuntamente como pago de honorarios por servicios profesionales. Los chats de Guerra lo mencionan como contacto clave para gestionar salidas en el Caso Penta. Es el puente entre el gobierno de Pinera y la red judicial de Hermosilla.",  "Sin condena en causas vinculadas a Penta. Imputado en el Caso Audios.",
  "longueira",     "Pablo\nLongueira",       "chilevamos",    "Exlider maximo de la UDI. Exministro de Economia en el primer gobierno de Pinera. Receptor de pagos directos de SQM identificado por el DOJ de EE.UU. como funcionario chileno 2.",                                                                "Su figura concentra las dos redes: como lider de la UDI era el referente político del entramado Penta; como identificado por el DOJ era receptor directo de SQM.",                                                                                                                                        "Absuelto en juicio oral octubre 2025.",
  "orpis",         "Jaime\nOrpis",           "chilevamos",    "Exsenador UDI. Identificado por el DOJ de EE.UU. como funcionario chileno 1 en el caso de pagos indebidos de SQM.",                                                                                                                                "Receptor directo de fondos de SQM. Su caso fue uno de los mas documentados en el expediente del Departamento de Justicia de EE.UU.",                                                                                                                                                                      "Absuelto en juicio oral octubre 2025.",

  # ── NUEVA MAYORÍA ────────────────────────────────────────────────────────────
  "penailillo",    "Rodrigo\nPeñailillo",    "nuevamayoria",  "Exministro del Interior del segundo gobierno de Bachelet. Encabezó las presiónes sobre el SII para frenar la investigación del Caso SQM en 2015.",                                                                                                 "Emitió boletas a la empresa de Martelli (AyN) que recibia fondos de SQM. Coordinó las gestiones para que el SII no presentara querella contra los involucrados. Su caso ilustra que la corrupcion no tiene color político.",                                                                               "No perseverado en 2021. Sin condena.",
  "martelli",      "Giorgio\nMartelli",      "nuevamayoria",  "Recaudador y operador político de la Concertacion. Su empresa AyN recibió $338 millones de SQM para financiar la precampaña de Bachelet.",                                                                                                         "Principal canal de financiamiento de SQM hacia la Nueva Mayoria. Fue el eslabón entre la empresa minera y los partidos de centroizquierda.",                                                                                                                                                               "Formalizado. Condenado: 800 dias pena cumplida en libertad + multa.",
  "donoso",        "Samuel\nDonoso",         "nuevamayoria",  "Abogado PPD. Asesor de Peñailillo. Se presentó en reunion en Hacienda para presiónar al SII a no querellarse contra Martelli. Tambien representó a Contesse de SQM y obstaculizo la entrega de contabilidad a la Fiscalia.",                       "Operó en los dos flancos: como asesor político de Peñailillo y como abogado defensor de los principales ejecutivos de SQM. Un mismo profesional cubriendo intereses de la empresa y del gobierno que debia fiscalizarla.",                                                                                 "Sin condena.",
  "meo",           "Marco E.-\nOminami",     "nuevamayoria",  "Excandidato presidencial. Receptor de pagos de SQM canalizados a traves de la Fundacion Progresa.",                                                                                                                                                "Candidato presidencial en 2009 y 2013 financiado parcialmente por SQM. Su caso muestra que el sistema de financiamiento ilegal abarcaba tambien a candidatos fuera de los partidos tradicionales.",                                                                                                       "Absuelto en juicio oral octubre 2025.",
  "pizarro",       "Jorge\nPizarro",         "nuevamayoria",  "Exvicepresidente del Senado (DC). Sus hijos Jorge y Benjamin Pizarro Cristi escaparon del proceso por inacción del SII.",                                                                                                                          "El SII no presentó querella contra sus hijos, quienes aparecian como receptores indirectos de fondos de SQM. El senador Pizarro fue uno de los políticos cuyas familias se beneficiaron del esquema sin consecuencias judiciales.",                                                                        "Sin formalización. Sus hijos tampoco fueron formalizados.",
  "arenas",        "Alberto\nArenas",        "nuevamayoria",  "Exministro de Hacienda del segundo gobierno de Bachelet. Co-encabezó junto a Peñailillo las presiónes al SII en 2015 para frenar la investigación SQM.",                                                                                           "Junto a Peñailillo coordinó las gestiones para que el SII no ampliara la querella en el Caso SQM. Es uno de los dos ministros del gobierno de Bachelet directamente documentados en el intento de frenar la investigación.",                                                                               "Sin formalización.",
  "rossi",         "Fulvio\nRossi",          "nuevamayoria",  "Exsenador PS. Receptor de fondos de SQM. La Corte Suprema rechazo su desafuero en 2018.",                                                                                                                                                          "Su caso ilustra como el sistema de financiamiento ilegal de SQM penetraba hasta los escalones mas altos del Senado en todos los partidos.",                                                                                                                                                                "Sin condena. Desafuero rechazado por la Corte Suprema en 2018.",
  "correa",        "Harold\nCorrea",         "nuevamayoria",  "PPD. Exjefe de gabinete del exministro Nicolas Eyzaguirre. El SII no presentó querella en su contra.",                                                                                                                                             "Su caso ilustra como la protección política dentro del gobierno de Bachelet alcanzo tambien a funcionarios de segundo rango que estaban vinculados a la red de financiamiento de SQM.",                                                                                                                   "Sin formalización. El SII no presentó querella.",

  # ── INDEPENDIENTE ───────────────────────────────────────────────────────────
  "velasco",       "Andres\nVelasco",        "independiente", "Ex precandidato presidencial independiente. PDI allano su domicilio. Declaró ante la Fiscalia en el marco del Caso Penta.",                                                                                                                         "Un almuerzo pagado por Penta genero la investigación. Su caso ilustra que el financiamiento ilegal alcanzaba a candidatos de todo el espectro, incluyendo figuras independientes de la izquierda liberal.",                                                                                                "Sin formalización. Declaró como testigo.",

  # ── RED JUDICIAL ────────────────────────────────────────────────────────────
  "abbott",        "Jorge\nAbbott",          "judicial",      "Exfiscal Nacional de Chile (2015-2023). Se reunio en secreto con Hernan Larraín y Mario Zumelzu mientras era candidato a fiscal, negociando salidas para imputados del Caso Penta. Instruyo internamente acotar las investigaciónes de platas políticas.", "Centro neuralgico de la red judicial. Coordinó con Larraín la salida de Novoa y la situacion de Moreira. Fue nombrado Fiscal Nacional en un proceso influenciado por sus relaciónes con actores políticos del caso. Investigado en el Caso Audios.",                                                    "Sin condena. Dejó el cargo de Fiscal Nacional en 2023.",
  "guerra",        "Manuel\nGuerra",         "judicial",      "Exfiscal Regional Oriente. Manejo directamente las causas del Caso Penta. Los chats con Hermosilla muestran coordinacion para dar salidas favorables a imputados y solicitudes de empleo a cambio.",                                                "Coordinaba con Hermosilla las resoluciónes en causas activas. Su caso es el eslabón mas explícito entre el poder judicial, el poder político y el mundo empresarial. Actuaba como intermediario entre Abbott y los intereses de Penta.",                                                                    "En prision preventiva en Capitan Yabar. Formalizado por cohecho, prevaricacion administrativa y violacion de secreto. Caso Audios.",
  "hermosilla",    "Luis\nHermosilla",       "judicial",      "Abogado. Hub central de la red judicial. Sus chats con el fiscal Guerra muestran coordinacion para dar salidas favorables a causas de Penta.",                                                                                                      "Recibió $229 millones de Andres Chadwick, presuntamente como honorarios profesionales. Conecta el mundo empresarial (clientes como Delano), el mundo político (Chadwick, ex ministro de Pinera) y el poder judicial (Guerra). Su red cruzaba todos los poderes del Estado.",                               "En prision preventiva. Formalizado en el Caso Audios por cohecho, obstruccion a la justicia y otros delitos.",
  "caso_audios",   "Caso\nAudios",           "judicial",      "Investigación judicial iniciada en 2023 tras la filtración de audios y chats de Luis Hermosilla que revelaron cómo operaba la red de influencias sobre el sistema judicial chileno.",                                                               "El Caso Audios es la continuación natural de los casos Penta y SQM: muestra que las redes de influencia no desaparecieron con las condenas de 2018, sino que siguieron operando. Involucra directamente a Hermosilla, Guerra, Chadwick, Abbott y Larraín.",                                               "Investigación activa. Multiples formalizados. Hermosilla y Guerra en prision preventiva.",
  "sauer",         "Daniel\nSauer",          "judicial",      "Empresario. Controlador de Factop, empresa de servicios financieros. Grabó el audio de 105 minutos que detonó el Caso Audios, en una reunion donde Hermosilla proponía sobornar funcionarios del SII y la CMF.",                                   "Su grabacion —que hizo para protegerse de Hermosilla en una disputa interna— terminó destapando la red de influencias más grande de la historia judicial chilena. La reunion ocurrió en el edificio del Grupo Patio en Vitacura. Hermosilla y Villalobos le proponían soborno a cambio de resolver los problemas regulatorios de Factop.",  "En prision preventiva. Formalizado junto a Hermosilla por lavado de activos y delitos tributarios.",
  "villalobos",    "Leonarda\nVillalobos",   "judicial",      "Abogada. Socia y colaboradora de Hermosilla. Participó en la reunion grabada por Sauer donde Hermosilla proponía sobornar a funcionarios del SII y la CMF.",                                                                                          "Alegó haber grabado ella misma la reunion como protección ante Sauer. Su version contradijo la de Hermosilla. Junto a Hermosilla representa la cara visible de como el tráfico de influencias operaba desde estudios jurídicos privados con conexiónes en todos los poderes del Estado.",                    "En prision preventiva. Formalizada en el Caso Audios.",

  # ── CONTEXTO HISTORICO ───────────────────────────────────────────────────────
  "pinochet",      "Augusto\nPinochet",      "contexto",      "Dictador de Chile (1973-1990). Suegro de Julio Ponce Lerou. La dictadura creo el marco legal e instituciónal que hizo posible que Ponce Lerou controlara SQM.",                                                                                     "Durante la dictadura, Ponce Lerou fue designado interventor y luego controlador de SQM a traves de privatizaciónes cuestionadas. El poder acumulado gracias a esa relación familiar con la dictadura fue el origen del esquema de financiamiento político ilegal que destaparon los casos SQM y Cascadas.",  "Fallecido en diciembre de 2006. No hubo proceso judicial por su rol en la entrega de SQM a Ponce Lerou.",
  "cascadas",      "Caso\nCascadas",         "contexto",      "Caso judicial iniciado en 2013 por la CMF. Reveló que Julio Ponce Lerou usó sociedades instrumentales para manipular el precio de las acciónes de SQM y transferir riqueza desde los acciónistas minoritarios hacia si mismo.",                    "El Caso Cascadas es el origen financiero del poder de Ponce Lerou dentro de SQM: a traves de ese esquema consolidó el control de la empresa a costa de los acciónistas, incluidos trabajadores y fondos de pensiones. Ese poder fue el que luego uso para financiar ilegalmente la política.",             "Sentenciado por la CMF. Ponce Lerou y otros ejecutivos multados. Sin prision efectiva."
)

red_aristas <- tibble::tribble(
  ~from,           ~to,
  # Penta interno
  "delano",        "lavin",
  "delano",        "bravo",
  "delano",        "castro",
  "delano",        "carvajal",
  "lavin",         "alvarez",
  # Penta -> Chile Vamos
  "delano",        "novoa",
  "delano",        "wagner",
  "delano",        "moreira",
  "delano",        "golborne",
  "delano",        "demussy",
  "delano",        "vonbaer",
  "lavin",         "cardemil",
  "lavin",         "zalaquett",
  # Mentor -> Penta
  "cruzat",        "delano",
  "cruzat",        "lavin",
  "cruzat",        "bravo",
  # Pinera conexiones
  "pinera",        "delano",
  "pinera",        "wagner",
  "pinera",        "abbott",
  "pinera",        "chadwick",
  # Dominga
  "delano",        "dominga",
  "wagner",        "dominga",
  # Chile Vamos interno
  "novoa",         "esilva",
  "larrainH",      "novoa",
  "larrainH",      "moreira",
  "zumelzu",       "larrainH",
  "chadwick",      "hermosilla",
  "chadwick",      "larrainH",
  "longueira",     "novoa",
  # Wagner triple nodo
  "wagner",        "ponce",
  "wagner",        "delano",
  # SQM interno
  "ponce",         "contesse",
  # SQM -> Chile Vamos
  "contesse",      "longueira",
  "contesse",      "orpis",
  "contesse",      "zalaquett",
  # SQM -> Nueva Mayoria
  "contesse",      "martelli",
  "contesse",      "penailillo",
  "contesse",      "meo",
  "contesse",      "donoso",
  # Nueva Mayoria interno
  "penailillo",    "donoso",
  "martelli",      "penailillo",
  "penailillo",    "arenas",
  "contesse",      "pizarro",
  "contesse",      "rossi",
  "contesse",      "correa",
  # Velasco
  "delano",        "velasco",
  # Red judicial
  "hermosilla",    "guerra",
  "guerra",        "abbott",
  "abbott",        "larrainH",
  "abbott",        "zumelzu",
  "abbott",        "novoa",
  "abbott",        "moreira",
  "hermosilla",    "delano",
  "hermosilla",    "chadwick",
  # Caso Audios
  "hermosilla",    "caso_audios",
  "guerra",        "caso_audios",
  "chadwick",      "caso_audios",
  "abbott",        "caso_audios",
  "sauer",         "caso_audios",
  "villalobos",    "caso_audios",
  "hermosilla",    "sauer",
  "hermosilla",    "villalobos",
  "sauer",         "villalobos",
  # Contexto historico
  "pinochet",      "ponce",
  "cascadas",      "ponce",
  "pinochet",      "cascadas"
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
        uiOutput(paste0("grafico_", sid)),

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

  # Generate SVG symbol charts for each subarea
  observe({
    area_sel   <- input$area_sel
    caso_id    <- input$caso_sel
    color_area <- as.character(colores_area[area_sel])
    stroke_col <- as.character(colores_stroke[area_sel])
    monto_sel  <- monto_actual()
    caso_nombre <- tabla_casos$nombre[tabla_casos$id == caso_id]

    df_subareas <- tabla_subareas %>% filter(area == area_sel)

    lapply(seq_len(nrow(df_subareas)), function(i) {
      row <- df_subareas[i, ]
      sid <- row$subarea_id
      local({
        sid_l        <- sid
        unidad_l     <- row$unidad
        escala_l     <- row$escala_mm
        costo_l      <- row$costo_unitario_mm

        equiv_caso   <- monto_sel / costo_l

        output[[paste0("grafico_", sid_l)]] <- renderUI({

          # ── TYPE A: proportional fill (symbol filled bottom-up) ───────────
          if (!is.na(escala_l)) {
            escala_equiv <- escala_l / costo_l
            pct          <- min(equiv_caso / escala_equiv, 1)
            pct_display  <- round(pct * 100, 1)

            svg_html <- svg_simbolo(
              area        = area_sel,
              fill_color  = color_area,
              stroke_color = stroke_col,
              fill_pct    = pct
            )

            div(style = "display:flex; align-items:center; gap:28px; margin:18px 0 10px;",
              # Symbol
              div(style = "flex-shrink:0;",
                HTML(svg_html)
              ),
              # Stats
              div(
                div(style = paste0("font-size:2.2rem; font-weight:600; color:", color_area,
                                   "; font-family:'Playfair Display'; line-height:1;"),
                    paste0(pct_display, "%")
                ),
                div(style = "font-size:0.82rem; color:#8a7a6a; margin-top:4px; line-height:1.4;",
                    paste0("del total necesario para cerrar la brecha")
                ),
                tags$hr(style = "border:none; border-top:1px solid #E5E4D0; margin:10px 0;"),
                div(style = "font-size:0.88rem; color:#6a5a45;",
                    tags$strong(fmt_num_r(equiv_caso)), " ", unidad_l
                ),
                div(style = "font-size:0.78rem; color:#aaa; margin-top:2px;",
                    paste0("de ", fmt_num_r(escala_equiv), " necesarios en total")
                )
              )
            )

          # ── TYPE B: big number over ghost icon ────────────────────────────
          } else {
            svg_html <- svg_simbolo(
              area        = area_sel,
              fill_color  = color_area,
              stroke_color = stroke_col,
              show_ghost  = TRUE
            )

            div(style = "display:flex; align-items:center; gap:28px; margin:18px 0 10px;",
              # Ghost symbol
              div(style = "flex-shrink:0; position:relative;",
                HTML(svg_html)
              ),
              # Big number
              div(
                div(style = paste0("font-size:2.8rem; font-weight:600; color:", color_area,
                                   "; font-family:'Playfair Display'; line-height:1;"),
                    fmt_num_r(equiv_caso)
                ),
                div(style = "font-size:0.85rem; color:#6a5a45; margin-top:6px; line-height:1.5;",
                    unidad_l
                ),
                div(style = "font-size:0.78rem; color:#aaa; margin-top:4px;",
                    paste0("con el monto de ", caso_nombre)
                )
              )
            )
          }
        })
      })
    })
  })

  # ── Red de poder (visNetwork) ──────────────────────────────────────────────
  output$red_poder <- renderVisNetwork({

    # Colores de fondo por nodo (vector simple, sin nombres)
    bg_colors <- unname(red_colores[red_nodos$grupo])

    # Tooltip HTML por nodo
    grupo_labels <- unname(red_grupos_label[red_nodos$grupo])
    tooltips <- paste0(
      "<div style='max-width:240px;padding:8px;font-size:0.82rem;'>",
      "<b>", gsub("\n", " ", red_nodos$label), "</b><br/>",
      "<span style='color:", bg_colors, ";font-size:0.75rem;'>",
      grupo_labels, "</span><hr style='margin:5px 0;'/>",
      "<b>Rol:</b> ", red_nodos$rol, "<br/><br/>",
      "<b>Conexiones:</b> ", red_nodos$conexion, "<br/><br/>",
      "<i style='color:#8B4513;'>", red_nodos$estado, "</i>",
      "</div>"
    )

    # Data frame de nodos — solo columnas simples
    nodos_vis <- data.frame(
      id                         = red_nodos$id,
      label                      = red_nodos$label,
      color.background           = bg_colors,
      color.border               = "#5a4030",
      color.highlight.background = "#4a3020",
      color.highlight.border     = "#2a1810",
      font.color                 = "#FFFFFF",
      font.size                  = 13,
      size                       = 28,
      title                      = tooltips,
      stringsAsFactors           = FALSE
    )

    # Data frame de aristas — solo columnas simples
    aristas_vis <- data.frame(
      from   = red_aristas$from,
      to     = red_aristas$to,
      color  = "#C8B8A0",
      width  = 1.5,
      arrows = "to",
      stringsAsFactors = FALSE
    )

    visNetwork(nodos_vis, aristas_vis,
               background = "#FDFCF0",
               width = "100%", height = "600px") %>%
      visNodes(
        shape       = "dot",
        borderWidth = 2,
        shadow      = list(enabled = TRUE, size = 8)
      ) %>%
      visEdges(
        smooth = list(enabled = TRUE, type = "continuous")
      ) %>%
      visOptions(
        highlightNearest = list(enabled = TRUE, degree = 1, hover = TRUE)
      ) %>%
      visInteraction(
        dragNodes    = TRUE,
        dragView     = TRUE,
        zoomView     = TRUE,
        tooltipDelay = 80
      ) %>%
      visPhysics(
        solver = "forceAtlas2Based",
        forceAtlas2Based = list(
          gravitationalConstant = -55,
          centralGravity        = 0.004,
          springLength          = 115,
          springConstant        = 0.05,
          damping               = 0.6
        ),
        stabilization = list(enabled = TRUE, iterations = 250)
      ) %>%
      visEvents(
        selectNode = "function(nodes) {
          Shiny.setInputValue('nodo_seleccionado', nodes.nodes[0], {priority: 'event'});
        }",
        deselectNode = "function(nodes) {
          Shiny.setInputValue('nodo_seleccionado', '', {priority: 'event'});
        }"
      )
  })

  output$panel_nodo <- renderUI({
    nodo_id <- input$nodo_seleccionado
    if (is.null(nodo_id) || nodo_id == "") {
      return(div(
        style = "border:1px solid #E5E4D0; border-radius:4px; background:#F5F4E6; padding:20px; height:600px; display:flex; align-items:center; justify-content:center;",
        p(style = "color:#aaa; font-size:0.85rem; text-align:center;",
          "Haz clic en un nodo para ver información del personaje"
        )
      ))
    }

    nodo <- red_nodos %>% filter(id == nodo_id)
    if (nrow(nodo) == 0) return(NULL)

    color_grupo <- red_colores[nodo$grupo]
    label_grupo <- red_grupos_label[nodo$grupo]

    div(
      style = "border:1px solid #E5E4D0; border-radius:4px; background:#F5F4E6; padding:20px; height:600px; overflow-y:auto; font-size:0.83rem;",

      div(style = paste0("font-family:'Playfair Display'; font-size:1.05rem; color:#4B3621; font-weight:600; line-height:1.3; margin-bottom:10px;"),
        gsub("\n", " ", nodo$label)
      ),
      tags$span(
        style = paste0("display:inline-block; background:", color_grupo,
                       "; color:white; padding:2px 10px; border-radius:10px; font-size:0.75rem; margin-bottom:14px;"),
        label_grupo
      ),

      tags$hr(style = "border:none; border-top:1px solid #E5E4D0; margin:12px 0;"),

      div(style = "color:#5a4a35; margin-bottom:14px; line-height:1.65;",
        tags$strong("Rol: "),
        nodo$rol
      ),
      div(style = "color:#6a5a45; margin-bottom:14px; line-height:1.65; border-top:1px solid #E5E4D0; padding-top:12px;",
        tags$strong("Conexiones documentadas: "),
        nodo$conexion
      ),
      div(style = "color:#8B4513; font-style:italic; font-size:0.78rem; line-height:1.5; border-top:1px solid #E5E4D0; padding-top:12px;",
        nodo$estado
      )
    )
  })

}

# ==============================================================================
shinyApp(ui, server)
