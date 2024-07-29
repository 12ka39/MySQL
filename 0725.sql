/* 환자 테이블 */

CREATE TABLE Patient(
	number TINYINT PRIMARY KEY,
	code   CHAR(2)  NOT NULL,
	days   SMALLINT NOT NULL,
	age   TINYINT NOT NULL,
	dept VARCHAR(20),
	operfee INT,
	hospitalfee INT,
	money INT
);


/*
	Author: N
    Date : 2024-07-25
    Objective: Basic SELECT
    Environment : Windows10, MySQL Workbench 8.0.38, MySQL 8.0.63
    
*/

/* 트랜젝션 한 개 이상의 sql문장 (DML) 집합, (복원 가능) */
/* 순서

START TRANSACTION;  // 이거 안 써주면 오류 롤백 안 됨
SAVEPOINT aaa;
ROLLBACK TO aaa;

*/

START TRANSACTION; 

SELECT * FROM emp;

SELECT * FROM emp
WHERE empno=7782;

UPDATE emp 
SET deptno=30
WHERE empno=7782;


SAVEPOINT aaa; /* 세이브 포인트 */


INSERT INTO emp (empno,ename, job,mgr,hiredate,sal, comm, deptno)
VALUES(7997, 'TOM', 'SALESMAN',7782,CURDATE(),2000,2000,10);

ROLLBACK TO aaa; /* 세이브 포인트로 롤백 */



/* 테이블 구조 변경  -- 근데 안 하는게 좋다 (오라클은 아예 구조 변경 막아둠) */
/* 1) create table */

CREATE TABLE emp20
AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 20;

SELECT * FROM emp20;



/* 2) ALTER TABLE  - ADD, DROP, MODIFY */
ALTER TABLE emp20
ADD age TINYINT AFTER ename; /* 컬럼 위치 지정 */


ALTER TABLE emp20
DROP COLUMN sal;

ALTER TABLE emp20
MODIFY ename VARCHAR(20);


/* 3) DROP TABLE */
DROP TABLE emp20;



/* 제약 조건 */
CREATE TABLE jusorok(
	bunho SMALLINT,
    gender CHAR(6) DEFAULT 'female'
);


INSERT INTO jusorok VALUE(1, DEFAULT);
INSERT INTO jusorok VALUE(2, 'MALE');

SELECT * FROM jusorok;



CREATE TABLE Student(
	hakbun   CHAR(4),
    name     VARCHAR(20) NOT NULL,
    kor      TINYINT     NOT NULL CHECK(kor BETWEEN 0 AND 100),
    eng      TINYINT     NOT NULL,
    mat      TINYINT     NOT NULL DEFAULT 0,
    edp      TINYINT,  /* 테이블 생성 후 not null을 추가해봤다 */
    tot      SMALLINT,
    avg      FLOAT(5,2),
    grade    CHAR(1),
    deptno  TINYINT,
 
	CONSTRAINT student_hakbun_uk PRIMARY KEY(hakbun),  
    CONSTRAINT student_name_uk  UNIQUE(name),
    CONSTRAINT student_grade_ck CHECK(grade IN('A','B','C','D','F')),
    CONSTRAINT student_deptno_fk FOREIGN KEY(deptno)
			REFERENCES dept(deptno)

) DEFAULT CHARSET utf8;


ALTER TABLE Student
MODIFY tot TINYINT NOT NULL;


/* 테이블 레벨      제약 조건 추가 -> ADD CONSTRAINT */
ALTER TABLE Student
ADD CONSTRAINT student_tot_ck CHECK(tot BETWEEN 0 AND 400);

/* not null은 반드시   ALTER TABLE     MODIFY    */
ALTER TABLE Student
MODIFY eng TINYINT;

/* 제약조건 삭제     ALTER TABLE         DROP CONSTRAINT     */
ALTER TABLE Student
DROP CONSTRAINT student_name_uk;

