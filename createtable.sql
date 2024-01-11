-- Student table
CREATE TABLE student(
    sid INTEGER  NOT NULL,
    sname VARCHAR(50) NOT NULL ,
    sex VARCHAR(10) NOT NULL,
    age INTEGER NOT NULL,
    year INTEGER NOT NULL,
    gpa NUMERIC(3,2) NOT NULL,
    PRIMARY KEY(sid)
);

-- Dept table 
CREATE TABLE dept(
    dname VARCHAR(50) NOT NULL,
    numphds INTEGER,
    PRIMARY KEY(dname)
);

-- Prof table
CREATE TABLE prof(
    pname VARCHAR(50) NOT NULL,
    dname VARCHAR(50) NOT NULL,
    PRIMARY KEY(pname)
);

-- course table
CREATE TABLE course(
    cno INTEGER NOT NULL,
    dname VARCHAR(50) NOT NULL,
    cname VARCHAR(50) NOT NULL,
    PRIMARY KEY(cno , dname),
    FOREIGN KEY(dname) REFERENCES dept(dname)
);

--Major table
CREATE TABLE major(
    dname VARCHAR(50) NOT NULL,
    sid INTEGER NOT NULL,
    PRIMARY KEY (dname, sid),
    FOREIGN KEY (dname) REFERENCES dept(dname),
    FOREIGN KEY (sid) REFERENCES student(sid)
);

--section table
CREATE TABLE section(
    dname VARCHAR(50) NOT NULL,
    cno INTEGER NOT NULL,
    sectno INTEGER NOT NULL,
    pname VARCHAR(50) NOT NULL,
    FOREIGN KEY(dname) REFERENCES dept(dname),
    FOREIGN KEY(cno, dname) REFERENCES course,
    PRIMARY KEY (dname, cno, sectno)
);

--enroll table
CREATE TABLE enroll (
    sid INTEGER NOT NULL,
    grade NUMERIC NOT NULL,
    dname VARCHAR(50) NOT NULL,
    cno INTEGER NOT NULL,
    sectno INTEGER NOT NULL,
    PRIMARY KEY (sid, dname, cno, sectno),
    FOREIGN KEY (sid) REFERENCES student(sid),
    FOREIGN KEY(dname) REFERENCES dept(dname),
    FOREIGN KEY(cno , dname) REFERENCES course,
    FOREIGN KEY (dname, cno , sectno) REFERENCES section
);

