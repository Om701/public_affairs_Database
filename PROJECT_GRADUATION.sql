-- Table: Auth
CREATE TABLE Auth (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
);
-- Table: Building
CREATE TABLE Building (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    description TEXT
);

-- Table: Course
CREATE TABLE Course (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    code VARCHAR(60) NOT NULL UNIQUE,
    credit_hrs INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    year VARCHAR(20) NOT NULL,
    program VARCHAR(20) NOT NULL,
    has_section BIT,
    regulation_id INT NOT NULL,
    department_id INT NOT NULL,
	CONSTRAINT fk_course FOREIGN KEY (regulation_id) REFERENCES regulation (id)
);

-- Table: CourseUpdates
CREATE TABLE CourseUpdates (
    course_id INT NOT NULL,
    semester_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (course_id),
    CONSTRAINT fk_courseupdates_course FOREIGN KEY (course_id) REFERENCES Course (id)
);

-- Table: Department
CREATE TABLE Department (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    description TEXT
);

-- Table: DivisionDepartments
CREATE TABLE DivisionDepartments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    division VARCHAR(20) NOT NULL,
    students_count INT DEFAULT 0,
    language VARCHAR(20) DEFAULT 'ar',
    department_id INT NOT NULL,
    CONSTRAINT fk_divisiondepartments_department FOREIGN KEY (department_id) REFERENCES Department (id)
);

-- Table: InstructorRole
CREATE TABLE InstructorRole (
    name VARCHAR(30) PRIMARY KEY,
    description TEXT
);

-- Table: Instructor
CREATE TABLE Instructor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    mac_address VARCHAR(48) UNIQUE,
    date_of_birth DATETIME,
    work_years INT,
    department_id INT NOT NULL,
    instructor_role VARCHAR(30) NOT NULL,
    CONSTRAINT fk_instructor_department FOREIGN KEY (department_id) REFERENCES Department (id),
    CONSTRAINT fk_instructor_role FOREIGN KEY (instructor_role) REFERENCES InstructorRole (name)
);

-- Table: InstructorCourse
CREATE TABLE InstructorCourse (
    id INT IDENTITY(1,1) PRIMARY KEY,
    groups_num INT DEFAULT 1,
    instructor_id INT NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT fk_instructorcourse_instructor FOREIGN KEY (instructor_id) REFERENCES Instructor (id),
    CONSTRAINT fk_instructorcourse_course FOREIGN KEY (course_id) REFERENCES Course (id)
);

-- Table: Room
CREATE TABLE Room (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    qr_code VARCHAR(255) UNIQUE,
    real_capacity INT,
    supported_capacity INT,
    building_id INT,
    CONSTRAINT fk_room_building FOREIGN KEY (building_id) REFERENCES Building (id)
);

-- Table: Regulation
CREATE TABLE Regulation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    description TEXT
);

-- Table: Lecture
CREATE TABLE Lecture (
    id INT IDENTITY(1,1) PRIMARY KEY,
    section_num INT,
    language VARCHAR(20) NOT NULL,
    absent BIT,
    is_section BIT,
    dashboard_id INT NOT NULL,
    instructor_course_id INT NOT NULL,
    room_id INT NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    start_time VARCHAR(5) NOT NULL,
    CONSTRAINT fk_lecture_instructorcourse FOREIGN KEY (instructor_course_id) REFERENCES InstructorCourse (id),
    CONSTRAINT fk_lecture_room FOREIGN KEY (room_id) REFERENCES Room (id)
);

-- Table: InstructorTime
CREATE TABLE InstructorTime (
    id INT IDENTITY(1,1) PRIMARY KEY,
    start_time VARCHAR(5) NOT NULL,
    end_time VARCHAR(5) NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    instructor_id INT NOT NULL,
    CONSTRAINT fk_instructortime_instructor FOREIGN KEY (instructor_id) REFERENCES Instructor (id)
);
-- Alter the Course table to add a foreign key constraint on regulation_id
ALTER TABLE Course
ADD CONSTRAINT fk_course_regulation FOREIGN KEY (regulation_id) REFERENCES Regulation (id);

ALTER TABLE Course
ADD CONSTRAINT fk_course_department FOREIGN KEY (department_id) REFERENCES department (id);