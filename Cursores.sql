/*criando as tabelas que serão usadas. DEPT receberá departamentos e 
 EMP os empregados. Nesta última haverá a chave estrangeira deptno para
 ligar o empregado ao departamento */ 
drop table dept cascade constraints;
drop table emp cascade constraints;

CREATE TABLE DEPT(deptno number(4) primary key,
dname varchar2(15) not null, local varchar2(15));

create table emp(empno number(5) primary key,
ename varchar2(15) not null, sal number(10,2), deptno number(4) references dept, 
DATA_ADMISSAO DATE);

insert into dept values(1,'contabilidade','sp');
insert into dept values(2,'T.I.','sp');
insert into dept values(3,'filial x','rj');
insert into dept values(4,'filial z','mg');

DELETE FROM EMP;
alter table emp add deptno number(4) references dept;
delete  from emp;
DESC EMP;
insert into emp values(100,'Jose Silva',1200.35,1,'12-12-11');
insert into emp values(101,'João Barbosa',1800.35,1,'11/11/11');
insert into emp values(102,'Carlos Siqueira',2000,1,'09/10/16');
insert into emp values(103,'Maria Santos',3400,2,'12/12/18');
insert into emp values(104,'Celina Anjos',3800,2,'01/01/16');
insert into emp values(105,'Alberto Carlos',5800,3,'03/03/15');
insert into emp values(106,'Roberto Vieira',4900,3,'04/04/12');
---------------------------------------------------------------
desc dept;
desc emp;
Select * from dept;
Select * from emp;
-----------------------------CURSORES IMPLICITOS------------------
---------------------------------------------------------------
set serveroutput on

BEGIN   
  INSERT INTO EMP(EMPNO,ENAME,SAL,DEPTNO) VALUES  
 (&DIGITE_NUMERO,'&DIGITE_NOME',&DIGITE_SALARIO,&DIGITE_DEPTO);
IF SQL%FOUND THEN
  DBMS_OUTPUT.PUT_LINE('INSERIDO');
ELSE
  DBMS_OUTPUT.PUT_LINE('NÃO INSERIDO');
END IF;
IF SQL%ISOPEN THEN
  DBMS_OUTPUT.PUT_LINE('CURSOR ABERTO');
END IF;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
   DBMS_OUTPUT.PUT_LINE('CHAVE DUPLICADA'); 
END; 
/ 

--------------------------------------------------------------

BEGIN   
     UPDATE EMP SET ENAME='&NOVO_NOME' WHERE
     EMPNO=&CODIGO_EMP;
     IF SQL%NOTFOUND THEN
         DBMS_OUTPUT.PUT_LINE('NÃO ALTERADO');
     ELSE
         DBMS_OUTPUT.PUT_LINE('ALTERADO');
     END IF; 
END; 
/ 

------------------------------------------------------------------------
SET SERVEROUTPUT ON
BEGIN   
     DELETE FROM EMP WHERE EMPNO=&CODIGO_EMP;
     IF SQL%NOTFOUND THEN
         DBMS_OUTPUT.PUT_LINE('NÃO ENCONTRADO'); 
     ELSE
         DBMS_OUTPUT.PUT_LINE('ELIMINADO'); 
     END IF; 
END; 
/ 

/* NO CASO DE UM SELECT INTO PODERIAMOS TESTAR O CURSOR PARA VER SE ENCONTROU
OU NÃO. PORÉM UMA EXCEPTION NO_DATA_FOUND FAZ ESSE TRABALHO E SERIA CHAMADA
NESSE CASO. PODERÍAMOS FAZER OUTROS TESTES, COMO CONTAGEM, VERIFICAR SE CURSOR
ESTÁ ABERTO, ETC. */

-----------------------------------------------------------------------------

-- CURSORES EXPLICITOS------------------------------------------------------
-- NO EXEMPLO ESTAMOS SELECIONANDO DEPARTAMENTOS E RESPECTIVOS EMPREGADOS 
-- ADMITIDOS A PARTIR DE UMA DETERMINADA DATA
-- UTILIZANDO O LAÇO LOOP
DESC DEPT;
DESC EMP;

DECLARE
  VEMP EMP.EMPNO%TYPE;
  VNOME EMP.ENAME%TYPE;
  VSAL EMP.SAL%TYPE;
  VDATA EMP.DATA_ADMISSAO%TYPE;
  VDEPT DEPT.DEPTNO%TYPE;  
  VDEPNOME DEPT.DNAME%TYPE;
  CURSOR PESQUISA_EMP IS SELECT DEPT.DEPTNO,DEPT.DNAME,EMPNO,ENAME,SAL,DATA_ADMISSAO
  FROM DEPT INNER JOIN EMP ON DEPT.DEPTNO=EMP.DEPTNO
  WHERE DATA_ADMISSAO >= '&DIGITE_DATA';
BEGIN
 OPEN PESQUISA_EMP;
 LOOP 
     FETCH PESQUISA_EMP INTO VDEPT,VDEPNOME,VEMP,VNOME,VSAL,VDATA;
     EXIT WHEN PESQUISA_EMP%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('NÚMERO DEPTO:' || VDEPT);
     DBMS_OUTPUT.PUT_LINE('NOME DEPTO:' ||  VDEPNOME); 
     DBMS_OUTPUT.PUT_LINE('NÚMERO EMPREGADO:' || VEMP);
     DBMS_OUTPUT.PUT_LINE('NOME EMPREGADO:' || VNOME);
     DBMS_OUTPUT.PUT_LINE('SALARIO EMPREGADO:' || VSAL);
     DBMS_OUTPUT.PUT_LINE('DATA ADMISSAO EMPREGADO:' || VDATA);
     DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
  CLOSE PESQUISA_EMP; 
 END;
/


------------------------------------------------------------------------
--------------LAÇO LOOP COM VARIÁVEL %ROWTYPE
DECLARE 
  CURSOR pesqemp IS select   
  dept.deptno,dname,empno,ename,sal,data_admissao
  FROM dept inner join emp on dept.deptno=emp.deptno 
  WHERE data_admissao>'&vdata';
  V_REGISTRO  pesqemp%rowtype; 
  BEGIN 
    OPEN pesqemp; 
    LOOP          
     FETCH pesqemp INTO V_REGISTRO; 
     IF PESQEMP%ROWCOUNT<1 THEN
       DBMS_OUTPUT.PUT_LINE('NENHUM FUNCIONÁRIO SELECIONADO');
     END IF;
     EXIT when pesqemp%notfound;    
     DBMS_OUTPUT.PUT_LINE('numero depto: '||V_REGISTRO.DEPTNO 
     || '   '  || ' nome:depto:'|| v_registro.dname || '   '
     || 'numero empregado:' ||  v_registro.empno || '   ' ||
     'nome empregado:' || v_registro.ename || '   ' || 'salario:'
     || v_registro.sal || '   ' || 'data admissão:' || 
     v_registro.data_admissao); 
    END LOOP; 
    CLOSE pesqemp; 
  END; 

------------------------EXPLICANDO O EXERCICIO ANTERIOR-----LOOP E %ROWTYPE
set serveroutput on
DECLARE 
  CURSOR pesqemp IS select   
  dept.deptno,dname,empno,ename,sal,data_admissao
  FROM dept inner join emp on dept.deptno=emp.deptno 
  WHERE data_admissao>'&vdata';
  --CRIAMOS O CURSOR---                       
  V_REGISTRO  pesqemp%rowtype; 
  --CRIAMOS UMA VARIÁVEL TIPO %ROWTYPE PARA RECEBER DADOS DO CURSOR
 BEGIN 
 OPEN pesqemp; --ABRIMOS O CURSOR
 
 LOOP          --CRIAMOS UM LOOP PARA MOVER ENTRE AS LINHAS DO CURSOR
 FETCH pesqemp INTO V_REGISTRO; -- FETCH MOVE PARA A LINHA SEGUINTE E CARREGA DADOS
 IF PESQEMP%NOTFOUND THEN
   DBMS_OUTPUT.PUT_LINE('FIM DA SELEÇÃO OU NENHUM SELECIONADO');
 END IF; 
 EXIT when pesqemp%notfound;    -- FORÇA A SAIDA CASO O CURSOR NÃO TENHA LINHAS 
 DBMS_OUTPUT.PUT_LINE('numero depto: '||V_REGISTRO.DEPTNO  
  || '   '  || ' nome:depto:'|| v_registro.dname || '   '
 || 'numero empregado:' ||  v_registro.empno || '   ' ||
 'nome empregado:' || v_registro.ename || '   ' || 'salario:'
 || v_registro.sal || '   ' || 'data admissão:' || 
 v_registro.data_admissao); 
 -- IMPRIME VARIÁVEL V_REGISTRO.COLUNA A IMPRIMIR
 END LOOP; 
     CLOSE pesqemp; 
END; 



----------------------------------------------------------------
--utilizando o laço WHILE
set serveroutput on
DECLARE 
  CURSOR PESQEMP IS select dept.deptno,dname,empno,ename,sal,data_admissao
  FROM dept inner join emp on dept.deptno=emp.deptno 
  WHERE data_admissao>='&vdata';
  V_REGISTRO  pesqemp%rowtype;
BEGIN 
 OPEN pesqemp; 
 WHILE TRUE LOOP
   FETCH pesqemp INTO V_REGISTRO; 
   EXIT when pesqemp%notfound; 
   DBMS_OUTPUT.PUT_LINE('numero depto: '||V_REGISTRO.DEPTNO 
   || '   '  || ' nome:depto:'|| v_registro.dname || '   '
   || 'numero empregado:' || v_registro.empno || '   ' ||
   'nome empregado:' || v_registro.ename || '   ' || 'salario:'
   || v_registro.sal || '   ' || 'data admissão:' || v_registro.data_admissao); 
END LOOP; 
CLOSE pesqemp; 
END; 
-------------------------------------------------------------------------------



-- UTILIZANDO O LAÇO FOR. 
-- OBSERVEM QUE NÃO É NECESSÁRIO ABRIR O CURSOR COM OPEN, NEM FECHA-LO COM CLOSE
-- NEM SEQUER UTILIZAR O COMANDO FETCH PARA MOVER E CARREGAR A VARIÁVEL COM A
-- LINHA DO CURSOR.

set serveroutput on
declare
  cursor c_pesqemp is select dept.deptno,dname,empno,
  ename,sal,data_admissao from dept inner join emp
  on dept.deptno = EMP.deptno where dept.deptno=&Numero_depto;
 begin
  for v_contador in c_pesqemp loop
    dbms_output.put_line('departamento:'||v_contador.deptno
    ||'  '||'nome depto:'||v_contador.dname|| '   '||
    'empregado:'||v_contador.empno||'  '||'nome empregado'||
    '  '||v_contador.ename||'  '||'salario:'||v_contador.sal
    || '  '|| 'data admissão:' || v_contador.data_admissao);
end loop;
end;
/  
