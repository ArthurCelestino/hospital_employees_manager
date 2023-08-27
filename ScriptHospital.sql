CREATE TABLE Medicamento (
	Codigo INT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Bula TEXT NOT NULL
);

CREATE TABLE Farmacia (
	Nome VARCHAR(100) PRIMARY KEY NOT NULL
);

CREATE TABLE MedicamentoFisico (
	Validade DATE NOT NULL,
	CodigoMedicamento INT NOT NULL,
	CONSTRAINT pk_medicamentofisico PRIMARY KEY (Validade, CodigoMedicamento)
);

CREATE TABLE Empregado (
	RG INT PRIMARY KEY,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DataContratação DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Logradouro VARCHAR(100) NOT NULL,
    Número INT NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(100) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    DataNascimento DATE NOT NULL,
    Nome VARCHAR(100) NOT NULL,
	CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
);

CREATE TABLE Farmaceutico (
	CRF INT UNIQUE NOT NULL,
	Salario NUMERIC(8,2) NOT NULL,
	RG INT PRIMARY KEY NOT NULL,
	NomeFarmacia VARCHAR(100)
);

CREATE TABLE Enfermeiro (
	COREN INT UNIQUE NOT NULL,
	Salario NUMERIC(8,2) NOT NULL,
	RG INT PRIMARY KEY NOT NULL,
	CodigoCTI INT
);

CREATE TABLE QuartoInternacao (
	NumeroQuarto INT PRIMARY KEY,
	NumeroPacientes INT NOT NULL
);

CREATE TABLE Cama (
	NumeroCama INT NOT NULL,
	NumeroQuarto INT NOT NULL,
	Ocupado BOOLEAN,
	CONSTRAINT pk_cama PRIMARY KEY (NumeroCama, NumeroQuarto)
);

CREATE TABLE Medico (
	Especialidade VARCHAR(100) NOT NULL,
	Salario NUMERIC(8,2) NOT NULL,
	CRM VARCHAR(9) UNIQUE NOT NULL,
	CodigoMed INT PRIMARY KEY NOT NULL
);

CREATE TABLE CTI (
	CodigoCTI INT PRIMARY KEY,
	Ocupado BOOLEAN
);

CREATE TABLE Leito (
	NumeroLeito INT NOT NULL,
	CodigoCTI INT NOT NULL,
	Ocupado BOOLEAN,
	CONSTRAINT pk_leito PRIMARY KEY (NumeroLeito, CodigoCTI)
);

CREATE TABLE ProntoSocorro (
	CodigoProntoSocorro INT PRIMARY KEY
);

CREATE TABLE Consultorio (
	NumeroConsultorio INT NOT NULL,
	CodigoProntoSocorro INT NOT NULL,
	EmUso BOOLEAN,
	CONSTRAINT pk_consultorio PRIMARY KEY (NumeroConsultorio, CodigoProntoSocorro)
);

CREATE TABLE Telefones (
	Telefones NUMERIC(11) NOT NULL,
	RG INT NOT NULL,
	CONSTRAINT pk_telefones PRIMARY KEY (Telefones, RG)
);

CREATE TABLE Horista (
	HorasTrabalhadas INT NOT NULL,
	RG INT PRIMARY KEY NOT NULL,
	CodigoMed INT
);

CREATE TABLE Plantonista (
	DuracaoPlantao INT NOT NULL,
	RG INT PRIMARY KEY NOT NULL,
	CodigoMed INT NOT NULL
);

CREATE TABLE Tem (
	NomeFarmacia VARCHAR(100) NOT NULL,
	CodigoMedicamento INT NOT NULL,
	CONSTRAINT pk_tem PRIMARY KEY (NomeFarmacia, CodigoMedicamento)
);

CREATE TABLE Trabalha (
	NumeroQuarto INT NOT NULL,
	RGEnfermeiro INT NOT NULL,
	CONSTRAINT pk_trabalha PRIMARY KEY (NumeroQuarto, RGEnfermeiro)
);

CREATE TABLE AtendimentoCTI (
	CodigoMed INT NOT NULL,
    CodigoCTI INT NOT NULL,
    DiaCTI DATE,
	EntradaCTI TIME,
	SaidaCTI TIME,
    CONSTRAINT pk_atendimentocti PRIMARY KEY (CodigoMed, CodigoCTI, DiaCTI, EntradaCTI, SaidaCTI)
);

CREATE TABLE AtendimentoConsultorio (
	CodigoMed INT NOT NULL,
    NumeroConsultorio INT NOT NULL,
	CodigoProntoSocorro INT NOT NULL,
    DiaConsultorio DATE,
	EntradaConsultorio TIME,
	SaidaConsultorio TIME,
    CONSTRAINT pk_atendimentoconsultorio PRIMARY KEY (CodigoMed, NumeroConsultorio, CodigoProntoSocorro, DiaConsultorio, EntradaConsultorio, SaidaConsultorio)
);

create view medicos
as select *
	FROM (medico natural join horista) natural join empregado 
    UNION 
    SELECT *
    FROM (medico natural join plantonista) natural join empregado;
    
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (111111111, '123.456.789-01', 'joao@email.com', '2023-08-01', 'M', 'Rua das Flores', 'Centro', 100, 'São Paulo', 'SP', '01234-567', '1990-01-15', 'João da Silva');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (222222222, '987.654.321-00', 'maria@email.com', '2023-08-02', 'F', 'Av. Principal', 'Bairro Novo', 200, 'Rio de Janeiro', 'RJ', '12345-678', '1992-05-20', 'Maria Oliveira');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (333333333, '111.222.333-44', 'fulano@email.com', '2023-08-03', 'M', 'Rua 1', 'Centro', 10, 'Recife', 'PE', '12345-678', '1988-07-15', 'Fulano Souza');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (444444444, '555.666.777-88', 'ciclana@email.com', '2023-08-04', 'F', 'Rua 2', 'Bairro Novo', 20, 'Belo Horizonte', 'MG', '54321-987', '1995-12-25', 'Ciclana Santos');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (555555555, '222.333.444-55', 'pedro@email.com', '2023-08-05', 'M', 'Rua 3', 'Vila Feliz', 30, 'Salvador', 'BA', '23456-789', '1993-03-10', 'Pedro Almeida');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (666666666, '888.999.000-11', 'carla@email.com', '2023-08-06', 'F', 'Rua 4', 'Centro', 40, 'Porto Alegre', 'RS', '34567-890', '1980-11-20', 'Carla Rodrigues');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (777777777, '111.333.555-77', 'jose@email.com', '2023-08-07', 'M', 'Rua 5', 'Bairro Novo', 50, 'Curitiba', 'PR', '45678-901', '1987-06-05', 'José Lima');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (888888888, '444.666.888-00', 'ana@email.com', '2023-08-08', 'F', 'Rua 6', 'Vila Nova', 60, 'Florianópolis', 'SC', '56789-012', '1991-09-30', 'Ana Ferreira');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (999999999, '777.888.999-00', 'marcos@email.com', '2023-08-09', 'M', 'Rua 7', 'Centro', 70, 'São Paulo', 'SP', '67890-123', '1994-12-18', 'Marcos Silva');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (101010101, '333.222.111-00', 'juliana@email.com', '2023-08-10', 'F', 'Rua 8', 'Bairro Novo', 80, 'Rio de Janeiro', 'RJ', '78901-234', '1997-05-22', 'Juliana Ribeiro');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (121212121, '999.888.777-66', 'andre@email.com', '2023-08-11', 'M', 'Rua 9', 'Centro', 90, 'Recife', 'PE', '89012-345', '1989-04-12', 'André Santos');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (131313131, '666.555.444-33', 'bruna@email.com', '2023-08-12', 'F', 'Rua 10', 'Vila Feliz', 100, 'Belo Horizonte', 'MG', '90123-456', '1996-02-05', 'Bruna Costa');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (141414141, '222.444.666-88', 'ricardo@email.com', '2023-08-13', 'M', 'Rua 11', 'Centro', 110, 'Salvador', 'BA', '23456-789', '1992-07-15', 'Ricardo Martins');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (151515151, '888.666.444-22', 'barbara@email.com', '2023-08-14', 'F', 'Rua 12', 'Bairro Novo', 120, 'Porto Alegre', 'RS', '34567-890', '1990-11-20', 'Bárbara Sousa');
INSERT INTO Empregado (RG, CPF, Email, DataContratação, Sexo, Rua, Logradouro, Número, Cidade, Estado, CEP, DataNascimento, Nome)
VALUES (161616161, '444.333.222-11', 'lucas@email.com', '2023-08-15', 'M', 'Rua 13', 'Vila Nova', 130, 'Curitiba', 'PR', '45678-901', '1993-06-05', 'Lucas Oliveira');

INSERT INTO Medicamento
VALUES (1, 'Dipirona', 'Medicamento para dores, febre, etc');
INSERT INTO Medicamento
VALUES (2, 'Dorflex', 'Relaxante muscular');
INSERT INTO Medicamento
VALUES (3, 'Ibuprofeno', 'Rémedio anti-inflamatório');

INSERT INTO Farmacia
VALUES ('Farmácia 1');
INSERT INTO Farmacia
VALUES ('Farmácia 2');

INSERT INTO MedicamentoFisico
VALUES ('2024-09-21', 2);
INSERT INTO MedicamentoFisico
VALUES ('2023-12-13', 2);
INSERT INTO MedicamentoFisico
VALUES ('2025-01-20', 1);
INSERT INTO MedicamentoFisico
VALUES ('2023-11-10', 3);
INSERT INTO MedicamentoFisico
VALUES ('2024-4-14', 3);
INSERT INTO MedicamentoFisico
VALUES ('2026-10-20', 2);

INSERT INTO Farmaceutico
VALUES (11111, 1000, 555555555, 'Farmácia 1');
INSERT INTO Farmaceutico
VALUES (22222, 1100, 161616161, 'Farmácia 2');

INSERT INTO Enfermeiro
VALUES (111, 2000, 111111111, 2);
INSERT INTO Enfermeiro
VALUES (112, 2780, 333333333, 2);
INSERT INTO Enfermeiro (COREN, Salario, RG)
VALUES (113, 3000, 666666666);
INSERT INTO Enfermeiro
VALUES (114, 2500, 777777777, 1);
INSERT INTO Enfermeiro (COREN, Salario, RG)
VALUES (115, 2500, 141414141);
INSERT INTO Enfermeiro
VALUES (116, 2000, 151515151, 1);

INSERT INTO QuartoInternacao
VALUES (01, 3);
INSERT INTO QuartoInternacao
VALUES (02, 2);

INSERT INTO Cama
VALUES (100, 02, true);
INSERT INTO Cama
VALUES (101, 02, false);
INSERT INTO Cama
VALUES (102, 02, false);
INSERT INTO Cama
VALUES (103, 02, true);
INSERT INTO Cama
VALUES (103, 01, false);
INSERT INTO Cama
VALUES (100, 01, true);
INSERT INTO Cama
VALUES (101, 01, true);
INSERT INTO Cama
VALUES (102, 01, true);

INSERT INTO Medico
VALUES ('Ortopedista', 7000, '111111/MG', 1);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Cardiologista', 9000, '222222/SP', 2);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Pediatra', 7500, '333333/SP', 3);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Cardiologista', 9780, '444444/SP', 4);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Ginecologista', 10090, '555555/RJ', 5);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Pediatra', 8900, '666666/RJ', 6);
INSERT INTO Medico (Especialidade, Salario, CRM, CodigoMed)
VALUES ('Neurologista', 11000, '777777/MG', 7);

INSERT INTO CTI
VALUES (1, true);
INSERT INTO CTI
VALUES (2, false);

INSERT INTO Leito
VALUES (200, 1, true);
INSERT INTO Leito
VALUES (201, 1, true);
INSERT INTO Leito
VALUES (200, 2, true);
INSERT INTO Leito
VALUES (201, 2, false);

INSERT INTO ProntoSocorro
VALUES (80);
INSERT INTO ProntoSocorro
VALUES (81);

INSERT INTO Consultorio
VALUES (90, 80, true);
INSERT INTO Consultorio
VALUES (91, 80, true);
INSERT INTO Consultorio
VALUES (90, 81, false);
INSERT INTO Consultorio
VALUES (91, 81, true);

INSERT INTO Telefones
VALUES (31910101010, 111111111);
INSERT INTO Telefones
VALUES (31910101111, 222222222);
INSERT INTO Telefones
VALUES (31920201212, 222222222);
INSERT INTO Telefones
VALUES (31920201313, 333333333);
INSERT INTO Telefones
VALUES (31910601314, 444444444);
INSERT INTO Telefones
VALUES (31910601515, 555555555);
INSERT INTO Telefones
VALUES (31910601616, 777777777);
INSERT INTO Telefones
VALUES (31910601717, 666666666);
INSERT INTO Telefones
VALUES (31910601818, 888888888);
INSERT INTO Telefones
VALUES (31915701819, 999999999);
INSERT INTO Telefones
VALUES (31915701610, 101010101);
INSERT INTO Telefones
VALUES (31915701611, 121212121);
INSERT INTO Telefones
VALUES (31915701612, 131313131);
INSERT INTO Telefones
VALUES (31915791613, 141414141);
INSERT INTO Telefones
VALUES (31915791614, 151515151);
INSERT INTO Telefones
VALUES (31915791615, 161616161);

INSERT INTO Horista
VALUES (36, 555555555, NULL);
INSERT INTO Horista
VALUES (40, 161616161, NULL);
INSERT INTO Horista
VALUES (38, 111111111, NULL);
INSERT INTO Horista
VALUES (36, 333333333, NULL);
INSERT INTO Horista
VALUES (40, 666666666, NULL);
INSERT INTO Horista
VALUES (40, 777777777, NULL);
INSERT INTO Horista
VALUES (38, 141414141, NULL);
INSERT INTO Horista
VALUES (38, 151515151, NULL);
INSERT INTO Horista
VALUES (38, 222222222, 1);
INSERT INTO Horista
VALUES (42, 444444444, 7);
INSERT INTO Horista
VALUES (40, 888888888, 2);

INSERT INTO Plantonista
VALUES (12, 999999999, 3);
INSERT INTO Plantonista
VALUES (10, 121212121, 6);
INSERT INTO Plantonista
VALUES (11, 131313131, 4);
INSERT INTO Plantonista
VALUES (12, 101010101, 5);

INSERT INTO Tem
VALUES ('Farmácia 1', 1);
INSERT INTO Tem
VALUES ('Farmácia 2', 1);
INSERT INTO Tem
VALUES ('Farmácia 2', 3);
INSERT INTO Tem
VALUES ('Farmácia 2', 2);
INSERT INTO Tem
VALUES ('Farmácia 1', 3);

INSERT INTO Trabalha
VALUES (01, 111111111);
INSERT INTO Trabalha
VALUES (01, 777777777);
INSERT INTO Trabalha
VALUES (02, 151515151);

INSERT INTO AtendimentoConsultorio
VALUES ( 1, 90, 80, '2023-08-20', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 1, 91, 81, '2023-08-21', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 1, 91, 80, '2023-08-22', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 2, 91, 81, '2023-08-20', '12:30:00', '18:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 2, 91, 80, '2023-08-21', '12:30:00', '15:30:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 2, 90, 81, '2023-08-22', '12:30:00', '18:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 4, 90, 80, '2023-08-20', '12:00:00', '18:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 4, 91, 80, '2023-08-21', '15:30:00', '18:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 5, 91, 80, '2023-08-19', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 5, 91, 80, '2023-08-20', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 6, 90, 81, '2023-08-20', '08:00:00', '12:00:00');
INSERT INTO AtendimentoConsultorio
VALUES ( 7, 90, 80, '2023-08-18', '07:00:00', '12:00:00');

INSERT INTO AtendimentoCti
VALUES ( 1, 2, '2023-08-20', '12:30:00', '18:00:00');
INSERT INTO AtendimentoCti
VALUES ( 3, 1, '2023-08-19', '00:30:00', '12:00:00');
INSERT INTO AtendimentoCti
VALUES ( 3, 2, '2023-08-19', '12:00:00', '00:00:00');
INSERT INTO AtendimentoCti
VALUES ( 5, 2, '2023-08-20', '00:00:00', '12:00:00');
INSERT INTO AtendimentoCti
VALUES ( 5, 2, '2023-08-21', '00:00:00', '12:00:00');
INSERT INTO AtendimentoCti
VALUES ( 5, 1, '2023-08-22', '00:00:00', '12:00:00');
INSERT INTO AtendimentoCti
VALUES ( 7, 1, '2023-08-20', '12:30:00', '20:00:00');
INSERT INTO AtendimentoCti
VALUES ( 7, 1, '2023-08-21', '12:30:00', '20:00:00');

ALTER TABLE MedicamentoFisico
ADD CONSTRAINT fk_medicamentofisico_medicamento FOREIGN KEY (CodigoMedicamento) REFERENCES Medicamento (Codigo);

ALTER TABLE Farmaceutico
ADD CONSTRAINT fk_farmaceutico_horista FOREIGN KEY (RG) REFERENCES Horista (RG);
ALTER TABLE Farmaceutico
ADD CONSTRAINT fk_farmaceutico_farmacia FOREIGN KEY (NomeFarmacia) REFERENCES Farmacia (Nome);

ALTER TABLE Enfermeiro
ADD CONSTRAINT fk_enfermeiro_horista FOREIGN KEY (RG) REFERENCES Horista (RG);
ALTER TABLE Enfermeiro
ADD CONSTRAINT fk_enfermeiro_cti FOREIGN KEY (CodigoCTI) REFERENCES CTI (CodigoCTI);

ALTER TABLE Cama
ADD CONSTRAINT fk_cama_quarto FOREIGN KEY (NumeroQuarto) REFERENCES QuartoInternacao (NumeroQuarto);

ALTER TABLE Leito
ADD CONSTRAINT fk_leito_cti FOREIGN KEY (CodigoCTI) REFERENCES CTI (CodigoCTI);

ALTER TABLE Consultorio
ADD CONSTRAINT fk_consultorio_prontosocorro FOREIGN KEY (CodigoProntoSocorro) REFERENCES ProntoSocorro (CodigoProntoSocorro);

ALTER TABLE Telefones
ADD CONSTRAINT fk_telefones_emps FOREIGN KEY (RG) REFERENCES Empregado (RG);

ALTER TABLE Horista
ADD CONSTRAINT fk_horista_emps FOREIGN KEY (RG) REFERENCES Empregado (RG);
ALTER TABLE Horista
ADD CONSTRAINT fk_horista_medico FOREIGN KEY (CodigoMed) REFERENCES Medico (CodigoMed);

ALTER TABLE Plantonista
ADD CONSTRAINT fk_plantonista_medico FOREIGN KEY (CodigoMed) REFERENCES Medico (CodigoMed);
ALTER TABLE Plantonista
ADD CONSTRAINT fk_plantonista_emps FOREIGN KEY (RG) REFERENCES Empregado (RG);

ALTER TABLE Tem
ADD CONSTRAINT fk_tem_farmacia FOREIGN KEY (NomeFarmacia) REFERENCES Farmacia (Nome);
ALTER TABLE Tem
ADD CONSTRAINT fk_tem_meds FOREIGN KEY (CodigoMedicamento) REFERENCES Medicamento (Codigo);

ALTER TABLE Trabalha
ADD CONSTRAINT fk_trabalha_quarto FOREIGN KEY (NumeroQuarto) REFERENCES QuartoInternacao (NumeroQuarto);
ALTER TABLE Trabalha
ADD CONSTRAINT fk_trabalha_enfermeiro FOREIGN KEY (RGEnfermeiro) REFERENCES Enfermeiro (RG);

ALTER TABLE AtendimentoCTI
ADD CONSTRAINT fk_atendimentocti_medico FOREIGN KEY (CodigoMed) REFERENCES Medico (CodigoMed);
ALTER TABLE AtendimentoCTI
ADD CONSTRAINT fk_atendimentocti_cti FOREIGN KEY (CodigoCTI) REFERENCES Cti (CodigoCTI);

ALTER TABLE AtendimentoConsultorio
ADD CONSTRAINT fk_atendimentoconsultorio_medico FOREIGN KEY (CodigoMed) REFERENCES Medico (CodigoMed);
ALTER TABLE AtendimentoConsultorio
ADD CONSTRAINT fk_atendimentoconsultorio_consultorio FOREIGN KEY (NumeroConsultorio, CodigoProntoSocorro) REFERENCES Consultorio (NumeroConsultorio, CodigoProntoSocorro);