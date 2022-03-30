
#Контрольная работа (29.03)
create table people.Task
(
    id          int primary key auto_increment primary key,
    nameTask    char(255),
    timeTask    time,
    costTask    int,
    executor_Id int,
    project_id  int,
    FOREIGN KEY (executor_Id) REFERENCES Executor (id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project (id) ON DELETE CASCADE
);

create table people.Project
(
    id               int primary key auto_increment primary key,
    nameProject      char(255),
    timeProject      time,
    diffucityProject char(10),
    executor_id      int,
    FOREIGN KEY (executor_id) REFERENCES Executor (id) ON DELETE CASCADE
);

create table people.Executor
(
    id       int primary key auto_increment primary key,
    name     char(255),
    surname  char(255),
    lastname char(255)
);

insert into people.Executor (name, surname, lastname)
values ('Петя', 'Петров', 'Сергеевич'),
       ('Сергей', 'Смирнов', 'Сергеевич'),
       ('Сергей', 'Фёдоров', 'Юрьевич');

SELECT *
FROM people.executor;

insert into people.Project (nameProject, timeProject, diffucityProject, executor_id)
VALUES ('Проект 1', 2, 'Сложный', 2),
       ('Проект 2', 1, 'Лёгкий', 3);

insert into people.Task (nameTask, timeTask, costTask, executor_Id, project_id)
VALUES ('Задача 1', '04:00:00', 2000, 1, 1),
       ('Задача 2', '08:00:00', 2500, 2, 1),
       ('Задача 3', '04:00:00', 1000, 2, 1),
       ('Задача 4', '05:00:00', 3000, 3, 2),
       ('Задача 5', '03:00:00', 500, 1, 2);

#Выводим на экран все задачи у проектов со сложностью "Сложный"
SELECT people.Task.nameTask, people.Project.nameProject, people.Project.diffucityProject
FROM people.Task
         JOIN people.Project ON people.project.id = people.Task.project_id
WHERE people.Project.diffucityProject = 'Сложный';

#Выводим цену каждого проекта (сумма цен всех задач проекта)
SELECT people.Project.nameProject, SUM(costTask) AS SumProject
from people.task
         JOIN people.Project ON people.project.id = people.Task.project_id
group by project_id;

#Выводим на экран проекты ценой больше 4000
SELECT people.Project.nameProject, SUM(costTask) AS SumProject
from people.task
         JOIN people.Project ON people.project.id = people.Task.project_id
group by project_id
having SumProject > 4000;

#Меняем название проекта
UPDATE people.Project
set nameProject = 'Проект 25'
where nameProject = 'Проект 1';
SELECT *
FROM people.project;



