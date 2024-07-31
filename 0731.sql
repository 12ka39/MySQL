/* PDF 13장 PROCEDURE */
/* PROCEDURE는 자바의 method */

/* 
시스템 변수 @@
임시변수     @v 
바인딩 변수  @t
*/

/* STORED PROCEDURE - 리턴 없음 */
 
 /* OUT 파라미터 있는 PROCEDURE ----------*/ 
 /* OUT 변수는 SELECT    INTO 뒤에 쓰는 듯..*/
DELIMITER //
CREATE PROCEDURE test(
	OUT v_now DATETIME, /* 데이터 타입은 DB의 데이터 타입을 적어준다. */
    OUT v_version VARCHAR(30)
)
BEGIN
	SELECT NOW(), VERSION() INTO v_now, v_version;
    /* 실행되는 쿼리를 적어야 한다, 그리고 그 결과를 
    변수 v_now, v_version에 담는다 */
END
//
DELIMITER ;

CALL test(@t_now, @t_version); 
/* 이걸 자바에서 가져다 쓰자 */
/* 시스템 변수 @@    
   임시변수     @v    
   바인딩 변수 @t       */
select @t_now, @t_version;




/* 파라미터 없는 stored procedure  ----------*/ 
DELETE FROM dept_clone; /* 테이블의 데이터'만' 삭제. 구조 남아있음 */
DROP TABLE dept_clone;  /* 테이블 날아감 */


CREATE TABLE dept_clone
AS
SELECT * FROM dept;

/* 만약 업데이트가 안 되면 */
/* sql 에디터 (edit -> preferences -> sql 에디터 -> 맨 하단 safeUPDATES 체크 해제 후 DB 재접속 */


DELIMITER //
CREATE PROCEDURE deleteDept()
BEGIN
	DELETE FROM dept_clone;
END
//
DELIMITER ;

CALL deleteDept();





/* IN 파라미터 있는 stored procedure  ----------*/ 

DELIMITER $$
CREATE PROCEDURE insertDept(
	IN v_deptno TINYINT,
    IN v_name VARCHAR(14), 
	IN v_loc VARCHAR(13)
)
BEGIN
	INSERT INTO dept_clone(deptno, dname, loc)
	VALUES (v_deptno, v_name, v_loc);
    COMMIT;
END
$$
DELIMITER ;

CALL insertDept(60, 'Design', 'Seoul');
SELECT * FROM dept_clone;



/* IN  &  OUT  파라미터 있는 stored procedure ----------*/ 
/* 사원 번호를 입력받아서 부서 이름과 부서 위치를 출력하시오. */

/* 이 쿼리를 PROCEDURE에 알맞게 고친다.*/
SELECT dname, loc FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE empno = 7369;


DELIMITER $$
CREATE PROCEDURE selectEmp(
	IN v_empno SMALLINT,
    OUT v_dname VARCHAR(14),
    OUT v_loc VARCHAR(13)
)
BEGIN
	SELECT dname, loc INTO v_dname, v_loc
    FROM emp JOIN dept ON (emp.deptno = dept.deptno)
    WHERE empno = v_empno;
END
$$
DELIMITER ;

CALL selectEmp(7369, @t_dname, @t_loc);
SELECT @t_name, @t_loc;



/* INOUT  - DECLARE 변수 선언이 필요 - 파라미터 있는 stored procedure ----------*/ 
/* 부서 이름(값이 들어갔다가) -> 부서 위치(나오는 값)를 출력하는 INOUT  Stored Procedure*/

/* v_name 으로 값을 입력 받아 그 값을 v_str에 넣고, 
그 값을 다시 v_name에 담아서 내보낸다 */
 /* v_name 에 새 값을 입력하기 위해 임시변수 v_str 가 필요 */

drop PROCEDURE selectDname;

DELIMITER $$
CREATE PROCEDURE selectDname(
	INOUT v_name VARCHAR(14)
)
BEGIN
	DECLARE v_str VARCHAR(13); /* 임시변수 */
	SELECT loc INTO v_str
    FROM dept
    WHERE dname = v_name;  /* v_name 에 새 값을 입력하기 위해 임시변수 v_str 가 필요 */
    SET v_name = v_str;
END $$
DELIMITER ;


SET @t_str := 'RESEARCH';  /* 값 세팅 */
CALL selectDname(@t_str); /* 세팅한 채로 프로시저 실행 */
SELECT @t_str; /* 값 담아져서 나옴,,  값이 들어갔다가 나오는 거. inout*/

/**********************여러 개의 레코드가 나올 때 *********************************/
/* 부서번호로 소속사원의 사원번호, 사원명, 부서명, 부서위치 */
SELECT empno, ename, dname, loc, deptno
FROM emp NATURAL JOIN dept
WHERE deptno = 10;


/* 내츄럴 조인 - 두 테이블의 공통 컬럼 찾아냄 
내츄럴 조인 아니고 join만 쓰면 on 이 있어야 한다 */

DELIMITER $$
CREATE PROCEDURE select_emp_dept(
	IN v_deptno TINYINT
)
BEGIN
	SELECT empno, ename, dname, loc, deptno
	FROM emp NATURAL JOIN dept
    WHERE deptno = v_deptno;
END $$
DELIMITER ;

/* DROP PROCEDURE select_emp_dept; */

CALL select_emp_dept(20);



/*  모든 환자. select * from patient 환자프로그램 - 모든 환자 가져오는 procedure  */
/* 번호, 진찰부서, 진찰비, 입원비, 진료비 */

Delimiter $$
CREATE PROCEDURE select_all_patient()
BEGIN
	SELECT number, dept, operfee, hospitalfee, money
    FROM patient 
    ORDER BY number DESC;
END
$$
Delimiter ;




/* 환자 한 명 가져오는 프로시저 */
Delimiter $$
CREATE PROCEDURE select_one_patient(IN v_number TINYINT)
BEGIN
	SELECT *
    FROM patient 
    WHERE number = v_number;
END $$
Delimiter ;

CALL select_one_patient(7);




Delimiter $$
CREATE PROCEDURE update_patient
(
	IN    v_number     TINYINT,
    IN    v_code        CHAR(2),
    IN    v_days         SMALLINT,
    IN    v_age          TiNYINT,
    IN    v_dept         VARCHAR(20),
    IN    v_operfee      INT,
    IN    v_hospitalfee   INT,
    IN    v_money      INT
)
BEGIN
	UPDATE Patient
    SET code = v_code, days = v_days,  age = v_age, 
           dept = v_dept, operfee = v_operfee, 
           hospitalfee = v_hospitalfee, money = v_money
    WHERE number = v_number;
    COMMIT;
END $$
Delimiter ;

