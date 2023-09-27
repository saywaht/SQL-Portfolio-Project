select * from project..data$

-- TOTAL EPISODES

select max([Ep# No#]) from project..data$
SELECT COUNT(DISTINCT [Ep# No#]) FROM project..data$


--pitches

select count(distinct Brand) from project..data$

-- pitches converted

select sum(a.converted_not_converted) funding_received, count(*) total_pitches from (
select amountinvestedlakhs , case when amountinvestedlakhs > 0 then 1 else 0 end as converted_not_converted from project..data$) a 

-- Success rate 

select cast(sum(a.converted_not_converted) as float) / cast(count(*) as float) from (
select amountinvestedlakhs , case when amountinvestedlakhs > 0 then 1 else 0 end as converted_not_converted from project..data$) a 

-- total male\

select sum(male) from project..data$

-- total female 

select sum(female) from project..data$

-- gender ratio

select sum(female) / sum(male) from project..data$

--total invested amount 

select sum(amountinvestedlakhs) from project..data$

-- avg equity taken

select AVG(a.[EquityTaken%]) from(
select * from project..data$ where [EquityTaken%]>0) a

-- highest deal taken 

select max(amountinvestedlakhs) from project..data$

--highest equity taken 

select max([EquityTaken%]) from project..data$

--- Startups having at least 1 women
select sum(a.Female_count) from (
select Female, case when Female > 0 then 1 else 0 end as Female_count from project..data$) a

---pitches converted having at least one women 

select * from project..data$

select sum(b.female_count) from(

select a.*, case when a.Female>0 then 1 else 0 end as female_count from (
select * from project..data$ where DEAL!= 'NO DEAL') a) b

-- Average team members

select avg(Teammembers) from project..data$

-- Avg Amount Invested per deal 
select avg(a.AmountInvestedlakhs) amount_invested_per_deal from
(select * from project..data$ where DEAL!= 'NO DEAL') a

-- Avg age group of contestants 

select Avgage,count(Avgage) cnt from project..data$ group by Avgage order by cnt desc

-- Location group of contestants

select Location,count(Location) cnt from project..data$ group by Location order by cnt desc

-- Sector group of contestants

select Sector,count(Sector) cnt from project..data$ group by Sector order by cnt desc

-- partner deals

select Partners,count(Partners) cnt from project..data$ where Partners!= '-' group by Partners order by cnt desc

--making the matrix

select 'Ashneer' as keyy Count(AshneerAmountinvested) from project..data$ where AshneerAmountinvested is not null

select 'Ashneer' as keyy Count(AshneerAmountinvested) from project..data$ where AshneerAmountinvested is not null AND AshneerAmountinvested!= 0

SELECT 'Ashneer' as keyy, SUM(C.AshneerAmountinvested), AVG(C.[AshneerEquityTaken%])
From( select * From project..data$ where [AshneerEquityTaken%]!=0 AND [AshneerEquityTaken%] IS NOT NULL) C

select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,Count(AshneerAmountinvested) total_deals_present from project..data$ where AshneerAmountinvested is not null) a

inner join(
select 'Ashneer' as keyy,Count(AshneerAmountinvested) total_deals from project..data$ 
where AshneerAmountinvested is not null AND AshneerAmountinvested!= 0) b

on a.keyy=b.keyy) m

inner join


(SELECT 'Ashneer' as keyy, SUM(C.AshneerAmountinvested) total_amount_invested, 
AVG(C.[AshneerEquityTaken%]) avg_equity_taken
From( select * From project..data$ where [AshneerEquityTaken%]!=0 AND [AshneerEquityTaken%] IS NOT NULL) C) n

on m.keyy=n.keyy


-- Startup in which the highest amount has been invested in each domain/sector


select c.* from
(select Brand,Sector,Amountinvestedlakhs,rank() over(partition by Sector order by Amountinvestedlakhs desc) rnk

from project..data$) c

where c.rnk=1


