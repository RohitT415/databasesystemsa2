-- Part 4d
select 
    case when Ship.shipName is null then Company.companyName
         when Company.companyName is null then 'Grand Total'
         else '    ' || Ship.shipName end as ShipDetails, 
    to_char(sum(Cruise.price + (Ship.dailyTips * Cruise.days)), '$999,999.00') as TotalPrice
from 
    Ship 
    join Cruise on Ship.shipName = Cruise.shipName and Ship.companyName = Cruise.companyName
    join Reservation on Cruise.cruiseID = Reservation.cruiseID
    join Company on Ship.companyName = Company.companyName
group by rollup(Company.companyName, Ship.shipName)
order by Company.companyName, Ship.shipName;
