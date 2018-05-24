CREATE TABLE eleitor(
	nome varchar(40) not null,
	cpf int not null,
	titulo int not null,
	ze_numero int not null,
	ano int not null,
	turno int not null,
	validacao boolean not null,
	CONSTRAINT pkeleitor
		PRIMARY KEY(cpf),
	CONSTRAINT UNkeleitor1
		UNIQUE (titulo),
	CONSTRAINT fkeleitor2
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkeleitor3
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE candidato(
	nome varchar(40) not null,
	cpf int not null,
	titulo int not null,
	c_numero int not null,
	e_vice int,
	sequencial int not null,
	CONSTRAINT pkeleitor
		PRIMARY KEY(cpf),
	CONSTRAINT unkcandidato
		UNIQUE (c_numero, sequencial),
	CONSTRAINT fkcandidato1
		FOREIGN KEY(e_vice) REFERENCES candidato(cpf) 
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkcandidato2
		FOREIGN KEY(c_numero) REFERENCES partido(p_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE zona_eleitoral(
	ze_numero int not null,
	CONSTRAINT pkzona_eleitoral
		PRIMARY KEY(ze_numero)
);

CREATE TABLE secao(
	sec_numero int not null,
	ze_numero int not null,
	total_eleitores int,
	CONSTRAINT pksecao
		PRIMARY KEY(sec_numero),
	CONSTRAINT fksecao1
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE mesario(
	cpf int not null,
	nome varchar(40) not null,
	CONSTRAINT pkmesario
		PRIMARY KEY(cpf)
);

CREATE TABLE cargo(
	nome varchar(40) not null,
	CONSTRAINT pkcargo
		PRIMARY KEY(nome)
);

CREATE TABLE partido(
	p_numero int not null,
	nome varchar(40) not null, 
	CONSTRAINT pkpartido
		PRIMARY KEY(p_numero)
);

CREATE TABLE eleicao(
	ano int not null,
	turno int not null,
	sec_numero int not null,
	validos int,
 	brancos int,
	nulos int,
	CONSTRAINT pkeleicao
		PRIMARY KEY(ano,turno) 
	CONSTRAINT fkeleicao1
		FOREIGN KEY(sec_numero) REFERENCES secao(sec_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE

);

CREATE TABLE vencedor(
	vencedor int,
	ano int,
	turno int,
	CONSTRAINT pkvencedor
		PRIMARY KEY(vencedor, ano, turno),
	CONSTRAINT fkvencedor1
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
);

CREATE TABLE estado(
	nome char(3) not null,
	ze_numero int not null,
	CONSTRAINT pkestado
		PRIMARY KEY(nome)
	CONSTRAINT fkestado2
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

--colpsado registrou

--colpsado participa 

--colapsado vinculado

--colapsado divido_em

--colapsado pertence

CREATE TABLE trabalham(
	sec_numero int not null,
	cpf int not null,
	ano int not null,
	turno int not null,
	CONSTRAINT pktrabalham
		PRIMARY KEY(sec_numero, cpf, ano, turno),
	CONSTRAINT fktrabalham1
		FOREIGN KEY(sec_numero) REFERENCES secao(sec_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fktrabalham2
		FOREIGN KEY(cpf) REFERENCES mesario(cpf)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fktrabalham3
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE concorre(
	votos int,
	ano int not null,
	turno int not null,
	c_nome varchar(40) not null,
	e_nome char(3) not null,
	cpf int not null,
	CONSTRAINT pkconcorre
		PRIMARY KEY(cpf, e_nome, c_nome, ano, turno),
	CONSTRAINT fkconcorre1
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkconcorre2
		FOREIGN KEY(cpf) REFERENCES candidato(cpf)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkconcorre3
		FOREIGN KEY(e_nome) REFERENCES estado(nome)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkconcorre4
		FOREIGN KEY(c_nome) REFERENCES cargo(nome)
		ON DELETE RESTRICT ON UPDATE CASCADE		
);

--filiado fraca