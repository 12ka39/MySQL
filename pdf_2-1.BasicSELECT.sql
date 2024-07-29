/* 2-1.Basic SELECT 실습 .pdf */

/* <정리> 
>NOT 
select * from emp
where not job ='manager'; 

> NOT IN
select ename, job from emp
where job NOT IN('CLERK', 'MANAGER', 'ANALYST');

>ROUND
select ename, sal, round(sal/5/12, 1) as '시간당 임금' from emp
where deptno = 20;

>IS NOT NULL
select ename, sal, comm, sal+comm as '총액' from emp
where comm is not null
order by '총액' desc;

>CAST
SELECT * FROM EMP
WHERE CAST(hiredate AS DATE) >='1981-4-2';
/* CAST 다른 데이터 유형으로 변환 -> AS DATE 형식으로 바꿈 


>LIKE | NOT LIKE
LIKE 'S%';

46. 입사일이 1981년 이외에 입사한 사람의 모든 정보를 출력하시오. 
select * from emp
where hiredate not LIKE '1981%';

>EXTRACT (A FROM B) - (B에서 A추출)  시간 데이터형의 특정 구성 요소를 추출할 때 사용하는 함수 

SELECT *
FROM emp
WHERE EXTRACT(YEAR FROM hiredate) <> 1981;

*/



/* 11. 1983년 이후에 입사한 사원의 사번, 이름, 입사일을 출력하시오. */
select empno, ename, hiredate from emp
where year(hiredate) >= 1983;


/* 12. 급여가 보너스(comm) 이하인 사원의 이름, 급여 및 보너스를 출력하시오. */
select ename, sal, comm from emp
where sal <= comm ;


/* 13. 관리자의 사원번호가 7902,7566,7788인 모든 사원의 사원번호,이름,급여 및 관리자의 
사원번호를 출력하시오. */
select empno, ename, sal, mgr  from emp
where mgr in(7902,7566,7788);



/* 14. 이름이 FORD 또는 ALLEN인 사원의 사번, 이름, 관리자 사원번호, 부서번호를 출력하시오. */
select empno, ename, mgr, deptno from emp
where ename in('ford', 'allen');


/*  15. job이 CLERK이면서 급여가 $1100 이상인 사원의 사번, 이름, 직위, 급여를 출력하시오. */
select empno, ename, job, sal from emp
where job='clerk' and sal >=1100;


/*** NOT IN ***********/
/* 16. 직위가 CLERK,MANAGER,ANALYST가 아닌 모든 사원의 이름 및 직위를 출력하시오. */
select ename, job from emp
where job NOT IN('CLERK', 'MANAGER', 'ANALYST');



/* 17. 두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
  1) 직위가 PRESIDENT면서 급여가 1500을 넘어야 한다.
  2) 직위가 SALESMAN이어야 한다  */
  
  select ename, job, sal from emp
  where job ='PRESIDENT' and sal>=1500 or job= 'SALESMAN';
 
 
/* 18. 두가지 조건을 만족하는 쿼리를 작성하시오. 이름, 직위, 급여를 출력합니다.
	1) 직위가 PRESIDENT 또는 SALESMAN이어야 한다.
	2) 급여가 1500을 넘어야 한다
*/
 
SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'PRESIDENT' OR job = 'SALESMAN') AND sal >= 2000;


/* 20.empTable에서 이름, 급여, 커미션 금액, 총액(sal+comm)을 구하여 총액이 많은 순서로 출
력하라. 단, 커미션이 NULL인 사람은 제외한다. */
select ename, sal, comm, (sal+comm) from emp
where comm is not null
order by sal desc;


/* 21.10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여,
보너스 금액, 부서번호를 출력하라. */
select ename, sal, ifnull(comm, 0) + sal*0.13 as '보너스', deptno from emp 
where deptno = 10;


/* 22. 30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉을 출력하라. 단, 연말에 급여의 150
 %를 보너스로 지급한다. */
 select ename, deptno, sal, (sal*12 + sal*1.5) as '연봉' from emp 
where deptno = 30;


 /* --------------- round -------------- */ 
/* 23. 부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라. 단,1달의 근무일수는 12일이고,
 1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올
림)을 출력하라 */
select ename, sal, round(sal/5/12, 1) as '시간당 임금' from emp
where deptno = 20;


/* 24. 모든 사원의 실수령액을 계산하여 출력하라. 단, 이름, 급여, 실수령액을 출력하라.(
실수령액은 금여에 대해 10%의 세금을 뺀 금액) */
select ename, sal, sal * 0.9 as 'real_sal' from emp;


/* 25.dept 테이블의 구조와 내용을 조회하라. */
select * from dept;

/* 26.dept 테이블에서 부서명과 위치를 연결하여 출력하라. */
select concat('부서번호: ', deptno, ' 위치: ', loc) from dept;

/* 27.emp 테이블에서 사원번호가 7788인 사원의 이름과 부서번호를 출력하는 문장을 작성하시오. */
select ename, deptno from emp
where empno=7788;


/*** IS NOT NULL ******/
/* 28.emp 테이블에서 이름, 급여, 커미션 금액, 총액(sal+comm)을 구하여 총액이 많은 순서로 출
력하라. 단, 커미션이 NULL인 사람은 제외한다. */

select ename, sal, comm, sal+comm as '총액' from emp
where comm is not null
order by '총액' desc;


/* 29. 10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여,
보너스 금액, 부서번호를 출력하라. */
select ename, sal, ifnull(comm,0) + sal*0.13 as 'bonus', deptno from emp
where deptno = 10;


/* 30. 30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉을 출력하라. 단, 연말에 급여의 150
%를 보너스로 지급한다. */


/*  31. 부서번호가 20인 부서의 시간당 임금을 계산하여 출력하라. 단,1달의 근무일수는 12일이고,
 1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올
림)을 출력하라 */



/* 32. 부서번호가 10번인 부서의 사람 중 사원번호, 이름, 월급을 출력하시오 */
select empno, ename, sal from emp
where deptno =10;

/*  33. 사원번호가 7369번 인 사람의 이름, 입사일, 부서번호를 출력하시오 */
select ename, hiredate, deptno from emp
where empno = 7369;

/* 34. 이름이 ALLEN인 사람의 모든 정보를 출력하시오 */
select * from emp where ename='allen';

/* 35. 입사일이 1981년 9월 8일 사원의 이름, 부서번호, 월급을 출력하시오. */
select ename, deptno, sal from emp
where hiredate = '1981-9-8'; /* '1981-09-08'; */
/********************/
/* 36. 직업이 MANAGER 가 아닌 사람의 모든 정보를 출력하시오. */
select * from emp
where not job ='manager'; 
where job not in('manager');


/* 37. 입사일이 81년 4월 2일 이후에 입사한 사람의 모든 정보를 출력하시오. */
select * from emp
where hiredate >= '1981-4-2';

/*****************************/
SELECT * FROM EMP
WHERE CAST(hiredate AS DATE) >='1981-4-2';
/* CAST 다른 데이터 유형으로 변환 -> AS DATE 형식으로 바꿈 
원래 DB 만들 때 hiredate 데이터 타입 DATE 로 만들었는데 
연습 겸 써 본 거 */


/* 38. 급여가 800 이상인 사람의 이름, 급여, 부서번호를 출력하시오. */
select ename, sal, deptno from emp
where sal >=800;

/* 39. 부서번호가 20번 이상인 사원의 모든 정보를 출력하시오. */
select * from emp 
where deptno >=20;

/* 40. 이름이 K로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보를 출력하시오. */
select * from emp
where ename > 'K';

/* 41. 입사일이 1981년 12월 9일보다 먼저 입사한 사원의 모든 정보를 출력하시오. */
select * from emp
where cast(hiredate as date) <= '1981-12-9';

/* 42. 입사번호가 7698보다 작거나 같은 사원의 입사번호와 이름을 출력하시오. */
 select empno, ename from emp
 where empno <= 7698;
 
 
/* 43. 입사일이 1981년 4월 2일보다 늦고 1982년 12월 9일보다 빠른 사원의 이름, 월급, 부서번호
를 출력하시오. */
select ename, sal, deptno, hiredate from emp
where hiredate > '1981-4-2' and hiredate < '1982-12-9';

/*  44. 급여가 1600만원보다 크고 3000만원보다 작은 사람의 이름, 직업, 급여를 출력하시오. */
select ename, sal from emp
where sal > 1600 and sal < 3000;


/* 45. 사원번호가 7654와 7782 사이 이외의 사원의 모든 정보를 출력하시오. */
select * from emp
where 7654 < empno and empno < 7782; 


/****** NOT LIKE '1987%' ***/
/* 46. 입사일이 1981년 이외에 입사한 사람의 모든 정보를 출력하시오. */
select * from emp
where hiredate not LIKE '1981%';

/********EXTRACT (A FROM B) - (B에서 A추출) ****************/ 
SELECT *
FROM emp
WHERE EXTRACT(YEAR FROM hiredate) <> 1981;
/* EXTRACT 날짜나 시간 데이터형의 특정 구성 요소를 추출할 때 사용하는 함수 */ 


/* 47. 직업이 MANAGER와 SALESMAN인 사람의 모든 정보를 출력하시오. */
SELECT * FROM EMP 
WHERE JOB IN('MANAGER', 'SALESMAN');

/* 48. 부서번호가 20번 30번을 제외한 모든 사람의 이름, 사원번호,부서번호를 출력하시오. */
select ename, empno, deptno from emp
where deptno not in(20, 30);

/*  49. 이름이 S로 시작하는 사원의 사원번호, 이름, 입사일, 부서번호를 출력하시오. */
select empno, ename, hiredate, deptno from emp
where ename like 'S%';


/*  50. 입사일이 1981년도인 사원의 모든 정보를 출력하시오. */
select * from emp
where year(hiredate) = 1981;

select * from emp
where extract(year from hiredate) = 1981;


/* 51. 이름중 S가 들어가 있는 사람의 모든 정보를 출력하시오. */
select * from emp
where ename like '%s%';

/*  52. 이름이 J로 시작하고 마지막 글자가 S로 끝나는 사람의 모든 정보(단 이름은 전체 5글자이다
.)를 출력하시오. */
select * from emp
where ename like 'J___S';

select * from emp
where ename like 'J%S';


/* 53. 첫번째 문자는 관계없고, 두번째 문자가 A인 사람의 모든 정보를 출력하시오. */
select * from emp
where ename like '_A%';

/* 54. 커미션이 NULL인 사람의 모든 정보를 출력하시오.  */
select * from emp
where comm is null;

/* 55. 커미션이 NULL이 아닌 사람의 모든 정보를 출력하시오. */
select * from emp
where comm is not null;

/* 56. 부서가 30번 부서이고 급여가 1500만원이상인 사람의 이름,부서, 월급을 출력하시오. */
select ename, dname, sal from emp 
join dept on emp.deptno = dept.deptno
where sal >= 1500;

/* 57. 이름의 첫글자가 K로 시작하거나 부서번호가 30인 사람의 사원번호, 이름, 부서번호를 출력
하시오. */
select empno, ename, deptno from emp
where ename like 'K%' or deptno=30;

/* 58. 급여가 1500만원이상이고, 부서번호가 30번인 사원 중 직업이 MANAGER인 사람의 정보를
출력하시오. */
select * from emp
where sal > 1500 and deptno=30 and job='manager';


/*  59. 부서번호가 30인 사람 중 사원번호로 정렬하시오. */
select * from emp
where deptno = 30
order by empno;


/* 60. 급여가 많은 순으로 정렬하시오. */
select * from emp
order by sal desc;

/* 61. 부서번호로 오름차순 정렬한 후 급여가 많은 사람순으로 출력하시오. */
select ename, deptno, sal from emp
order by deptno, sal desc;

/* 62. 부서번호로 내림차순 정렬하고 이름순으로 오름차순으로 정렬하고 급여순으로 내림차순으로 
출력하시오. */
select * from emp
order by deptno desc, ename, sal desc;


/* 63. 이름이 B와 J 사이의 모든 사원의 정보출력하시오. */
select * from emp
where ename > 'B' and ename < 'J';