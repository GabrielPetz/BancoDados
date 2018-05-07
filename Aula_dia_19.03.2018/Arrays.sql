DECLARE 
type Arraynome IS VARRAY(6) OF VARCHAR2(10);
type Notas IS VARRAY(6) OF INTEGER;
nomes Arraynome;
nota Notas;
total Integer;
BEGIN 
nomes:= Arraynome('Jão','Zé','Madruga','Chaves','Kiko');
nota:= Notas(98,65,98,54,65);
total:= nomes.count;
dbms_output.put_line('Total' || total || 'Students');
FOR i in 1..total LOOP
dbms_output.put_line('Student: ' || nomes(i) || 'point: ' || nota(i));
END LOOP;
END;
/




CREATE OR REPLACE FUNCTION VALIDACPF(NRCPF NUMBER) RETURN NUMBER IS
BEGIN
DECLARE 
	TYPE ARRAYCPF IS VARRAY(11) OF NUMBER(1);
	CPF ARRAYCPF := ARRAYCPF();
	CPFSTRING VARCHAR2(11);
	SOMA NUMBER(30);
	DIGITO1 NUMBER(5) := 0;
	DIGITO2 NUMBER(5) := 0;
BEGIN
		CPFSTRING := LPAD( TO_CHAR( NRCPF ), 11, '0'); 
		dbms_output.put_line('CPF recebido: ');
		dbms_output.put_line(CPFSTRING);
		dbms_output.put_line('-----------------------------------------------');
		FOR I IN 1..LENGTH(CPFSTRING) LOOP
			CPF.EXTEND();
			CPF(I) := SUBSTR(CPFSTRING, I, 1);
			dbms_output.put_line(CPF(I));
		END LOOP;
			dbms_output.put_line('-----------------------------------------------');
		FOR I IN 1..9 LOOP
			DIGITO1 := DIGITO1 + ( CPF(I) * ( 11 - I ) );
			dbms_output.put_line(DIGITO1);
		END LOOP;
			dbms_output.put_line('-----------------------------------------------');

		DIGITO1 := DIGITO1 * 10;

		DIGITO1 := MOD(DIGITO1, 11);

		IF DIGITO1 = 10 THEN 
		DIGITO1 := 0;
		END IF; 

		IF DIGITO1 != CPF(10)
		THEN RETURN 0;
		END IF; 
		
		dbms_output.put_line('Digito verificador 1 : ');
		dbms_output.put_line(DIGITO1);
		dbms_output.put_line('-----------------------------------------------');


		FOR I IN 1..10 LOOP
			DIGITO2 := DIGITO2 + ( CPF(I) * ( 12 - I ) );
			dbms_output.put_line(DIGITO2);
		END LOOP;
			dbms_output.put_line('-----------------------------------------------');

				DIGITO2 := DIGITO2 * 10;

				DIGITO2 := MOD(DIGITO2, 11);

				IF DIGITO2 = 10 THEN 
				DIGITO2 := 0;
				END IF; 

				IF DIGITO2 != CPF(11)
				THEN RETURN 0;
				END IF; 


			dbms_output.put_line('Digito verificador 2 : ');
			dbms_output.put_line(DIGITO2);
			dbms_output.put_line('-----------------------------------------------');



		RETURN 1;
END;
END;
/


SELECT VALIDACPF(52998224725) FROM DUAL;
SELECT VALIDACPF(10615753906) FROM DUAL;
SELECT VALIDACPF(92920091921) FROM DUAL;
