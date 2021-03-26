--usando laço loop - faz numero de vezes determinado no laço
set serveroutput on
DECLARE 
 v_acumula NUMBER(2) := 0; 
BEGIN 
 FOR V_CONTADOR IN 1..10  LOOP 
 v_acumula :=v_acumula +1; 
 DBMS_OUTPUT.PUT_LINE (v_acumula); 
 END LOOP; 
END; 
/

-- laço while - testa condição antes
DECLARE 
v_conta NUMBER(2) := 0; 
BEGIN 
 while v_conta < 10 LOOP 
 v_conta := v_conta +1; 
 DBMS_OUTPUT.PUT_LINE (v_conta); 
 END LOOP; 
END; 
/
----------------------------------------

-- laço loop - faz pelo menos uma vez
DECLARE 
 V_ACUMULA NUMBER(2) := 0; 
BEGIN 
 LOOP 
 V_ACUMULA := V_ACUMULA +1; 
 DBMS_OUTPUT.PUT_LINE (V_ACUMULA); 
 IF V_ACUMULA = 10 
   THEN EXIT; 
 END IF; 
 END LOOP; 
END; 
/ 
--------------------------------------------------------------------
 -------------------EXEMPLOS------------------------
-- Estruturas de Controle - WHILE , LOOP , FOR

--------------EXEMPLO DE DE CONTROLE LOOP...END LOOP;
SET SERVEROUTPUT ON
DECLARE    
  V_CODIGO   NUMBER(4); 
  V_NOME_FUNC VARCHAR2(15);
  V_SALARIO  NUMBER(10,2);
  V_AUMENTO NUMBER(3);
  V_ANO NUMBER(2):=0;
BEGIN   
     SELECT EMPNO,ENAME,SAL INTO V_CODIGO,V_NOME_FUNC,V_SALARIO  
     FROM EMP WHERE EMPNO=&V_CODIGO;
     DBMS_OUTPUT.PUT_LINE('CODIGO: ' || V_CODIGO ||'  '|| 'NOME:'|| 
     V_NOME_FUNC || '   ' || 'SALARIO:' || V_SALARIO );
     DBMS_OUTPUT.PUT_LINE('VALOR PREVISTO PRÓXIMO 5 ANOS');
     V_AUMENTO:='&DIGITE_PREVISAO_AUMENTO';
     LOOP
        V_ANO:=V_ANO+1;
        V_SALARIO:=V_SALARIO*V_AUMENTO/100+V_SALARIO;
        DBMS_OUTPUT.PUT_LINE('NO ANO:' || V_ANO ||'  ' || ' SALARIO SERÁ:' ||V_SALARIO);
      EXIT WHEN V_ANO >=5;
    END LOOP;
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');  
 END;
  / 
-------------------------------------------------------------------------------------------

---EXEMPLO DE ESTRUTURA DE CONTROLE WHILE-END LOOP;
SET SERVEROUTPUT ON
DECLARE    
  V_CODIGO   NUMBER(4); 
  V_NOME_FUNC VARCHAR2(15);
  V_SALARIO  NUMBER(10,2);
  V_AUMENTO NUMBER(3);
  V_ANO NUMBER(2):=1;
BEGIN   
     SELECT EMPNO,ENAME,SAL INTO V_CODIGO,V_NOME_FUNC,V_SALARIO  
     FROM EMP WHERE EMPNO=&V_CODIGO;
     DBMS_OUTPUT.PUT_LINE('CODIGO: ' || V_CODIGO ||'  '|| 'NOME:'|| 
     V_NOME_FUNC || '   ' || 'SALARIO:' || V_SALARIO );
     DBMS_OUTPUT.PUT_LINE('VALOR PREVISTO PRÓXIMO 5 ANOS');
     V_AUMENTO:='&DIGITE_PREVISAO_AUMENTO';
     WHILE V_ANO <=5 LOOP
        V_SALARIO:=V_SALARIO*V_AUMENTO/100+V_SALARIO;
        DBMS_OUTPUT.PUT_LINE('NO ANO:' || V_ANO ||'  ' || ' SALARIO SERÁ:' ||V_SALARIO);
        V_ANO:=V_ANO+1;
    END LOOP;
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');  
 END;
  / 

--------------------------------------------------------------------------------------------
     
---EXEMPLO DE ESTRUTURA DE CONTROLE FOR-END LOOP;
SET SERVEROUTPUT ON
DECLARE    
  V_CODIGO   NUMBER(4); 
  V_NOME_FUNC VARCHAR2(15);
  V_SALARIO  NUMBER(10,2);
  V_AUMENTO NUMBER(3);
BEGIN   
     SELECT EMPNO,ENAME,SAL INTO V_CODIGO,V_NOME_FUNC,V_SALARIO  
     FROM EMP WHERE EMPNO=&V_CODIGO;
     DBMS_OUTPUT.PUT_LINE('CODIGO: ' || V_CODIGO ||'  '|| 'NOME:'|| 
     V_NOME_FUNC || '   ' || 'SALARIO:' || V_SALARIO );
     DBMS_OUTPUT.PUT_LINE('VALOR PREVISTO PRÓXIMO 5 ANOS');
     V_AUMENTO:='&DIGITE_PREVISAO_AUMENTO';
     FOR CONTA IN 1..5 LOOP
         V_SALARIO:=V_SALARIO*V_AUMENTO/100+V_SALARIO;
         DBMS_OUTPUT.PUT_LINE('NO ANO:' || CONTA ||'  ' || ' SALARIO SERÁ:' ||V_SALARIO);
     END LOOP;
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO');  
 END;
  / 

