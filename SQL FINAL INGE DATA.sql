#SCRIPT SQL PILOTO SAMUEL BLANCO CASTELLANOS
#Hola profe, comento que para organizar el codigo se lo pase a chat para que colocara los encabezados y los datos y una vez hice las vistas
#tambien se lo pase para que los mostrará
-- ===================================
-- BASE DE DATOS EXTENSION UR
-- ===================================
CREATE DATABASE IF NOT EXISTS ExtensionUR;
USE ExtensionUR;

-- ===================================
-- TABLA ODS
-- ===================================

CREATE TABLE ODS (
    idODS INT PRIMARY KEY,
    Nombre TEXT
) ENGINE=InnoDB;

-- ===================================
-- TABLA LineaInv
-- ===================================

CREATE TABLE LineaInv (
    idLinea INT PRIMARY KEY,
    Nombre VARCHAR(100),
    idODS1 INT,
    idODS2 INT,
    FOREIGN KEY (idODS1) REFERENCES ODS(idODS),
    FOREIGN KEY (idODS2) REFERENCES ODS(idODS)
) ENGINE=InnoDB;

-- ===================================
-- TABLA TipoActividad
-- ===================================

CREATE TABLE TipoActividad (
    idTipo INT PRIMARY KEY,
    Tipo TEXT
) ENGINE=InnoDB;

-- ===================================
-- TABLA FuenteActividad (NUEVA)
-- ===================================

CREATE TABLE FuenteActividad (
    idFuente INT AUTO_INCREMENT PRIMARY KEY,
    NombreFuente VARCHAR(150) NOT NULL,
    Descripcion TEXT
) ENGINE=InnoDB;

-- ===================================
-- TABLA ProgramaAcademico (NUEVA)
-- ===================================

CREATE TABLE ProgramaAcademico (
    idPrograma INT AUTO_INCREMENT PRIMARY KEY,
    NombrePrograma VARCHAR(150) NOT NULL,
    Facultad VARCHAR(150),
    Nivel ENUM('Pregrado', 'Posgrado') NOT NULL
) ENGINE=InnoDB;

-- ===================================
-- TABLA Entidad
-- ===================================

CREATE TABLE Entidad (
    idEntidad INT PRIMARY KEY,
    Nombre VARCHAR(150),
    Tipo VARCHAR(100),
    Pais VARCHAR(100),
    Nacional BOOLEAN,
    Contacto VARCHAR(150),
    Email VARCHAR(150),
    Direccion VARCHAR(200),
    Telefono VARCHAR(30),
    Sector VARCHAR(100),
    Ciudad VARCHAR(100)
) ENGINE=InnoDB;

-- ===================================
-- TABLA Persona (Actualizada con ProgramaAcademico)
-- ===================================

CREATE TABLE Persona (
    CCPersona INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(150),
    idPrograma INT,
    Nacionalidad VARCHAR(100),
    Egresado BOOLEAN,
    Experiencia TEXT,
    Intercambio BOOLEAN,
    Funcion VARCHAR(100),
    FOREIGN KEY (idPrograma) REFERENCES ProgramaAcademico(idPrograma)
) ENGINE=InnoDB;

-- ===================================
-- TABLA Actividad (Actualizada con FuenteActividad)
-- ===================================

CREATE TABLE Actividad (
    idActividad INT AUTO_INCREMENT PRIMARY KEY,
    idFinanciero INT,
    Nombre VARCHAR(150),
    idTipoActividad INT,
    idFuente INT,
    Modalidad VARCHAR(50),
    Periodo VARCHAR(50),
    FechaInicio DATE,
    FechaFin DATE,
    idLinea INT,
    idEntidad INT,
    Avance DECIMAL(4,2),
    FOREIGN KEY (idTipoActividad) REFERENCES TipoActividad(idTipo),
    FOREIGN KEY (idFuente) REFERENCES FuenteActividad(idFuente),
    FOREIGN KEY (idLinea) REFERENCES LineaInv(idLinea),
    FOREIGN KEY (idEntidad) REFERENCES Entidad(idEntidad)
) ENGINE=InnoDB;

-- ===================================
-- TABLA Participacion
-- ===================================

CREATE TABLE Participacion (
    idParticipacion INT AUTO_INCREMENT PRIMARY KEY,
    idActividad INT,
    CCPersona INT,
    Rol VARCHAR(100),
    Horas INT,
    FOREIGN KEY (idActividad) REFERENCES Actividad(idActividad),
    FOREIGN KEY (CCPersona) REFERENCES Persona(CCPersona)
) ENGINE=InnoDB;

-- ===================================
-- TABLA Presupuesto
-- ===================================

CREATE TABLE Presupuesto (
    idPresupuesto INT AUTO_INCREMENT PRIMARY KEY,
    idActividad INT,
    MontoPlaneado DECIMAL(10,2),
    MontoEjecutado DECIMAL(10,2),
    PorcentajeEjecutado DECIMAL(10,2),
    FuenteFinanciacion VARCHAR(100),
    Ingresos INT,
    Egresos INT,
    FOREIGN KEY (idActividad) REFERENCES Actividad(idActividad)
) ENGINE=InnoDB;


#INSERTS DE EJEMPLO:
INSERT INTO ODS (idODS, Nombre) VALUES
(1, 'Fin de la pobreza'),
(2, 'Hambre cero'),
(3, 'Salud y bienestar'),
(4, 'Educación de calidad'),
(5, 'Igualdad de género'),
(6, 'Agua limpia y saneamiento'),
(7, 'Energía asequible y no contaminante'),
(8, 'Trabajo decente y crecimiento económico'),
(9, 'Industria, innovación e infraestructura'),
(10, 'Reducción de las desigualdades');

INSERT INTO LineaInv (idLinea, Nombre, idODS1, idODS2) VALUES
(1, 'Política Pública', 4, 8),
(2, 'Desarrollo Territorial', 9, 10),
(3, 'Educación Económica', 4, 1),
(4, 'Innovación Social', 5, 8),
(5, 'Finanzas Sostenibles', 8, 7);

INSERT INTO TipoActividad (idTipo, Tipo) VALUES
(1, 'Consultoría'),
(2, 'MOOC'),
(3, 'Educación Continua'),
(4, 'Evento'),
(5, 'Voluntariado');

INSERT INTO FuenteActividad (idFuente, NombreFuente, Descripcion) VALUES
(1, 'Proyectos de Consultoría', 'Actividades de consultoría externa e interna'),
(2, 'Convenios', 'Actividades desarrolladas bajo convenios institucionales'),
(3, 'Educon', 'Cursos de educación continua'),
(4, 'MOOCs', 'Cursos masivos en línea'),
(5, 'Egresados', 'Eventos y actividades para egresados'),
(6, 'Laboratorio de Finanzas', 'Actividades y talleres del laboratorio'),
(7, 'Movilidad Global', 'Intercambios y movilidad académica'),
(8, 'Premios y Distinciones', 'Reconocimientos y concursos'),
(9, 'Eventos', 'Seminarios, conferencias, talleres'),
(10, 'Voluntariado', 'Acciones de voluntariado universitario');

INSERT INTO ProgramaAcademico (idPrograma, NombrePrograma, Facultad, Nivel) VALUES
-- ========================
-- PREGRADOS
-- ========================
(1, 'Economía', 'Facultad de Economía', 'Pregrado'),
(2, 'Finanzas y Comercio Internacional', 'Escuela de Administración', 'Pregrado'),
(3, 'Administración de Empresas', 'Escuela de Administración', 'Pregrado'),
(4, 'Contaduría Pública', 'Escuela de Administración', 'Pregrado'),
(5, 'Jurisprudencia', 'Facultad de Jurisprudencia', 'Pregrado'),
(6, 'Ciencia Política y Gobierno', 'Escuela de Ciencias Humanas', 'Pregrado'),
(7, 'Relaciones Internacionales', 'Escuela de Ciencias Humanas', 'Pregrado'),
(8, 'Periodismo y Opinión Pública', 'Escuela de Ciencias Humanas', 'Pregrado'),
(9, 'Historia', 'Escuela de Ciencias Humanas', 'Pregrado'),
(10, 'Psicología', 'Escuela de Medicina y Ciencias de la Salud', 'Pregrado'),
(11, 'Medicina', 'Escuela de Medicina y Ciencias de la Salud', 'Pregrado'),
(12, 'Fisioterapia', 'Escuela de Medicina y Ciencias de la Salud', 'Pregrado'),
(13, 'Terapia Ocupacional', 'Escuela de Medicina y Ciencias de la Salud', 'Pregrado'),
(14, 'Enfermería', 'Escuela de Medicina y Ciencias de la Salud', 'Pregrado'),
(15, 'Ingeniería Biomédica', 'Escuela de Ingeniería, Ciencia y Tecnología', 'Pregrado'),
(16, 'Ingeniería de Sistemas', 'Escuela de Ingeniería, Ciencia y Tecnología', 'Pregrado'),
(17, 'Ingeniería Industrial', 'Escuela de Ingeniería, Ciencia y Tecnología', 'Pregrado'),
(18, 'Gestión y Desarrollo Urbanos', 'Escuela de Ciencias Humanas', 'Pregrado'),

-- ========================
-- POSGRADOS
-- ========================
(19, 'Maestría en Economía', 'Facultad de Economía', 'Posgrado'),
(20, 'Maestría en Gestión Pública', 'Escuela de Gobierno', 'Posgrado'),
(21, 'Maestría en Estudios Políticos e Internacionales', 'Escuela de Ciencias Humanas', 'Posgrado'),
(22, 'Maestría en Evaluación de Políticas Públicas', 'Escuela de Gobierno', 'Posgrado'),
(23, 'Maestría en Analítica de Datos', 'Escuela de Ingeniería, Ciencia y Tecnología', 'Posgrado'),
(24, 'Maestría en Derecho Internacional', 'Facultad de Jurisprudencia', 'Posgrado'),
(25, 'Maestría en Epidemiología', 'Escuela de Medicina y Ciencias de la Salud', 'Posgrado'),
(26, 'Maestría en Desarrollo Territorial', 'Escuela de Ciencias Humanas', 'Posgrado'),
(27, 'Especialización en Finanzas', 'Escuela de Administración', 'Posgrado'),
(28, 'Especialización en Big Data y Analítica', 'Escuela de Ingeniería, Ciencia y Tecnología', 'Posgrado'),
(29, 'Especialización en Derecho Administrativo', 'Facultad de Jurisprudencia', 'Posgrado'),
(30, 'MBA - Maestría en Administración', 'Escuela de Administración', 'Posgrado');

INSERT INTO Entidad 
(idEntidad, Nombre, Tipo, Pais, Nacional, Contacto, Email, Direccion, Telefono, Sector, Ciudad) VALUES
-- ==========================
-- ENTIDADES PÚBLICAS
-- ==========================
(1, 'Banco de la República', 'Pública', 'Colombia', 1, 'Carlos López', 'clopez@banrep.gov.co', 'Cra 7 #14-78', '6013431111', 'Financiero', 'Bogotá'),
(2, 'Ministerio de Educación Nacional', 'Pública', 'Colombia', 1, 'Jorge Pérez', 'jperez@mineducacion.gov.co', 'Calle 26 #10-45', '6012222800', 'Educación', 'Bogotá'),
(3, 'Departamento Nacional de Planeación (DNP)', 'Pública', 'Colombia', 1, 'Ana Camargo', 'acamargo@dnp.gov.co', 'Cl 26 #13-19', '6013815000', 'Planeación', 'Bogotá'),
(4, 'Alcaldía Mayor de Bogotá', 'Pública', 'Colombia', 1, 'Diana Salazar', 'dsalazar@bogota.gov.co', 'Cra 8 #10-65', '6013813000', 'Gobierno', 'Bogotá'),
(5, 'SENA - Dirección General', 'Pública', 'Colombia', 1, 'María Gómez', 'mgomez@sena.edu.co', 'Av. 68 #49A-47', '6015461500', 'Formación Técnica', 'Bogotá'),

-- ==========================
-- ONG / FUNDACIONES
-- ==========================
(6, 'UNICEF Colombia', 'ONG', 'Colombia', 1, 'Miguel Herrera', 'mherrera@unicef.org', 'Cra 9 #60-50', '6012571254', 'Niñez', 'Bogotá'),
(7, 'ACDI/VOCA', 'ONG', 'Estados Unidos', 0, 'John Davis', 'jdavis@acdivoca.org', '2400 N St NW', '1202987456', 'Desarrollo', 'Washington D.C.'),
(8, 'Fondo Acción', 'ONG', 'Colombia', 1, 'Oscar Martínez', 'omartinez@fondoaccion.org', 'Cra 5 #26-20', '6013472929', 'Ambiental', 'Bogotá'),
(9, 'Fundación Corona', 'ONG', 'Colombia', 1, 'Martín Rojas', 'mrojas@fundacioncorona.org', 'Cl 82 #10-33', '6017440444', 'Desarrollo Social', 'Bogotá'),
(10, 'Save the Children Colombia', 'ONG', 'Colombia', 1, 'Lorena Suárez', 'lsuarez@savethechildren.org', 'Cl 95 # 14-35', '6017440250', 'Niñez', 'Bogotá'),

-- ==========================
-- ENTIDADES MULTILATERALES
-- ==========================
(11, 'ONU Mujeres', 'Multilateral', 'Internacional', 0, 'Lucía Méndez', 'lmendez@unwomen.org', 'Av. Naciones Unidas 12', '12125550000', 'Equidad de Género', 'Nueva York'),
(12, 'Banco Mundial', 'Multilateral', 'Estados Unidos', 0, 'Emily Smith', 'esmith@worldbank.org', '1818 H St NW', '12024731000', 'Desarrollo Económico', 'Washington D.C.'),
(13, 'UNESCO', 'Multilateral', 'Francia', 0, 'Claude Dupont', 'cdupont@unesco.org', '7 Pl. de Fontenoy', '331456789', 'Educación y Cultura', 'París'),

-- ==========================
-- EMPRESAS PRIVADAS
-- ==========================
(14, 'Cámara de Comercio de Bogotá', 'Privada', 'Colombia', 1, 'Sandra Díaz', 'sdiaz@ccb.org.co', 'Cl 74 #11-68', '6013830330', 'Empresarial', 'Bogotá'),
(15, 'Google LATAM', 'Privada', 'Estados Unidos', 0, 'Sara Lin', 'sara.lin@google.com', '1600 Amphitheatre Pkwy', '16504500000', 'Tecnología', 'Mountain View'),
(16, 'Nestlé Global', 'Privada', 'Suiza', 0, 'Stefan Müller', 'stefan.mueller@nestle.com', 'Avenue Nestlé 55', '41219242424', 'Alimentos', 'Vevey'),
(17, 'Nutresa', 'Privada', 'Colombia', 1, 'Angela Torres', 'atorres@nutresa.com', 'Cra 52 #2-38', '6044443600', 'Alimentos', 'Medellín'),
(18, 'Ecopetrol', 'Privada', 'Colombia', 1, 'Carlos Medina', 'cmedina@ecopetrol.com.co', 'Cl 37 # 8-43', '6012344000', 'Energía', 'Bogotá'),

-- ==========================
-- UNIVERSIDADES & CENTROS DE INVESTIGACIÓN
-- ==========================
(19, 'Universidad Nacional de Colombia', 'Pública', 'Colombia', 1, 'Luis Ramírez', 'lramirez@unal.edu.co', 'Cra 30 #45-03', '6013165000', 'Educación Superior', 'Bogotá'),
(20, 'Fedesarrollo', 'Privada', 'Colombia', 1, 'Carlos Torres', 'ctorres@fedesarrollo.org.co', 'Cl 78 #9-91', '6013474111', 'Investigación Económica', 'Bogotá');

INSERT INTO Persona 
(CCPersona, Nombre, Apellido, Email, idPrograma, Nacionalidad, Egresado, Experiencia, Intercambio, Funcion) VALUES
(1001, 'Laura', 'Gómez', 'laura.gomez@urosario.edu.co', 1, 'Colombiana', 0, 'Asistencia en proyectos de economía pública.', 1, 'Estudiante'),
(1002, 'Mateo', 'Ramírez', 'mateo.ramirez@urosario.edu.co', 3, 'Colombiana', 1, 'Investigación en gestión pública.', 0, 'Monitor'),
(1003, 'Daniela', 'Cortés', 'daniela.cortes@urosario.edu.co', 2, 'Colombiana', 0, 'Tutoría en métodos cuantitativos y finanzas.', 1, 'Estudiante'),
(1004, 'Sofía', 'Hernández', 'sofia.hernandez@urosario.edu.co', 6, 'Colombiana', 1, 'Apoyo en proyectos de ciencia política.', 0, 'Asistente'),
(1005, 'Juan', 'Martínez', 'juan.martinez@urosario.edu.co', 7, 'Colombiana', 1, 'Relaciones internacionales y cooperación.', 1, 'Profesor Cátedra'),
(1006, 'Valentina', 'Rojas', 'valentina.rojas@urosario.edu.co', 5, 'Colombiana', 0, 'Auxiliar jurídica en proyectos sociales.', 0, 'Estudiante'),
(1007, 'Tomás', 'Ospina', 'tomas.ospina@urosario.edu.co', 1, 'Colombiana', 1, 'Investigación aplicada en econometría.', 1, 'Profesor Planta'),
(1008, 'María', 'Fernández', 'maria.fernandez@urosario.edu.co', 10, 'Colombiana', 0, 'Asistencia en programas de bienestar.', 0, 'Estudiante'),
(1009, 'Alejandro', 'Pérez', 'alejandro.perez@urosario.edu.co', 16, 'Colombiana', 0, 'Proyectos en ingeniería de datos.', 1, 'Estudiante'),
(1010, 'Isabella', 'Torres', 'isabella.torres@urosario.edu.co', 8, 'Colombiana', 1, 'Producción editorial y contenidos públicos.', 0, 'Asistente'),

(1011, 'Camilo', 'García', 'camilo.garcia@urosario.edu.co', 2, 'Colombiana', 1, 'Asistencia técnica en comercio internacional.', 0, 'Monitor'),
(1012, 'Sara', 'Navarro', 'sara.navarro@urosario.edu.co', 11, 'Colombiana', 0, 'Rotación clínica y apoyo en brigadas.', 0, 'Estudiante'),
(1013, 'Nicolás', 'Vargas', 'nicolas.vargas@urosario.edu.co', 12, 'Colombiana', 1, 'Prácticas en rehabilitación comunitaria.', 0, 'Estudiante'),
(1014, 'Juliana', 'Acosta', 'juliana.acosta@urosario.edu.co', 15, 'Colombiana', 1, 'Proyectos biomédicos con énfasis en sensores.', 0, 'Investigadora'),
(1015, 'Samuel', 'Ruiz', 'samuel.ruiz@urosario.edu.co', 3, 'Colombiana', 0, 'Asistencia en evaluación financiera.', 0, 'Estudiante'),

(1016, 'Elena', 'Méndez', 'elena.mendez@urosario.edu.co', 14, 'Colombiana', 1, 'Voluntariado en salud pública.', 0, 'Estudiante'),
(1017, 'David', 'Zuluaga', 'david.zuluaga@urosario.edu.co', 17, 'Colombiana', 1, 'Optimización de procesos industriales.', 0, 'Monitor'),
(1018, 'Carolina', 'Guzmán', 'carolina.guzman@urosario.edu.co', 18, 'Colombiana', 0, 'Gestión territorial y proyectos urbanos.', 1, 'Estudiante'),
(1019, 'Manuela', 'Cárdenas', 'manuela.cardenas@urosario.edu.co', 1, 'Colombiana', 1, 'Investigación en pobreza multidimensional.', 0, 'Asistente'),
(1020, 'Luis', 'Muñoz', 'luis.munoz@urosario.edu.co', 7, 'Colombiana', 0, 'Cooperación internacional y diplomacia.', 1, 'Estudiante'),

(1021, 'Gabriela', 'Salinas', 'gabriela.salinas@urosario.edu.co', 6, 'Colombiana', 0, 'Análisis de políticas públicas.', 0, 'Estudiante'),
(1022, 'Felipe', 'Ortega', 'felipe.ortega@urosario.edu.co', 9, 'Colombiana', 1, 'Proyectos de memoria histórica.', 0, 'Investigador'),
(1023, 'Lucía', 'Prieto', 'lucia.prieto@urosario.edu.co', 3, 'Colombiana', 1, 'Consultoría administrativa.', 1, 'Asistente'),
(1024, 'Martín', 'Cortés', 'martin.cortes@urosario.edu.co', 2, 'Colombiana', 0, 'Investigación en mercados internacionales.', 1, 'Estudiante'),
(1025, 'Tomás', 'López', 'tomas.lopez@urosario.edu.co', 8, 'Colombiana', 1, 'Producción de contenidos digitales.', 0, 'Estudiante'),

(1026, 'Andrea', 'Serrano', 'andrea.serrano@urosario.edu.co', 13, 'Colombiana', 0, 'Apoyo en proyectos de inclusión.', 0, 'Estudiante'),
(1027, 'Juan Pablo', 'Arango', 'juan.arango@urosario.edu.co', 1, 'Colombiana', 1, 'Investigación en economía laboral.', 1, 'Profesor Cátedra'),
(1028, 'Camila', 'Vargas', 'camila.vargas@urosario.edu.co', 5, 'Colombiana', 0, 'Auxiliar jurídica en extensión.', 0, 'Estudiante'),
(1029, 'Emilio', 'Ramírez', 'emilio.ramirez@urosario.edu.co', 16, 'Colombiana', 0, 'Modelado de datos aplicado a política pública.', 1, 'Estudiante'),
(1030, 'Isabel', 'Molina', 'isabel.molina@urosario.edu.co', 10, 'Colombiana', 1, 'Trabajo con comunidades vulnerables.', 0, 'Estudiante'),

(1031, 'Sebastián', 'Gómez', 'sebastian.gomez@urosario.edu.co', 19, 'Colombiana', 1, 'Maestría en Economía: asistente de investigación.', 0, 'Estudiante Posgrado'),
(1032, 'Daniel', 'Santos', 'daniel.santos@urosario.edu.co', 23, 'Colombiana', 0, 'Proyectos de analítica aplicada.', 0, 'Alumno'),
(1033, 'Alejandra', 'Nieves', 'alejandra.nieves@urosario.edu.co', 21, 'Colombiana', 1, 'Investigación política internacional.', 1, 'Estudiante Posgrado'),
(1034, 'Santiago', 'Rosales', 'santiago.rosales@urosario.edu.co', 27, 'Colombiana', 1, 'Consultoría financiera.', 0, 'Estudiante Posgrado'),
(1035, 'Paula', 'Cruz', 'paula.cruz@urosario.edu.co', 30, 'Colombiana', 1, 'Gestión estratégica en empresas.', 0, 'Estudiante Posgrado'),

(1036, 'Valeria', 'Pineda', 'valeria.pineda@urosario.edu.co', 22, 'Colombiana', 1, 'Evaluación de políticas públicas.', 1, 'Asistente Investigación'),
(1037, 'Carlos', 'Mejía', 'carlos.mejia@urosario.edu.co', 20, 'Colombiana', 1, 'Gestión pública territorial.', 0, 'Estudiante Posgrado'),
(1038, 'Julieta', 'Riveros', 'julieta.riveros@urosario.edu.co', 18, 'Colombiana', 0, 'Proyectos urbanos sostenibles.', 0, 'Estudiante'),
(1039, 'Diego', 'Castro', 'diego.castro@urosario.edu.co', 17, 'Colombiana', 0, 'Optimización logística.', 1, 'Monitor'),
(1040, 'Mariana', 'López', 'mariana.lopez@urosario.edu.co', 1, 'Colombiana', 1, 'Análisis económico regional.', 0, 'Investigadora'),

(1041, 'Lucía', 'Gaitán', 'lucia.gaitan@urosario.edu.co', 10, 'Colombiana', 0, 'Psicología organizacional.', 0, 'Estudiante'),
(1042, 'Juan Diego', 'Sánchez', 'juan.sanchez@urosario.edu.co', 11, 'Colombiana', 0, 'Salud pública comunitaria.', 0, 'Estudiante'),
(1043, 'Adriana', 'Peña', 'adriana.pena@urosario.edu.co', 7, 'Colombiana', 1, 'Diplomacia y relaciones multilaterales.', 1, 'Asistente'),
(1044, 'Esteban', 'Morales', 'esteban.morales@urosario.edu.co', 19, 'Colombiana', 1, 'Investigación macroeconómica.', 0, 'Estudiante Posgrado'),
(1045, 'Valeria', 'Salamanca', 'valeria.salamanca@urosario.edu.co', 8, 'Colombiana', 0, 'Comunicación estratégica.', 0, 'Estudiante');

INSERT INTO Actividad 
(idActividad, idFinanciero, Nombre, idTipoActividad, idFuente, Modalidad, Periodo, FechaInicio, FechaFin, idLinea, idEntidad, Avance) VALUES
(1, 7101, 'Consultoría en Análisis Territorial para Municipios PDET', 1, 1, 'Híbrida', '2025-1', '2025-02-01', '2025-05-30', 2, 9, 0.81),
(2, 7102, 'MOOC: Gobernanza y Participación Ciudadana', 2, 4, 'Virtual', '2025-1', '2025-03-10', '2025-06-10', 1, 5, 0.89),
(3, 7103, 'Diplomado en Finanzas Verdes y Sostenibilidad', 3, 3, 'Virtual', '2025-2', '2025-08-01', '2025-11-25', 5, 12, 0.75),
(4, 7104, 'Seminario Internacional sobre Evaluación de Políticas Públicas', 4, 9, 'Presencial', '2025-1', '2025-04-18', '2025-04-20', 1, 1, 0.92),
(5, 7105, 'Voluntariado en Alfabetización Financiera Comunitaria', 5, 10, 'Presencial', '2025-2', '2025-07-03', '2025-10-05', 3, 8, 0.72),

(6, 7106, 'Consultoría: Reformas Educativas con Enfoque de Equidad', 1, 1, 'Híbrida', '2025-2', '2025-08-15', '2025-12-02', 4, 3, 0.84),
(7, 7107, 'MOOC sobre Transformación Digital en el Sector Público', 2, 4, 'Virtual', '2025-1', '2025-02-20', '2025-05-25', 1, 15, 0.86),
(8, 7108, 'Curso Especializado en Análisis de Datos Públicos', 3, 3, 'Híbrida', '2025-2', '2025-08-05', '2025-11-20', 3, 2, 0.77),
(9, 7109, 'Foro: Desarrollo Urbano y Movilidad Inteligente', 4, 9, 'Presencial', '2025-1', '2025-03-10', '2025-03-12', 2, 19, 0.94),
(10, 7110, 'Programa de Voluntariado Ambiental Escolar', 5, 10, 'Presencial', '2025-2', '2025-07-10', '2025-10-15', 4, 16, 0.69),

(11, 7111, 'Consultoría en Monitoreo y Evaluación de Programas Sociales', 1, 1, 'Virtual', '2025-1', '2025-02-12', '2025-06-02', 1, 6, 0.82),
(12, 7112, 'MOOC: Economía del Comportamiento Aplicada', 2, 4, 'Virtual', '2025-1', '2025-03-01', '2025-06-05', 3, 11, 0.91),
(13, 7113, 'Diplomado en Innovación Social y Desarrollo Comunitario', 3, 3, 'Híbrida', '2025-2', '2025-08-18', '2025-12-05', 4, 5, 0.74),
(14, 7114, 'Seminario: Género, Economía y Desigualdad', 4, 9, 'Virtual', '2025-2', '2025-09-12', '2025-09-13', 4, 2, 0.95),
(15, 7115, 'Voluntariado en Proyectos de Desarrollo Local', 5, 10, 'Presencial', '2025-2', '2025-07-20', '2025-10-20', 2, 18, 0.68),

(16, 7116, 'Consultoría en Evaluación de Estrategias Educativas', 1, 1, 'Híbrida', '2025-1', '2025-02-05', '2025-05-30', 3, 4, 0.83),
(17, 7117, 'MOOC: Inteligencia Artificial para el Sector Público', 2, 4, 'Virtual', '2025-1', '2025-03-18', '2025-06-22', 1, 17, 0.87),
(18, 7118, 'Curso: Gestión de Proyectos Sociales', 3, 3, 'Virtual', '2025-2', '2025-08-10', '2025-11-22', 4, 10, 0.73),
(19, 7119, 'Foro Regional: Educación de Calidad y ODS 4', 4, 9, 'Presencial', '2025-1', '2025-04-12', '2025-04-14', 3, 3, 0.93),
(20, 7120, 'Voluntariado en Infraestructura Comunitaria', 5, 10, 'Híbrida', '2025-2', '2025-07-08', '2025-10-12', 2, 7, 0.71),

(21, 7121, 'Consultoría Económica para Programas de Empleo Urbano', 1, 1, 'Híbrida', '2025-1', '2025-02-01', '2025-06-01', 1, 1, 0.84),
(22, 7122, 'MOOC: Introducción a Finanzas Públicas', 2, 4, 'Virtual', '2025-1', '2025-03-05', '2025-06-15', 3, 6, 0.88),
(23, 7123, 'Diplomado en Planeación Urbana Participativa', 3, 3, 'Presencial', '2025-2', '2025-08-02', '2025-11-28', 2, 9, 0.79),
(24, 7124, 'Seminario: Transformación Digital en Gobiernos Locales', 4, 9, 'Híbrida', '2025-1', '2025-04-08', '2025-04-10', 1, 17, 0.96),
(25, 7125, 'Voluntariado en Educación Ambiental Escolar', 5, 10, 'Presencial', '2025-2', '2025-07-22', '2025-10-22', 4, 16, 0.76),

(26, 7126, 'Consultoría: Políticas de Seguridad Alimentaria', 1, 1, 'Virtual', '2025-2', '2025-08-01', '2025-11-30', 2, 14, 0.78),
(27, 7127, 'MOOC: Innovación Social para el Desarrollo', 2, 4, 'Virtual', '2025-1', '2025-02-24', '2025-05-24', 4, 5, 0.89),
(28, 7128, 'Curso: Métodos Cuantitativos para el Sector Público', 3, 3, 'Híbrida', '2025-2', '2025-08-07', '2025-11-23', 1, 1, 0.75),
(29, 7129, 'Foro: Industrialización y Desarrollo Rural', 4, 9, 'Presencial', '2025-1', '2025-03-20', '2025-03-22', 2, 20, 0.95),
(30, 7130, 'Voluntariado de Intervención Comunitaria Multisectorial', 5, 10, 'Presencial', '2025-2', '2025-07-04', '2025-10-05', 3, 18, 0.70),

(31, 7131, 'Consultoría en Inclusión Financiera de Mujeres', 1, 1, 'Híbrida', '2025-1', '2025-02-10', '2025-05-28', 5, 2, 0.85),
(32, 7132, 'MOOC: Evaluación de Impacto para Políticas Públicas', 2, 4, 'Virtual', '2025-1', '2025-03-14', '2025-06-20', 3, 10, 0.90),
(33, 7133, 'Diplomado en Género y Gobernanza', 3, 3, 'Presencial', '2025-2', '2025-08-03', '2025-11-27', 4, 11, 0.76),
(34, 7134, 'Seminario de Innovación en Educación Rural', 4, 9, 'Virtual', '2025-1', '2025-04-01', '2025-04-03', 3, 3, 0.92),
(35, 7135, 'Voluntariado de Mentoría Académica Universitaria', 5, 10, 'Híbrida', '2025-2', '2025-07-18', '2025-10-18', 1, 7, 0.73),

(36, 7136, 'Consultoría para Planeación Estratégica Municipal', 1, 1, 'Virtual', '2025-1', '2025-02-08', '2025-05-25', 2, 4, 0.83),
(37, 7137, 'MOOC: Macroeconomía Aplicada para el Desarrollo', 2, 4, 'Virtual', '2025-1', '2025-03-22', '2025-06-18', 1, 1, 0.88),
(38, 7138, 'Curso: Inteligencia de Datos para ONGs', 3, 3, 'Híbrida', '2025-2', '2025-08-14', '2025-11-26', 3, 19, 0.77),
(39, 7139, 'Foro sobre Desigualdad y Pobreza Multidimensional', 4, 9, 'Presencial', '2025-1', '2025-03-05', '2025-03-06', 1, 13, 0.95),
(40, 7140, 'Voluntariado en Orientación para Migrantes', 5, 10, 'Presencial', '2025-2', '2025-07-15', '2025-10-25', 4, 5, 0.72),

(41, 7141, 'Consultoría: Educación Financiera Juvenil', 1, 1, 'Híbrida', '2025-1', '2025-02-03', '2025-05-29', 3, 12, 0.84),
(42, 7142, 'MOOC: Política Exterior y Cooperación Internacional', 2, 4, 'Virtual', '2025-1', '2025-03-17', '2025-06-30', 4, 11, 0.89),
(43, 7143, 'Diplomado en Gestión Pública Territorial', 3, 3, 'Presencial', '2025-2', '2025-08-12', '2025-11-30', 2, 9, 0.78),
(44, 7144, 'Seminario sobre Ciudades Inteligentes', 4, 9, 'Híbrida', '2025-1', '2025-04-07', '2025-04-09', 3, 17, 0.93),
(45, 7145, 'Voluntariado para Tutorías en Matemáticas', 5, 10, 'Presencial', '2025-2', '2025-07-12', '2025-10-11', 3, 7, 0.65),

(46, 7146, 'Consultoría en Políticas de Juventud', 1, 1, 'Virtual', '2025-1', '2025-02-02', '2025-05-20', 4, 18, 0.82),
(47, 7147, 'MOOC: Innovación Educativa con TIC', 2, 4, 'Virtual', '2025-1', '2025-03-12', '2025-06-12', 3, 3, 0.87),
(48, 7148, 'Curso: Finanzas Públicas Locales', 3, 3, 'Híbrida', '2025-2', '2025-08-06', '2025-11-28', 1, 1, 0.77),
(49, 7149, 'Foro: Gobernanza Metropolitana', 4, 9, 'Presencial', '2025-1', '2025-03-14', '2025-03-15', 2, 9, 0.94),
(50, 7150, 'Voluntariado en Proyectos de Salud Comunitaria', 5, 10, 'Presencial', '2025-2', '2025-07-02', '2025-10-10', 4, 11, 0.75);

INSERT INTO Presupuesto 
(idActividad, MontoPlaneado, MontoEjecutado, PorcentajeEjecutado, FuenteFinanciacion, Ingresos, Egresos) VALUES
(1, 52000000, 43000000, 82.69, 'Cooperación Internacional', 55000000, 43000000),
(2, 30000000, 27000000, 90.00, 'Entidad Multilateral', 31000000, 27000000),
(3, 48000000, 36000000, 75.00, 'Recursos Propios', 50000000, 36000000),
(4, 18000000, 17000000, 94.44, 'Patrocinio Privado', 19000000, 17000000),
(5, 26000000, 20000000, 76.92, 'Donaciones y Voluntariado', 28000000, 20000000),

(6, 51000000, 42000000, 82.35, 'Cooperación Internacional', 54000000, 42000000),
(7, 22000000, 19500000, 88.64, 'Entidad Tecnológica', 23500000, 19500000),
(8, 35000000, 28000000, 80.00, 'Recursos Propios', 36000000, 28000000),
(9, 15000000, 14500000, 96.67, 'Patrocinio Empresarial', 16000000, 14500000),
(10, 30000000, 22000000, 73.33, 'ONG Ambiental', 31000000, 22000000),

(11, 54000000, 43000000, 79.63, 'Cooperación Internacional', 58000000, 43000000),
(12, 24000000, 21500000, 89.58, 'Recursos Propios', 25000000, 21500000),
(13, 42000000, 31000000, 73.81, 'Entidad ONG', 44000000, 31000000),
(14, 20000000, 19000000, 95.00, 'Organismo Multilateral', 21500000, 19000000),
(15, 27500000, 20500000, 74.55, 'Gobierno Local', 29000000, 20500000),

(16, 49000000, 40000000, 81.63, 'Cooperación Internacional', 52000000, 40000000),
(17, 24500000, 21500000, 87.76, 'Entidad Tecnológica', 26000000, 21500000),
(18, 37000000, 30000000, 81.08, 'Recursos Propios', 38000000, 30000000),
(19, 16000000, 15000000, 93.75, 'Patrocinio Educativo', 17000000, 15000000),
(20, 29000000, 21500000, 74.14, 'ONG Internacional', 30000000, 21500000),

(21, 52000000, 43000000, 82.69, 'Cooperación Internacional', 54000000, 43000000),
(22, 25000000, 22000000, 88.00, 'Gobierno Nacional', 26000000, 22000000),
(23, 46000000, 36000000, 78.26, 'Recursos Propios', 48000000, 36000000),
(24, 21000000, 20000000, 95.24, 'Entidad Innovación', 22000000, 20000000),
(25, 28000000, 23000000, 82.14, 'ONG Ambiental', 29000000, 23000000),

(26, 50000000, 39000000, 78.00, 'Cooperación Internacional', 53000000, 39000000),
(27, 24000000, 21500000, 89.58, 'Cooperación Académica', 26000000, 21500000),
(28, 34000000, 27000000, 79.41, 'Recursos Propios', 36000000, 27000000),
(29, 18000000, 17200000, 95.56, 'Patrocinio Sector Industrial', 19000000, 17200000),
(30, 30000000, 24000000, 80.00, 'ONG Internacional', 32000000, 24000000),

(31, 47000000, 39500000, 84.04, 'Cooperación Financiera', 49000000, 39500000),
(32, 27000000, 24000000, 88.89, 'Entidad Multilateral', 29000000, 24000000),
(33, 43000000, 33000000, 76.74, 'Recursos Propios', 45000000, 33000000),
(34, 19000000, 18200000, 95.79, 'ONG Educativa', 20000000, 18200000),
(35, 26000000, 20500000, 78.85, 'Voluntariado Académico', 27500000, 20500000),

(36, 51000000, 42000000, 82.35, 'Cooperación Territorial', 53000000, 42000000),
(37, 25000000, 22000000, 88.00, 'Organismo Económico', 26500000, 22000000),
(38, 36000000, 29000000, 80.56, 'Fundación Internacional', 38000000, 29000000),
(39, 17000000, 16300000, 95.88, 'Patrocinio Académico', 18000000, 16300000),
(40, 29000000, 23000000, 79.31, 'ONG Migratoria', 30500000, 23000000),

(41, 49500000, 41000000, 82.83, 'Cooperación Bancaria', 52000000, 41000000),
(42, 27000000, 24000000, 88.89, 'Organismo Multilateral', 29000000, 24000000),
(43, 45500000, 35000000, 76.92, 'Recursos Propios', 47000000, 35000000),
(44, 18500000, 17700000, 95.68, 'Entidad de Innovación Urbana', 19500000, 17700000),
(45, 25500000, 19500000, 76.47, 'Voluntariado Educativo', 27000000, 19500000),

(46, 50000000, 39000000, 78.00, 'Cooperación Internacional', 52000000, 39000000),
(47, 26000000, 23000000, 88.46, 'ONG Educativa', 27500000, 23000000),
(48, 35000000, 28000000, 80.00, 'Recursos Propios', 37000000, 28000000),
(49, 18000000, 17100000, 95.00, 'Patrocinio Metropolitano', 19500000, 17100000),
(50, 30000000, 24000000, 80.00, 'ONG Salud Pública', 31500000, 24000000);

INSERT INTO Participacion (idActividad, CCPersona, Rol, Horas) VALUES
-- 1
(1,1007,'Investigador',60), (1,1001,'Estudiante',40), (1,1021,'Asistente',35),
-- 2
(2,1005,'Profesor Cátedra',30), (2,1003,'Estudiante',32), (2,1006,'Auxiliar',28),
-- 3
(3,1018,'Estudiante',50), (3,1023,'Asistente',38), (3,1036,'Investigador',45),
-- 4
(4,1007,'Conferencista',20), (4,1031,'Investigador',30), (4,1044,'Estudiante Posgrado',25),
-- 5
(5,1008,'Voluntario',45), (5,1016,'Estudiante',30), (5,1026,'Facilitador',34),

-- 6
(6,1004,'Asistente',42), (6,1028,'Estudiante',35), (6,1037,'Investigador',50),
-- 7
(7,1009,'Analista',55), (7,1032,'Desarrollador',48), (7,1014,'Investigadora',40),
-- 8
(8,1015,'Tutor',48), (8,1034,'Estudiante Posgrado',33), (8,1037,'Asesor',30),
-- 9
(9,1020,'Moderador',28), (9,1024,'Investigador',35), (9,1038,'Coordinadora',40),
-- 10
(10,1019,'Voluntaria',32), (10,1001,'Estudiante',25), (10,1030,'Analista Social',40),

-- 11
(11,1007,'Investigador',55), (11,1001,'Asistente',35), (11,1023,'Estudiante',32),
-- 12
(12,1003,'Estudiante',28), (12,1021,'Investigadora',40), (12,1014,'Profesora',35),
-- 13
(13,1018,'Estudiante',42), (13,1026,'Asistente',30), (13,1036,'Investigador',50),
-- 14
(14,1005,'Panelista',20), (14,1031,'Investigador',27), (14,1028,'Estudiante',25),
-- 15
(15,1019,'Voluntaria',34), (15,1016,'Estudiante',28), (15,1026,'Facilitadora',30),

-- 16
(16,1004,'Asistente',38), (16,1009,'Analista',45), (16,1037,'Investigador',50),
-- 17
(17,1032,'Especialista TIC',50), (17,1014,'Investigadora',40), (17,1003,'Estudiante',32),
-- 18
(18,1023,'Coordinador',40), (18,1034,'Estudiante Posgrado',28), (18,1037,'Asesor',34),
-- 19
(19,1020,'Moderador',22), (19,1038,'Coordinadora',30), (19,1031,'Investigador',35),
-- 20
(20,1019,'Voluntaria',40), (20,1021,'Asistente',32), (20,1030,'Estudiante',28),

-- 21
(21,1007,'Analista Senior',55), (21,1001,'Estudiante',34), (21,1024,'Investigador',40),
-- 22
(22,1003,'Estudiante',30), (22,1014,'Docente',40), (22,1028,'Estudiante',35),
-- 23
(23,1018,'Estudiante',48), (23,1023,'Asistente',34), (23,1036,'Investigador',45),
-- 24
(24,1032,'Especialista TIC',45), (24,1014,'Panelista',25), (24,1009,'Analista',38),
-- 25
(25,1019,'Voluntaria',35), (25,1008,'Estudiante',28), (25,1026,'Facilitador',32),

-- 26
(26,1024,'Investigador',45), (26,1037,'Investigador',50), (26,1016,'Estudiante',35),
-- 27
(27,1005,'Profesor',30), (27,1003,'Estudiante',32), (27,1021,'Asistente',28),
-- 28
(28,1009,'Analista',50), (28,1034,'Estudiante Posgrado',33), (28,1031,'Investigador',40),
-- 29
(29,1020,'Moderador',20), (29,1024,'Investigador',35), (29,1038,'Coordinadora',38),
-- 30
(30,1019,'Voluntaria',38), (30,1016,'Estudiante',30), (30,1026,'Asistente',34),

-- 31
(31,1007,'Investigador',60), (31,1021,'Asistente',35), (31,1024,'Analista',45),
-- 32
(32,1003,'Estudiante',30), (32,1036,'Investigador',50), (32,1014,'Docente',40),
-- 33
(33,1018,'Estudiante',48), (33,1026,'Asistente',28), (33,1037,'Investigador',45),
-- 34
(34,1005,'Expositor',20), (34,1031,'Investigador',25), (34,1028,'Estudiante',30),
-- 35
(35,1019,'Voluntaria',42), (35,1008,'Estudiante',36), (35,1026,'Tutor',32),

-- 36
(36,1007,'Consultor',55), (36,1024,'Investigador',42), (36,1036,'Analista',40),
-- 37
(37,1003,'Estudiante',32), (37,1014,'Docente',38), (37,1032,'Analista',45),
-- 38
(38,1009,'Analista',55), (38,1034,'Estudiante Posgrado',35), (38,1038,'Coordinadora',40),
-- 39
(39,1020,'Moderador',22), (39,1024,'Investigador',30), (39,1031,'Investigador Senior',35),
-- 40
(40,1019,'Voluntaria',38), (40,1021,'Asistente',34), (40,1030,'Estudiante',30),

-- 41
(41,1007,'Investigador',58), (41,1023,'Asistente',36), (41,1036,'Analista',40),
-- 42
(42,1005,'Profesor Cátedra',28), (42,1003,'Estudiante',32), (42,1028,'Asistente',30),
-- 43
(43,1018,'Estudiante',44), (43,1023,'Asistente',36), (43,1037,'Investigador',48),
-- 44
(44,1009,'Analista',45), (44,1032,'Especialista TIC',50), (44,1014,'Docente',38),
-- 45
(45,1019,'Voluntaria',40), (45,1008,'Estudiante',30), (45,1026,'Tutor',32),

-- 46
(46,1004,'Asistente',40), (46,1028,'Estudiante',33), (46,1037,'Investigador',48),
-- 47
(47,1005,'Profesor',30), (47,1003,'Estudiante',32), (47,1014,'Docente',40),
-- 48
(48,1009,'Analista',55), (48,1034,'Estudiante Posgrado',34), (48,1031,'Investigador',40),
-- 49
(49,1020,'Moderador',25), (49,1038,'Coordinadora',38), (49,1024,'Investigador',40),
-- 50
(50,1019,'Voluntaria',36), (50,1021,'Asistente',32), (50,1030,'Estudiante',30);






CREATE OR REPLACE VIEW vw_actividades_riesgo AS
WITH actividad_resumen AS (
    SELECT 
        a.idActividad,
        a.Nombre,
        p.MontoEjecutado,
        p.Ingresos,
        p.Egresos,
        COUNT(pa.idParticipacion) AS Participantes,
        CASE 
            WHEN p.Egresos = 0 THEN NULL
            ELSE p.Ingresos / p.Egresos
        END AS Rentabilidad
    FROM Actividad a
    JOIN Presupuesto p ON p.idActividad = a.idActividad
    LEFT JOIN Participacion pa ON pa.idActividad = a.idActividad
    GROUP BY 
        a.idActividad,
        a.Nombre,
        p.MontoEjecutado,
        p.Ingresos,
        p.Egresos
),
kpis AS (
    SELECT
        AVG(MontoEjecutado) AS Prom_Monto,
        AVG(Rentabilidad)   AS Prom_Rent,
        AVG(Participantes)  AS Prom_Part
    FROM actividad_resumen
)

SELECT 
    r.*,
    (
        (r.MontoEjecutado > k.Prom_Monto) +
        (r.Rentabilidad   < k.Prom_Rent) +
        (r.Participantes  < k.Prom_Part)
    ) AS PuntosRiesgo
FROM actividad_resumen r
CROSS JOIN kpis k
WHERE
    (
        (r.MontoEjecutado > k.Prom_Monto) +
        (r.Rentabilidad   < k.Prom_Rent) +
        (r.Participantes  < k.Prom_Part)
    ) >= 2
ORDER BY PuntosRiesgo DESC, MontoEjecutado DESC;



/* ============================================================
   VISTA 2: Desempeño de Entidades por Periodo
   ------------------------------------------------------------
   Mide la actividad de cada entidad aliada en el tiempo:
     - Número de actividades realizadas
     - Avance promedio de esas actividades
   Esta vista es sencilla, rápida y perfecta para dashboards.
   ============================================================ */

CREATE OR REPLACE VIEW vw_entidades_desempeno AS
SELECT
    e.idEntidad,
    e.Nombre AS Entidad,
    a.Periodo,
    COUNT(a.idActividad) AS NumActividades,
    ROUND(AVG(a.Avance), 2) AS AvancePromedio
FROM Entidad e
JOIN Actividad a ON a.idEntidad = e.idEntidad
GROUP BY e.idEntidad, e.Nombre, a.Periodo
ORDER BY e.Nombre ASC, a.Periodo ASC;

/* ============================================================
   VISTA 3: Ranking de Participación de la Comunidad UR
   ------------------------------------------------------------
   Mide el compromiso de cada persona con las actividades
   institucionales. Incluye:
     - Nº de actividades
     - Horas totales contribuidas
     - Roles desempeñados
     - Función principal de la persona
   ============================================================ */

CREATE OR REPLACE VIEW vw_ranking_comunidad AS
SELECT 
    p.CCPersona,
    CONCAT(p.Nombre, ' ', p.Apellido) AS Persona,
    p.Funcion,
    
    COUNT(DISTINCT pa.idActividad) AS NumActividades,
    SUM(pa.Horas) AS TotalHoras,

    -- Conteos por tipo de rol
    SUM(pa.Rol = 'Docente')      AS RolesDocente,
    SUM(pa.Rol = 'Investigador') AS RolesInvestigador,
    SUM(pa.Rol = 'Estudiante')   AS RolesEstudiante,
    SUM(pa.Rol = 'Asistente')    AS RolesAsistente,
    SUM(pa.Rol = 'Coordinador')  AS RolesCoordinador

FROM Persona p
JOIN Participacion pa 
    ON pa.CCPersona = p.CCPersona

GROUP BY p.CCPersona, Persona, p.Funcion
ORDER BY NumActividades DESC, TotalHoras DESC;

/* ============================================================
   VISTA 4: Actividades por Línea de Investigación y ODS
   ------------------------------------------------------------
   Relaciona líneas de investigación con los ODS asociados.
   Mide:
     - Número de actividades por ODS
     - Avance promedio (%)
     - Códigos de actividades en esa intersección
   ============================================================ */

CREATE OR REPLACE VIEW vw_ods_lineas AS
SELECT
    li.idLinea,
    li.Nombre AS LineaInvestigacion,
    ods.idODS,
    ods.Nombre AS ODS,

    COUNT(a.idActividad) AS NumActividades,

    GROUP_CONCAT(a.idActividad ORDER BY a.idActividad SEPARATOR ', ') 
        AS CodigosActividades,

    ROUND(AVG(a.Avance) * 100, 2) AS PorcentajePromAvance

FROM Actividad a
JOIN LineaInv li 
    ON li.idLinea = a.idLinea

JOIN ODS ods 
    ON ods.idODS = li.idODS1 
    OR ods.idODS = li.idODS2

GROUP BY 
    li.idLinea,
    li.Nombre,
    ods.idODS,
    ods.Nombre

ORDER BY NumActividades DESC, PorcentajePromAvance DESC;

/* ============================================================
   VISTA 2: Participación por Programa Académico
   ------------------------------------------------------------
   Mide el grado de involucramiento de los programas UR en
   actividades institucionales:
     - Nº de actividades
     - Horas totales
     - Roles desempeñados
     - Nivel (Pregrado / Posgrado)
     - Facultad
   ============================================================ */

CREATE OR REPLACE VIEW vw_programas_participacion AS
SELECT
    pa.idPrograma,
    pa.NombrePrograma,
    pa.Facultad,
    pa.Nivel,

    COUNT(DISTINCT a.idActividad) AS NumActividades,
    SUM(p.Horas) AS TotalHoras,

    SUM(p.Rol = 'Docente')      AS RolDocente,
    SUM(p.Rol = 'Investigador') AS RolInvestigador,
    SUM(p.Rol = 'Estudiante')   AS RolEstudiante,
    SUM(p.Rol = 'Asistente')    AS RolAsistente,
    SUM(p.Rol = 'Coordinador')  AS RolCoordinador

FROM ProgramaAcademico pa
JOIN Persona pe 
    ON pe.idPrograma = pa.idPrograma
JOIN Participacion p 
    ON p.CCPersona = pe.CCPersona
JOIN Actividad a
    ON a.idActividad = p.idActividad

GROUP BY pa.idPrograma, pa.NombrePrograma, pa.Facultad, pa.Nivel
ORDER BY NumActividades DESC;

/* ============================================================
   VISTA 4: Actividades por Fuente de Financiación
   ------------------------------------------------------------
   Analiza el desempeño de cada fuente:
     - Nº actividades
     - Monto planeado vs ejecutado
     - Ejecución %
     - Rentabilidad (Ingresos/Egresos)
     - Avance promedio
   ============================================================ */

CREATE OR REPLACE VIEW vw_fuentes_financiacion AS
SELECT
    f.idFuente,
    f.NombreFuente,

    COUNT(a.idActividad) AS NumActividades,

    SUM(p.MontoPlaneado) AS TotalPlaneado,
    SUM(p.MontoEjecutado) AS TotalEjecutado,

    ROUND(AVG(p.PorcentajeEjecutado), 2) AS EjecucionPromedio,

    ROUND(AVG(a.Avance), 2) AS AvancePromedio,

    ROUND(AVG(
        CASE WHEN p.Egresos = 0 THEN NULL 
             ELSE p.Ingresos / p.Egresos 
        END
    ), 2) AS RentabilidadPromedio

FROM FuenteActividad f
LEFT JOIN Actividad a 
    ON a.idFuente = f.idFuente
LEFT JOIN Presupuesto p
    ON p.idActividad = a.idActividad

GROUP BY f.idFuente, f.NombreFuente
ORDER BY TotalEjecutado DESC;

/* ============================================================
   VISTA 5: Estado de las Actividades
   ------------------------------------------------------------
   Clasifica actividades en:
     - Terminadas (Avance = 100)
     - En Curso (FechaFin >= HOY)
     - Retrasadas (FechaFin < HOY y Avance < 100)
   ============================================================ */

CREATE OR REPLACE VIEW vw_estado_actividades AS
SELECT
    a.idActividad,
    a.Nombre,
    a.Periodo,
    a.FechaInicio,
    a.FechaFin,
    a.Avance,

    CASE
        WHEN a.Avance = 100 THEN 'Terminada'
        WHEN a.FechaFin < CURDATE() AND a.Avance < 100 THEN 'Retrasada'
        ELSE 'En Curso'
    END AS EstadoActividad

FROM Actividad a
ORDER BY EstadoActividad, a.FechaFin;


INSERT INTO Actividad
(idActividad, idFinanciero, Nombre, idTipoActividad, idFuente, Modalidad, Periodo,
 FechaInicio, FechaFin, idLinea, idEntidad, Avance)
VALUES
(9001, 8001, 'Evaluación Climática Rural', 1, 1, 'Presencial', '2025-2',
 '2025-08-01', '2025-11-30', 2, 8, 0.32),

(9002, 8002, 'Taller de Datos Ambientales', 3, 3, 'Virtual', '2025-1',
 '2025-03-02', '2025-05-25', 1, 3, 0.45),

(9003, 8003, 'MOOC de Gobernanza Local', 2, 4, 'Virtual', '2025-2',
 '2025-08-10', '2025-12-01', 4, 11, 0.55),

(9004, 8004, 'Seminario de Impacto Territorial', 4, 9, 'Presencial', '2025-1',
 '2025-02-15', '2025-02-18', 3, 1, 0.78),

(9005, 8005, 'Voluntariado en Educación Rural', 5, 10, 'Presencial', '2025-2',
 '2025-07-01', '2025-10-10', 3, 16, 0.40),

(9006, 8006, 'Consultoría en Políticas de Empleo', 1, 1, 'Híbrida', '2025-1',
 '2025-02-03', '2025-05-30', 1, 6, 0.60),

(9007, 8007, 'Curso de Finanzas Territoriales', 3, 3, 'Virtual', '2025-1',
 '2025-03-05', '2025-06-05', 5, 14, 0.72);

INSERT INTO Presupuesto
(idActividad, MontoPlaneado, MontoEjecutado, PorcentajeEjecutado,
 FuenteFinanciacion, Ingresos, Egresos)
VALUES
(9001, 90000000, 60000000, 66.67, 'Recursos UR', 75000000, 60000000),
(9002, 30000000, 18000000, 60.00, 'Cooperación Internacional', 25000000, 18000000),
(9003, 45000000, 30000000, 66.67, 'Entidad Pública', 40000000, 30000000),
(9004, 20000000, 15000000, 75.00, 'Patrocinio Privado', 18000000, 15000000),
(9005, 25000000, 12000000, 48.00, 'Voluntariado', 18000000, 12000000),
(9006, 50000000, 35000000, 70.00, 'Cooperación Multilateral', 42000000, 35000000),
(9007, 32000000, 21000000, 65.63, 'Recursos Propios', 29000000, 21000000);

INSERT INTO Participacion (idActividad, CCPersona, Rol, Horas) VALUES
(9001, 1007, 'Investigador', 40), 
(9001, 1019, 'Asistente', 30),
(9001, 1024, 'Analista', 25),

(9002, 1003, 'Estudiante', 28),
(9002, 1026, 'Asistente', 20),

(9003, 1014, 'Docente', 35),
(9003, 1036, 'Investigador', 42),
(9003, 1001, 'Estudiante', 30),

(9004, 1005, 'Conferencista', 12),
(9004, 1031, 'Investigador', 20),

(9005, 1016, 'Voluntario', 30),
(9005, 1020, 'Moderador', 25),
(9005, 1008, 'Estudiante', 20),

(9006, 1009, 'Analista', 35),
(9006, 1023, 'Asistente', 28),

(9007, 1018, 'Estudiante', 34),
(9007, 1032, 'Especialista TIC', 40),
(9007, 1021, 'Asistente', 25);

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

