/* =======================================================
   sistema de información de extensión universitaria
   autor: samuel blanco
   fecha: octubre 2025
   descripción: script completo del modelo relacional
   ======================================================= */

/* ============================
   creación de base de datos
   ============================ */
create database if not exists sistema_extension_ur;
use sistema_extension_ur;

/* ============================
   creación de tablas (ddl)
   ============================ */

create table usuario (
    id_usuario int auto_increment primary key,
    nombre_usuario varchar(100) not null,
    correo varchar(100) unique not null,
    rol varchar(50) not null,
    estado_usuario varchar(20)
);

create table unidadacademica (
    id_unidad int auto_increment primary key,
    nombre_unidad varchar(150) not null,
    tipo_unidad varchar(50),
    dependencia varchar(100),
    sede varchar(50)
);

create table lineatematica (
    id_linea int auto_increment primary key,
    nombre_linea varchar(100) not null,
    descripcion text,
    eje_estrategico varchar(100)
);

create table actividad (
    id_actividad int auto_increment primary key,
    nombre_actividad varchar(150) not null,
    tipo_actividad varchar(50),
    modalidad varchar(50),
    periodo varchar(20),
    fecha_inicio date,
    fecha_fin date,
    estado varchar(30),
    valor_planeado decimal(12,2),
    valor_ejecutado decimal(12,2),
    fuente_financiacion varchar(100),
    num_participantes int,
    id_unidad int,
    id_linea int,
    id_usuario int,
    foreign key (id_unidad) references unidadacademica(id_unidad),
    foreign key (id_linea) references lineatematica(id_linea),
    foreign key (id_usuario) references usuario(id_usuario)
);

create table presupuesto (
    id_presupuesto int auto_increment primary key,
    valor_planeado decimal(12,2),
    valor_ejecutado decimal(12,2),
    porcentaje_ejecucion decimal(5,2),
    fuente_financiacion varchar(100),
    id_actividad int unique,
    foreign key (id_actividad) references actividad(id_actividad)
);

create table persona (
    id_persona int auto_increment primary key,
    nombre varchar(100) not null,
    apellido varchar(100),
    correo varchar(100),
    tipo_vinculo varchar(50),
    unidad_academica varchar(100),
    dedicacion varchar(50),
    experiencia_anios int
);

create table participacion (
    id_participacion int auto_increment primary key,
    id_actividad int,
    id_persona int,
    rol_en_actividad varchar(100),
    horas_dedicadas int,
    aporte_tematico varchar(255),
    foreign key (id_actividad) references actividad(id_actividad),
    foreign key (id_persona) references persona(id_persona)
);

create table ods (
    id_ods int auto_increment primary key,
    nombre_ods varchar(150) not null,
    descripcion_ods text,
    categoria varchar(50)
);

create table actividad_ods (
    id_relacion int auto_increment primary key,
    id_actividad int,
    id_ods int,
    foreign key (id_actividad) references actividad(id_actividad),
    foreign key (id_ods) references ods(id_ods)
);

/* ============================
   inserción de datos (50 por tabla)
   ============================ */

insert into usuario (nombre_usuario, correo, rol, estado_usuario)
values
('alejandra niño','alejandra@urosario.edu.co','coordinadora','activo'),
('catalina zapata','catalina@urosario.edu.co','directora','activo'),
('tatiana cabrera','tatiana@urosario.edu.co','profesora','activo'),
('samuel blanco','samuel@urosario.edu.co','analista','activo'),
('maria jose pinzón','maria.pinzon@urosario.edu.co','gestora de investigación','activo'),
('olga pineda','olga.pineda@urosario.edu.co','asistente administrativa','activo'),
('juan vargas','juan.vargas@urosario.edu.co','asesor académico','activo'),
('dianey núñez','dianey.nunez@urosario.edu.co','analista financiero','activo'),
('david chiguachi','david.chiguachi@urosario.edu.co','coordinador de compras','activo'),
('yeimy romero','yeimy.romero@urosario.edu.co','secretaria de decanatura','activo'),
('angélica velandia','angelica.velandia@urosario.edu.co','secretaria académica','activo'),
('laura pinilla','laura.pinilla@urosario.edu.co','directora de pregrado','activo'),
('ana maldonado','ana.maldonado@urosario.edu.co','directora de posgrado','activo'),
('luz mary chitiva','luz.chitiva@urosario.edu.co','coordinadora académica','activo'),
('giselle garcía','giselle.garcia@urosario.edu.co','asistente de programas','activo'),
('jeimy ordóñez','jeimy.ordonez@urosario.edu.co','coordinadora logística','activo'),
('heybey guerra','heybey.guerra@urosario.edu.co','apoyo administrativo','activo'),
('michael pita','michael.pita@urosario.edu.co','coordinador de permanencia','activo'),
('andrés garcía','andres.garcia@urosario.edu.co','decano','activo'),
('carlos torres','carlos.torres@urosario.edu.co','docente investigador','activo'),
('paula medina','paula.medina@urosario.edu.co','docente asistente','activo'),
('jorge cabrera','jorge.cabrera@urosario.edu.co','profesor asociado','activo'),
('martha rojas','martha.rojas@urosario.edu.co','coordinadora de convenios','activo'),
('alejandro cruz','alejandro.cruz@urosario.edu.co','auxiliar de sistemas','activo'),
('carolina fuentes','carolina.fuentes@urosario.edu.co','analista de proyectos','activo'),
('juliana gómez','juliana.gomez@urosario.edu.co','analista de datos','activo'),
('sebastián martínez','sebastian.martinez@urosario.edu.co','soporte técnico','activo'),
('valentina parra','valentina.parra@urosario.edu.co','gestora de extensión','activo'),
('daniel montoya','daniel.montoya@urosario.edu.co','auxiliar académico','activo'),
('natalia suárez','natalia.suarez@urosario.edu.co','coordinadora de investigación','activo'),
('felipe gómez','felipe.gomez@urosario.edu.co','asesor financiero','activo'),
('camila rodríguez','camila.rodriguez@urosario.edu.co','analista de planeación','activo'),
('mariana castro','mariana.castro@urosario.edu.co','profesora visitante','activo'),
('santiago cardozo','santiago.cardozo@urosario.edu.co','asistente de extensión','activo'),
('isabella ramírez','isabella.ramirez@urosario.edu.co','auxiliar contable','activo'),
('miguel rojas','miguel.rojas@urosario.edu.co','analista de calidad','activo'),
('juanita prada','juanita.prada@urosario.edu.co','asistente de comunicación','activo'),
('karol mejía','karol.mejia@urosario.edu.co','practicante de extensión','activo'),
('sergio fernández','sergio.fernandez@urosario.edu.co','docente de apoyo','activo'),
('cristina alvarez','cristina.alvarez@urosario.edu.co','analista de talento humano','activo'),
('edgar moreno','edgar.moreno@urosario.edu.co','administrador de base de datos','activo'),
('maría isabel lópez','maria.lopez@urosario.edu.co','gestora de proyectos','activo'),
('diana camargo','diana.camargo@urosario.edu.co','auxiliar de investigación','activo'),
('lorena arango','lorena.arango@urosario.edu.co','coordinadora de egresados','activo'),
('andrea martínez','andrea.martinez@urosario.edu.co','coordinadora de eventos','activo'),
('julián nieto','julian.nieto@urosario.edu.co','docente investigador','activo'),
('susana rodríguez','susana.rodriguez@urosario.edu.co','profesora asociada','activo'),
('esteban molina','esteban.molina@urosario.edu.co','asistente académico','activo'),
('valeria rodríguez','valeria.rodriguez@urosario.edu.co','analista de innovación','activo'),
('cristian vega','cristian.vega@urosario.edu.co','desarrollador sql','activo'),
('gabriela restrepo','gabriela.restrepo@urosario.edu.co','gestora de alianzas','activo'),
('sofia gonzález','sofia.gonzalez@urosario.edu.co','profesora invitada','activo');


insert into unidadacademica (nombre_unidad, tipo_unidad, dependencia, sede)
values
('laboratorio de finanzas','laboratorio','facultad de economía','claustro'),
('educación continua','dirección','facultad de economía','claustro'),
('cancillería','oficina','rectoría','norte'),
('centro de liderazgo público','centro','rectoría','claustro'),
('laboratorio de políticas públicas','laboratorio','facultad de economía','claustro'),
('centro de estudios territoriales','centro','facultad de economía','claustro'),
('oficina de internacionalización','oficina','rectoría','norte'),
('centro de emprendimiento','centro','rectoría','claustro'),
('dirección de desarrollo','dirección','facultad de economía','claustro'),
('laboratorio de innovación social','laboratorio','facultad de economía','claustro'),
('centro de investigación económica','centro','facultad de economía','claustro'),
('oficina de comunicaciones','oficina','facultad de economía','claustro'),
('coordinación de voluntariado','coordinación','facultad de economía','claustro'),
('centro de liderazgo femenino','centro','rectoría','norte'),
('programa de responsabilidad social','programa','rectoría','claustro'),
('coordinación académica','coordinación','facultad de economía','claustro'),
('oficina de extensión universitaria','oficina','facultad de economía','claustro'),
('unidad de proyectos estratégicos','unidad','rectoría','claustro'),
('centro de educación financiera','centro','facultad de economía','claustro'),
('unidad de investigación aplicada','unidad','facultad de economía','claustro'),
('centro de estudios en equidad','centro','facultad de economía','claustro'),
('dirección de sostenibilidad','dirección','rectoría','norte'),
('oficina de innovación educativa','oficina','rectoría','claustro'),
('centro de estudios sociales','centro','facultad de economía','claustro'),
('coordinación de egresados','coordinación','facultad de economía','claustro'),
('programa de economía naranja','programa','facultad de economía','claustro'),
('oficina de bienestar universitario','oficina','rectoría','norte'),
('centro de análisis económico','centro','facultad de economía','claustro'),
('unidad de apoyo estadístico','unidad','facultad de economía','claustro'),
('centro de estudios rurales','centro','rectoría','claustro'),
('coordinación de prácticas profesionales','coordinación','facultad de economía','claustro'),
('programa de educación financiera','programa','facultad de economía','claustro'),
('centro de transformación digital','centro','rectoría','norte'),
('oficina de planeación estratégica','oficina','rectoría','claustro'),
('unidad de sistemas de información','unidad','facultad de economía','claustro'),
('centro de estudios ambientales','centro','rectoría','claustro'),
('dirección de vinculación externa','dirección','facultad de economía','claustro'),
('centro de análisis político','centro','facultad de economía','claustro'),
('oficina de relaciones institucionales','oficina','rectoría','claustro'),
('unidad de evaluación de impacto','unidad','facultad de economía','claustro'),
('laboratorio de innovación pública','laboratorio','facultad de economía','claustro'),
('centro de estudios de desarrollo','centro','facultad de economía','claustro'),
('programa de liderazgo juvenil','programa','rectoría','norte'),
('oficina de calidad académica','oficina','rectoría','claustro'),
('unidad de apoyo docente','unidad','facultad de economía','claustro'),
('centro de estudios demográficos','centro','rectoría','claustro'),
('dirección de cooperación académica','dirección','rectoría','norte'),
('oficina de ética institucional','oficina','rectoría','claustro'),
('unidad de gestión administrativa','unidad','facultad de economía','claustro'),
('centro de políticas económicas','centro','facultad de economía','claustro'),
('programa de extensión territorial','programa','facultad de economía','claustro');


insert into lineatematica (nombre_linea, descripcion, eje_estrategico)
values
('economía social','actividades sobre desarrollo comunitario','sostenibilidad'),
('finanzas sostenibles','proyectos de inversión verde','sostenibilidad'),
('educación económica','formación ciudadana en finanzas','equidad'),
('innovación pública','gestión y transformación institucional','eficiencia'),
('inclusión financiera','estrategias para mejorar el acceso al crédito','equidad'),
('desarrollo rural','proyectos para fortalecer economías campesinas','sostenibilidad'),
('equidad de género','programas para reducir brechas económicas y laborales','inclusión'),
('emprendimiento juvenil','fomento de la cultura emprendedora en jóvenes','innovación'),
('economía naranja','impulso de industrias creativas y culturales','innovación'),
('transformación digital','aplicación de tecnología en procesos educativos','eficiencia'),
('evaluación de impacto','análisis de resultados de proyectos sociales','transparencia'),
('gobernanza institucional','fortalecimiento de estructuras administrativas','eficiencia'),
('educación financiera escolar','formación básica en economía para colegios','equidad'),
('finanzas públicas','análisis y planeación de recursos estatales','eficiencia'),
('sostenibilidad ambiental','proyectos enfocados en mitigación del cambio climático','sostenibilidad'),
('innovación pedagógica','nuevas metodologías en educación superior','calidad'),
('planeación estratégica','gestión y mejora de procesos organizacionales','eficiencia'),
('desarrollo local','iniciativas para el crecimiento territorial','sostenibilidad'),
('participación ciudadana','mecanismos de fortalecimiento comunitario','democracia'),
('responsabilidad social universitaria','acciones con impacto social de la academia','sostenibilidad'),
('economía circular','uso eficiente de recursos y reducción de residuos','sostenibilidad'),
('gestión del conocimiento','difusión y sistematización de experiencias exitosas','eficiencia'),
('investigación aplicada','proyectos orientados a la resolución de problemas reales','innovación'),
('alianzas público-privadas','cooperación entre sectores para desarrollo territorial','eficiencia'),
('educación continua','programas de formación para profesionales y comunidades','equidad'),
('planeación urbana','estudios sobre ordenamiento territorial y vivienda','sostenibilidad'),
('economía del comportamiento','análisis de decisiones y diseño de políticas públicas','innovación'),
('gestión cultural','fortalecimiento de procesos artísticos y patrimoniales','identidad'),
('política social','análisis y diseño de programas sociales','equidad'),
('desarrollo institucional','mejora continua de la gestión universitaria','eficiencia'),
('economía digital','integración de tecnología en modelos de negocio','innovación'),
('empleabilidad y talento humano','estrategias de formación para el trabajo','equidad'),
('gestión ambiental','planes para conservación de recursos naturales','sostenibilidad'),
('economía solidaria','modelos asociativos y cooperativos sostenibles','inclusión'),
('gobierno abierto','promoción de la transparencia y la participación ciudadana','democracia'),
('educación para el desarrollo','formación basada en objetivos sostenibles','sostenibilidad'),
('innovación social','soluciones creativas a problemas comunitarios','inclusión'),
('competitividad regional','fortalecimiento de economías locales','eficiencia'),
('política pública educativa','diseño de estrategias institucionales','calidad'),
('gestión de proyectos','planificación y evaluación de programas de extensión','eficiencia'),
('movilidad académica','fomento del intercambio estudiantil y docente','internacionalización'),
('desarrollo sostenible','integración de dimensiones ambiental, social y económica','sostenibilidad'),
('salud pública y bienestar','acciones en promoción de salud y prevención','equidad'),
('fortalecimiento organizacional','consolidación de capacidades institucionales','eficiencia'),
('formación docente','capacitación en metodologías pedagógicas','calidad'),
('educación virtual','implementación de plataformas de aprendizaje digital','eficiencia'),
('seguridad alimentaria','proyectos para mejorar la nutrición y agricultura local','sostenibilidad'),
('tecnología y datos','uso de información para la toma de decisiones','innovación'),
('economía del conocimiento','fomento de ciencia y tecnología en sectores productivos','competitividad'),
('innovación territorial','estrategias para el desarrollo regional','sostenibilidad'),
('intervención comunitaria','programas de acercamiento y transformación social','inclusión');

insert into actividad 
(nombre_actividad, tipo_actividad, modalidad, periodo, fecha_inicio, fecha_fin, estado, valor_planeado, valor_ejecutado, fuente_financiacion, num_participantes, id_unidad, id_linea, id_usuario)
values
('curso de finanzas personales','curso','presencial','2024-2','2024-08-01','2024-09-15','finalizada',8000000,7800000,'universidad del rosario',45,1,2,1),
('seminario de economía circular','evento','virtual','2024-1','2024-04-02','2024-04-20','finalizada',5000000,4900000,'rectoría',65,2,1,2),
('taller de innovación pública','taller','presencial','2024-1','2024-02-10','2024-02-15','finalizada',3000000,2950000,'facultad de economía',30,4,3,3),
('consultoría en educación financiera','consultoría','virtual','2024-2','2024-08-10','2024-10-30','en ejecución',9000000,4500000,'laboratorio de finanzas',25,3,2,4),
('diplomado en desarrollo rural','diplomado','presencial','2024-2','2024-09-05','2024-11-30','planificada',12000000,0,'rectoría',50,6,5,5),
('foros de economía social','evento','virtual','2023-2','2023-11-01','2023-11-10','finalizada',4000000,3950000,'dirección de desarrollo',120,1,1,6),
('programa de sostenibilidad ambiental','programa','mixta','2023-2','2023-09-15','2023-12-15','finalizada',7000000,6700000,'facultad de economía',35,15,4,7),
('curso en política pública educativa','curso','presencial','2023-1','2023-02-05','2023-03-20','finalizada',6000000,5900000,'rectoría',40,39,9,8),
('congreso de educación financiera','evento','virtual','2024-1','2024-05-01','2024-05-10','finalizada',5500000,5300000,'laboratorio de finanzas',80,3,2,1),
('proyecto de equidad de género','proyecto','mixta','2024-1','2024-03-15','2024-05-30','en ejecución',7500000,4000000,'rectoría',60,7,1,2),
('taller de desarrollo local','taller','presencial','2024-1','2024-02-01','2024-03-01','finalizada',3500000,3400000,'rectoría',25,18,3,3),
('encuentro de gobernanza universitaria','evento','presencial','2024-2','2024-09-10','2024-09-12','planificada',4500000,0,'rectoría',90,12,4,5),
('capacitaciones en emprendimiento juvenil','curso','virtual','2023-2','2023-10-01','2023-11-30','finalizada',5000000,4800000,'dirección de desarrollo',70,8,6,4),
('laboratorio de economía digital','proyecto','mixta','2024-2','2024-08-15','2024-11-30','en ejecución',10000000,6000000,'facultad de economía',30,31,2,9),
('curso de evaluación de impacto','curso','virtual','2023-2','2023-09-01','2023-10-15','finalizada',4000000,3800000,'facultad de economía',55,10,5,10),
('proyecto de innovación pedagógica','proyecto','mixta','2024-1','2024-04-15','2024-08-15','en ejecución',9500000,4000000,'rectoría',40,16,4,3),
('conferencia sobre economía solidaria','evento','presencial','2023-2','2023-11-10','2023-11-12','finalizada',2500000,2400000,'facultad de economía',60,34,7,8),
('curso de gobernanza institucional','curso','presencial','2024-1','2024-02-01','2024-03-15','finalizada',6000000,5800000,'rectoría',35,12,4,9),
('diplomado en inclusión financiera','diplomado','virtual','2024-1','2024-03-01','2024-05-30','en ejecución',11000000,5000000,'laboratorio de finanzas',50,5,2,1),
('seminario en educación virtual','seminario','virtual','2024-1','2024-04-10','2024-04-20','finalizada',3500000,3300000,'facultad de economía',25,47,8,2),
('proyecto de desarrollo sostenible','proyecto','mixta','2024-2','2024-08-20','2024-12-20','en ejecución',15000000,7500000,'rectoría',80,42,6,10),
('curso de economía del comportamiento','curso','presencial','2024-2','2024-09-01','2024-10-30','planificada',7000000,0,'facultad de economía',45,27,1,5),
('foro de competitividad regional','evento','virtual','2024-1','2024-05-10','2024-05-15','finalizada',4000000,3900000,'rectoría',100,38,9,2),
('taller de innovación social','taller','mixta','2023-2','2023-09-20','2023-10-05','finalizada',3200000,3100000,'facultad de economía',30,37,4,3),
('consultoría sobre desarrollo institucional','consultoría','virtual','2023-2','2023-10-10','2023-12-20','finalizada',9000000,8800000,'rectoría',20,30,7,6),
('curso de economía del conocimiento','curso','presencial','2024-2','2024-09-15','2024-10-20','planificada',8000000,0,'facultad de economía',40,49,4,5),
('charla sobre responsabilidad social','evento','virtual','2024-1','2024-03-10','2024-03-11','finalizada',2000000,1950000,'facultad de economía',70,20,2,4),
('diplomado en planeación urbana','diplomado','presencial','2024-1','2024-02-15','2024-06-15','en ejecución',12000000,6000000,'rectoría',45,26,1,3),
('curso de investigación aplicada','curso','virtual','2024-1','2024-03-01','2024-04-15','finalizada',4500000,4400000,'facultad de economía',40,23,5,9),
('programa de movilidad académica','programa','virtual','2024-1','2024-02-10','2024-03-30','finalizada',6500000,6400000,'rectoría',55,41,7,10),
('congreso de sostenibilidad ambiental','evento','presencial','2023-2','2023-11-01','2023-11-03','finalizada',5000000,4900000,'rectoría',150,15,4,1),
('taller de educación para el desarrollo','taller','mixta','2024-1','2024-03-05','2024-03-15','finalizada',2800000,2700000,'rectoría',30,36,3,2),
('curso de fortalecimiento organizacional','curso','virtual','2023-2','2023-10-01','2023-12-01','finalizada',4000000,3800000,'facultad de economía',25,44,2,3),
('proyecto de salud pública','proyecto','presencial','2024-2','2024-08-01','2024-11-30','en ejecución',9500000,4700000,'rectoría',50,43,8,5),
('seminario de gobierno abierto','evento','virtual','2023-2','2023-09-10','2023-09-12','finalizada',2500000,2400000,'rectoría',65,35,9,6),
('curso de tecnología y datos','curso','virtual','2024-1','2024-03-01','2024-03-20','finalizada',3000000,2950000,'facultad de economía',40,48,4,7),
('diplomado en equidad social','diplomado','mixta','2024-2','2024-08-10','2024-11-30','en ejecución',11500000,5800000,'rectoría',45,7,3,9),
('programa de economía solidaria','programa','presencial','2023-2','2023-10-01','2023-12-20','finalizada',7500000,7300000,'facultad de economía',60,34,5,4),
('taller de educación virtual','taller','virtual','2024-2','2024-09-05','2024-09-25','planificada',4000000,0,'rectoría',35,47,9,3),
('curso de liderazgo institucional','curso','presencial','2024-1','2024-02-01','2024-02-20','finalizada',2500000,2400000,'facultad de economía',30,12,2,5),
('foro de transparencia pública','evento','virtual','2024-1','2024-05-01','2024-05-05','finalizada',3200000,3100000,'rectoría',80,35,1,1),
('diplomado en gestión ambiental','diplomado','mixta','2024-2','2024-08-05','2024-11-05','en ejecución',10000000,5200000,'rectoría',60,33,7,8),
('curso de innovación territorial','curso','virtual','2023-2','2023-10-10','2023-11-20','finalizada',5000000,4900000,'facultad de economía',30,50,8,10),
('seminario en economía digital','seminario','virtual','2024-2','2024-08-01','2024-08-10','planificada',3000000,0,'facultad de economía',45,31,2,1),
('proyecto de política social','proyecto','mixta','2024-1','2024-03-10','2024-06-10','en ejecución',9500000,4800000,'rectoría',40,29,4,2),
('curso de evaluación de proyectos','curso','virtual','2024-1','2024-04-01','2024-05-15','finalizada',4500000,4300000,'facultad de economía',30,40,6,5),
('foro de educación económica','evento','presencial','2024-2','2024-09-01','2024-09-05','planificada',4000000,0,'facultad de economía',100,3,9,7),
('proyecto de alianzas público-privadas','proyecto','mixta','2023-2','2023-10-15','2023-12-30','finalizada',9500000,9400000,'rectoría',55,24,2,8),
('curso de empleabilidad y talento humano','curso','presencial','2024-1','2024-02-15','2024-03-15','finalizada',3500000,3400000,'facultad de economía',25,32,5,9),
('seminario de educación para la paz','seminario','virtual','2024-1','2024-05-10','2024-05-20','finalizada',2800000,2700000,'rectoría',40,19,7,3),
('curso de ética profesional','curso','presencial','2024-1','2024-03-01','2024-03-10','finalizada',2000000,1950000,'rectoría',30,11,5,6);

insert into persona (nombre, apellido, correo, tipo_vinculo, unidad_academica, dedicacion, experiencia_anios)
values
('andrés','martínez','andres@urosario.edu.co','profesor','finanzas','tiempo completo',8),
('valentina','rojas','valentina@urosario.edu.co','estudiante','economía','medio tiempo',1),
('laura','gómez','laura@urosario.edu.co','egresada','economía','independiente',3),
('juan','torres','juan.torres@urosario.edu.co','profesor','economía','tiempo completo',10),
('camila','díaz','camila.diaz@urosario.edu.co','estudiante','finanzas','medio tiempo',2),
('felipe','ramírez','felipe.ramirez@urosario.edu.co','egresado','economía','independiente',4),
('carolina','vargas','carolina.vargas@urosario.edu.co','profesora','administración','tiempo completo',7),
('esteban','rodríguez','esteban.rodriguez@urosario.edu.co','aliado externo','banco popular','consultor',12),
('sofia','gómez','sofia.gomez@urosario.edu.co','estudiante','finanzas','medio tiempo',1),
('sebastián','lópez','sebastian.lopez@urosario.edu.co','profesor','economía','tiempo completo',9),
('valeria','hernández','valeria.hernandez@urosario.edu.co','egresada','economía','independiente',5),
('miguel','rojas','miguel.rojas@urosario.edu.co','estudiante','economía','medio tiempo',2),
('isabella','prieto','isabella.prieto@urosario.edu.co','profesora','finanzas','tiempo completo',6),
('daniel','castro','daniel.castro@urosario.edu.co','profesor','economía','tiempo completo',11),
('natalia','mejía','natalia.mejia@urosario.edu.co','estudiante','finanzas','medio tiempo',1),
('alejandro','suárez','alejandro.suarez@urosario.edu.co','profesor','economía','tiempo completo',15),
('paula','rodríguez','paula.rodriguez@urosario.edu.co','egresada','economía','independiente',3),
('jorge','pérez','jorge.perez@urosario.edu.co','profesor','finanzas','tiempo completo',9),
('maria','hoyos','maria.hoyos@urosario.edu.co','profesora','economía','tiempo completo',7),
('santiago','ramírez','santiago.ramirez@urosario.edu.co','estudiante','economía','medio tiempo',2),
('valentina','jara','valentina.jara@urosario.edu.co','egresada','economía','independiente',5),
('carla','alvarez','carla.alvarez@urosario.edu.co','profesora','finanzas','tiempo completo',8),
('andrea','fernández','andrea.fernandez@urosario.edu.co','egresada','administración','independiente',6),
('manuel','moreno','manuel.moreno@urosario.edu.co','profesor','economía','tiempo completo',13),
('maría','jiménez','maria.jimenez@urosario.edu.co','profesora','finanzas','tiempo completo',10),
('ana','garcía','ana.garcia@urosario.edu.co','estudiante','economía','medio tiempo',1),
('julián','ortega','julian.ortega@urosario.edu.co','egresado','economía','independiente',4),
('catalina','león','catalina.leon@urosario.edu.co','profesora','finanzas','tiempo completo',9),
('samuel','blanco','samuel.blanco@urosario.edu.co','analista','extensión','tiempo completo',4),
('olga','pineda','olga.pineda@urosario.edu.co','administrativa','extensión','tiempo completo',8),
('michael','pita','michael.pita@urosario.edu.co','profesor','economía','tiempo completo',12),
('heybey','guerra','heybey.guerra@urosario.edu.co','asistente','extensión','tiempo completo',5),
('catalina','zapata','catalina.zapata@urosario.edu.co','directora','desarrollo','tiempo completo',14),
('alejandra','niño','alejandra.niño@urosario.edu.co','coordinadora','laboratorio de finanzas','tiempo completo',9),
('maría','pinzón','maria.pinzon@urosario.edu.co','gestora','investigación','tiempo completo',6),
('yeimy','romero','yeimy.romero@urosario.edu.co','secretaria','decanatura','tiempo completo',10),
('andrés','garcía','andres.garcia@urosario.edu.co','decano','facultad de economía','tiempo completo',15),
('dianey','núñez','dianey.nunez@urosario.edu.co','administrativa','finanzas','tiempo completo',8),
('david','chiguachi','david.chiguachi@urosario.edu.co','analista','compras','tiempo completo',7),
('angela','velandia','angela.velandia@urosario.edu.co','secretaria','académica','tiempo completo',11),
('giselle','garcía','giselle.garcia@urosario.edu.co','asistente','programas','medio tiempo',4),
('jeimy','ordóñez','jeimy.ordonez@urosario.edu.co','coordinadora','logística','tiempo completo',5),
('laura','pinilla','laura.pinilla@urosario.edu.co','directora','pregrado','tiempo completo',10),
('ana','maldonado','ana.maldonado@urosario.edu.co','directora','posgrado','tiempo completo',9),
('luz','chitiva','luz.chitiva@urosario.edu.co','coordinadora','académica','tiempo completo',8),
('cristian','vega','cristian.vega@urosario.edu.co','desarrollador','informática','tiempo completo',5),
('juanita','prada','juanita.prada@urosario.edu.co','comunicadora','extensión','tiempo completo',7),
('sergio','fernández','sergio.fernandez@urosario.edu.co','docente','finanzas','tiempo completo',10),
('valeria','rodríguez','valeria.rodriguez@urosario.edu.co','analista','innovación','tiempo completo',4),
('edgar','moreno','edgar.moreno@urosario.edu.co','administrador','bases de datos','tiempo completo',12);

insert into participacion (id_actividad, id_persona, rol_en_actividad, horas_dedicadas, aporte_tematico)
values
(1,1,'ponente',10,'educación financiera'),
(1,2,'asistente',6,'participación estudiantil'),
(2,3,'organizadora',12,'sostenibilidad'),
(2,4,'ponente',8,'finanzas verdes'),
(3,5,'asistente',4,'gobernanza'),
(3,6,'colaborador',9,'gestión institucional'),
(4,7,'ponente',10,'equidad e inclusión'),
(5,8,'asesor',15,'emprendimiento rural'),
(6,9,'asistente',6,'desarrollo social'),
(7,10,'ponente',8,'innovación social'),
(8,11,'organizador',10,'educación virtual'),
(9,12,'colaborador',9,'gestión del conocimiento'),
(10,13,'ponente',11,'sostenibilidad ambiental'),
(11,14,'asistente',6,'participación ciudadana'),
(12,15,'asesor',10,'gobernanza universitaria'),
(13,16,'organizador',8,'educación para la equidad'),
(14,17,'ponente',7,'finanzas digitales'),
(15,18,'colaborador',6,'investigación aplicada'),
(16,19,'ponente',9,'innovación pedagógica'),
(17,20,'asistente',5,'educación solidaria'),
(18,21,'organizador',12,'equidad de género'),
(19,22,'ponente',8,'inclusión financiera'),
(20,23,'colaborador',10,'transformación digital'),
(21,24,'asistente',6,'sostenibilidad urbana'),
(22,25,'organizador',8,'evaluación institucional'),
(23,26,'ponente',10,'responsabilidad social'),
(24,27,'colaborador',9,'economía circular'),
(25,28,'asistente',6,'gestión académica'),
(26,29,'organizador',10,'extensión comunitaria'),
(27,30,'ponente',12,'investigación aplicada'),
(28,31,'asistente',7,'innovación territorial'),
(29,32,'colaborador',8,'sostenibilidad'),
(30,33,'asistente',6,'gobierno abierto'),
(31,34,'organizador',9,'planeación estratégica'),
(32,35,'ponente',11,'competitividad regional'),
(33,36,'asistente',5,'fortalecimiento institucional'),
(34,37,'colaborador',10,'economía social'),
(35,38,'ponente',9,'educación económica'),
(36,39,'asistente',4,'política social'),
(37,40,'organizador',10,'gestión ambiental'),
(38,41,'colaborador',8,'educación financiera'),
(39,42,'asistente',6,'equidad laboral'),
(40,43,'organizador',10,'salud pública'),
(41,44,'ponente',8,'economía digital'),
(42,45,'asistente',7,'ODS y sostenibilidad'),
(43,46,'colaborador',9,'innovación institucional'),
(44,47,'organizador',10,'empleabilidad y talento humano'),
(45,48,'asistente',6,'gobernanza local'),
(46,49,'colaborador',10,'alianzas estratégicas'),
(47,50,'ponente',9,'educación de calidad'),
(48,1,'asistente',5,'extensión territorial'),
(49,2,'colaborador',7,'planeación académica'),
(50,3,'ponente',10,'ODS en la universidad');

insert into ods (nombre_ods, descripcion_ods, categoria)
values
('ods 1: fin de la pobreza','erradicar la pobreza en todas sus formas','social'),
('ods 2: hambre cero','poner fin al hambre y lograr seguridad alimentaria','social'),
('ods 3: salud y bienestar','garantizar una vida sana y promover el bienestar','social'),
('ods 4: educación de calidad','garantizar educación inclusiva y equitativa','social'),
('ods 5: igualdad de género','lograr igualdad entre los géneros','social'),
('ods 6: agua limpia y saneamiento','garantizar disponibilidad de agua y saneamiento','ambiental'),
('ods 7: energía asequible y no contaminante','asegurar acceso a energía sostenible','ambiental'),
('ods 8: trabajo decente y crecimiento económico','promover el empleo pleno y productivo','económico'),
('ods 9: industria, innovación e infraestructura','fomentar la innovación y la infraestructura resiliente','económico'),
('ods 10: reducción de las desigualdades','reducir desigualdades dentro de los países','social'),
('ods 11: ciudades sostenibles','lograr asentamientos humanos inclusivos','ambiental'),
('ods 12: producción y consumo responsable','garantizar patrones sostenibles de consumo','ambiental'),
('ods 13: acción por el clima','adoptar medidas urgentes contra el cambio climático','ambiental'),
('ods 14: vida submarina','conservar los océanos y ecosistemas marinos','ambiental'),
('ods 15: vida de ecosistemas terrestres','gestionar sosteniblemente los bosques','ambiental'),
('ods 16: paz, justicia e instituciones sólidas','promover sociedades pacíficas e inclusivas','social'),
('ods 17: alianzas para lograr los objetivos','revitalizar la alianza mundial para el desarrollo','institucional'),
('ods 18: innovación social','impulsar soluciones tecnológicas con impacto','institucional'),
('ods 19: educación económica','promover formación financiera','social'),
('ods 20: finanzas sostenibles','fomentar la inversión verde y responsable','económico'),
('ods 21: participación ciudadana','impulsar el liderazgo comunitario','institucional'),
('ods 22: sostenibilidad urbana','fortalecer prácticas ambientales locales','ambiental'),
('ods 23: cooperación internacional','fortalecer alianzas académicas y científicas','institucional'),
('ods 24: gobernanza y transparencia','promover rendición de cuentas','institucional'),
('ods 25: empleo juvenil','crear oportunidades laborales dignas','económico'),
('ods 26: fortalecimiento educativo','ampliar cobertura y calidad académica','social'),
('ods 27: emprendimiento femenino','apoyar empresas lideradas por mujeres','económico'),
('ods 28: equidad regional','promover desarrollo equitativo entre territorios','económico'),
('ods 29: economía circular','fomentar uso eficiente de recursos','ambiental'),
('ods 30: salud mental','fortalecer la atención psicológica','social'),
('ods 31: innovación tecnológica','fomentar la adopción de tecnologías limpias','económico'),
('ods 32: bienestar animal','proteger la fauna doméstica y silvestre','ambiental'),
('ods 33: inclusión digital','reducir brechas tecnológicas','institucional'),
('ods 34: desarrollo rural','impulsar productividad del campo','económico'),
('ods 35: educación continua','formación permanente para profesionales','social'),
('ods 36: economía solidaria','promover cooperativismo','económico'),
('ods 37: igualdad educativa','garantizar equidad en acceso a educación','social'),
('ods 38: protección del agua','conservar fuentes hídricas','ambiental'),
('ods 39: cambio climático','reducir emisiones y mitigar riesgos','ambiental'),
('ods 40: economía verde','transición a modelos productivos sostenibles','económico'),
('ods 41: acceso a la justicia','promover defensa de derechos humanos','institucional'),
('ods 42: innovación pedagógica','mejorar los métodos de enseñanza','social'),
('ods 43: salud pública','impulsar políticas sanitarias inclusivas','social'),
('ods 44: movilidad sostenible','promover transporte bajo en carbono','ambiental'),
('ods 45: liderazgo juvenil','impulsar participación de jóvenes en el cambio','social'),
('ods 46: acceso a la información','garantizar libertad informativa','institucional'),
('ods 47: seguridad alimentaria','mejorar producción y distribución de alimentos','social'),
('ods 48: investigación científica','fortalecer producción académica','institucional'),
('ods 49: economía digital','impulsar inclusión tecnológica en mercados','económico'),
('ods 50: gobernanza universitaria','promover gestión ética y transparente','institucional');

insert into actividad_ods (id_actividad, id_ods)
values
(1,4),
(2,13),
(3,8),
(4,20),
(5,6),
(6,10),
(7,15),
(8,9),
(9,4),
(10,5),
(11,13),
(12,16),
(13,3),
(14,12),
(15,2),
(16,7),
(17,27),
(18,19),
(19,21),
(20,30),
(21,33),
(22,34),
(23,35),
(24,36),
(25,37),
(26,38),
(27,39),
(28,40),
(29,41),
(30,42),
(31,43),
(32,44),
(33,45),
(34,46),
(35,47),
(36,48),
(37,49),
(38,50),
(39,1),
(40,2),
(41,3),
(42,4),
(43,5),
(44,6),
(45,7),
(46,8),
(47,9),
(48,10),
(49,11),
(50,12);

/* ============================
   consultas básicas y específicas
   ============================ */
/* ============================================================
   CONSULTAS SQL – SISTEMA DE INFORMACIÓN DE EXTENSIÓN UNIVERSITARIA
   AUTOR: SAMUEL BLANCO
   ============================================================ */

/* ============================================================
   TABLA: USUARIO
   ============================================================ */

-- consulta básica
select * from usuario;

-- 1. listar los usuarios activos
select nombre_usuario, rol from usuario where estado_usuario = 'activo';

-- 2. contar cuántos usuarios hay por rol
select rol, count(*) as total from usuario group by rol;

-- 3. buscar usuarios cuyo correo pertenece a la facultad de economía
select nombre_usuario, correo from usuario where correo like '%economia%';

-- 4. mostrar los roles únicos registrados
select distinct rol from usuario;

-- 5. obtener los usuarios que son coordinadores o directores
select nombre_usuario, rol from usuario where rol in ('coordinadora','directora');

-- 6. mostrar los usuarios ordenados alfabéticamente por nombre
select nombre_usuario, rol from usuario order by nombre_usuario asc;

-- 7. consultar cuántos usuarios están inactivos (si existieran)
select count(*) as usuarios_inactivos from usuario where estado_usuario <> 'activo';



/* ============================================================
   TABLA: UNIDADACADEMICA
   ============================================================ */

-- consulta básica
select * from unidadacademica;

-- 1. listar todas las unidades de tipo laboratorio
select nombre_unidad, dependencia from unidadacademica where tipo_unidad = 'laboratorio';

-- 2. contar cuántas unidades hay por tipo
select tipo_unidad, count(*) as total from unidadacademica group by tipo_unidad;

-- 3. buscar unidades que dependan directamente de rectoría
select nombre_unidad, sede from unidadacademica where dependencia = 'rectoría';

-- 4. mostrar las unidades ubicadas en el claustro
select nombre_unidad, tipo_unidad from unidadacademica where sede = 'claustro';

-- 5. obtener todas las direcciones y centros académicos
select nombre_unidad from unidadacademica where tipo_unidad in ('dirección','centro');

-- 6. listar las unidades que contienen la palabra "innovación"
select * from unidadacademica where nombre_unidad like '%innovación%';

-- 7. ordenar las unidades por tipo y nombre
select tipo_unidad, nombre_unidad from unidadacademica order by tipo_unidad, nombre_unidad;



/* ============================================================
   TABLA: LINEATEMATICA
   ============================================================ */

-- consulta básica
select * from lineatematica;

-- 1. listar todas las líneas cuyo eje es sostenibilidad
select nombre_linea from lineatematica where eje_estrategico = 'sostenibilidad';

-- 2. contar líneas por eje estratégico
select eje_estrategico, count(*) as total from lineatematica group by eje_estrategico;

-- 3. buscar líneas que incluyan la palabra 'educación'
select nombre_linea from lineatematica where nombre_linea like '%educación%';

-- 4. mostrar líneas de innovación o eficiencia
select nombre_linea from lineatematica where eje_estrategico in ('innovación','eficiencia');

-- 5. obtener las tres primeras líneas alfabéticamente
select nombre_linea from lineatematica order by nombre_linea asc limit 3;

-- 6. consultar cuántas líneas están enfocadas en equidad o inclusión
select count(*) as total_equidad from lineatematica where eje_estrategico in ('equidad','inclusión');

-- 7. listar las líneas con descripción más larga (más de 50 caracteres)
select nombre_linea, length(descripcion) as longitud from lineatematica where length(descripcion) > 50;



/* ============================================================
   TABLA: ACTIVIDAD
   ============================================================ */

-- consulta básica
select * from actividad;

-- 1. listar las actividades finalizadas
select nombre_actividad, estado from actividad where estado = 'finalizada';

-- 2. contar actividades por tipo
select tipo_actividad, count(*) as total from actividad group by tipo_actividad;

-- 3. mostrar actividades cuya fuente de financiación sea rectoría
select nombre_actividad, valor_planeado from actividad where fuente_financiacion = 'rectoría';

-- 4. calcular promedio de valor ejecutado por modalidad
select modalidad, avg(valor_ejecutado) as promedio_ejecutado from actividad group by modalidad;

-- 5. obtener las 5 actividades más costosas según valor planeado
select nombre_actividad, valor_planeado from actividad order by valor_planeado desc limit 5;

-- 6. listar actividades con ejecución menor al 80% del presupuesto planeado
select nombre_actividad, (valor_ejecutado/valor_planeado)*100 as porcentaje
from actividad
where valor_ejecutado < (valor_planeado * 0.8);

-- 7. mostrar las actividades con más de 50 participantes
select nombre_actividad, num_participantes from actividad where num_participantes > 50;



/* ============================================================
   TABLA: PERSONA
   ============================================================ */

-- consulta básica
select * from persona;

-- 1. listar todos los profesores con dedicación tiempo completo
select nombre, apellido from persona where tipo_vinculo = 'profesor' and dedicacion = 'tiempo completo';

-- 2. contar personas por tipo de vínculo
select tipo_vinculo, count(*) as total from persona group by tipo_vinculo;

-- 3. obtener los egresados con más de 5 años de experiencia
select nombre, apellido, experiencia_anios from persona where tipo_vinculo = 'egresada' and experiencia_anios > 5;

-- 4. listar estudiantes con dedicación medio tiempo
select nombre, apellido from persona where tipo_vinculo = 'estudiante' and dedicacion = 'medio tiempo';

-- 5. mostrar los profesores con experiencia superior a 10 años
select nombre, apellido, experiencia_anios from persona where tipo_vinculo = 'profesor' and experiencia_anios >= 10;

-- 6. ordenar por años de experiencia de mayor a menor
select nombre, apellido, experiencia_anios from persona order by experiencia_anios desc;

-- 7. buscar personas del área de finanzas
select nombre, apellido, unidad_academica from persona where unidad_academica like '%finanzas%';



/* ============================================================
   TABLA: PARTICIPACION
   ============================================================ */

-- consulta básica
select * from participacion;

-- 1. contar cuántas participaciones hay por rol
select rol_en_actividad, count(*) as total from participacion group by rol_en_actividad;

-- 2. obtener las participaciones que dedicaron más de 10 horas
select id_persona, id_actividad, horas_dedicadas from participacion where horas_dedicadas > 10;

-- 3. listar las participaciones que incluyen la palabra 'educación'
select * from participacion where aporte_tematico like '%educación%';

-- 4. calcular promedio de horas dedicadas por rol
select rol_en_actividad, avg(horas_dedicadas) as promedio_horas from participacion group by rol_en_actividad;

-- 5. buscar los participantes que actuaron como ponentes
select id_persona, id_actividad from participacion where rol_en_actividad = 'ponente';

-- 6. contar participaciones por actividad
select id_actividad, count(*) as total_participaciones from participacion group by id_actividad;

-- 7. mostrar las participaciones con horas iguales a la media general
select * from participacion 
where horas_dedicadas = (select round(avg(horas_dedicadas),0) from participacion);

/* ============================================================
   TABLA: ODS
   ============================================================ */

-- consulta básica
select * from ods;

-- 1. listar todos los ods de categoría ambiental
select nombre_ods from ods where categoria = 'ambiental';

-- 2. contar cuántos ods hay por categoría
select categoria, count(*) as total from ods group by categoria;

-- 3. buscar ods relacionados con educación
select * from ods where nombre_ods like '%educación%';

-- 4. mostrar los ods con descripciones largas (más de 60 caracteres)
select nombre_ods, length(descripcion_ods) from ods where length(descripcion_ods) > 60;

-- 5. obtener los ods de tipo económico o institucional
select nombre_ods, categoria from ods where categoria in ('económico','institucional');

-- 6. listar los primeros 10 ods en orden alfabético
select nombre_ods from ods order by nombre_ods asc limit 10;

-- 7. mostrar ods con la palabra "igualdad" en su nombre o descripción
select * from ods where nombre_ods like '%igualdad%' or descripcion_ods like '%igualdad%';

/* ============================================================
   TABLA: ACTIVIDAD_ODS
   ============================================================ */

-- consulta básica
select * from actividad_ods;

-- 1. contar cuántas actividades están asociadas a cada ods
select id_ods, count(*) as total_actividades from actividad_ods group by id_ods;

-- 2. listar los ods relacionados con la primera actividad
select id_ods from actividad_ods where id_actividad = 1;

-- 3. buscar todas las asociaciones del ods 13
select id_actividad from actividad_ods where id_ods = 13;

-- 4. mostrar asociaciones ordenadas por id de actividad
select id_actividad, id_ods from actividad_ods order by id_actividad;

-- 5. contar los ods distintos asociados a actividades
select count(distinct id_ods) as total_ods_asociados from actividad_ods;

-- 6. mostrar las actividades que contribuyen a más de un ods
select id_actividad, count(id_ods) as total
from actividad_ods
group by id_actividad
having total > 1;

-- 7. verificar si alguna actividad no tiene ods asignado
select a.id_actividad, a.nombre_actividad
from actividad a
left join actividad_ods ao on a.id_actividad = ao.id_actividad
where ao.id_ods is null;

/* ============================
   modificaciones y eliminación
   ============================ */

-- actualizar valor ejecutado de una actividad
update actividad set valor_ejecutado = 8200000 where id_actividad = 1;

-- actualizar estado de actividad
update actividad set estado = 'activa' where id_actividad = 2;

-- actualizar rol de una persona
update persona set tipo_vinculo = 'aliado externo' where id_persona = 3;

-- actualizar horas dedicadas
update participacion set horas_dedicadas = 14 where id_participacion = 3;

-- actualizar dependencia de una unidad
update unidadacademica set dependencia = 'rectoría' where id_unidad = 1;

-- eliminar registro de participación
delete from participacion where id_participacion = 2;

/* ============================================================
   SUBCONSULTAS Y CONSULTAS MULTITABLA
   ============================================================ */

-- 1. actividades cuyo valor ejecutado está por encima del promedio
select nombre_actividad, valor_ejecutado
from actividad
where valor_ejecutado > (select avg(valor_ejecutado) from actividad);

-- 2. unidades con actividades finalizadas
select distinct u.nombre_unidad
from unidadacademica u
inner join actividad a on u.id_unidad = a.id_unidad
where a.estado = 'finalizada';

-- 3. personas que participaron en actividades financiadas por la rectoría
select distinct p.nombre, p.apellido
from persona p
inner join participacion pa on p.id_persona = pa.id_persona
inner join actividad a on pa.id_actividad = a.id_actividad
where a.fuente_financiacion = 'rectoría';

-- 4. actividades y sus líneas temáticas asociadas
select a.nombre_actividad, l.nombre_linea, l.eje_estrategico
from actividad a
inner join lineatematica l on a.id_linea = l.id_linea
order by a.nombre_actividad;

-- 5. usuarios responsables de actividades con más de 60 participantes
select distinct u.nombre_usuario, a.nombre_actividad, a.num_participantes
from usuario u
inner join actividad a on u.id_usuario = a.id_usuario
where a.num_participantes > 60
order by a.num_participantes desc;

-- 6. ods asociados a actividades que superaron el 90% del valor planeado
select o.nombre_ods, a.nombre_actividad, a.valor_ejecutado, a.valor_planeado
from actividad a
inner join actividad_ods ao on a.id_actividad = ao.id_actividad
inner join ods o on ao.id_ods = o.id_ods
where a.valor_ejecutado >= (a.valor_planeado * 0.9);

-- 7. unidades académicas con promedio de valor ejecutado superior a 6 millones
select u.nombre_unidad, avg(a.valor_ejecutado) as promedio_ejecutado
from unidadacademica u
inner join actividad a on u.id_unidad = a.id_unidad
group by u.nombre_unidad
having avg(a.valor_ejecutado) > 6000000;

-- 8. listar las personas que han participado en más de una actividad
select p.nombre, p.apellido, count(pa.id_actividad) as total_actividades
from persona p
inner join participacion pa on p.id_persona = pa.id_persona
group by p.id_persona
having count(pa.id_actividad) > 1;

-- 9. líneas temáticas que agrupan más de 3 actividades
select l.nombre_linea, count(a.id_actividad) as total_actividades
from lineatematica l
inner join actividad a on l.id_linea = a.id_linea
group by l.id_linea
having count(a.id_actividad) > 3;

-- 10. consultar las actividades relacionadas con los ods de educación o equidad
select distinct a.nombre_actividad, o.nombre_ods
from actividad a
inner join actividad_ods ao on a.id_actividad = ao.id_actividad
inner join ods o on ao.id_ods = o.id_ods
where o.nombre_ods like '%educación%' or o.nombre_ods like '%equidad%';


/* ============================================================
   CREACIÓN DE PROCESOS ALMACENADOS Y VISTAS
   ============================================================ */

delimiter //

/* ============================================================
   PROCEDIMIENTO 1: insertar nueva actividad
   ============================================================ */
create procedure sp_insertar_actividad(
    in p_nombre varchar(100),
    in p_tipo varchar(50),
    in p_modalidad varchar(50),
    in p_periodo varchar(10),
    in p_fecha_inicio date,
    in p_fecha_fin date,
    in p_estado varchar(30),
    in p_valor_planeado decimal(12,2),
    in p_fuente varchar(100),
    in p_id_unidad int,
    in p_id_linea int,
    in p_id_usuario int
)
begin
    insert into actividad(nombre_actividad, tipo_actividad, modalidad, periodo, fecha_inicio, fecha_fin, estado, valor_planeado, valor_ejecutado, fuente_financiacion, num_participantes, id_unidad, id_linea, id_usuario)
    values(p_nombre, p_tipo, p_modalidad, p_periodo, p_fecha_inicio, p_fecha_fin, p_estado, p_valor_planeado, 0, p_fuente, 0, p_id_unidad, p_id_linea, p_id_usuario);
end //

/* ============================================================
   PROCEDIMIENTO 2: actualizar valor ejecutado de una actividad
   ============================================================ */
create procedure sp_actualizar_ejecucion(
    in p_id_actividad int,
    in p_valor_ejecutado decimal(12,2)
)
begin
    update actividad
    set valor_ejecutado = p_valor_ejecutado
    where id_actividad = p_id_actividad;
end //

/* ============================================================
   PROCEDIMIENTO 3: registrar participación en una actividad
   ============================================================ */
create procedure sp_registrar_participacion(
    in p_id_actividad int,
    in p_id_persona int,
    in p_rol varchar(50),
    in p_horas int,
    in p_aporte varchar(150)
)
begin
    insert into participacion(id_actividad, id_persona, rol_en_actividad, horas_dedicadas, aporte_tematico)
    values(p_id_actividad, p_id_persona, p_rol, p_horas, p_aporte);
end //

/* ============================================================
   PROCEDIMIENTO 4: calcular total de actividades por unidad académica
   ============================================================ */
create procedure sp_total_actividades_por_unidad()
begin
    select u.nombre_unidad, count(a.id_actividad) as total_actividades
    from unidadacademica u
    left join actividad a on u.id_unidad = a.id_unidad
    group by u.id_unidad;
end //

/* ============================================================
   PROCEDIMIENTO 5: listar actividades por eje estratégico
   ============================================================ */
create procedure sp_actividades_por_eje(in p_eje varchar(50))
begin
    select a.nombre_actividad, l.nombre_linea, l.eje_estrategico
    from actividad a
    inner join lineatematica l on a.id_linea = l.id_linea
    where l.eje_estrategico = p_eje;
end //

/* ============================================================
   PROCEDIMIENTO 6: calcular promedio de ejecución general
   ============================================================ */
create procedure sp_promedio_ejecucion()
begin
    select avg(valor_ejecutado/valor_planeado)*100 as porcentaje_promedio
    from actividad
    where valor_planeado > 0;
end //

/* ============================================================
   PROCEDIMIENTO 7: eliminar participaciones por inactividad
   ============================================================ */
create procedure sp_eliminar_participaciones_inactivas()
begin
    delete from participacion
    where id_actividad not in (select id_actividad from actividad where estado = 'en ejecución' or estado = 'planificada');
end //

delimiter ;



/* ============================================================
   CREACIÓN DE VISTAS
   ============================================================ */

/* ============================================================
   VISTA 1: resumen de ejecución de actividades
   ============================================================ */
create view vw_resumen_ejecucion as
select 
    a.id_actividad,
    a.nombre_actividad,
    u.nombre_unidad,
    l.nombre_linea,
    round((a.valor_ejecutado/a.valor_planeado)*100,2) as porcentaje_ejecucion,
    a.num_participantes,
    a.estado
from actividad a
inner join unidadacademica u on a.id_unidad = u.id_unidad
inner join lineatematica l on a.id_linea = l.id_linea;

/* ============================================================
   VISTA 2: participantes por actividad
   ============================================================ */
create view vw_participacion_detallada as
select 
    a.nombre_actividad,
    concat(p.nombre,' ',p.apellido) as participante,
    pa.rol_en_actividad,
    pa.horas_dedicadas,
    pa.aporte_tematico
from participacion pa
inner join persona p on pa.id_persona = p.id_persona
inner join actividad a on pa.id_actividad = a.id_actividad;

/* ============================================================
   VISTA 3: resumen por ods
   ============================================================ */
create view vw_actividades_ods as
select 
    o.nombre_ods,
    count(ao.id_actividad) as total_actividades,
    group_concat(distinct a.nombre_actividad order by a.nombre_actividad separator ', ') as actividades_relacionadas
from ods o
left join actividad_ods ao on o.id_ods = ao.id_ods
left join actividad a on ao.id_actividad = a.id_actividad
group by o.nombre_ods;

/* ============================================================
   VISTA 4: indicadores de impacto general
   ============================================================ */
create view vw_indicadores_impacto as
select 
    count(distinct a.id_actividad) as total_actividades,
    sum(a.valor_planeado) as presupuesto_planeado_total,
    sum(a.valor_ejecutado) as presupuesto_ejecutado_total,
    avg(a.num_participantes) as promedio_participantes,
    round(avg((a.valor_ejecutado/a.valor_planeado)*100),2) as promedio_ejecucion
from actividad a;

/* ============================================================
   VISTA 5: actividades con mayor participación y ejecución
   ============================================================ */
create view vw_top_actividades as
select 
    nombre_actividad,
    num_participantes,
    round((valor_ejecutado/valor_planeado)*100,2) as porcentaje_ejecucion
from actividad
where valor_planeado > 0
order by num_participantes desc, porcentaje_ejecucion desc
limit 10;


/* ============================
   triggers
   ============================ */

-- trigger 1: calcular porcentaje de ejecución automáticamente
delimiter //
create trigger tr_porcentaje_ejecucion
before insert on presupuesto
for each row
begin
    if new.valor_planeado > 0 then
        set new.porcentaje_ejecucion = (new.valor_ejecutado / new.valor_planeado) * 100;
    end if;
end //
delimiter ;

-- trigger 2: actualizar estado de actividad al finalizar
delimiter //
create trigger tr_cierre_actividad
after update on actividad
for each row
begin
    if new.fecha_fin < curdate() then
        update actividad set estado = 'finalizada' where id_actividad = new.id_actividad;
    end if;
end //
delimiter ;

#SUSTENTACION
describe unidadacademica;
describe actividad;

#RQF 39 MULTITABLA
select u.nombre_unidad, a.periodo, a.nombre_actividad, a.tipo_actividad
from actividad as a 
inner join unidadacademica u on a.id_unidad = u.id_unidad
order by a.periodo;

describe lineatematica;

#RQF 35 PROCEDIMIENTO
Create procedure particion_docente_lineatematica(id_profesor)
begin 
select lt.nombre_linea,
       pr.id_profesor,
       pr.nombre_completo as profesor,
       COUNT(ap.id_actividad) as numero_actividades
from LineasTematicas lt
inner join Actividades_Extension a ON a.id_linea_tematica = lt.id_linea_tematica
inner join Actividades_Profesores ap on ap.id_actividad = a.id_actividad
inner join Profesores pr on pr.id_profesor = ap.id_profesor
group by lt.nombre_linea, pr.id_profesor;
end;

#RQF 46 PROCEDIMIENTO
#ESTE LO HABIA PLANTEADO PARA VISUALIZACION NO ME DA EL TIEMPO PERO LO INTENTARE FUERA

#RQF 18 FUNCION CALCULADA
describe actividad;
DELIMITER $$
Create Function Duracion_promedio_act(date fecha_inicio in, in fecha_fin date)

begin

end $$
DELIMITER ;

Select fecha_inicio, fecha_fin, avg(timestampdiff(fecha_inicio, fecha_fin)) as duracion_promedio
from actividades;

#RQF 3 FUNCIÓN








