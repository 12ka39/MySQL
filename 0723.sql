/*
	Author: N
    Date : 2024-07-23
    Objective: Basic SELECT
    Environment : Windows10, MySQL Workbench 8.0.38, MySQL 8.0.63
    
*/


/*  7월 23일 */

/* mycompany db */


select database();
select user();
select ename from emp;

/* 그룹 함수 - 값이 하나만 나오는 함수 Aggregate Function */
SELECT AVG(sal), SUM(sal), MAX(sal), MIN(sal)
FROM emp
WHERE deptno = 20;

/* 그룹 함수 사용시 주의점. 레코드 개수가 다르면 오류난다 */
/* SELECT ename, AVG(sal)  14개, 1개로 개수 불일치로 오류 남 */
SELECT AVG(comm), AVG(IFNULL(comm, 0)), SUM(IFNULL(comm, 0)) / COUNT(*)
FROM emp;

/* null은 계산에 제외된다 
IFNULL로 0으로 값 변경 -> 계산에 포함되어 결과가 다르게 나온다 */
SELECT AVG(comm), AVG(IFNULL(comm, 0))
FROM emp;

SELECT AVG(comm), AVG(IFNULL(comm, 0)), SUM(IFNULL(comm, 0)) / count(*)
FROM emp;


/* 중복 제거한 직무의 개수 */
SELECT count(DISTINCT job)
FROM emp;


SELECT MIN(hiredate), MAX(hiredate)
FROM emp; 

/* Group by 절 --- 부서별 */  
SELECT deptno, AVG(sal), MAX(sal), MIN(sal) /* 개수가 같아야 오류 안 남*/
FROM emp
GROUP BY deptno; /* 부서별 */


SELECT job, SUM(sal) 
from emp
GROUP BY job;


/* 입사 연도별 ********/
SELECT YEAR(hiredate), COUNT(*) AS "카운트"
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY YEAR(hiredate);


/* 멀티플 GROUP BY */
SELECT deptno, job, count(*)
FROM emp
GROUP BY deptno, job /* group by 에 있는 요소가 select에 올라와야 한다 */
ORDER BY deptno ASC; 


/* WITH ROLLUP */ /*  항목별 합계에 전체 합계 행이 하나 추가된다 */
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job
WITH ROLLUP;  /* 각 그룹의 전체 합을 보여주는 행 추가 */


/* 표준 JOIN - 다양한 데이터베이스 시스템에서 동일하게 작동.
   INNER JOIN, LEFT (OUTER) JOIN, RIGHT (OUTER) JOIN, FULL (OUTER) JOIN */

/* 비표준 JOIN  - SQL 표준을 따르지 않는 JOIN 방법들로, 주로 MySQL에서 특화된 기능이나 구문을 사용합니다. 다른 DBMS에서는 동일한 방식으로 동작하지 않을 수 있습니다.
STRAIGHT_JOIN, CROSS JOIN, NATURAL JOIN */

/* CROSS JOIN(카티션 곱) - 두 테이블에 관계가 없을 때 사용. 
두 테이블의 모든 가능한 행 조합을 반환
- 비표준join */

SELECT empno, ename, dname
FROM emp, dept;

/* 비표준 join - CROSS JOIN */
SELECT  emp.ename, emp.sal, dept.deptno, dept.loc, salgrade.grade
FROM   emp 
CROSS JOIN dept CROSS JOIN salgrade ;


/* 비표준 join (카티션곱에 조건 준 거) , 근데 많이 쓰인다, 별칭을 쓸 수 있다. */
SELECT ename, d.deptno, loc
FROM dept d, emp e /* 이게 제일 먼저 실행된다 */
WHERE d.deptno = e.deptno AND ename = 'SMITH';


/* 아래 2개의 문장을 하나로 만든 게 위에 있는 sql*/
SELECT deptno
FROM emp
WHERE ename = 'SMITH';  /* 20 */

SELECT loc
FROM dept
WHERE deptno = 20;



/* 위 sql과 결과는 같은데 다른 방법을 이용해보았다. */

SELECT ename, loc
/* FROM emp NATURAL JOIN dept  */
/* FROM emp INNER JOIN dept USING(deptno) */
FROM emp JOIN dept ON(emp.deptno = dept.deptno) /* 특별한 조인 유형을 지정하지 않으면 기본적으로 INNER JOIN으로 간주 */
/* 계속 조건을 추가하려면 join aaa on () JOIN bbb ON()   JOIN ccc ON()  ....추가 */
WHERE ename = 'SMITH';



/* world db */

use world;

/* 3개 테이블 join on */
/* 등가(=)조인, 내부 조인, 내추럴 조인 -- 이거 정말 많이 쓴다. */
SELECT city.name, city.Population, country.name, country.IndepYear, countrylanguage.Language
FROM city JOIN country ON (city.countrycode = country.code)
		  JOIN countrylanguage ON (country.code = countrylanguage.countrycode)
WHERE city.name = 'SEOUL';


/* mycompany DB*/
use mycompany;

/* 비등가 join */
SELECT ename, sal, grade
FROM emp, salgrade
WHERE (sal BETWEEN losal AND hisal) 
						AND ename ='SMITH'; 
         
       
SELECT  dept.deptno, dname, AVG(sal), SUM(sal)
FROM   emp JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY deptno;
       

SELECT emp.ename, emp.empno, dept.dname, dept.loc
FROM emp RIGHT OUTER JOIN dept ON (emp.deptno = dept.deptno);
/* FROM emp INNER JOIN dept ON (emp.deptno = dept.deptno);  이렇게 하면 오류 나는 거 정상.. 왜??*/ 

/* 테이블 그대로 데이터 까지 복사 */         
CREATE TABLE emp1 
AS
SELECT * FROM emp;


INSERT INTO emp1(empno, ename, sal, job,deptno)
VALUES(8282, 'JACK', 3000, 'ANALYST',50);

select * from emp1 where ename = 'jack';
         
/* LEFT OUTER JOIN */         
SELECT e.ename, e.job, e.sal, d.loc, d.dname
FROM emp1 e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno);
         
         
         
/* SELF JOIN 반드시 별칭을 써야 한다. 
안 쓰면 테이블명이 다 자기자신 구분이 안 됨*/
/* 우선은 SELF JOIN 안 하면 쿼리 2개 써야 함 */
SELECT mgr
FROM emp
WHERE ename = 'SMITH'; /* 7902 */

SELECT mgr
FROM emp
WHERE empno = '7902';

/* SELF JOIN */
SELECT CONCAT(worker.ename, '의 관리자의 이름은 ',  manager.ename, '입니다.')
FROM   emp  worker JOIN emp manager 
ON   worker.mgr = manager.empno;
/* WHERE worker.ename = 'SMITH'; */ 



/* UNION  중복 허용X */
/* 2개의 쿼리를 위아래로 이어붙여 출력하는 쿼리
위쪽 쿼리와 아래쪽 쿼리 칼럼의 개수, 데이터 타입 동일해야 한다 */

SELECT job, deptno
FROM emp
WHERE sal >= 3000

UNION

SELECT job, deptno
FROM emp
WHERE deptno = 10;




/* UNION ALL 중복 허용 */ 
/* 위아래의 쿼리 결과를 하나의 결과로 출력하는 집합 연산 */
SELECT job, deptno
FROM emp
WHERE sal >= 3000

UNION ALL

SELECT job, deptno
FROM emp
WHERE deptno = 10;

/* 서브 쿼리 - 서브 쿼리부터 수행된다*/
/* 사원 번호 7566의 급여보다 많이 받는 사원의 이름 */
/* 2개의 쿼리를 */
SELECT sal FROM emp WHERE empno = 7566; 
SELECT ename FROM emp WHERE sal > 2975.00;

/* 하나의 쿼리로 */
SELECT ename 
FROM emp 
WHERE sal > (SELECT sal FROM emp WHERE empno = 7566);


/* 스미스는 어디에서 근무하는가? */
SELECT deptno 
FROM emp 
WHERE ename='SMITH';  /* 20 */

SELECT loc 
FROM dept
WHERE deptno=20;


SELECT loc
FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');


/* 부서에서 최소 급여를 받는 사람 --- 바로 쿼리 짜도록 연습하자 */
select * from dept;
select min(sal) from emp group by deptno;

/* IN(1300.00, 800.00, 950.00) */  
SELECT ename, deptno, sal
FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp GROUP BY deptno);