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

insert into emp values(100,'Jose Silva',1200.35,1,'12-12-11');
insert into emp values(101,'João Barbosa',1800.35,1,'11/11/11');
insert into emp values(102,'Carlos Siqueira',2000,1,'09/10/16');
insert into emp values(103,'Maria Santos',3400,2,'12/12/18');
insert into emp values(104,'Celina Anjos',3800,2,'01/01/16');
insert into emp values(105,'Alberto Carlos',5800,3,'03/03/15');
insert into emp values(106,'Roberto Vieira',4900,3,'04/04/12');

/* SELECIONE OS EMPREGADOS ADMITIDOS A PARTIR DE UMA DETERMINADA DATA E NÃO GANHAM O MINIMO
ESTIPULADO PELA EMPRESA A PARTIR DESSA DARA E ALTERE O SALÁRIO DOS MESMOS PARA QUE PASSE A 
GANHAR ESSE MINIMO
*/


SET SERVEROUTPUT ON
DECLARE
    VDEPT DEPT.DEPTNO%TYPE;
    VNOME_DEPTO DEPT.DNAME%TYPE;
    VEMP EMP.EMPNO%TYPE;
    VNOME_EMP EMP.ENAME%TYPE;
    VSAL EMP.SAL%TYPE;
    VDATA EMP.DATA_ADMISSAO%TYPE;
    VVALOR_MINIMO NUMBER(9,2):=&DIGITE_VALOR_MINIMO;
    CURSOR PESQ_EMP IS SELECT DEPT.DEPTNO, DNAME, EMPNO, ENAME, SAL, DATA_ADMISSAO
    FROM DEPT INNER JOIN EMP ON DEPT.DEPTNO=EMP.DEPTNO WHERE
    DATA_ADMISSAO >= '&DIGITE_DATA_ADMISSAO';

BEGIN
    OPEN PESQ_EMP;
    LOOP
        FETCH PESQ_EMP INTO VDEPT, VNOME_DEPTO, VEMP, VNOME_EMP, VSAL, VDATA;
        EXIT WHEN PESQ_EMP%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('NUMERO DEPTO: ' || VDEPT );
        DBMS_OUTPUT.PUT_LINE('NOME DEPTO: ' || VNOME_DEPTO);
        DBMS_OUTPUT.PUT_LINE('NUMERO EMP: ' || VEMP);
        DBMS_OUTPUT.PUT_LINE('NOME EMP: ' || VNOME_EMP);
        DBMS_OUTPUT.PUT_LINE('SALARIO: ' || VSAL);
        DBMS_OUTPUT.PUT_LINE('DATA ADMISSAO' || VDATA);
        IF VSAL < VVALOR_MINIMO THEN
            UPDATE EMP SET SAL = VVALOR_MINIMO WHERE EMPNO=VEMP
            AND DATA_ADMISSAO >= VDATA;
        END IF;
    END LOOP;
    CLOSE PESQ_EMP;
END;
/

