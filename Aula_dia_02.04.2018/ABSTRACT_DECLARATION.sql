
-- Pega o tipo de dado da coluna especificada
VARIAVEL TB_NAME_AND_GENDER.FIRST_NAME%TYPE;



DECLARE 
	TB_PERSON TB_NAME_AND_GENDER%ROWTYPE;
BEGIN
SELECT *
INTO TB_PERSON
FROM TB_NAME_AND_GENDER
WHERE PERSON_CODE = 1;

-- SELECT PERSON_CODE, FIRST_NAME, GENDER
-- INTO TB_PERSON.PERSON_CODE, TB_PERSON.FIRST_NAME, TB_PERSON.GENDER
-- FROM TB_NAME_AND_GENDER
-- WHERE PERSON_CODE = 1;

DBMS_OUTPUT.PUT_LINE('NOME: ' || TB_PERSON.FIRST_NAME || CHR(10) || 'SEXO: ' || TB_PERSON.GENDER);

END;
/




CREATE OR REPLACE FUNCTION FIND_NAME(NAME_PERSON TB_PERSON.FIRST_NAME%TYPE) RETURN VARCHAR2 IS 
DECLARE 
CURSOR MOUSE IS SELECT PERMISSION, MIDDLE_NAME, LAST_NAME
FROM TB_PERMISSION T1 
INNER JOIN TB_USER_PERMISSION T2 
ON T1.ID_TB_PERMISSION = T2.ID_TB_PERMISSION 
INNER JOIN TB_PERSON T3
ON T2.ID_TB_USER = T3.ID_TB_USER
WHERE FIRST_NAME = NAME_PERSON;

V_PERMISSAO TB_PERMISSION.PERMISSION%TYPE;
V_NOME_MEIO TB_PERSON.MIDDLE_NAME%TYPE;
V_NOME_FIM TB_PERSON.LAST_NAME%TYPE;

BEGIN 

	FOR I IN MOUSE LOOP
		
		EXCEPTION WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('FODEU');
	END LOOP;

END;