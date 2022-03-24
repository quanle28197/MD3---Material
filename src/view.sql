CREATE DATABASE material1;
USE material;

create table Material
(
    id    int primary key,
    Code  varchar(50),
    name  varchar(255),
    unit  varchar(50),
    price double
);

create table Storage
(
    id         int primary key,
    materialID int,
    quantity   int,
    import     int,
    export     int,
    foreign key (materialID) references Material (id)
);

create table Supplier
(
    id      int primary key,
    code    varchar(50),
    name    varchar(255),
    address varchar(50),
    phone   varchar(50)
);

create table Orders
(
    id         int primary key,
    supplierID int,
    code       varchar(50),
    date       datetime,
    foreign key (supplierID) references Supplier (id)
);

create table GoodRecieveNote
(
    id      int primary key,
    code    varchar(50),
    date    datetime,
    orderID int,
    foreign key (orderID) references Orders (id)
);

create table GoodDeliveryNote
(
    id           int primary key,
    code         varchar(50),
    date         datetime,
    customerName varchar(255)
);

create table OrderDetail
(
    id         int primary key,
    orderID    int,
    foreign key (orderID) references Orders (id),
    materialID int,
    foreign key (materialID) references Material (id),
    quantity   int
);

create table RecieveNoteDetail
(
    id            int primary key,
    recieveNoteID int,
    foreign key (recieveNoteID) references GoodRecieveNote (id),
    materialID    int,
    foreign key (materialID) references Material (id),
    quantity      int,
    price         double,
    note          varchar(255)
);

create table DeliveryNoteDetail
(
    id             int primary key,
    deliveryNoteID int,
    foreign key (deliveryNoteID) references GoodDeliveryNote (id),
    materialID     int,
    foreign key (materialID) references Material (id),
    quantity       int,
    price          double,
    note           varchar(255)
);

insert into Material
values (1, 1, 'Cafe Verona', 'goi', 20000),
       (2, 2, 'Cafe Colombia', 'goi', 10000),
       (3, 3, 'Cafe Sumatra', 'goi', 500000),
       (4, 4, 'Cafe Ehiopia', 'goi', 100000),
       (5, 5, 'Cafe Italian', 'goi', 30000);

insert into Storage
values (1, 1, 100, 200, 50),
       (2, 2, 50, 100, 30),
       (3, 3, 300, 40, 10),
       (4, 4, 500, 300, 100),
       (5, 5, 200, 30, 20),
       (6, 1, 250, 100, 50),
       (7, 2, 120, 60, 20),
       (8, 3, 330, 100, 80),
       (9, 4, 700, 100, 60),
       (10, 5, 210, 300, 150);

insert into Supplier
values (1, 1, 'Starbucks', 'HN', '0934568542'),
       (2, 2, 'Gio Viet', 'HCM', '0988389874'),
       (3, 3, 'Bloom', 'DN', '0986325495');

insert into Orders
values (1, 1, 1, '2021-5-24 12:21:30'),
       (2, 3, 2, '2021-5-25 8:27:45'),
       (3, 2, 3, '2021-4-19 6:57:26');

insert into GoodDeliveryNote
values (1, 1, '2021-5-23', 'Minh Quan'),
       (2, 2, '2021-2-5', 'Thanh'),
       (3, 3, '2021-2-14', 'Huy Hoa');

insert into GoodRecieveNote
values (1, 1, '2021-1-14', 1),
       (2, 2, '2021-1-19', 2),
       (3, 3, '2021-1-20', 3);

insert into OrderDetail
values (1, 1, 3, 100),
       (2, 2, 1, 50),
       (3, 2, 2, 100),
       (4, 3, 4, 140),
       (5, 1, 5, 60),
       (6, 3, 3, 180);

insert into DeliveryNoteDetail
values (1, 1, 1, 200, 30000, ''),
       (2, 1, 2, 300, 20000, ''),
       (3, 2, 2, 200, 22000, ''),
       (4, 2, 3, 100, 450000, ''),
       (5, 3, 4, 100, 100000, ''),
       (6, 3, 5, 230, 32000, '');

insert into RecieveNoteDetail
values (1, 1, 1, 150, 27000, ''),
       (2, 1, 2, 300, 18000, ''),
       (3, 2, 2, 100, 21000, ''),
       (4, 2, 3, 100, 440000, ''),
       (5, 3, 4, 100, 90000, ''),
       (6, 3, 5, 230, 30000, '');