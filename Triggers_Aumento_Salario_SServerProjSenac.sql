

/* TRIGGER UPDATE  EM ATUALIZAÇÃO DE SALÁRIO NO SERVER */


/*CRIANDO A TABELA INICIAL DE EMPREGADO */
CREATE TABLE EMPREGADO(
	IDEMP INT PRIMARY KEY,
	NOME VARCHAR(30),
	CARGO_ATUAL VARCHAR(20),
	SALARIO MONEY,
	ID_GERENTE INT,
	FOREIGN KEY(ID_GERENTE) REFERENCES EMPREGADO(IDEMP)
)
GO

ALTER TABLE EMPREGADO
ALTER COLUMN CARGO_ATUAL VARCHAR(40)  /*AUMENTANDO A CAPACIDADE DO CAMPO */
GO

ALTER TABLE EMPREGADO   /*ADICIONADO  COLUNA */
ADD  EMAIL VARCHAR(45) 
GO

ALTER TABLE EMPREGADO    /*ADICIONADO  COLUNA */
ADD TELEFONE VARCHAR(25) 
GO



/*FAZENDO AS INSERÇÕES */

INSERT INTO EMPREGADO(IDEMP,NOME,CARGO_ATUAL,SALARIO,ID_GERENTE, EMAIL, TELEFONE)
VALUES
 	(1,'CLARA PEREIRA', 'Gerente Geral',3000.00,NULL, 'CLARAPEREIRA@GMAIL.COM', '61-99878-3396'),
	(2,'CELIA MACHADO', 'Funcionario Caixa',1700.00,1,'CELIAMACHADO@GMAIL.COM', '61-99123-8996'),
	(3,'JOAO ANTUNES', 'Funcionario Repositor', 1500.00,1,'JOAOANTUNES@GMAIL.COM', '61-99018-0596'),
	(4,'MARCOS SILVEIRA', 'Funcionario Padaria', 2000.00,1,'MARCOSSILVEIRA@GMAIL.COM', '61-92878-8975'),
	(5,'PAULO FERREIRA', 'Funcionario Açougue', 2450.00,1,'PAULOFERREIRA@GMAIL.COM', '61-99568-5421')
GO


/*CRIANDO A TABELA DAS ALTERAÇÕES DE SALÁRIO*/

CREATE TABLE HIST_SALARIO(
	IDEMPREGADO INT,
	NOME VARCHAR(30),
	EMAIL VARCHAR(45),
	TELEFONE VARCHAR(25),
	CARGO_ATUAL VARCHAR(40),
	ANTIGOSAL MONEY,
	NOVOSAL MONEY,
	DATA DATETIME,
	USUARIO VARCHAR (30),
	MENSAGEM VARCHAR(65) 
)
GO 


/*CRIANDO A TRIGGER/GATILHO QUE VAI REGISTRAR TDS EVENTOS DE 'ALTERAÇÕES DE PREÇO"*/

CREATE TRIGGER TG_SALARIO
ON DBO.EMPREGADO
FOR UPDATE AS
IF UPDATE(SALARIO)  /*faz disparar o gatilho apenas se alterar na coluna SALARIO*/
BEGIN
	 INSERT INTO HIST_SALARIO
	 (IDEMPREGADO,NOME, EMAIL, TELEFONE, CARGO_ATUAL, ANTIGOSAL, NOVOSAL, DATA, USUARIO, MENSAGEM)
	 SELECT D.IDEMP, D.NOME, D.EMAIL, D.TELEFONE, D.CARGO_ATUAL, D.SALARIO, I.SALARIO, GETDATE(), SUSER_NAME(), 'Atenção Alteração Salário'
	 FROM DELETED D, inserted I
	 WHERE D.IDEMP = I.IDEMP
END
PRINT 'TRIGGER EXECUTADA COM SUCESSO'
GO




/*CRIANDO A TABELA DE PISOS MINIMO/MÁXIMO*/
CREATE TABLE TAB_PISO_MIN_MAX(
	MIN_SAL MONEY,
	MAX_SAL MONEY
)
GO
 
INSERT INTO TAB_PISO_MIN_MAX VALUES(1000.00, 4000.00)
GO




/* CRIANDO TAMBÉM UM GATILHO  PARA TESTAR SE O SALÁRIO ESTÁ ENTRE OS PISOS MINIMO E MAXIMO */

 CREATE TRIGGER TG_Piso_Min_Max
ON DBO.EMPREGADO
FOR INSERT,UPDATE
AS 
	DECLARE
		@MIN_SAL MONEY,
		@MAX_SAL MONEY,
		@ATUAL_SAL MONEY

	SELECT @MIN_SAL = MIN_SAL, @MAX_SAL = MAX_SAL FROM TAB_PISO_MIN_MAX

	SELECT @ATUAL_SAL = I.SALARIO
	FROM INSERTED I

	IF(@ATUAL_SAL < @MIN_SAL)
	BEGIN
			RAISERROR('SALARIO MENOR QUE O PISO',16,1)
			ROLLBACK TRANSACTION
	END

	IF(@ATUAL_SAL > @MAX_SAL)
	BEGIN
			RAISERROR('SALARIO MAIOR QUE O TETO',16,1)
			ROLLBACK TRANSACTION
	END
	
GO



/*TESTANDO A TRIGGER*/
UPDATE EMPREGADO SET SALARIO = 9000.00
WHERE IDEMP = 1
GO

UPDATE EMPREGADO SET SALARIO = 1000.00
WHERE IDEMP = 1



/* FAZENDO TDS OPERAÇÕES PARA TESTE...*/
select * from EMPREGADO
GO

select * from HIST_SALARIO
GO

DELETE FROM HIST_SALARIO
GO

UPDATE EMPREGADO 
SET CARGO_ATUAL='Operador Caixa'
WHERE IDEMP=2
GO


UPDATE EMPREGADO 
SET SALARIO=1750.00
WHERE IDEMP=4
GO

UPDATE EMPREGADO SET SALARIO = SALARIO * 1.1  
GO 


/*OBSERVAÇÕES GERAIS: A versão mais atual está td dentro do SSMS  banco DIRETORIA_TESTE.  */