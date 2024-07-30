/*

	VIEW - 보안과 빠른 속도를 위해 쓰인다
    PROCEDURE - 리턴 없는 함수

	Author: N
    Date : 2024-07-30
    Objective: VIEW
    Environment : Windows10, MySQL Workbench 8.0.38, MySQL 8.0.63
    

view
OR REPLACE
*/


/* VIEW */
CREATE VIEW aaa
AS
SELECT empno,ename, job
FROM emp
WHERE deptno=10;

SELECT *
FROM aaa; 


/* JOIN	된 VIEW가 만들어졌다 */

CREATE VIEW bbb
AS
SELECT empno, ename, dname, loc
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE dept.deptno = 30;

SELECT * FROM bbb;


CREATE OR REPLACE VIEW EMP20(ENO,NAME,PAYROLL)
AS
SELECT EMPNO,ENAME,SAL
FROMEMP
 163   WHEREDEPTNO=20;
 
 DESC INFORMATION_SCHEMA.VIEWS;
 
/* 단순 뷰 - 단순뷰는 READ, WRITE 가 된다 
INSERT 쿼리를 쓸 수 있다는 뜻 */
CREATE VIEW EMP_30_VU
AS
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 30;

SELECT *
FROM EMP_30_VU;

INSERT INTO EMP_30_VU
VALUES(1111, 'Jimin', 500, 30);


/*  WITH CHECK OPTION -- 업데이트 방지(안전장치) */

CREATE OR REPLACE VIEW emp_20
AS
SELECT * FROM emp
WHERE deptno = 20
WITH CHECK OPTION;

SELECT *
FROM emp_20;


/* WITH CHECK OPTION 때문에 업데이트 안 됨. */

UPDATE emp_20
SET deptno = 30
WHERE empno = 7369; /* 오류 나는 거 정상 */

/* INDEX  인덱스 - 속도 때문에 쓴다 */ 
SHOW INDEX FROM emp;

CREATE INDEX i_emp_ename ON emp(ename);


/* pdf 12장 - stored procedure는 보안, 퍼포먼스 좋지만 
JPA에서는 에러 메시지가 잘 안 떠서 안 쓴다. 
jpa 에서는 sql문을 쓴다. */
/* $$ 로 써도 됨   delimiter : 시작 ~ 끝*/

delimiter //
CREATE PROCEDURE if_test()
BEGIN
	DECLARE var INT;
	SET var := 51;
	IF var % 2 = 0 THEN
		SELECT 'Even Number';
	ELSE
		SELECT 'Odd Number';
	END IF;
END
//
delimiter ;


CALL if_test();



/* 13장 */


/* 파라미터 없는 프로시저. 콜 바이 네임(이름으로 호출하기)*/
DELIMITER $$
CREATE procedure helloworld()
BEGIN
	SELECT 'hello world';
END
$$
DELIMITER ;

CALL helloworld();