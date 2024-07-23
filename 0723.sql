
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
SELECT ename, AVG(sal) /* 14개, 1개로 개수 불일치로 오류 남 */
FROM emp
WHERE deptno = 20;

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

/* 입사 연도별 */
SELECT YEAR(hiredate), COUNT(*) AS "카운트"
FROM emp
GROUP BY YEAR(hiredate)
ORDER BY YEAR(hiredate);


/* 멀티플 GROUP BY */
SELECT deptno, job, count(*)
FROM emp
GROUP BY deptno, job /* 그룹바이 있는 요소가 select에 올라와야 한다 */
ORDER BY deptno ASC; 


/* WITH ROLLUP */
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job
WITH ROLLUP; /* 소계 - 각 그룹의 합, 전체 합을 보여준다 */


/* 안 됨 오류-! */
/* CROSS join(카티시안 곱) - 두 테이블에 관계가 없을 때 사용. - 비표준join, 표준join*/
/* 비표준 join ->  */
SELECT emp.ename, emp.sal, dept.detpno, dept.loc
FROM emp, dept;

/* 표준 join */
SELECT emp.ename, emp.sal, dept.detpno, dept.loc, salgrade.grade
FROM emp CROSS JOIN dept CROSS JOIN salgrade;


/* CROSS JOIN */
/* 비표준 join , 근데 많이 쓰인다, 별칭을 쓸 수 있다. */
SELECT ename, d.deptno, loc
FROM dept d, emp e /* 이게 제일 먼저 실행되니까 */
WHERE d.deptno = e.deptno AND name = 'SMITH';





SELECT ename, loc
/* FROM emp NATURAL JOIN dept  */
/* FROM emp INNER JOIN dept USING(deptno) */
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
/* 계속 조건을 추가하려면 join aaa on ()  ....추가 */
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

/* 비등가 join */  /* 이것도 오류 */
/*
SELECT ename, sal, grade
FROM emp, salgrade
WHERE (sal BETWEEN losal AND hisal)
		 AND ename ='SMITH"; 
         */
       
/* 이것도 안 됨 */
SELECT emp.ename, emp.empno.dept.dname, dept.loc
FROM emp RIGHT OUTER JOIN dept ON (emp.deptno = dept.deptno);
/* FROM emp INNER JOIN dept ON (emp.deptno = dept.deptno);  이렇게 하면 오류 나는 거 정상*/ 

         
CREATE TABLE emp1 SELECT * FROM emp;
 
INSERT INTO emp1(empno,ename, sal, job,deptno)
VALUES(8282, 'JACK',3000, 'ANALYST',50);
         
SELECT e.ename, e.job, e.sal, d.loc, d.dname
FROM emp1 e LEFT OUTER JOIN dept d
ON (e.deptno = d.deptno);
         
         
         
/* self join은 반드시 별칭을 써야 한다*/
SELECT mgr
FROM emp
WHERE ename = 'SMITH'; /* 7902 */


SELECT mgr
FROM emp
WHERE empno = '7902';

/* 실행은 되는데 왜 이렇게 쓰는지 모르겠음 */
SELECT CONCAT(worker.ename, ' 의 관리자의 이름은 ', manager.ename, ' 입니다.')
FROM emp worker JOIN emp manager
ON worker.mgr = manager.empno;
/* WHERE employer.ename = 'SMITH'; */



/* UNION  중복 허용X */

SELECT job, deptno
FROM emp
WHERE sal >= 3000

UNION

SELECT job, deptno
FROM emp
WHERE deptno = 10;



/* UNION ALL 중복 허용 */ 
SELECT job, deptno
FROM emp
WHERE sal >= 3000

UNION ALL

SELECT job, deptno
FROM emp
WHERE deptno = 10;

/* 서브 쿼리 - 서브 쿼리부터 수행된다*/
/* 사원 번호 7566의 급여보다 많이 받는 사원의 이름 */
/* 이 두 줄을 하나로 */
SELECT sal FROM emp WHERE empno = 7566; 
SELECT ename FROM emp WHERE sal > 2975.00;

SELECT ename 
FROM emp 
WHERE sal > (SELECT sal FROM emp WHERE empno = 7566);


/* 스미스는 어디에서 근무하는가? */
SELECT deptno
FROM emp
WHERE ename='SMITH';

SELECT loc
FROM dept
WHERE deptno=20;


SELECT loc
FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');


/* 부서에서 최소 급여를 받는 사람- - 이것도 안 됨 */
IN(1300.00, 800.00, 950.00) 
SELECT ename, deptno, sal
FROM emp
WHERE sal IN(SELECT MIN(SAL) FROM emp
GROUP BY depno);