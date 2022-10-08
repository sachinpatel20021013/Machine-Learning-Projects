--print entire table data1 and data2
select * from Data1;
select * from Data2;

--total no of rows in both the tables
select count(*) from data1;
select count(*) from data2;

--dataset for any two state let say West Bengal Karnataka
select * from data1 where state in ('west Bengal','karnataka');

--Average growth in population of india
select Avg(growth)*100 average_growth from data1;

--Total population of india
select sum(population) total_population from data2;

--total population state wise
select state,sum(population) total_population from data2 group by state;

--Average growth % state wise
select state,Avg(growth)*100 average_growth from data1 group by state;

--print minimun and maximun growth state
select state,Avg(growth)*100 average_growth from data1 group by state having Avg(growth)*100 in (max(Avg(growth)),min(Avg(growth)));

--average sex ratio of india
select round(avg(sex_ratio),0) from data1;

--average sex ration state wise
select state,round(avg(sex_ratio),0) sex_ratio from data1 group by state order by sex_ratio desc;

--averge Literacy rate greater than 90
select state,avg(literacy) avg_literacy from data1 group by state having avg(literacy)>90  order by avg_literacy desc;

--top 3 state according to literacy rate
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy desc;
select  state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy desc limit 3;

--lowest 3 state according to literacy rate
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy;

---lowest 3 and top 3 state according to literacy rate
select * from(
select * from (
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy desc ) a 
union
select * from (
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy) b ) a 
order by avg_literacy ;

--another ways doing same thing using creating temporary table
drop table  if exists topstate;
create table topstate(
state varchar(255),
avg_literacy float)

insert into topstate
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy desc

select * from topstate order by avg_literacy ;


drop table if exists loweststate 
create table loweststate(
state varchar(255),
avg_literacy float)

insert into loweststate
select top 3 state,avg(literacy) avg_literacy from data1 group by state order by avg_literacy 

select * from loweststate order by avg_literacy;

--union opertor 
select * from(
select * from(
select * from topstate) a

union 

select * from(
select * from loweststate) b) a order by avg_literacy;

--State which starting with A letter or letter M and count no. of state
select count(*) from(
select distinct state from data1 where state like 'A%' or state like 'M%') a;

--joining two table and finding total male and female
select state , sum(female) female , sum(male) male from(
select district , state , round((Population*sex_ratio)/(1000+sex_ratio),0) as female,round((Population*1000)/(1000+sex_ratio),0) as male from (
select data1.district ,data1.state ,sex_ratio,population 
from data1,data2 where data1.district =data2.district) a) a group by state;

--again joining two table and find total literate people and inliterate people
select state,sum(literate) literate_people,sum(unliterate) unliterate_people from(
select district , state,round(population*literacy,0) literate,round(population*(100-literacy),0) unliterate from(
select data1.district , data1.state ,literacy,population
from data1 , data2 where data1.district = data2.district)a)a group by state;

--finding maximun literate people in which state and minminum
-- max
select top 1 state,literate_people from(
select state,sum(literate) literate_people,sum(unliterate) unliterate_people from(
select district , state,round(population*literacy,0) literate,round(population*(100-literacy),0) unliterate from(
select data1.district , data1.state ,literacy,population
from data1 , data2 where data1.district = data2.district)a)a group by state)a  order by literate_people desc;

--fro min
select top 1 state,literate_people from(
select state,sum(literate) literate_people,sum(unliterate) unliterate_people from(
select district , state,round(population*literacy,0) literate,round(population*(100-literacy),0) unliterate from(
select data1.district , data1.state ,literacy,population
from data1 , data2 where data1.district = data2.district)a)a group by state)a  order by literate_people;


---finding population of previous census
select state ,(population - pre_population) population_inscrease from(
select state,sum(pre_population) pre_population,sum(population) population from(
select district,state,round(population/(1+growth),0) Pre_population,population from(
select data1.district,data1.state,growth,population from
data1,data2 where data1.district = data2.district) a)a group by state) a;

--total population of india in previous census
select sum(pre_population) total_pre_population, sum(population ) total_population , -sum(pre_population)+sum(population ) total_increase from(
select state,sum(pre_population) pre_population,sum(population) population from(
select district,state,round(population/(1+growth),0) Pre_population,population from(
select data1.district,data1.state,growth,population from
data1,data2 where data1.district = data2.district) a ) a group by state)a;


--finding area reduces per person
select state,area_km2*(1/pre_population - 1/population) dec_area_per_person from(
select state,sum(area_km2) area_km2,sum(pre_population) pre_population,sum(population) population from(
select district,state,area_km2,round(population/(1+growth),0) Pre_population,population from(
select data1.district,data1.state,data2.area_km2,growth,population from
data1,data2 where data1.district = data2.district) a)a group by state) a;

--top 3 district in each state which has highest literacy rate
--using window 
select district , state,literacy from(
select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from data1)a where rnk in (1,2,3);

---bottom 3 district in each state which has lowest literacy rate
select district , state,literacy from(
select district,state,literacy,rank() over(partition by state order by literacy ) rnk from data1 aesc)a where rnk in (1,2,3);



