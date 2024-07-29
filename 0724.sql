/*
	Author: N
    Date : 2024-07-24
    Objective: Basic SELECT
    Environment : Windows10, MySQL Workbench 8.0.38, MySQL 8.0.63
    
*/

/* insert */

use mycompany;
SELECT * FROM dept;

/* 이렇게 해도 되지만 다른 사람이 보면 가독성이 안 좋음 */
INSERT INTO dept 
VALUES (50, 'Design', 'Busan');


/* 컬럼 순서에 맞는 값만 잘 적어주면 컬럼 뭘 먼저 쓰든 상관 없음 */
INSERT INTO dept(loc, deptno, dname)
VALUES('Taejeon', 60, 'Development');


/* 암시적 NULL */
INSERT INTO dept(deptno, dname, loc)
VALUES(70, NULL, 'Inchon');


/* 명시적으로 NULL 을 쓸 때 */
insert into dept(deptno, dname, loc) 
values(70, null, 'Incheon');


/* 제약조건 - 부서번호 deptno(PK)는 입력 필수 사항이라 아래 sql문은 오류다 */
INSERT INTO dept(dname, loc)
VALUES('Account', 'Yongin'); /* 오류 */

/* 제약 조건 위배 - 부서번호(deptno)가 dept라는 부모 테이블에서 값을 참조(FK)하는데 
부모테이블에 없는 값이라 오류 */
INSERT INTO emp(empno, deptno)
VALUES(9999, 90);



/* 데이터 불일치. hiredate는 '연월일'만 나오고, now()는 '연월일 시분초'라. 타입이 안 맞음. 
그래도 입력하면 warning 뜨면서 시분초 잘리고 데이터 들어가지만
				==> curdate() 쓰자 */
               
/*  CURDATE(), 연월일 */
INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES(9998, 'Jimin', CURDATE(), 40); 

/* NOW() 연월일 시분초 */
INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES(9990, 'Jimin', NOW(), 40); /* now 로 해도 경고 뜨고 데이터는 연월일까지만 잘려서 들어감*/

SELECT * FROM emp;


/* copy 하면 제약조건 다 날아간다 
스키마(구조) + 데이터 복사 */
CREATE TABLE emp_copy
AS
SELECT empno, ename, sal, hiredate
FROM emp 
WHERE deptno = 10;


/* 스키마(구조)만 복사 - WHERE 절에 말도 안 되는 조건 줘서 데이터는 없게 만든다. */
CREATE TABLE emp_copy1
AS
SELECT *
FROM emp 
WHERE 0 = 1; /* 이런 조건을 충족하는 데이터는 없으니까 
데이터는 제외하고, 구조만 복사된다. */


SELECT * FROM emp_copy1; /* 스키마만 복사한 테이블 - 제약조건 초기화됨 */
/* 복사한 테이블에 데이터 추가 (한글이 되는지 확인하자) */

INSERT INTO emp_copy1(empno, ename) VALUES (1122, "한지민");


/* update 와 delete는 반드사 where이 있어야 한다. 
						안 그러면 전체 적용되니 주의하자. */

/* UPDATE      SET      */
SELECT * FROM dept;

INSERT INTO dept(deptno) VALUES (70);

UPDATE dept
SET dname = 'FINANCE'
WHERE deptno = 70;

/* 여러 개를 한꺼번에 바꿀 때 */
UPDATE dept 
SET dname='HR', loc='Busan'
WHERE deptno=70; 

UPDATE DEPT 
SET DEPTNO=60, DNAME='MI', LOC='SKY'
WHERE DEPTNO=70;