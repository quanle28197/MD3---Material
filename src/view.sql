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
