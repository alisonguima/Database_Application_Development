DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE EMP CASCADE CONSTRAINTS;

CREATE TABLE DEPT(deptno number(4) primary key,
dname varchar2(15) not null, local varchar2(15));

create table emp(empno number(5) primary key,
ename varchar2(20) not null, sal number(10,2), 
deptno number(4) references dept);

insert into dept values(1,'contabilidade','sp');
insert into dept values(2,'T.I.','sp');
insert into dept values(3,'filial x','rj');
insert into dept values(4,'filial z','mg');

insert into emp values(100,'Jose Silva',1200.35,1);
insert into emp values(101,'João Barbosa',1800.35,1);
insert into emp values(102,'Carlos Siqueira',2000,1);
insert into emp values(103,'Maria Jose Santos',3400,2);
insert into emp values(104,'Celina Anjos',3800,2);
insert into emp values(105,'Alberto Carlos',5800,3);
insert into emp values(106,'Roberto Vieira',4900,3);

COMMIT;

--ver todos os dados
Select * from Dept;
Select * from emp;

 
BEGIN   
     INSERT INTO EMP(EMPNO,ENAME,SAL,DEPTNO) VALUES  
     (&DIGITE_NUMERO,'&DIGITE_NOME',&DIGITE_SALARIO,&DIGITE_DEPTO);
     COMMIT;
exception
     when dup_val_on_index then
     dbms_outpu.put_line("registro já existe");
 END; 
/ 

BEGIN   
     DELETE FROM EMP WHERE EMPNO=&V_CODIGO;
     COMMIT;
exception
     when no_data_found then
     dbms_outpu.put_line("registro já existe");
 END; 
/ 

BEGIN   
     UPDATE EMP SET ENAME=’&DIGITE_NOVO_NOME’
     WHERE EMPNO=&DIGITE_NUMERO_EMPREGADO;
     COMMIT;
exception
     when no_data_found then
     dbms_outpu.put_line("registro já existe"); 
END; 
/ 

-- O QUE VIMOS NA AULA PASSADA:

---------SELECIONAR E APRESENTAR UMA LINHA, USANDO SELECT...INTO....DBMS......
SET SERVEROUTPUT ON
DECLARE    
  V_CODIGO   NUMBER(4); 
  V_NOME_FUNC VARCHAR2(15);
  V_SALARIO  NUMBER(10,2);
BEGIN   
     SELECT EMPNO,ENAME,SAL INTO V_CODIGO,V_NOME_FUNC,
     V_SALARIO FROM EMP WHERE EMPNO=&V_CODIGO;
     DBMS_OUTPUT.PUT_LINE('CODIGO:' || V_CODIGO);
     DBMS_OUTPUT.PUT_LINE('NOME: '  || V_NOME_FUNC);
     DBMS_OUTPUT.PUT_LINE('SALARIO:'|| V_SALARIO);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');
END; 
/ 

/*
--- O QUE VEREMOS HOJE 18/03/21--------------------------- 
Problema: Um usuário de RH pediu a seguinte pesquisa em um 
          banco de dados oracle. Quando for feita a seleção 
          de um determinado empregado o programa deve:
          Imprimir "salario está baixo" na tela quando o 
          funcionário pesquisado receber 1000 ou menos.
          "salario é mediano, quando receber entre 1001 e 3000.
          "salario é alto, quando for maior que 3000.  

Vamos desenvolver o bloco PL-SQL passo a passo
----------------------------------------------------------
1) preciso configurar o ambiente? SET...
2) preciso declarar variáveis? Quais?
3) Se vou selecionar apenas um funcionario uso Select..into..
4) Vou criar um bloco Begin ... end; ?
5) Vou comparar o valor contido na variável que capturei o salário com os limites estabelecidos 
6) Vou usar o IF...THEN...  Porque não usar o CASE ?
7) Qual a estrutura do IF e do Case?
8) Vou imprimir usando DBMS ? Quero imprimir colunado ou por linha?
9) Vou criar uma area de Exception ? Que exceções podem ocorrer?
*/     
 ---------------------------------------------------------------------
 ------EXEMPLO DE ESTRUTURA IF-ELSIF-ELSE-END IF;
SET SERVEROUTPUT ON
DECLARE    
    V_EMP NUMBER(4);
    V_NOME_EMP VARCHAR2(20);    
    V_SALARIO NUMBER(7,2);
BEGIN
    SELECT EMPNO, ENAME, SAL INTO V_EMP, V_NOME_EMP, V_SALARIO
    FROM EMP WHERE EMPNO=&DIGITE_NUMERO_EMPREGADO;
    DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || V_EMP );
    DBMS_OUTPUT.PUT_LINE('NOME: ' || V_NOME_EMP);
        
    IF V_SALARIO <= 1000 THEN
        DBMS_OUTPUT.PUT_LINE('SALÁRIO: ' || V_SALARIO || ' É BAIXO');
    ELSIF V_SALARIO > 1000 AND V_SALARIO <= 3000 THEN
        DBMS_OUTPUT.PUT_LINE('SALÁRIO: ' || V_SALARIO || ' É MEDIANO');
    ELSE
        DBMS_OUTPUT.PUT_LINE('SALÁRIO: ' || V_SALARIO || ' É ALTO');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');
END;
/
------------------------------------------------------------------------------------------

------EXEMPLO DE ESTRUTURA CASE-WHEN-ELSE-END CASE;
 SET SERVEROUTPUT ON
 DECLARE    
  V_CODIGO   NUMBER(4); 
  V_NOME_FUNC VARCHAR2(15);
  V_SALARIO  NUMBER(10,2);
BEGIN   
     SELECT EMPNO,ENAME,SAL INTO V_CODIGO,V_NOME_FUNC,V_SALARIO  
     FROM EMP WHERE EMPNO=&V_CODIGO;
     DBMS_OUTPUT.PUT_LINE('CODIGO: ' || V_CODIGO);
     DBMS_OUTPUT.PUT_LINE('NOME: ' || V_NOME_FUNC);
     CASE
     WHEN V_SALARIO <= 1000 THEN
          DBMS_OUTPUT.PUT_LINE('SALARIO: ' || V_SALARIO || ' ESTA BAIXO');
     WHEN V_SALARIO >= 1001 AND v_SALARIO <= 3000 THEN
          DBMS_OUTPUT.PUT_LINE('SALARIO: ' || V_SALARIO || ' É MEDIANO');
     ELSE
         DBMS_OUTPUT.PUT_LINE('SALARIO: ' || V_SALARIO || ' É ALTO');
     END CASE;
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');
END;  
/ 

------------------------------------------------------------------------------------------