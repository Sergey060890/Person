#Практическое задание (22.03)
CREATE TABLE people.person
(
    Id             INT AUTO_INCREMENT,
    Age            INT,
    Salary         FLOAT,
    Passport       CHAR(10),
    Address        VARCHAR(200),
    DateOfBirthday DATE,
    DateTimeCreate DATETIME,
    TimeToLounch   TIME,
    Letter         MEDIUMTEXT,
    PRIMARY KEY (Id)
);

INSERT people.person(Age, Salary, Passport, Address, DateOfBirthday, DateTimeCreate, TimeToLounch, Letter)
VALUES (23, 1550.5, 'MP21924A02', 'Minsk, Rafieva-80', '2002-02-04', '2022-02-14 09:15:44', '13:00:00',
        'Hi, My Name is Sergey'),
       (23, 1320.2, 'MP31944A01', 'Mocsow, Lenina -10', '1999-01-31', '2021-03-24 17:15:44', '13:30:00',
        'Hi, My Name is Viktoria'),
       (31, 1105.3, 'MP10984A01', 'Madrid, La Espina -15', '1990-08-06', '2020-12-20 16:15:44', '14:00:00',
        'Hi, My Name is Egor'),
       (26, 2504.7, 'MP41976A01', 'Paris, Rivoli -20', '1996-01-13', '2021-11-17 12:15:44', '13:15:00',
        'Hi, My Name is Pavel'),
       (19, 1700.2, 'MP56924B02', 'Tokio, Tokashi -11', '2003-05-04', '2021-06-25 11:15:44', '14:10:00',
        'Hi, My Name is Yulia');

SELECT *
FROM people.person; #выводим всю таблицу

SELECT *
FROM people.person
WHERE person.Age > 21
ORDER BY people.person.DateTimeCreate;
#выбираем из таблицы тех у кого age >21
#и сразу же сортируем по полю dateTimeCteate

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



#Практическое задание (24.03)
#1.Основы
create table people.users
(
    id   integer auto_increment primary key,
    name varchar(30),
    age  integer
);
#создание таблицы с помощью консоли

insert into people.users (name, age)
values ('Sergey', 31);
#добавляем строку в таблицу

rename table people.users to people.clients;
#переименуем таблицу

TRUNCATE TABLE people.clients;
#удаление всех данных в таблице

DROP TABLE people.clients;
#удаление таблицы

#2.Атрибуты

CREATE TABLE people.customers
(
    Id        INT AUTO_INCREMENT,
    Age       INT UNIQUE,
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NULL,
    City      VARCHAR(20) DEFAULT 'Minsk',
    PRIMARY KEY (Id)
);
#Первичный ключ уникально идентифицирует строку в таблице.
#В качестве первичного ключа необязательно должны выступать столбцы с типом int, они могут представлять любой другой тип.
#Установка первичного ключа на уровне таблицы

CREATE TABLE people.orderlines
(
    OrderId   INT,
    ProductId INT,
    Quantity  INT,
    Price     INT,
    PRIMARY KEY (OrderId, ProductId)
);
#Первичный ключ может быть составным. Такой ключ использовать сразу несколько столбцов, чтобы уникально идентифицировать строку в таблице.
#Здесь поля OrderId и ProductId вместе выступают как составной первичный ключ. То есть в таблице OrderLines не может быть двух строк,
#где для обоих из этих полей одновременно были бы одни и те же значения.

#AUTO_INCREMENT
#Атрибут AUTO_INCREMENT позволяет указать, что значение столбца будет автоматически увеличиваться при добавлении новой строки.
# Данный атрибут работает для столбцов, которые представляют целочисленный тип или числа с плавающей точкой.

#UNIQUE
#Атрибут UNIQUE указывает, что столбец может хранить только уникальные значения.

#NULL и NOT NULL
#Чтобы указать, может ли столбец принимать значение NULL, при определении столбца ему можно задать атрибут NULL или NOT NULL.
#Если этот атрибут явным образом не будет использован, то по умолчанию столбец будет допускать значение NULL.
#Исключением является тот случай, когда столбец выступает в роли первичного ключа - в этом случае по умолчанию столбец имеет значение NOT NULL.

#DEFAULT
#Атрибут DEFAULT определяет значение по умолчанию для столбца.
# Если при добавлении данных для столбца не будет предусмотрено значение, то для него будет использоваться значение по умолчанию.

#CHECK
#Атрибут CHECK задает ограничение для диапазона значений, которые могут храниться в столбце. Для этого после CHECK указывается в скобках условие, которому должен соответствовать столбец или несколько столбцов.
#Например, возраст клиентов не может быть меньше 0 или больше 100:
CREATE TABLE Customers
(
    Id        INT AUTO_INCREMENT,
    Age       INT DEFAULT 18 CHECK (Age > 0 AND Age < 100),
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NOT NULL,
    Email     VARCHAR(30) CHECK (Email != ''),
    Phone     VARCHAR(20) CHECK (Phone != '')
);
#Для соединения условий используется ключевое слово AND. Условия можно задать в виде операций сравнения больше (>), меньше (<), не равно (!=).
#CHECK((Age >0 AND Age<100) AND (Email !='') AND (Phone !=''))

#Оператор CONSTRAINT. Установка имени ограничений
#С помощью ключевого слова CONSTRAINT можно задать имя для ограничений. Они указываются после ключевого слова CONSTRAINT перед атрибутами на уровне таблицы:
CREATE TABLE Customers
(
    Id        INT AUTO_INCREMENT,
    Age       INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NOT NULL,
    Email     VARCHAR(30),
    Phone     VARCHAR(20) NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (Id),
    CONSTRAINT customer_phone_uq UNIQUE (Phone),
    CONSTRAINT customer_age_chk CHECK (Age > 0 AND Age < 100)
);
#Смысл установки имен ограничений заключается в том,
#что впоследствии через эти имена мы сможем управлять ограничениями - удалять или изменять их.

#3.Внешние ключи (FOREIGN KEY)

CREATE TABLE mypractice.Customers
(
    Id        INT PRIMARY KEY AUTO_INCREMENT,
    Age       INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NOT NULL,
    Phone     VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE mypractice.Orders
(
    Id         INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt  Date,
    CONSTRAINT orders_custonmers_fk
        FOREIGN KEY (CustomerId) REFERENCES mypractice.Customers (Id)
);

SELECT *
FROM mypractice.Customers;
#Внешние ключи позволяют установить связи между таблицами. Внешний ключ устанавливается для столбцов из зависимой,
#подчиненной таблицы, и указывает на один из столбцов из главной таблицы.
#Как правило, внешний ключ указывает на первичный ключ из связанной главной таблицы.

#В данном случае определены таблицы Customers и Orders.
#Customers является главной и представляет клиента. Orders является зависимой и представляет заказ, сделанный клиентом.
#Таблица Orders через столбец CustomerId связана с таблицей Customers и ее столбцом Id.
#То есть столбец CustomerId является внешним ключом, который указывает на столбец Id из таблицы Customers.
#С помощью оператора CONSTRAINT можно задать имя для ограничения внешнего ключа.

#ON DELETE и ON UPDATE
#С помощью выражений ON DELETE и ON UPDATE можно установить действия, которые выполняются соответственно при удалении и изменении связанной строки из главной таблицы.
# В качестве действия могут использоваться следующие опции:

#CASCADE: автоматически удаляет или изменяет строки из зависимой таблицы при удалении или изменении связанных строк в главной таблице.
#SET NULL: при удалении или обновлении связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение NULL.
#(В этом случае столбец внешнего ключа должен поддерживать установку NULL)
#RESTRICT: отклоняет удаление или изменение строк в главной таблице при наличии связанных строк в зависимой таблице.
#NO ACTION: то же самое, что и RESTRICT.
#SET DEFAULT: при удалении связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение по умолчанию, которое задается с помощью атрибуты DEFAULT.
#Несмотря на то, что данная опция в принципе доступна, однако движок InnoDB не поддерживает данное выражение.

#Каскадное удаление
#Каскадное удаление позволяет при удалении строки из главной таблицы автоматически удалить все связанные строки из зависимой таблицы.
#Для этого применяется опция CASCADE:
CREATE TABLE Orders
(
    Id         INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt  Date,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
);

#Установка NULL
#При установки для внешнего ключа опции SET NULL необходимо, чтобы столбец внешнего ключа допускал значение NULL:
CREATE TABLE Orders
(
    Id         INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt  Date,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE SET NULL
);

#4.Изменение таблиц и столбцов

#Если таблица уже была ранее создана, и ее необходимо изменить, то для этого применяется команда ALTER TABLE.

#Ее сокращенный формальный синтаксис:
#ALTER TABLE название_таблицы
#{ADD название_столбца тип_данных_столбца [атрибуты_столбца] |
#DROP COLUMN название_столбца |
#MODIFY COLUMN название_столбца тип_данных_столбца [атрибуты_столбца] |
#ALTER COLUMN название_столбца SET DEFAULT значение_по_умолчанию |
# ADD [CONSTRAINT] определение_ограничения |
#DROP [CONSTRAINT] имя_ограничения}

#Добавление нового столбца
ALTER TABLE mypractice.orders
    ADD Price int NOT NULL;

ALTER TABLE mypractice.orders
    ADD ProductName VARCHAR(200) NOT NULL;

#Удаление столбца
ALTER TABLE mypractice.orders
    DROP COLUMN Price;

#Изменение значения по умолчанию
#Установим в таблице Customers для столбца Age значение по умолчанию 22:
ALTER TABLE mypractice.orders
    ALTER COLUMN Price SET DEFAULT 300;

#Изменение типа столбца
#Изменим в таблице Customers тип данных у столбца FirstName на CHAR(100) и установим для него атрибут NULL:
ALTER TABLE mypractice.orders
    MODIFY COLUMN Price CHAR(100) NULL;

#Добавление и удаление внешнего ключа
#Пусть изначально в базе данных будут добавлены две таблицы, никак не связанные:
CREATE TABLE Customers
(
    Id        INT PRIMARY KEY AUTO_INCREMENT,
    Age       INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NOT NULL
);
CREATE TABLE Orders
(
    Id         INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt  Date
);

#Добавим ограничение внешнего ключа к столбцу CustomerId таблицы Orders:
ALTER TABLE Orders
    ADD FOREIGN KEY (CustomerId) REFERENCES Customers (Id);

#При добавлении ограничений мы можем указать для них имя, используя оператор CONSTRAINT, после которого указывается имя ограничения:
ALTER TABLE Orders
    ADD CONSTRAINT orders_customers_fk
        FOREIGN KEY (CustomerId) REFERENCES Customers (Id);

#В данном случае ограничение внешнего ключа называется orders_customers_fk.

#Затем по этому имени мы можем удалить ограничение:
ALTER TABLE Orders
    DROP FOREIGN KEY orders_customers_fk;

#Добавление и удаление первичного ключа
#Добавим в таблицу Products первичный ключ:
CREATE TABLE Products
(
    Id    INT,
    Model VARCHAR(20)
);

ALTER TABLE Products
    ADD PRIMARY KEY (Id);

#Удалим первичный ключ:
ALTER TABLE Products
    DROP PRIMARY KEY;

#5 Добавление. Команда Insert
#Для добавления данных в БД в MySQL используется команда INSERT, которая имеет следующий формальный синтаксис:
#INSERT [INTO] имя_таблицы [(список_столбцов)] VALUES (значение1, значение2, ... значениеN)

#Добавление строки
INSERT mypractice.orders (CustomerId, CreatedAt, Price)
VALUES (3, '2022-03-10', 400);

#Необязательно при добавлении данных указывать значения абсолютно для всех столбцов таблицы.
#Например, в примере выше не указано значение для стобца Id. Но поскольку для данного столбца определен атрибут AUTO_INCREMENT, то его значение будет автоматически генерироваться.

#Также мы можем опускать при добавлении такие столбцы, которые поддерживают значение NULL или для которых указано значение по умолчанию,
#то есть для них определены атрибуты NULL или DEFAULT.
#Так, в таблице Products столбец ProductCount имеет значение по умолчанию - число 0.
#Поэтому мы можем при добавлении опустить этот столбец, и ему будет передаваться число 0.

#С помощью ключевых слов DEFAULT и NULL можно указать, что в качестве значения будет использовать значение по умолчанию или NULL соответственно:
#INSERT Products(ProductName, Manufacturer, Price, ProductCount)
#VALUES ('Nokia 9', 'HDM Global', 41000, DEFAULT);

#INSERT Products(ProductName, Manufacturer, Price, ProductCount)
#или
#VALUES ('Nokia 9', 'HDM Global', 41000, NULL);

#Множественное добавление
INSERT mypractice.orders (CustomerId, CreatedAt, Price)
VALUES (4, '2022-03-10', 410),
       (5, '2021-04-21', 420),
       (6, '2022-03-10', 430);

#Выборка данных. Команда SELECT
#Для выборки данных из БД в MySQL применяется команда SELECT. В упрощенном виде она имеет следующий синтаксис:
#SELECT список_столбцов FROM имя_таблицы

#Получение всех обьектов таблицы
SELECT *
FROM mypractice.orders;

#Если необходимо получить данные не из всех, а из каких-то конкретных столбцов,
# тогда спецификации этих столбцов перечисляются через запятую после SELECT:

SELECT CreatedAt, Price
FROM mypractice.orders;

ALTER TABLE mypractice.orders
    ADD ProductCount int NOT NULL;

#Спецификация столбца необязательно должна представлять его название.
#Это может быть любое выражение, например, результат арифметической операции. Так, выполним следующий запрос:
SELECT CustomerId, Price * ProductCount
FROM mypractice.orders;
#Здесь при выборке будут создаваться два столбца. Причем второй столбец представляет значение столбца Price,
# умноженное на значение столбца ProductCount, то есть совокупную стоимость товара.

#Оператор AS можнет изменить название выходного столбца или определить его псевдоним:
SELECT CustomerId AS Title, Price * ProductCount AS TotalSum
FROM mypractice.orders;
#Здесь для первого столбца определяется псевдоним Title, хотя в реальности он будет представлять столбец CustomerId.
# Второй столбец TotalSum хранит произведение столбцов ProductCount и Price.

#Фильтрация данных. Оператор WHERE

#Зачастую необходимо извлекать не все данные из БД, а только те, которые соответствуют определенному условию.
#Для фильтрации данных в команде SELECT применяется оператор WHERE, после которого указывается условие:
#Если условие истинно, то строка попадает в результирующую выборку. В качестве можно использовать операции сравнения, которые сравнивают два выражения:

#=: сравнение на равенство

#!=: сравнение на неравенство

#<>: сравнение на неравенство

#<: меньше чем

#>: больше чем

#<=: меньше чем или равно

#>=: больше чем или равно

SELECT *
FROM mypractice.orders
WHERE ProductCount = 2;
#Отфильтровали данные по полю ProductCount у которых значение = 2.

#Другой пример - найдем все товары, количество которых меньше 3:
SELECT *
FROM mypractice.orders
WHERE ProductCount < 4;

#Критерий фильтрации может представлять и более сложное составное выражение.
# Например, найдем все товары, у которых совокупная стоимость больше 1000:

SELECT *
FROM mypractice.orders
WHERE Price * ProductCount > 1000;

#Логические операторы

#Логические операторы позволяют объединить несколько условий. В MySQL можно использовать следующие логические операторы:
#AND: операция логического И. Она объединяет два выражения:
#OR: операция логического ИЛИ. Она также объединяет два выражения:
#NOT: операция логического отрицания. Если выражение в этой операции ложно, то общее условие истинно.

SELECT *
FROM mypractice.orders
WHERE Price > 200
  AND ProductCount > 5;
#выбрали по двум критериям

SELECT *
FROM mypractice.orders
WHERE Price > 300
   OR ProductCount > 3;
#по одному из двух критериев

SELECT *
FROM mypractice.orders
WHERE NOT ProductCount > 3;
#всё что не равно критерию выведет, можно использовать ">=" и т.п

#Приоритет операций
#В одном условии при необходимости мы можем объединять несколько логических операций.
# Однако следует учитывать, что самой приоритетной операцией, которая выполняется в первую очередь,
# является NOT, менее приоритетная - AND и операция с наименьшим приоритетом - OR. Например:

SELECT *
FROM mypractice.orders
WHERE ProductName = 'Twix'
   OR NOT Price > 300 AND ProductCount > 2;

#В данном случае сначала вычисляется выражение NOT Price > 300, то есть цена должна быть меньше или равна 300.
#Затем вычисляется выражение NOT Price > 300 AND ProductCount > 2, то есть цена должна быть меньше или равна 300 и одновременно количество товаров должно быть больше 2.
#В конце вычисляется оператор OR - либо цена должна быть меньше или равна 30000 и одновременно количество товаров должно быть больше 2, либо производителем должен быть Twix.
#В данном случаем дойдёт до последнего оператора OR  и выберет производителя Twix

#С помощью скобок можно переопределить приоритет операций:
SELECT *
FROM mypractice.orders
WHERE ProductName = 'Twix'
   OR NOT (Price > 300 AND ProductCount > 2);

#В данном случае находим товары, у которых либо производитель Twix, либо одновременно цена товара меньше или равна 300 и количество товаров меньше 3.

#Обновление данных. Команда UPDATE
#Команда UPDATE применяется для обновления уже имеющихся строк. Она имеет следующий формальный синтаксис:
#UPDATE имя_таблицы
#SET столбец1 = значение1, столбец2 = значение2, ... столбецN = значениеN
#[WHERE условие_обновления]
#Например, увеличим у всех товаров цену на 50:
UPDATE mypractice.orders
SET Price = Price + 50;

#Можем менять название, к примеру, производителя
UPDATE mypractice.orders
SET ProductName = 'Pringles'
WHERE ProductName = 'Lays';
#в начале указывается на что меняем (Set)

#Можно менять сразу несколько столбцов
UPDATE mypractice.orders
SET Price       = Price + 10,
    ProductName = 'Onega'
WHERE ProductName = 'Pringles';

#При обновлении вместо конкретных значений и выражений мы можем использовать ключевые слова DEFAULT и NULL
#для установки соответственно значения по умолчанию или NULL:
UPDATE mypractice.orders
SET ProductName = DEFAULT
WHERE mypractice.Orders.ProductName = 'Huawei';
#если оно установлено!!!

#Удаение данных. Команда DELETE
#Команда DELETE удаляет данные из БД. Она имеет следующий формальный синтаксис:
#DELETE FROM имя_таблицы
#[WHERE условие_удаления]

#Например, удалим строки, у которых производитель - Pepsi:
DELETE
FROM mypractice.orders
WHERE ProductName = 'Pepsi';

#Или удалим все товары, производителем которых является Snickers и которые имеют цену меньше 320:
DELETE
FROM mypractice.orders
WHERE ProductName = 'Snickers'
  AND Price < 320;

#Если необходимо удалить все строки
DELETE
FROM mypractice.orders;

#6.Запросы
#Выборка уникальных значений. Оператор DISTINCT
#С помощью оператора DISTINCT можно выбрать уникальные данные по определенным столбцам.
#Если мы просто выберем все продукты, то они повторятся
SELECT ProductName
FROM mypractice.orders;

#Теперь применим оператор DISTINCT для выборки уникальных значений:
SELECT DISTINCT ProductName
FROM mypractice.orders;

#по нескольким столбцам
SELECT DISTINCT ProductName, Price
FROM mypractice.orders;

#Оператор фильтрации
#Оператор IN
#Оператор IN определяет набор значений, которые должны иметь столбцы
#Например, выберем товары, у которых имя либо Coca-Cola, либо MArs:
SELECT *
FROM mypractice.orders
WHERE ProductName IN ('Coca-Cola', 'Mars');

#Оператор NOT
#Оператор NOT, наоборот, позволяет выбрать все строки, столбцы которых не имеют определенных значений:
SELECT *
FROM mypractice.orders
WHERE ProductName NOT IN ('Coca-Cola', 'Mars');

#Оператор BETWEEN
#Оператор BETWEEN определяет диапазон значений с помощью начального и конечного значения, которому должно соответствовать выражение:
#Например, получим все товары, у которых цена от 410 до 480 (начальное и конечное значения также включаются в диапазон):

SELECT *
FROM mypractice.orders
WHERE Price BETWEEN 410 AND 480;

#NOT
SELECT *
FROM mypractice.orders
WHERE Price NOT BETWEEN 410 AND 480;
#выбрать те строки, которые не попадают в данный диапазон

#Можно использовать более сложные выражения
SELECT *
FROM mypractice.orders
WHERE Price * ProductCount BETWEEN 1300 AND 1500;

#Операторы LIKE и REGEXP
#LIKE
#Оператор LIKE принимает шаблон строки, которому должно соответствовать выражение.
#Для определения шаблона могут применяться ряд специальных символов подстановки:

#%: соответствует любой подстроке, которая может иметь любое количество символов, при этом подстрока может и не содержать ни одного символа
#Например, выражение WHERE ProductName LIKE 'Galaxy%' соответствует таким значениям как "Galaxy Ace 2" или "Galaxy S7"

#_: соответствует любому одиночному символу
#Например, выражение WHERE ProductName LIKE 'Galaxy S_' соответствует таким значениям как "Galaxy S7" или "Galaxy S8".

SELECT *
FROM mypractice.orders
WHERE ProductName LIKE 'Coca_Cola%';

SELECT *
FROM mypractice.orders
WHERE ProductName LIKE 'Galaxy S_';
#ProductName LIKE 'Galaxy S_' соответствует таким значениям как "Galaxy S7" или "Galaxy S8".

#REGEXP
#REGEXP позволяет задать регулярное выражение, которому должно соответствовать значение столбца.
#В этом плане REGEXP представляет более изощренный и комплексный способ фильтрации, нежели оператор LIKE.

#Регулярное выражение может принимать следующие специальные символы:

#^: указывает на начало строки

#$: указывает на конец строки

#.: соответствует любому одиночному символу

#[символы]: соответствует любому одиночному символу из скобок

#[начальный_символ-конечный_символ]: соответствует любому одиночному символу из диапазона символов

#|: отделяет два шаблона строки, и значение должно соответствовать одну из этих шаблонов

#Примеры REGEXP:

#WHERE ProductName REGEXP 'Phone': строка должна содержать "Phone", например, iPhone X, Nokia Phone N, iPhone

#WHERE ProductName REGEXP '^Phone': строка должна начинаться с "Phone", например, Phone 34, PhoneX

#WHERE ProductName REGEXP 'Phone$': строка должна заканчиваться на "Phone", например, iPhone, Nokia Phone

#WHERE ProductName REGEXP 'iPhone [78]';: строка должна содержать либо iPhone 7, либо iPhone 8

#WHERE ProductName REGEXP 'iPhone [6-8]';: строка должна содержать либо iPhone 6, либо iPhone 7, либо iPhone 8
#Например, найдем товары, названия которых содержат либо "Coca-Cola", либо "Twix":
SELECT *
FROM mypractice.orders
WHERE ProductName REGEXP 'Coca-Cola|Twix';

#IS NULL
#Оператор IS NULL позволяет выбрать все строки, столбцы которых имеют значение NULL:
SELECT *
FROM mypractice.orders
WHERE ProductName IS NULL;

#NOT
#С помощью добавления оператора NOT можно, наоброт, выбрать строки, столбцы которых не имеют значения NULL:
SELECT *
FROM mypractice.orders
WHERE ProductName IS NOT NULL;

#Сортировка. ORDER BY
#Оператор ORDER BY сортируют значения по одному или нескольких столбцам. Например, упорядочим выборку из таблицы orders по столбцу Price:
SELECT *
FROM mypractice.orders
ORDER BY Price;
#можно использовать DESC (от большего к меньшему) или ASK (от меньшего к большему)

#Также можно производить упорядочивание данных по псевдониму столбца, который определяется с помощью оператора AS:
SELECT ProductName, ProductCount * Price AS TotalSum
FROM mypractice.orders
ORDER BY TotalSum;
##можно использовать DESC (от большего к меньшему) или ASK (от меньшего к большему)

#В качестве критерия сортировки также можно использовать сложно выражение на основе столбцов:
SELECT ProductName, Price, ProductCount
FROM mypractice.orders
ORDER BY ProductCount * Price;

#Сортировка по нескольким столбцам
#При сортировке сразу по нескольким столбцам все эти столбцы указываются через запятую после оператора ORDER BY
SELECT ProductName, ProductCount, Price
FROM mypractice.orders
ORDER BY Price ASC, ProductCount DESC;

#Получение диапазона строк. Оператор LIMIT
#Оператор LIMIT позволяет извлечь определенное количество строк и имеет следующий синтаксис:
#LIMIT [offset,] rowcount
#Если оператору LIMIT передается один параметр, то он указывает на количество извлекаемых строка. Если передается два параметра, то первый параметр устанавливает смещение относительно начала, то есть сколько строк нужно пропустить, а второй параметр также указывает на количество извлекаемых строк.

#Например, выберем первые три строки:
SELECT *
FROM mypractice.orders
LIMIT 3;

#Теперь используем второй параметр и укажем смещение, с которой должна происходить выборка:
SELECT *
FROM mypractice.orders
LIMIT 3,2;
#пропускам 3 и выводим следующие 2

#Как правило, оператор LIMIT используетс вместе с оператором ORBER BY:
SELECT *
FROM mypractice.orders
ORDER BY Price
LIMIT 2,3;

#Агрегатные функции
#Агрегатные функции вычисляют некоторые скалярные значения в наборе строк. В MySQL есть следующие агрегатные функции:

#AVG: вычисляет среднее значение

#SUM: вычисляет сумму значений

#MIN: вычисляет наименьшее значение

#MAX: вычисляет наибольшее значение

#COUNT: вычисляет количество строк в запросе

#Все агрегатные функции принимают в качестве параметра выражение, которое представляет критерий для определения значений. Зачастую, в качестве выражения выступает название столбца, над значениями которого надо проводить вычисления.
#Выражения в функциях AVG и SUM должно представлять числовое значение (например, столбец, который хранит числовые значения). Выражение в функциях MIN, MAX и COUNT может представлять числовое или строковое значение или дату.

#Все агрегатные функции за исключением COUNT(*) игнорируют значения NULL.

#AVG
SELECT AVG(Price) AS Average_Price
FROM mypractice.orders;
#средняя цена товаров

#На этапе выборки можно применять фильтрацию. Например, найдем среднюю цену для товаров определенного производителя:
SELECT AVG(Price)
FROM mypractice.orders
WHERE ProductName = 'Twix';

#Также можно находить среднее значение для более сложных выражений. Например, найдем среднюю сумму всех товаров, учитывая их количество:
SELECT AVG(Price * ProductCount)
FROM mypractice.orders;

#Count
#Функция Count вычисляет количество строк в выборке. Есть две формы этой функции.
#Первая форма COUNT(*) подсчитывает число строк в выборке:

SELECT COUNT(*)
FROM mypractice.orders;

#Вторая форма функции вычисляет количество строк по определенному столбцу, при этом строки со значениями NULL игнорируются:
SELECT COUNT(ProductName)
FROM mypractice.orders;

#Min Max
#Функции Min и Max вычисляют минимальное и максимальное значение по столбцу соответственно.
#Например, найдем минимальную цену среди товаров:
SELECT MIN(Price), MAX(Price)
FROM mypractice.orders;

#Данные функции также игнорируют значения NULL и не учитывают их при подсчете.

#SUM
#Функция Sum вычисляет сумму значений столбца. Например, подсчитаем общее количество товаров:

SELECT SUM(ProductCount)
FROM mypractice.orders;

#Также вместо имени столбца может передаваться вычисляемое выражение.
#Например, найдем общую стоимость всех имеющихся товаров:
SELECT SUM(ProductCount * orders.Price)
FROM mypractice.orders;

#All и Distinct
#По умолчанию все вышеперечисленных пять функций учитывают все строки выборки для вычисления результата.
#Но выборка может содержать повторяющие значения. Если необходимо выполнить вычисления только над уникальными значениями,
#исключив из набора значений повторяющиеся данные, то для этого применяется оператор DISTINCT.

SELECT COUNT(DISTINCT ProductName)
FROM mypractice.orders;

#По умолчанию вместо DISTINCT применяется оператор ALL, который выбирает все строки:
SELECT COUNT(ALL ProductName)
FROM mypractice.orders;
#В данном случае мы видим, что производители могут повторяться в таблице, так как некоторые товары могут иметь одних и тех же производителей.
#Поэтому чтобы подсчитать количество уникальных производителей, необходимо использовать оператор DISTINCT.
#Так как этот оператор неявно подразумевается при отсутствии DISTINCT, то его можно не указывать.

#Комбинирование функций
#Объединим применение нескольких функций:
SELECT COUNT(*)          AS ProdCount,
       SUM(ProductCount) AS TotalCount,
       MIN(Price)        AS MinPrice,
       MAX(Price)        AS MaxPrice,
       AVG(Price)        AS AvgPrice
FROM mypractice.orders;

#Группировка
#Операторы GROUP BY и HAVING позволяют сгруппировать данные. Они употребляются в рамках команды SELECT:

#GROUP BY
#Оператор GROUP BY определяет, как строки будут группироваться.

#Например, сгруппируем товары по производителю
SELECT ProductName, COUNT(*) AS ModelsCount
FROM mypractice.orders
GROUP BY ProductName;

#Оператор GROUP BY может выполнять группировку по множеству столбцов. Так, добавим группировку по количеству товаров:
SELECT ProductName, ProductCount, COUNT(*) AS ModelsCount
FROM mypractice.orders
GROUP BY ProductName, ProductCount;

#Следует учитывать, что выражение GROUP BY должно идти после выражения WHERE, но до выражения ORDER BY:
SELECT ProductName, COUNT(*) AS ModelsCount
FROM mypractice.orders
WHERE Price > 300
GROUP BY ProductName
ORDER BY ModelsCount DESC;

#Фильтрация групп. HAVING
#Оператор HAVING позволяет выполнить фильтрацию групп, то есть определяет, какие группы будут включены в выходной результат.
#Использование HAVING во многом аналогично применению WHERE. Только есть WHERE применяется для фильтрации строк, то HAVING - для фильтрации групп.

#Например, найдем все группы товаров по производителям, для которых определено более 1 модели:
SELECT ProductName, COUNT(*) AS ModelsCount
FROM mypractice.orders
GROUP BY ProductName
HAVING COUNT(*) > 1;

#В одной команде также можно сочетать выражения WHERE и HAVING:
SELECT ProductName, COUNT(*) AS ModelsCount
FROM mypractice.orders
WHERE Price * ProductCount > 1000
GROUP BY ProductName
HAVING COUNT(*) > 1;

#То есть в данном случае сначала фильтруются строки: выбираются те товары, общая стоимость которых больше 1000.
#Затем выбранные товары группируются по производителям. И далее фильтруются сами группы - выбираются те группы,
#которые содержат больше 1 модели.

#Если при этом необходимо провести сортировку, то выражение ORDER BY идет после выражения HAVING:
SELECT ProductName, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM mypractice.orders
WHERE Price * ProductCount > 1000
GROUP BY ProductName
HAVING SUM(ProductCount) > 2
ORDER BY Units DESC;

#Подзапросы
#Подзапросы представляют выражения SELECT, которые встроены в другие запросы SQL.
#Рассмотрим простейший пример применения подзапросов.
#Добавим в таблицы некоторые данные:
INSERT INTO mypractice.order (ProductId, CreatedAt, ProductCount, Price)
VALUES ((SELECT Id FROM mypractice.product WHERE ProductName = 'Galaxy S8'),
        '2018-05-21',
        2,
        (SELECT Price FROM mypractice.product WHERE ProductName = 'Galaxy S8'));

#При добавлении данных в таблицу Orders как раз используются подзапросы.
# Например, первый заказ был сделан на товар Galaxy S8. Соответственно в таблицу Orders нам надо
#сохранить информацию о заказе, где поле ProductId указывает на Id товара Galaxy S8, поле Price - на его цену.
#Но на момент написания запроса нам может быть неизвестен ни Id покупателя,
#ни Id товара, ни цена товара. В этом случае можно выполнить подзапрос в виде

#(SELECT Price FROM Products WHERE ProductName='iPhone 8')
#Подзапрос выполняет команду SELECT и заключается в скобки.
#В данном же случае при добавлении одного товара выполняется два подзапроса. Каждый подзапрос возвращает одного скалярное значение, например, числовой идентификатор.

#В примере выше подзапросы выполнялись к другой таблице, но могут выполняться и к той же, для которой вызывается основной запрос. Например, найдем товары из таблицы Products, которые имеют минимальную цену:

#SELECT * FROM Products
#WHERE Price = (SELECT MIN(Price) FROM Products);
#Или найдем товары, цена которых выше средней:

#SELECT * FROM Products
#WHERE Price > (SELECT AVG(Price) FROM Products);

#Подзапросы в SELECT

#В выражении SELECT мы можем вводить подзапросы четырьмя способами:

#В условии в выражении WHERE

#В условии в выражении HAVING

#В качестве таблицы для выборки в выражении FROM

#В качестве спецификации столбца в выражении SELECT
#Рассмотрим некоторые из этих случаев. Например, получим все товары, у которых цена выше средней:

SELECT *
FROM mypractice.product
WHERE Price > (SELECT AVG(Price) FROM Products);

#Чтобы получить нужные товары, нам вначале надо выполнить подзапрос на получение средней цены товара: SELECT AVG(Price) FROM Products.

#Оператор IN
#Нередко подзапросы применяются вместе с оператором IN,
# который выбирает из набора значений. И подзапрос как раз может предоставить требуемый набор значений.
#Например, выберем все товары из таблицы Products, на которые есть заказы в таблице Orders:


SELECT *
FROM mypractice.product
WHERE Id IN (SELECT ProductId FROM mypractice.order);

#То есть подзапрос в данном случае выбирает все идентификаторы товаров из Orders,
# затем по этим идентификаторам извлекаютя товары из Products.

#Добавив оператор NOT, мы можем выбрать те товары, на которые нет заказов в таблице Orders:

SELECT *
FROM mypractice.product
WHERE Id NOT IN (SELECT ProductId FROM mypractice.order);
#Стоит отметить, что это не самый эффективный способ для извлечения связанных данных из других таблиц,
# так как для сведения данных из разных таблиц можно использовать оператор JOIN, который рассматривается в следующей главе.

#Получение набора значений
#При использовании в операторах сравнения подзапросы должны возвращать одно скалярное значение.
# Но иногда возникает необходимость получить набор значений.
# Чтобы при использовании в операторах сравнения подзапрос мог возвращать набор значений,
# перед ним необходимо использовать один из операторов: ALL, SOME или ANY.

#При использовании ключевого слова ALL условие в операции сравнения должно быть верно для всех значений, которые возвращаются подзапросом. Например, найдем все товары, цена которых меньше чем у любого товара фирмы Apple:

SELECT *
FROM mypractice.product
WHERE Price < ALL (SELECT Price FROM Products WHERE Manufacturer = 'Apple');

#Если бы мы в данном случае опустили бы ключевое слово ALL, то мы бы столкнулись с ошибкой.

#Допустим, если данный подзапрос возвращает значения vаl1, val2 и val3,
#то условие фильтрации фактически было бы аналогично объединению этих значений через оператор AND:


#WHERE Price < val1 AND Price < val2 AND Price < val3
#В тоже время подобный запрос гораздо проще переписать другим образом:

SELECT *
FROM mypractice.product
WHERE Price < (SELECT MIN(Price) FROM mypractice.product WHERE Manufacturer = 'Apple');

#Как работает оператор ALL:

#x > ALL (1, 2) эквивалентно x > 2

#x < ALL (1, 2) эквивалентно x < 1

#x = ALL (1, 2) эквивалентно (x = 1) AND (x = 2)

#x <> ALL (1, 2) эквивалентно x NOT IN (1, 2)

#Операторы ANY и SOME условие в операции сравнения должно быть истинным для хотя бы одного из значений,
# возвращаемых подзапросом. По своему действию оба этих оператора аналогичны, поэтому можно применять любой из них.
# Например, в следующем случае получим товары, которые стоят меньше самого дорогого товара компании Apple:


SELECT *
FROM mypractice.product
WHERE Price < ANY (SELECT Price FROM mypractice.product WHERE Manufacturer = 'Apple');
#И также стоит отметить, что данный запрос можно сделать проще, переписав следующим образом:


SELECT *
FROM mypractice.product
WHERE Price < (SELECT MAX(Price) FROM mypractice.product WHERE Manufacturer = 'Apple');
#Как работает оператор ANY (а также SOME):

#x > ANY (1, 2) эквивалентно x > 1

#x < ANY (1, 2) эквивалентно x < 2

#x = ANY (1, 2) эквивалентно x IN (1, 2)

#x <> ANY (1, 2) эквивалентно (x <> 1) OR (x <> 2)

#Подзапрос как спецификация столбца
#Результат подзапроса может представлять отдельный столбец в выборке. Например, выберем все заказы и добавим к ним информацию о названии товара:

SELECT *,
       (SELECT ProductName FROM mypractice.product WHERE Id = ProductId) AS Product
FROM mypractice.order;

#Подзапросы в SELECT в MySQL
#Подзапросы в команде INSERT
#В команде INSERT подзапросы могут применяться для определения значения, которое вставляется в один из столбцов:

INSERT INTO mypractice.`order`(ProductId, CreatedAt, ProductCount, Price)
VALUES ((SELECT Id FROM mypractice.product WHERE ProductName = 'Galaxy S8'),
        '2018-05-23',
        2,
        (SELECT Price FROM mypractice.product WHERE ProductName = 'Galaxy S8'));

#Подзапросы в команде UPDATE
#В команде UPDATE подзапросы могут применяться:

#В качестве устанавливаемого значения после оператора SET

#Как часть условия в выражении WHERE

#Так, увеличим в таблице Orders количество купленных товаров компании Apple на 2:

UPDATE mypractice.order
SET ProductCount = ProductCount + 2
WHERE ProductId IN (SELECT Id FROM mypractice.product WHERE Manufacturer = 'Apple');
#Или установим для заказа цену товара, полученную в результате подзапроса:

UPDATE mypractice.order
SET Price = (SELECT Price FROM mypractice.product WHERE Id = mypractice.order.ProductId) + 3000
WHERE Id = 1;

#Подзапросы в команде DELETE
#В команде DELETE подзапросы также применяются как часть условия. Так, удалим все заказы на Galaxy S8:


DELETE
FROM mypractice.order
WHERE ProductId = (SELECT Id FROM mypractice.product WHERE ProductName = 'Galaxy S8');

#Оператор EXISTS
#Оператор EXISTS проверяет, возвращает ли подзапрос какое-либо значение. Как правило, этот оператор используется для индикации того, что как минимум одна строка в таблице удовлетворяет некоторому условию. Поскольку возвращения набора строк не происходит, то подзапросы с подобным оператором выполняются довольно быстро.

#Применение оператора имеет следующий формальный синтаксис:

#WHERE [NOT] EXISTS (подзапрос)
#Например, найдем все товары из таблицы Products, на которые есть заказы в таблице Orders:
SELECT *
FROM mypractice.product
WHERE EXISTS
          (SELECT * FROM mypractice.order WHERE mypractice.order.ProductId = mypractice.product.Id);

#Если мы хотим узнать, наоброт, есть ли в таблице строки, которые НЕ удовлетворяют условию, то можно использовать операторы NOT EXISTS.
#Например, найдем все товары из таблицы Products, на которые не было заказов в таблице Orders:

#SELECT * FROM mypractice.product
#WHERE NOT EXISTS (SELECT * FROM mypractice.order WHERE Products.Id = Orders.ProductId)

#Стоит отметить, что для получения подобного результата можно было бы использовать и опеатор IN:

#

SELECT *
FROM mypractice.product
WHERE Id NOT IN (SELECT ProductId FROM mypractice.order);
#Но поскольку при применении EXISTS не происходит выборка строк,
#то его использование более оптимально и эффективно, чем использование оператора IN.
#Соединение таблиц
#Неявное соединение таблиц

CREATE TABLE mypractice.product
(
    Id           INT AUTO_INCREMENT PRIMARY KEY,
    ProductName  VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price        DECIMAL     NOT NULL
);
CREATE TABLE mypractice.customer
(
    Id        INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL
);
CREATE TABLE mypractice.order
(
    Id           INT AUTO_INCREMENT PRIMARY KEY,
    ProductId    INT     NOT NULL,
    CustomerId   INT     NOT NULL,
    CreatedAt    DATE    NOT NULL,
    ProductCount INT DEFAULT 1,
    Price        DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Product (Id) ON DELETE CASCADE,
    FOREIGN KEY (CustomerId) REFERENCES Customer (Id) ON DELETE CASCADE
);

#Нередко возникает необходимость в одном запросе получить данные сразу из нескольких таблиц. Для сведения данных из разных таблиц мы можем использовать разные способы. В данной статье рассмотрим не самый распространный,
#однако довольно простой способ, который представляет неявное соединение таблиц.
INSERT INTO mypractice.product (ProductName, Manufacturer, ProductCount, Price)
VALUES ('iPhone X', 'Apple', 2, 76000),
       ('iPhone 8', 'Apple', 2, 51000),
       ('iPhone 7', 'Apple', 5, 42000),
       ('Galaxy S9', 'Samsung', 2, 56000),
       ('Galaxy S8', 'Samsung', 1, 46000),
       ('Honor 10', 'Huawei', 2, 26000),
       ('Nokia 8', 'HMD Global', 6, 38000);

INSERT INTO mypractice.customer(FirstName)
VALUES ('Tom'),
       ('Bob'),
       ('Sam');

INSERT INTO mypractice.order (ProductId, CustomerId, CreatedAt, ProductCount, Price)
VALUES ((SELECT Id FROM mypractice.product WHERE ProductName = 'Galaxy S8'),
        (SELECT Id FROM mypractice.customer WHERE FirstName = 'Tom'),
        '2018-05-21',
        2,
        (SELECT Price FROM mypractice.product WHERE ProductName = 'Galaxy S8')),
       ((SELECT Id FROM mypractice.product WHERE ProductName = 'iPhone X'),
        (SELECT Id FROM mypractice.customer WHERE FirstName = 'Tom'),
        '2018-05-23',
        1,
        (SELECT Price FROM mypractice.product WHERE ProductName = 'iPhone X')),
       ((SELECT Id FROM mypractice.product WHERE ProductName = 'iPhone X'),
        (SELECT Id FROM mypractice.customer WHERE FirstName = 'Bob'),
        '2018-05-21',
        1,
        (SELECT Price FROM mypractice.product WHERE ProductName = 'iPhone X'));


SELECT *
FROM mypractice.order,
     mypractice.customer;

#При такой выборке каждая строка из таблицы Orders будет соединяться с каждой строкой из таблицы Customers. То есть, получится перекрестное соединение. Например,
#в Orders три строки, а в Customers то же три строки, значит мы получим 3 * 3 = 9 строк:
#Чтобы решить задачу, необходимо использовать выражение WHERE и фильтровать строки при условии,
#что поле CustomerId из Orders соответствует полю Id из Customers:
SELECT *
FROM mypractice.order,
     mypractice.customer
WHERE order.CustomerId = customer.Id;

#Теперь объединим данные по трем таблицам Orders, Customers и Proucts.
#То есть получим все заказы и добавим информацию по клиенту и связанному товару:
SELECT mypractice.customer.FirstName, mypractice.product.ProductName, mypractice.order.CreatedAt
FROM mypractice.order,
     mypractice.customer,
     mypractice.product
WHERE mypractice.order.CustomerId = customer.Id
  AND mypractice.order.ProductId = product.Id;

#Так как здесь нужно соединить три таблицы, то применяются как минимум два условия.
#Ключевой таблицей остается Orders, из которой извлекаются все заказы, а затем к ней подсоединяется данные по клиенту
#по условию Orders.CustomerId = Customers.Id и данные по товару по условию Orders.ProductId=Products.Id

#В данном случае названия таблиц сильно увеличивают код, но мы его можем сократить за счет использования псевдонимов таблиц:
SELECT C.FirstName, P.ProductName, O.CreatedAt
FROM mypractice.order AS O,
     mypractice.customer AS C,
     mypractice.product AS P
WHERE O.CustomerId = C.Id
  AND O.ProductId = P.Id;

#Если необходимо при использовании псевдонима выбрать все столбцы из определенной таблицы,
#то можно использовать звездочку:
SELECT C.FirstName, P.ProductName, O.*
FROM mypractice.order AS O,
     mypractice.customer AS C,
     mypractice.product AS P
WHERE O.CustomerId = C.Id
  AND O.ProductId = P.Id;

#INNER JOIN
#В прошлой теме было рассмотрено неявное соединение таблиц с помощью простой выборки путем сведения данных. Но, как правило, более распространенный подход соединения данных из разных таблиц представляет применение оператора JOIN. Общий формальный синтаксис применения оператора INNER JOIN:

#SELECT столбцы
#FROM таблица1
#    [INNER] JOIN таблица2
#ON условие1
#    [[INNER] JOIN таблица3
#    ON условие2]

# После оператора JOIN идет название второй таблицы, из которой надо добавить данные в выборку.
# Перед JOIN может использоваться необязательное ключевое слово INNER.
# Его наличие или отсутствие ни на что не влияет. Затем после ключевого слова ON указывается условие соединения.
# Это условие устанавливает, как две таблицы будут сравниваться.
# В большинстве случаев для соединения применяется первичный ключ главной таблицы и внешний ключ зависимой таблицы.

#Используя JOIN, выберем все заказы и добавим к ним информацию о товарах:

#SELECT Orders.CreatedAt, Orders.ProductCount, Products.ProductName
#FROM mypractice.order
# JOIN mypractice.product ON Products.Id = Orders.ProductId;

#Поскольку таблицы могут содержать столбцы с одинаковыми названиями,
# то при указании столбцов для выборки указывается их полное имя вместе с именем таблицы, например, "Orders.ProductCount".

#Используя псевдонимы для таблиц, можно сократить код:
SELECT O.CreatedAt, O.ProductCount, P.ProductName
FROM mypractice.order AS O
         JOIN mypractice.product AS P
              ON P.Id = O.ProductId;

#Также можно присоединять данные сразу из нескольких таблиц.
#Например, добавим к заказу информацию о покупателе из таблицы Customers:

#SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName
#FROM mypractice.order
#JOIN mypractice.product ON Products.Id = Orders.ProductId
#JOIN mypractice.customer ON Customers.Id=Orders.CustomerId;

#Благодаря соединению таблиц мы можем использовать их столбцы для фильтрации выборки или ее сортировки:

#SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName
#FROM Orders
#         JOIN Products ON Products.Id = Orders.ProductId
#         JOIN Customers ON Customers.Id=Orders.CustomerId
#WHERE Products.Price > 45000
#ORDER BY Customers.FirstName;

#Outer Join
#В предыдущей теме рассматривля Inner Join или внутреннее соединение таблиц. Но также в MySQL мы можем использовать и так называемое внешнее соединение или Outer Join. В отличие от Inner Join внешнее соединение возвращает все строки одной или двух таблиц, которые участвуют в соединении.

#Outer Join имеет следующий формальный синтаксис:

#SELECT столбцы
#FROM таблица1
# {LEFT|RIGHT} [OUTER] JOIN таблица2 ON условие1
#[{LEFT|RIGHT} [OUTER] JOIN таблица3 ON условие2]...

#Перед оператором JOIN указывается одно из ключевых слов LEFT или RIGHT, которые определяют тип соединения:

#LEFT: выборка будет содержать все строки из первой или левой таблицы

#RIGHT: выборка будет содержать все строки из второй или правой таблицы

#Также перед оператором JOIN может указываться ключевое слово OUTER, но его применение необязательно. Далее после JOIN указывается присоединяемая таблица, а затем идет условие соединения.

#Например, соединим таблицы Orders и Customers:
#SELECT FirstName, CreatedAt, ProductCount, Price, ProductId
#FROM mypractice.order LEFT JOIN mypractice.customer;
#ON Orders.CustomerId = Customers.Id

#По вышеприведенному результату может показаться, что левостороннее соединение аналогично INNER Join,
# но это не так. Inner Join объединяет строки из дух таблиц при соответствии условию.
# Если одна из таблиц содержит строки, которые не соответствуют этому условию,
# то данные строки не включаются в выходную выборку.
# Left Join выбирает все строки первой таблицы и затем присоединяет к ним строки правой таблицы.
# К примеру, возьмем таблицу Customers и добавим к покупателям информацию об их заказах:

#И также можно применять более комплексные условия с фильтрацией и сортировкой.
# Например, выберем все заказы с информацией о клиентах и товарах по тем товарам,
# у которых цена больше 45000, и отсортируем по дате заказа:

#SELECT Customers.FirstName, Orders.CreatedAt,
#    Products.ProductName, Products.Manufacturer
#FROM Orders
#    LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
#    LEFT JOIN Products ON Orders.ProductId = Products.Id
#WHERE Products.Price > 45000
#ORDER BY Orders.CreatedAt;

#UNION
#Оператор UNION позволяет обединить две однотипных выборки.
# Эти выборки могут быть из разных таблиц или из одной и той же таблицы. Формальный синтаксис объединения:

#SELECT_выражение1
#UNION [ALL] SELECT_выражение2
#[UNION [ALL] SELECT_выражениеN]

#Встроенные функции
#Функции для работы со строками
#Для работы со строка в MySQL определен ряд встроенных функций:

#CONCAT: объединяет строки. В качестве параметра принимает от 2-х и более строк, которые надо соединить:

SELECT CONCAT('Tom', ' ', 'Smith');
-- Tom Smith
#При этом в функцию можно передавать не только непосредственно строки, но и числа, даты - они будут преобразовываться в строки и также объединяться.

#CONCAT_WS: также объединяет строки, но в качестве первого параметра принимает разделитель,
# который будет соединять строки:


SELECT CONCAT_WS(' ', 'Tom', 'Smith', 'Age:', 34);
-- Tom Smith Age: 34
#LENGTH: возвращает количество символов в строке. В качестве параметра в функцию передается строка, для которой надо найти длину:


SELECT LENGTH('Tom Smith');
-- 9
#LTRIM: удаляет начальные пробелы из строки. В качестве параметра принимает строку:


SELECT LTRIM('  Apple');
#RTRIM: удаляет конечные пробелы из строки. В качестве параметра принимает строку:


SELECT RTRIM(' Apple    ');
#TRIM: удаляет начальные и конечные пробелы из строки. В качестве параметра принимает строку:


SELECT TRIM('  Tom Smith   ');
#С помощью дополнительного оператора можно задать где имеено удалить пробелы: BOTH (в начале и в конце), TRAILING (только в конце), LEADING (только в начале):


SELECT TRIM(BOTH FROM '  Tom Smith   ');
#LOCATE(find, search [, start]): возвращает позицию первого вхождения подстроки find в строку search. Дополнительный параметр start позволяет установить позицию в строке search, с которой начинается поиск подстроки find. Если подстрока search не найдена, то возвращается 0:


SELECT LOCATE('om', 'Tom Smith'); -- 2
SELECT LOCATE('m', 'Tom Smith'); -- 3
SELECT LOCATE('m', 'Tom Smith', 4); -- 6
SELECT LOCATE('mig', 'Tom Smith');
-- 0
#LEFT: вырезает с начала строки определенное количество символов. Первый параметр функции - строка, а второй - количество символов, которые надо вырезать сначала строки:


#SELECT LEFT('Apple', 3) -- App
#RIGHT: вырезает с конца строки определенное количество символов. Первый параметр функции - строка, а второй - количество символов, которые надо вырезать сначала строки:


#SELECT RIGHT('Apple', 3)    -- ple
#SUBSTRING(str, start [, length]): вырезает из строки str подстроку, начиная с позиции start. Третий необязательный параметр передает количество вырезаемых символов:


SELECT SUBSTRING('Galaxy S8 Plus', 8), -- S8 Plus
       (SELECT SUBSTRING('Galaxy S8 Plus', 8, 2));
-- S8
#SUBSTRING_INDEX(str, delimiter, count): вырезает из строки str подстроку. Параметр delimiter определяет разделитель внутри строки. А параметр count определяет, до какого вхождения разделителя надо вырезать подстроку. Если count положительный, то подстрока вырезается с начала, если count отрицательный, то с конца строки str:


SELECT SUBSTRING_INDEX('Galaxy S8 Plus', ' ', 1),          -- Galaxy
       (SELECT SUBSTRING_INDEX('Galaxy S8 Plus', ' ', 2)), -- Galaxy S8
       (SELECT SUBSTRING_INDEX('Galaxy S8 Plus', ' ', -2));
-- S8 Plus
#REPLACE(search, find, replace): заменяет в строке find подстроку search на подстроку replace. Первый параметр функции - строка, второй - подстрока, которую надо заменить, а третий - подстрока, на которую надо заменить:


#SELECT REPLACE('Galaxy S8 Plus', 'S8 Plus', 'Note 8')   -- Galaxy Note 8
#INSERT(str, start, length, insert): вставляет в строку str, заменяя length символов с позиции start подстрокой insert. Первый параметр функции - строка, второй - позиция, с которой надо заменить, третий - сколько символов с позиции start надо заменить вставляемой подстрокой, четвертый параметр - вставляемая подстрока:


SELECT INSERT('Galaxy S9', 8, 3, 'Note 9');
-- Galaxy Note 9
#REVERSE: переворачивает строку наоборот:


SELECT REVERSE('123456789');
-- 987654321
#           LOWER: переводит строку в нижний регистр:

SELECT LOWER('Apple');
-- apple
#           UPPER: переводит строку в верхний регистр


SELECT UPPER('Apple');
-- APPLE
#           SPACE: возвращает строку, которая содержит определенное количество пробелов

#REPEATE(str, count): возвращает строку, которая содержит определенное количество повторов подстроки str. Количество повторов задается через параметр count.

SELECT REPEAT('ab', 5);
-- ababababab
#LPAD(str, length, pad): добавляет слева от строки str некоторое количество символов, которые определены в параметре pad. Количество добавляемых символов вычисляется по формуле length - LENGTH(str). Если параметр length меньше длины строки str, то эта строка усекается до length символов.

#SELECT LPAD('Tom Smith', 13, '*');   -- ****Tom Smith
#RPAD(str, length, pad): добавляет справа от строки str некоторое количество символов, которые определены в параметре pad. Количество добавляемых символов вычисляется по формуле length - LENGTH(str). Если параметр length меньше длины строки str, то эта строка усекается до length символов.

#SELECT RPAD('Tom Smith', 13, '*');   -- Tom Smith****
#Например, возьмем таблицу:

CREATE TABLE Products
(
    Id           INT AUTO_INCREMENT PRIMARY KEY,
    ProductName  VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price        DECIMAL     NOT NULL
);
#И при извлечении данных применим строковые функции:

#SELECT UPPER(LEFT(Manufacturer,2)) AS Abbreviation,
#CONCAT(ProductName, ' - ',  Manufacturer) AS FullProdName
#FROM Products
#ORDER BY Abbreviation

#Функции для работы с числами

#Для работы с числовыми данными MySQL предоставляет ряд функций:

#ROUND: округляет число. В качестве первого параметра передается число. Второй параметр указывает на длину.
# Если длина представляет положительное число, то оно указывает, до какой цифры после запятой идет округление. Если длина представляет отрицательное число, то оно указывает, до какой цифры с конца числа до запятой идет округление

SELECT ROUND(1342.345, 2), -- 1342.35
       (SELECT ROUND(1342.345, -2));
-- 1300;
#TRUNCATE: оставляет в дробной части определенное количество символов

SELECT TRUNCATE(1342.345, 2);
-- 1342.34
#ABS: возвращает абсолютное значение числа.


SELECT ABS(-123);
-- 123
#  CEILING: возвращает наименьшее целое число, которое больше или равно текущему значению.


#SELECT CEILING(-123.45),        -- -123
#(SELECT CEILING(123.45));       -- 124
#FLOOR: возвращает наибольшее целое число, которое меньше или равно текущему значению.


SELECT FLOOR(-123.45), -- -124
       (SELECT FLOOR(123.45));
-- 123
#POWER: возводит число в определенную степень.


SELECT POWER(5, 2), -- 25
       (SELECT POWER(5, 3));
-- 125
#SQRT: получает квадратный корень числа.


SELECT SQRT(225);
-- 15
#SIGN: возвращает -1, если число меньше 0, и возвращает 1, если число больше 0. Если число равно 0, то возвращает 0.


SELECT SIGN(-5), -- -1
       (SELECT SIGN(7));
-- 1
#RAND: генерирует случайное число с плавающей точкой в диапазоне от 0 до 1.


SELECT RAND(); -- 0.707365088352935
SELECT RAND();
-- 0.173808327956812
#Например, возьмем таблицу:


CREATE TABLE Products
(
    Id           INT AUTO_INCREMENT PRIMARY KEY,
    ProductName  VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price        DECIMAL     NOT NULL
);
#Округлим произведение цены товара на количество этого товара:

#SELECT ProductName, ROUND(Price * ProductCount, 2)
#FROM Products;

#Функции для работы с датами и временем
#Получение даты и времени
#Функции NOW(), SYSDATE(), CURRENT_TIMESTAMP() возвращают текущую локальную дату и время на основе системных часов
# в виде объекта datetime. Все три функции возвращают одинаковый результат

SELECT NOW();               -- 2018-05-25 21:34:55
SELECT SYSDATE();           -- 2018-05-25 21:34:55
SELECT CURRENT_TIMESTAMP(); -- 2018-05-25 21:32:55
#Функции CURDATE и CURRENT_DATE возвращают текущую локальную дату в виде объекта date:


SELECT CURRENT_DATE();      -- 2018-05-25
SELECT CURDATE();           -- 2018-05-25
#Функции CURTIME и CURRENT_TIME возвращают текущее время в виде объекта time:

SELECT CURRENT_TIME();  -- 20:47:45
SELECT CURTIME();       -- 20:47:45
#UTC_DATE возвращает текущую локальную дату относительно GMT
SELECT UTC_DATE();
-- 2018-05-25

#UTC_TIME возвращает текущее локальное время относительно GMT
SELECT UTC_TIME();
-- 17:47:45
#Парсинг даты и времени
#DAYOFMONTH(date) возвращает день месяца в виде числового значения

#DAYOFWEEK(date) возвращает день недели в виде числового значения

#DAYOFYEAR(date) возвращает номер дня в году

#MONTH(date) возвращает месяц даты

#YEAR(date) возвращает год из даты

#QUARTER(date) возвращает номер квартала года

#WEEK(date [, first]) возвращает номер недели года. Необязательный параметр позволяет задать стартовый день недели.
# Если этот параметр равен 1, то первым днем считается понедельник, иначе воскресенье

#LAST_DAY(date) возвращает последний день месяца в виде даты

#DAYNAME(date) возвращает название дня недели

#MONTHNAME(date) возвращает название текущего месяца

#HOUR(time) возвращает час времени

#MINUTE(time) возвращает минуту времени

#SECOND(time) возвращает секунду времени

#Примеры функций:

#Функция

#Результат

#DAYOFMONTH('2018-05-25')

#DAYOFWEEK('2018-05-25')


#DAYOFYEAR('2018-05-25')

#MONTH('2018-05-25')

#YEAR('2018-05-25')

#QUARTER('2018-05-25')

#WEEK('2018-05-25', 1)

#LAST_DAY('2018-05-25')

#2018-05-31

#DAYNAME('2018-05-25')

#Friday

#MONTHNAME('2018-05-25')

#May

#HOUR('21:25:54')

#MINUTE('21:25:54')

#SECOND('21:25:54')

#Функция EXTRACT
#Функция EXTRACT извлекает из даты и времени какой-то определенный компонент. Ее формальный синтаксис:

#EXTRACT(unit FROM datetime)
#Значение datetime представляет исходную дату и (или) время, а значение unit указывает,
# какой компонент даты или времени будет извлекаться.
#Параметр unit может представлять одно из следующих значений:
#Примеры вызова функции:

#EXTRACT( SECOND FROM '2018-05-25 21:25:54')

#EXTRACT( MINUTE FROM '2018-05-25 21:25:54')

#EXTRACT( HOUR FROM '2018-05-25 21:25:54')

#EXTRACT( DAY FROM '2018-05-25 21:25:54')


#EXTRACT( MONTH FROM '2018-05-25 21:25:54')

#EXTRACT( YEAR FROM '2018-05-25 21:25:54')

#EXTRACT( MINUTE_SECOND FROM '2018-05-25 21:25:54')

#EXTRACT( DAY_HOUR FROM '2018-05-25 21:25:54')

#EXTRACT( YEAR_MONTH FROM '2018-05-25 21:25:54')

#EXTRACT( HOUR_SECOND FROM '2018-05-25 21:25:54')

#EXTRACT( DAY_MINUTE FROM '2018-05-25 21:25:54')

#EXTRACT( DAY_SECOND FROM '2018-05-25 21:25:54')

#Функции для манипуляции с датами
#Ряд функций позволяют производить операции сложения и вычитания с датами и временем:

#DATE_ADD(date, INTERVAL expression unit) возвращает объект DATE или DATETIME,
# который является результатом сложения даты date с определенным временным интервалом. Интервал задается с помощью выражения INTERVAL expression unit, где INTERVAL предоставляет ключевое слово, expression - количество добавляемых к дате единиц, а unit - тип единиц (часы, дни и т.д.) Параметр unit может иметь те же значения, что и в функции EXTRACT, то есть DAY, HOUR и т.д.

#DATE_SUB(date, INTERVAL expression unit) возвращает объект DATE или DATETIME,
# который является результатом вычитания из даты date определенного временного интервала

#DATEDIFF(date1, date2) возвращает разницу в днях между датами date1 и date2

#TO_DAYS(date) возвращает количество дней с 0-го года

#TIME_TO_SEC(time) возвращает количество секунд, прошедших с момента полуночи

#Примеры применения:

#DATE_ADD('2018-05-25', INTERVAL 1 DAY)

#2018-05-26

#DATE_ADD('2018-05-25', INTERVAL 3 MONTH)

#2018-08-25

#DATE_ADD('2018-05-25 21:31:27', INTERVAL 4 HOUR)

#2018-05-26 01:31:27

#DATE_SUB('2018-05-25', INTERVAL 4 DAY)

#2018-05-21

#DATEDIFF('2018-05-25', '2018-05-27')

#-2

#DATEDIFF('2018-05-25', '2018-05-21')

#4

#DATEDIFF('2018-05-25', '2018-03-21')

#65

#TO_DAYS('2018-05-25')

#737204

#TIME_TO_SEC('10:00')

#36000

#Форматирование дат и времени
#DATE_FORMAT(date, format) возвращает объект DATE или DATETIME, отформатированный с помощью шаблона format

#TIME_FORMAT(date, format) возвращает объект TIME или DATETIME, отформатированный с помощью шаблона format

#Обе функции в качестве второго параметра принимают строку форматирования или шаблон, который показывает,
# как оформатировать значение. Этот шаблон может принимать следующие значения:

#%m: месяц в числовом формате 01..12

#%с: месяц в числовом формате 1..12


#%W: название дня недели (Sunday...Saturday)


#%H: час в формате 00..23

#Примеры применения:

#DATE_FORMAT('2018-05-25', '%d/%m/%y')

#25/05/18

#DATE_FORMAT('2018-05-25 21:25:54', '%d %M %Y')

#25 May 2018

#DATE_FORMAT('2018-05-25 21:25:54', '%r')

#09:25:54 PM

#TIME_FORMAT('2018-05-25 21:25:54', '%H:%i:%S')

#21:25:24

#TIME_FORMAT('21:25:54', '%k:%i')

#21:25

#В качестве примера использования функций найдем заказы, которые были сделаны 5 дней назад:
SELECT *
FROM Orders
WHERE DATEDIFF(CURDATE(), CreatedAt) = 5;

#Функции CASE, IF, IFNULL, COALESCE

#CASE
#Функция CASE проверяет истинность набора условий и в зависимости от результата проверки может возвращать тот
# или иной результат.
#Эта функция принимает следующую форму:
#CASE
#    WHEN условие_1 THEN результат_1
#    WHEN условие_2 THEN результат_2
#    .................................
#    WHEN условие_N THEN условие_N
#    [ELSE альтернативный_результат]
#END

#Возьмем для примера следующую таблицу Products:

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
#Выполним запрос к этой таблице и используем функцию CASE:

#SELECT ProductName, ProductCount,
       #CASE
           #WHEN ProductCount = 1
               #THEN 'Товар заканчивается'
           #WHEN ProductCount = 2
               #THEN 'Мало товара'
           #WHEN ProductCount = 3
               #THEN 'Есть в наличии'
           #ELSE 'Много товара'
#END AS Category
#FROM Products;
#Функция CASE в MySQL
#Функция IF
#Функция IF в зависимости от результата условного выражения возвращает одно из двух значений.
# Общая форма функции выглядит следующим образом:

#IF(условие, значение_1, значение_2)
#Если условие, передаваемое в качестве первого параметра, верно, то возвращается первое значение,
# иначе возвращается второе значение. Например:

#SELECT ProductName, Manufacturer,
# IF(ProductCount > 3, 'Много товара', 'Мало товара')
#FROM Products;
#Функция IF в MySQL
#IFNULL
#Функция IFNULL проверяет значение некоторого выражения. Если оно равно NULL, то функция возвращает значение,
# которое передается в качестве второго параметра:

#IFNULL(выражение, значение)
#Например, возьмем следующую таблицу

CREATE TABLE Clients
(
    Id        INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName  VARCHAR(20) NOT NULL,
    Phone     VARCHAR(20) NULL,
    Email     VARCHAR(20) NULL
);

INSERT INTO Clients (FirstName, LastName, Phone, Email)
VALUES ('Tom', 'Smith', '+36436734', NULL),
       ('Bob', 'Simpson', NULL, NULL);
#И применим при получении данных функцию IFNULL:

SELECT FirstName,
       LastName,
       IFNULL(Phone, 'не определено') AS Phone,
       IFNULL(Email, 'неизвестно')    AS Email
FROM Clients;

#Функция IFNULL в MySQL
#COALESCE
#Функция COALESCE принимает список значений и возвращает первое из них, которое не равно NULL:

#COALESCE(выражение_1, выражение_2, выражение_N);
#Например, выберем из таблицы Clients пользователей и в контактах у них определим либо телефон,
# либо электронный адрес, если они не равны NULL:

SELECT FirstName,
       LastName,
       COALESCE(Phone, Email, 'не определено') AS Contacts
FROM Clients;
#То есть в данном случае возвращается телефон, если он определен.
# Если он не определен, то возвращается электронный адрес. Если и электронный адрес не определен, то возвращается строка "не определено".




