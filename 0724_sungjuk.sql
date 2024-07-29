/*
JAVA 성적관리 프로그램 학생 테이블
https://github.com/12ka39/Java_Core/tree/main/0724%EC%84%B1%EC%A0%81%EA%B4%80%EB%A6%AC%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A82
*/


CREATE TABLE Student(
hakbun CHAR(4)   PRIMARY KEY,
name VARCHAR(20) NOT NULL, 
kor TINYINT      NOT NULL,
eng TINYINT      NOT NULL,
mat TINYINT      NOT NULL,
edp TINYINT      NOT NULL,
tot SMALLINT,
avg FLOAT(5,2),
grade CHAR(1)
);
