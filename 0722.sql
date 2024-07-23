
/*
	Author: N
    Date : 2024-07-22
    Objective: Basic SELECT
    Environment : Windows10, MySQL Workbench 8.0.38, MySQL 8.0.63
    
*/

/* mycompany DB */

select 4+5; /* mysql은 from이 필수가 아니다. oracle은 필수 */
SELECT * FROM mycompany.dept;
SELECT deptno, dname, loc
FROM dept;

/* 0과 null은 다르다! comm 컬럼 참조 */
SELECT ename, empno, sal+1, hiredate, comm
FROM emp;

/* null은 연산이 되지 않는다. */
SELECT ename, sal, comm, sal + comm
FROM emp
WHERE ename = 'SMITH';

/* DB에서 null은 연산이 안 되어 골치아프다 
이걸 처리할 함수가 각 DB마다 있다
IFNULL 함수*/
SELECT  ename, sal, comm, sal + IFNULL(comm, 0)
FROM emp
WHERE ename = 'SMITH';

/* 연봉 */
SELECT empno, ename, (sal + IFNULL(comm, 0)) *12
FROM emp;
/* 윈도우에서는 대소문자 구분 안 하지만, 리눅스는 대소문자 구분하니까 
적을 때 대소문자 잘 구분하는 습관을 들이자 */

/* null을 최소화 시키는 게 정규화 */
SELECT  *
FROM emp;

/* 별칭 */ 
SELECT empno AS "사원번호", ename AS "사원이름", (sal + IFNULL(comm, 0)) *12 as "Annual Salary"
FROM emp;

/* 연결연산자 CONCAT(, , , ) */
SELECT CONCAT(ename, '의 봉급은', sal, '입니다')
FROM emp;


/* emp 테이블의 레코드 개수만큼 aaa를 찍는다*/ 
SELECT 'aaa' 
FROM emp; 

/* ALL 컬럼명 (중복 허용, 디폴트)*/
SELECT ALL job 
FROM emp;

/* DISTINCT 컬럼명 (중복 불허용)*/
SELECT DISTINCT job 
FROM emp;

SELECT DISTINCT deptno /* 부서명 */
FROM emp;

/* where */
SELECT *
FROM emp
WHERE ename = UPPER('smith'); 
/* 사실 윈도우는 대소문자를 구분 안 해도 상관업는데 리눅스는 구분되기 때문에
구분을 하자 */



/* 1980년 입사한 직원 */
/* 날짜형은 내부적으로 숫자로 저장되기 때문에 비교가 가능하다 */
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '1980-01-01' AND hiredate<='1980-12-31';


SELECT now(), version();


/* BETWEEN A AND B */
SELECT ename, sal, hiredate
FROM emp
WHERE hiredate BETWEEN '1987-01-01' AND '1987-12-31';
/* WHERE hiredate >='1987-01-01' AND hiredate <= '1987-12-31'; */

/* 우리 회사 직원 중에서 직무가 회사원이거나 분석가인 사원의 사원이름, 사원의 직무를 출력하시오 */
SELECT ename, job
FROM emp
WHERE job IN('CLERK' , 'ANALYST'); /* job = 'CLERK' or job = 'ANALYST'; 
or로 쓰면 너무 길어지니까 IN()으로 묶는다 */



/* <패턴매칭>    1글자 대용>  _     여러글자 대용>  %     */

SELECT ename
FROM emp
WHERE ename LIKE 'S%'; /* s로 시작하는 사원 이름 */



SELECT ename
FROM emp
WHERE ename LIKE '%T'; /* t로 끝나는 사원 이름 */


SELECT ename FROM emp WHERE ename LIKE '%I%'; 
SELECT ename FROM emp WHERE ename LIKE '%I_'; 

SELECT ename, job,hiredate FROM emp
WHERE hiredate LIKE '1987%';

/* 우리 회사 직원 중에 보너스를 받는 사람은? */
SELECT empno, ename, comm, deptno
FROM emp
WHERE comm IS NOT NULL;


/* order by는 데이터랑 상관 없고, 출력 직전에 실행된다*/
/* (1차 정렬) 입사일 기준 내림차순,  (2차 정렬)월급 기준 오름차순 */
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY hiredate DESC, sal ASC;

/* 우리 회사 직원 중 20번 부서 또는 30번 부서의 연봉 내림차순으로 출력하시오 */
SELECT deptno, (sal + IFNULL(comm, 0)) * 12 AS Annual
FROM emp
WHERE deptno IN(20, 30)
ORDER BY Annual DESC; 


