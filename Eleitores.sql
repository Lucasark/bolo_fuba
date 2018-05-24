CREATE TABLE eleitor(
	nome varchar(40) not null,
	cpf int not null,
	titulo int not null,
	CONSTRAINT pkeleitor
		PRIMARY KEY(cpf),
	CONSTRAINT UNkeleitor1
		UNIQUE (titulo)
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
	total_eleitores int,
	CONSTRAINT pksecao
		PRIMARY KEY(sec_numero)
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
	CONSTRAINT pkeleicao
		PRIMARY KEY(ano,turno)
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
	CONSTRAINT pkestado
		PRIMARY KEY(nome)
);

CREATE TABLE registrou(
	ano int not null,
	turno int not null,
	sec_numero int not null,
	validos int,
 	brancos int,
	nulos int, 
	CONSTRAINT pkregistrou
		PRIMARY KEY(ano, turno, sec_numero),
	CONSTRAINT fkregistrou1
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fkregistrou2
		FOREIGN KEY(sec_numero) REFERENCES secao(sec_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE participa(
	cpf int not null,
	ano int not null,
	turno int not null,
	validacao boolean,
	CONSTRAINT pkparticipa
		PRIMARY KEY(cpf, ano, turno),
	CONSTRAINT fkparticipa1
		FOREIGN KEY(ano, turno) REFERENCES eleicao(ano, turno)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkparticipa3
		FOREIGN KEY(cpf) REFERENCES eleitor(cpf)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE vinculado(
	cpf int not null,
	ze_numero int not null,
	CONSTRAINT pkvinculado
		PRIMARY KEY(cpf, ze_numero),
	CONSTRAINT fkvinculado1
		FOREIGN KEY(cpf) REFERENCES eleitor(cpf)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkvinculado2
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE dividida_em(
	sec_numero int not null,
	ze_numero int not null,
	CONSTRAINT pkdividida_em
		PRIMARY KEY(sec_numero, ze_numero),
	CONSTRAINT fkdividida_em1
		FOREIGN KEY(sec_numero) REFERENCES secao(sec_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkdividida_em2
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pertence(
	nome char(3) not null,
	ze_numero int not null,
	CONSTRAINT pkpertence
		PRIMARY KEY(ze_numero, nome),
	CONSTRAINT fkpertence1
		FOREIGN KEY(nome) REFERENCES estado(nome)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkpertence2
		FOREIGN KEY(ze_numero) REFERENCES zona_eleitoral(ze_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

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

CREATE TABLE filiado(
	cpf int not null,
	numero int not null,
	CONSTRAINT pkfiliado
		PRIMARY KEY(cpf, numero),
	CONSTRAINT fkfiliado1
		FOREIGN KEY(cpf) REFERENCES candidato(cpf)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fkfiliado2
		FOREIGN KEY(numero) REFERENCES partido(p_numero)
		ON DELETE RESTRICT ON UPDATE CASCADE	
); 