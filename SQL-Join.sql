-- tabel mahasiswa
create table mahasiswa(
    nim varchar(100),
    nama varchar(200),
    jenis_kelamin varchar(1),
    alamat varchar(50),
    primary key(nim));

insert into mahasiswa values
('101','Arif','L','Jl. Kenangan'),
('102','Budi','P','Jl. Jombang'),
('103','Wati','P','Jl. Surabaya'),
('104','Ika','P','Jl. Jombang'),
('105','Tono','L','Jl. Jakarta'),
('106','Iwan','L','Jl. Bandung'),
('107','Sari','P','Jl. Malang');

-- tabel ambil_mk
create table ambil_mk(
    nim varchar(100),
    kode_mk varchar (20));

insert into ambil_mk values
('101','PTI447'),
('103','TIK333'),
('104','PTI333'),
('104','PTI777'),
('111','PTI123'),
('123','PTI999');

-- case 1 : dapatkan data yang mengambil matakuliah
select mahasiswa.nim, mahasiswa.nama
from mahasiswa inner join ambil_mk
on  mahasiswa.nim = ambil_mk.nim
inner join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk
group by mahasiswa.nim;
--
select mahasiswa.nim, mahasiswa.nama
from mahasiswa,ambil_mk, matakuliah
where mahasiswa.nim = ambil_mk.nim 
and ambil_mk.kode_mk = matakuliah.kode_mk
group by mahasiswa.nim;

-- case 2 : kelompokkan data mahasiswa yang tidak mengambil matakuliah berdasarkan jenis kelamin
select mahasiswa.jenis_kelamin, count(mahasiswa.jenis_kelamin) as jumlah
from mahasiswa left join ambil_mk
on mahasiswa.nim = ambil_mk.nim
where ambil_mk.nim is NULL
group by mahasiswa.jenis_kelamin;

-- case 3 : nim dan nama mahasiswa yang mengambil matakuliah beserta kode_mk dan nama_mk yang diambilnya
select mahasiswa.nim, mahasiswa.nama, matakuliah.kode_mk, matakuliah.nama_mk
from mahasiswa inner join ambil_mk
on  mahasiswa.nim = ambil_mk.nim
inner join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk;
--
select mahasiswa.nim, mahasiswa.nama, matakuliah.kode_mk, matakuliah.nama_mk
from mahasiswa, ambil_mk, matakuliah
where mahasiswa.nim = ambil_mk.nim
and ambil_mk.kode_mk = matakuliah.kode_mk;

-- case 4 : nim, nama, dan total sks yang diambil oleh mahasiswa, di mana total sksnya lebih dari 4 dan kurang dari 10
select mahasiswa.nim, mahasiswa.nama, sum(sks) as total_sks
from mahasiswa inner join ambil_mk
on  mahasiswa.nim = ambil_mk.nim
inner join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk
group by nama
having sum(sks) > 4 and sum(sks) < 10;

-- case 5 : Dapatkan data matakuliah yang tidak diambil oleh mahasiswa terdaftar
select matakuliah.kode_mk, matakuliah.nama_mk, sks, semester
from mahasiswa left join ambil_mk
on mahasiswa.nim = ambil_mk.nim
right join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk
where nama is null;

-- TUGAS RUMAH --

-- tabel instruktur
create table instruktur (
    nip int,
    nama_ins varchar(20),
    jurusan varchar(20),
    asal_kota varchar(20),
    primary key(nip));

insert into instruktur values
('1','Steve Wozniak','Ilmu Komputer','Bantul'),
('2','Steve Jobs','Seni Rupa','Solo'),
('3','James Gosling','Ilmu Komputer','Klaten'),
('4','Bill Gates','Ilmu Komputer','Magelang');

-- tabel matakuliah
create table matakuliah (
    no_mk varchar (20),
    namamk varchar(100),
    sks int,
    primary key (no_mk));

insert into matakuliah values 
    ('KOM101','Algoritma dan Pemrogaman','3'),
    ('KOM102','Basis Data','3'),
    ('KOM201','Pemrogaman Berorientasi Objek','3'),
    ('SR101','Desain Elementer','3');

-- tabel kuliah
create table kuliah (
    nip int,
    no_mk varchar(20),
    ruangan int(3),
    jml_mhs int (2));

insert into kuliah values
('1','KOM101','101','50'),
('1','KOM102','102','35'),
('2','SR101','101','45'),
('3','KOM201','101','55');

-- CASE : Tampilkan Nomor dan mata kuliah yang pesertanya lebih dari 40 orang. 
select matakuliah.no_mk, matakuliah.namamk
from matakuliah inner join kuliah
on matakuliah.no_mk = kuliah.no_mk
where kuliah.jml_mhs > 40;

-- Tampilkan nip dan nama instruktur yang mengajar mata kuliah 'Basis Data'
select instruktur.nip, instruktur.nama_ins
from instruktur inner join kuliah
on instruktur.nip = kuliah.nip
inner join matakuliah
on kuliah.no_mk = matakuliah.no_mk
where matakuliah.namamk = "Basis Data";

-- Tampilkan Total jumlah total mahasiswa yang Diajar oleh 'Steve Wozniak' menggunakan JOIN.
select sum(jml_mhs) as total_mahasiswa
from kuliah inner join instruktur
on kuliah.nip = instruktur.nip
where instruktur.nama_ins = "Steve Wozniak";

-- tabel customer
create table customer(
    customer_id varchar(20),
    customer_name varchar(100),
    customer_addres  varchar(100),
    primary key(customer_id)); 

insert into customer values
('CS001','Adiba','Pandaan'),
('CS002','Erwina','Sidoarjo'),
('CS003','Annas','Blitar'),
('CS004','Galuh','Malang'),
('CS005','Dewi','Tulungagung');

-- tabel orders
create table orders(
    order_id int(4),
    order_date varchar(50),
    customer_id varchar(20),
    qty int,
    amount int(5),
    primary key(order_id));

insert into orders values
('0001','01-04-2015','CS001','2','40000'),
('0002','08-04-2015','CS003','3','50000'),
('0003','14-04-2015','CS005','1','60000');

-- CASE : Gabungkan kedua tabel itu menggunakan JOIN dan UNION 
select customer.customer_id,customer_name, order_id,order_date,qty,amount
from customer left outer join orders
on customer.customer_id = orders.customer_id
order by customer_name;