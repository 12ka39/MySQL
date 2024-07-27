/* insert */

use mycompany;
select * from dept;

/* 이렇게 해도 되지만 다른 사람이 보면 가독성이 안 좋음 */
insert into dept values (50, 'Design', 'Seoul');

/* 컬럼명을 적어주면 해당 컬럼에 맞는 값만 잘 적어주면 순서는 상관 없음 */
insert into dept(dname, loc, deptno)
values ('Development', 'Daejun', 60);

/* 명시적으로 NULL 을 쓸 때 */
insert into dept(deptno, dname, loc) 
values(70, null, 'Incheon');


/* 암시적 NULL */
insert into dept(deptno, loc) values(80, 'Busan');



/* 제약조건 - 부서명(PK)는 입력 필수 사항이라 아래 sql문은 오류다 */
insert into dept(dname, loc) values ('Account', 'Yongin');

/* 제약 조건에 위배 - 부모 테이블에 없는 값이라 오류 ????? */
insert into emp(empno, deptno)
values(9999, 90);



/* 데이터 불일치. hiredate는 날짜만 나오고, now()는 연원일 시분초라. 타입이 안 맞음. ==> cu */
insert into emp(empno, ename, hiredate, deptno) 
values(9999, 'Jimin', CURDATE(), 80); /* 이거 왜 오류남 >>>*/
--values(9999, 'Jimin', NOW(), 80);


/* copy 하면 제약조건 다 날아간다 */
create table emp_copy
as
select empno, ename, sal, hiredate
from emp 
where deptno = 10;

/* 스키마만 복사하고 데이터는 복사하지 않는 방법 */
create table emp_copy1
as
select *
from emp 
where 0 = 1; /* 이런 조건을 충족하는 데이터는 없으니까 
데이터는 제외하고, 구조만 복사된다. */


select * from emp_copy1; /* 스키마만 복사한 테이블 */
/* 복사한 테이블에 데이터 추가 (한글이 되는지 확인하자) */
insert into emp_copy1(empno, ename) values (1122, "한지민");


/* update 와 delete는 반드사 where이 있어야 한다. 안 그러면 전체 적용됨. */

/* update    set   */
select * from dept;

update dept 
set dname='finance'
where deptno=70; 

/* 여러 개를 한꺼번에 바꿀 때 */
update dept 
set dname='HR', loc='Busan'
where deptno=70; 
