-- Regras de Negócio:
-- 01 - Não pode cadastrar mais de 4 alunos na mesma turma
-- 02 - Não pode cadastrar um aluno em uma turma que não existe

-- Inserir novo aluno
set serveroutput on
declare
  valuno number(4) := &digitenumero;
  vnome varchar(15) := '&digitenome';
  vturma number(4) := &digitaturma;
  valunos number(4);
  turma_limite exception;
  pragma exception_init(turma_limite,-20001); 
  turma_not_found exception;
  -- -2291 FK exception
  pragma exception_init(turma_not_found, -2291);
begin
   select 
        count(id_aluno) 
   into valunos 
   from t_aluno 
   where id_turma=vturma;

   if valunos >= 4 then
        raise_application_error(-20001, 'Não pode ser adicionado novos alunos!'); 
   else 
        insert into t_aluno 
        values (valuno,vnome,vturma);
   end if; 
exception
   when turma_limite then
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
   when turma_not_found then
        dbms_output.put_line(sqlcode);
        dbms_output.put_line('Turma não encontrada');
   when dup_val_on_index then
        dbms_output.put_line('Chave primária duplicada!');
end;