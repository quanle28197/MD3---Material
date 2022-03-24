#Cau1
create view vw_CTPNhap as
select id, materialID, quantity, price, price * quantity as value
from RecieveNoteDetail;

#Cau2
create view vw_CTPNhap_VT as
select vw_CTPNhap.id,
       vw_CTPNhap.materialID,
       M.name,
       vw_CTPNhap.quantity,
       vw_CTPNhap.price,
       vw_CTPNhap.price * vw_CTPNhap.quantity as total
from vw_CTPNhap
         join Material M on vw_CTPNhap.materialID = M.id;

# Cau3
create view vw_CTPNhap_VT_PN as
select R.id,
       G.date,
       G.orderID,
       R.materialID,
       M.name,
       R.quantity,
       R.price,
       R.quantity * R.price as total
from RecieveNoteDetail as R
         join GoodRecieveNote as G on G.id = R.id
         join Material M on R.materialID = M.id;

# Cau4
create view vw_CTPNHAP_VT_PN_DH as
select R.id,
       G.date,
       G.orderID,
        S.code,
       R.materialID,
       M.name,
       R.quantity,
       R.price,
       R.quantity * R.price as total
from  RecieveNoteDetail as R
join GoodRecieveNote as G on G.id = R.id
join Material M on R.materialID = M.id
join Supplier S on G.code = S.code;

# Cau5
create view vw_CTPNhap_Loc as
select R.recieveNoteID, R.materialID, R.quantity, R.price, R.quantity * R.price as total
from RecieveNoteDetail as R
where R.quantity > 5;

# Cau6
CREATE VIEW vw_CTPNHAP_VT_loc as
select R.recieveNoteID, R.materialID,M.name, R.quantity, R.price, R.quantity * R.price as total
from RecieveNoteDetail as R
JOIN Material M on R.materialID = M.id
WHERE M.unit = 'goi';

# Cau7
CREATE VIEW  vw_CTPXUAT as
select D.id, D.materialID, D.quantity, D.price, D.quantity * D.price as total
from DeliveryNoteDetail as D;

# Cau8
create view vw_CTPXuat_VT as
select V.id, V.materialID, M.name, V.price, V.quantity
from vw_CTPXuat as V
         join Material M on V.materialID = M.id;

# Cau9
create view vw_CTXuat_VT_PX as
select D.id, G.customerName, D.materialID, M.name, D.price, D.quantity
from DeliveryNoteDetail as D
         join GoodDeliveryNote as G on G.id = D.deliveryNoteID
         join Material M on D.materialID = M.id;


# # Cau1 Sto
delimiter //
create procedure MaterialQuantity(
    IN materialID int)
begin
    declare storeQuantity int;
    declare totalImport int;
    declare totalExport int;
    declare result int;

    set storeQuantity = (select S.quantity as quantity
                         from Material as M
                                  join Storage S on M.id = S.materialID
                         where S.id = materialID);
    set totalImport = (select sum(R.quantity)
                       from RecieveNoteDetail as R
                       where materialID = R.materialID);

    set totalExport = (select sum(D.quantity)
                       from DeliveryNoteDetail as D
                       where materialID = D.materialID);
    set result = storeQuantity + totalImport - totalExport;
    select result;
end;
//
delimiter ;


call MaterialQuantity(1);

# Cau2
delimiter //
create procedure totalExport(in materialID int)
begin
    declare totalExport int;
    set totalExport = (select sum(V.price*V.quantity)
                       from vw_CTPXuat_VT as V
                       where V.materialID = materialID);
    select totalExport;
end;
//
delimiter ;

call totalExport(2);

# Cau3
delimiter //
create procedure totalOrderQuantity(in orderID int)
begin
    select T.materialID, T.quantity
    from (select O.materialID, O.quantity
          from OrderDetail as O where O.orderID = orderID) as T;
end;
//
delimiter ;

call totalOrderQuantity(3);

# Cau4
delimiter //
create procedure addNewOrder(
    in id int,
    in supplierID int,
    in code int,
    in date datetime)
begin
    insert into Orders value (id, supplierID, code, date);
end;
//
delimiter ;

call addNewOrder(5,3,5,'2022-03-24 16:27:50');


# Cau5
delimiter //
create procedure addNewOrderDetail(
    in id int,
    in orderID int,
    in materialID int,
    in quantity int)
begin
    insert into OrderDetail value (id, orderID, materialID, quantity);
end;
//
delimiter ;
call addNewOrderDetail(7, 2, 4,150);