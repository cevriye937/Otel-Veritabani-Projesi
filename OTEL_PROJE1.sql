create table oda_tip (
    oda_tip_id number primary key,
    tip_adi varchar2(50) unique not null,
    kapasite number check (kapasite > 0),
    gunluk_ucret number(10,2) check (gunluk_ucret > 0)
);

create table musteri (
    musteri_id number primary key,
    ad varchar2(50) not null,
    soyad varchar2(50) not null,
    telefon varchar2(15) unique,
    email varchar2(100) unique
);

create table personel (
    personel_id number primary key,
    ad varchar2(50) not null,
    soyad varchar2(50) not null,
    gorev varchar2(50),
    telefon varchar2(15) unique,
    maas number(10,2) check (maas > 0)
);

create table oda (
    oda_id number primary key,
    oda_no varchar2(10) unique not null,
    oda_tip_id number not null,
    durum varchar2(20) check (durum in ('bos','dolu','temiz','kapali')),
    foreign key (oda_tip_id) references oda_tip(oda_tip_id)
);

create table rezervasyon (
    rezervasyon_id number primary key,
    musteri_id number not null,
    oda_id number not null,
    giris_tarihi date not null,
    cikis_tarihi date not null,
    durum varchar2(20) check (durum in ('beklemede','onaylandi','iptal')),
    foreign key (musteri_id) references musteri(musteri_id),
    foreign key (oda_id) references oda(oda_id)
);

create table servis (
    servis_id number primary key,
    servis_adi varchar2(50) not null,
    fiyat number(10,2) check (fiyat > 0)
);

create table fatura (
    fatura_id number primary key,
    rezervasyon_id number not null,
    toplam_tutar number(10,2),
    fatura_tarihi date,
    foreign key (rezervasyon_id) references rezervasyon(rezervasyon_id)
);

create table kampanya (
    kampanya_id number primary key,
    kampanya_adi varchar2(100) not null,
    indirim_orani number(5,2) check (indirim_orani between 0 and 100),
    baslangic_tarihi date,
    bitis_tarihi date
);

create table oda_yorum (
    yorum_id number primary key,
    musteri_id number not null,
    oda_id number not null,
    puan number check (puan between 1 and 5),
    yorum varchar2(200),
    yorum_tarihi date default sysdate,
    foreign key (musteri_id) references musteri(musteri_id),
    foreign key (oda_id) references oda(oda_id)
);

create table giris_kaydi (
    giris_id number primary key,
    musteri_id number not null,
    oda_id number not null,
    giris_zamani date default sysdate,
    foreign key (musteri_id) references musteri(musteri_id),
    foreign key (oda_id) references oda(oda_id)
);

create table cikis_kaydi (
    cikis_id number primary key,
    musteri_id number not null,
    oda_id number not null,
    cikis_zamani date default sysdate,
    foreign key (musteri_id) references musteri(musteri_id),
    foreign key (oda_id) references oda(oda_id)
);

create table oda_durum (
    oda_durum_id number primary key,
    durum_adi varchar2(30) unique not null
);

create table kullanici_log (
    log_id number primary key,
    islem_turu varchar2(30),
    tablo_adi varchar2(50),
    aciklama varchar2(200),
    islem_zamani date default sysdate
);

create table otel_rapor (
    rapor_id number primary key,
    rapor_tarihi date default sysdate,
    toplam_rezervasyon number,
    toplam_gelir number(12,2),
    dolu_oda_sayisi number,
    bos_oda_sayisi number
);

create table rezervasyon_servis (
    rezervasyon_id number,
    servis_id number,
    primary key (rezervasyon_id, servis_id),
    foreign key (rezervasyon_id) references rezervasyon(rezervasyon_id),
    foreign key (servis_id) references servis(servis_id)
);
-----------

create sequence seq_oda_tip start with 1 increment by 1;
create sequence seq_musteri start with 1 increment by 1;
create sequence seq_personel start with 1 increment by 1;
create sequence seq_oda start with 1 increment by 1;
create sequence seq_rezervasyon start with 1 increment by 1;
create sequence seq_servis start with 1 increment by 1;
create sequence seq_fatura start with 1 increment by 1;
create sequence seq_kampanya start with 1 increment by 1;
create sequence seq_oda_yorum start with 1 increment by 1;
create sequence seq_giris start with 1 increment by 1;
create sequence seq_cikis start with 1 increment by 1;
create sequence seq_oda_durum start with 1 increment by 1;
create sequence seq_kullanici_log start with 1 increment by 1;
create sequence seq_otel_rapor start with 1 increment by 1;
create sequence seq_rezervasyon_servis start with 1 increment by 1;
-----------------

create or replace trigger trg_oda_tip_id
before insert on oda_tip
for each row
begin
     :new.oda_tip_id := seq_oda_tip.nextval;
end;
/

create or replace trigger trg_musteri_id
before insert on musteri
for each row
begin
     :new.musteri_id := seq_musteri.nextval;
end;
/

create or replace trigger trg_personel_id
before insert on personel
for each row
begin
     :new.personel_id := seq_personel.nextval;
end;
/

create or replace trigger trg_oda_id
before insert on oda
for each row
begin
     :new.oda_id := seq_oda.nextval;
end;
/

create or replace trigger trg_rezervasyon_id
before insert on rezervasyon
for each row
begin
     :new.rezervasyon_id := seq_rezervasyon.nextval;
end;
/

create or replace trigger trg_servis_id
before insert on servis
for each row
begin
     :new.servis_id := seq_servis.nextval;
end;
/

create or replace trigger trg_fatura_id
before insert on fatura
for each row
begin
     :new.fatura_id := seq_fatura.nextval;
end;
/

create or replace trigger trg_kampanya_id
before insert on kampanya
for each row
begin
     :new.kampanya_id := seq_kampanya.nextval;
end;
/

create or replace trigger trg_oda_yorum_id
before insert on oda_yorum
for each row
begin
     :new.yorum_id := seq_oda_yorum.nextval;
end;
/


create or replace trigger trg_giris_id
before insert on  giris_kaydi
for each row
begin
     :new.giris_id := seq_giris.nextval;
end;
/

create or replace trigger trg_cikis_id
before insert on cikis_kaydi
for each row
begin
     :new.cikis_id := seq_cikis.nextval;
end;
/

create or replace trigger trg_oda_durum_id
before insert on oda_durum
for each row
begin
     :new.oda_durum_id := seq_oda_durum.nextval;
end;
/

create or replace trigger trg_kullanici_log_id
before insert on kullanici_log
for each row
begin
     :new.log_id := seq_kullanici_log.nextval;
end;
/

create or replace trigger trg_otel_rapor_id
before insert on otel_rapor
for each row
begin
     :new.rapor_id := seq_otel_rapor.nextval;
end;
/

create or replace trigger trg_rezervasyon_servis_id
before insert on rezervasyon_servis
for each row
begin
     null;
end;
/
----------
---oda tipleri----
insert into oda_tip (tip_adi, kapasite, gunluk_ucret)
values ('standart', 2, 1500);

insert into oda_tip (tip_adi, kapasite, gunluk_ucret)
values ('deluxe', 3, 3000);

insert into oda_tip (tip_adi, kapasite, gunluk_ucret)
values ('vip', 4, 6000);

----müşteriler-----
insert into musteri (ad, soyad, telefon, email)
values ('ahmet', 'yilmaz', '5551112233', 'ahmet@mail.com');

insert into musteri (ad, soyad, telefon, email)
values ('ayse', 'demir', '5552223344', 'ayse@mail.com');

-------personel----

insert into personel (ad, soyad, gorev, telefon, maas)
values ('mehmet', 'can', 'resepsiyon', '5559998877', 30000);

insert into personel (ad, soyad, gorev, telefon, maas)
values ('fatma', 'kaya', 'temizlik', '5558887766', 25000);

-----odalar----

insert into oda (oda_no, oda_tip_id, durum)
values ('101', 1, 'bos');

insert into oda (oda_no, oda_tip_id, durum)
values ('102', 2, 'temiz');

insert into oda (oda_no, oda_tip_id, durum)
values ('201', 3, 'bos');

------rezervasyon------

insert into rezervasyon (musteri_id, oda_id, giris_tarihi, cikis_tarihi, durum)
values (1, 1, sysdate, sysdate+3, 'onaylandi');

insert into rezervasyon (musteri_id, oda_id, giris_tarihi, cikis_tarihi, durum)
values (2, 2, sysdate, sysdate+5, 'beklemede');

-----servis-----

insert into servis (servis_adi, fiyat)
values ('kahvalti', 250);

insert into servis (servis_adi, fiyat)
values ('oda servisi', 400);

----fatura----

insert into fatura (rezervasyon_id, toplam_tutar, fatura_tarihi)
values (1, 4500, sysdate);

insert into fatura (rezervasyon_id, toplam_tutar, fatura_tarihi)
values (2, 8000, sysdate);

---oda yorum----

insert into oda_yorum (musteri_id, oda_id, puan, yorum)
values (1, 1, 5, 'cok guzeldi');

insert into oda_yorum (musteri_id, oda_id, puan, yorum)
values (2, 2, 4, 'iyiydi');

------giris/cikis----

insert into giris_kaydi (musteri_id, oda_id)
values (1, 1);

insert into cikis_kaydi (musteri_id, oda_id)
values (1, 1);

----SORGULAR-----

----MÜŞTERİLER VE REZERVASYONLARI---

select 
    m.ad,
    m.soyad,
    r.rezervasyon_id,
    r.giris_tarihi,
    r.cikis_tarihi,
    r.durum
from musteri m
join rezervasyon r on m.musteri_id = r.musteri_id;

------odalar ve tipleri-----

select 
    o.oda_no,
    t.tip_adi,
    t.kapasite,
    t.gunluk_ucret,
    o.durum
from oda o
join oda_tip t on o.oda_tip_id = t.oda_tip_id;

------toplam rezervasyon satısı----

select count(*) as toplam_rezervasyon
from rezervasyon;

------toplam gelir----

select sum(toplam_tutar) as toplam_gelir
from fatura;

--------dolu ve boş oda sayısı-----

select 
    durum,
    count(*) as adet
from oda
group by durum;

-----ortalama puan----

select avg(puan) as ortalama_puan
from oda_yorum;

-------en çok rezervasyon yapan müsteri----

select 
    m.ad,
    m.soyad,
    count(r.rezervasyon_id) as rezervasyon_sayisi
from musteri m
join rezervasyon r on m.musteri_id = r.musteri_id
group by m.ad, m.soyad
order by rezervasyon_sayisi desc;

---------aktif rezervasyonlar-----

select *
from rezervasyon
where durum = 'onaylandi';

------odalara göre gelir-----

select 
    o.oda_no,
    sum(f.toplam_tutar) as gelir
from oda o
join rezervasyon r on o.oda_id = r.oda_id
join fatura f on r.rezervasyon_id = f.rezervasyon_id
group by o.oda_no;

--------------------

-----tablo gösterimi-----

SELECT table_name
FROM user_tables
ORDER BY table_name;

-----veri eklendiği-----

SELECT * FROM musteri;
SELECT * FROM oda;
SELECT * FROM rezervasyon;
SELECT * FROM fatura;

-----triggerların çalıştığı----

INSERT INTO musteri(ad, soyad, telefon, email)
VALUES ('test', 'test', '5557778899', 'test@test.com');

SELECT * FROM musteri;

-------sequence ve trigger listesi----

SELECT sequence_name
FROM user_sequences
ORDER BY sequence_name;

SELECT trigger_name, status
FROM user_triggers
ORDER BY trigger_name;

-----view----

create or replace view vw_rezervasyon_detay as
select
    r.rezervasyon_id,
    m.ad,
    m.soyad,
    o.oda_no,
    r.giris_tarihi,
    r.cikis_tarihi,
    r.durum
from rezervasyon r
join musteri m on r.musteri_id = m.musteri_id
join oda o on r.oda_id = o.oda_id;

select * from vw_rezervasyon_detay;----test----

create or replace view vw_oda_detay as
select
    o.oda_id,
    o.oda_no,
    t.tip_adi,
    t.kapasite,
    t.gunluk_ucret,
    o.durum
from oda o
join oda_tip t on o.oda_tip_id = t.oda_tip_id;

select * from vw_oda_detay;----test----

create or replace view vw_musteri_rezervasyon as
select
    m.musteri_id,
    m.ad,
    m.soyad,
    count(r.rezervasyon_id) as rezervasyon_sayisi
from musteri m
left join rezervasyon r
    on m.musteri_id = r.musteri_id
group by
    m.musteri_id,
    m.ad,
    m.soyad;
    
    select * from vw_musteri_rezervasyon; ---test----
    
    select view_name
from user_views;


------fonksiyonlar----

create or replace function fn_musteri_sayisi
return number
is
    v_sayi number;
begin
    select count(*)
    into v_sayi
    from musteri;

    return v_sayi;
end;
/

select fn_musteri_sayisi from dual;---test---

create or replace function fn_toplam_gelir
return number
is
    v_toplam number;
begin
    select nvl(sum(toplam_tutar),0)
    into v_toplam
    from fatura;

    return v_toplam;
end;
/

select fn_toplam_gelir from dual;---test----

create or replace function fn_dolu_oda_sayisi
return number
is
    v_sayi number;
begin
    select count(*)
    into v_sayi
    from oda
    where durum = 'dolu';

    return v_sayi;
end;
/

select fn_dolu_oda_sayisi from dual;---test---

select object_name
from user_objects
where object_type = 'FUNCTION';

------PROSEDÜRLER---

--YENİ MÜSTERİ EKLEME---

create or replace procedure pr_musteri_ekle(
    p_ad varchar2,
    p_soyad varchar2,
    p_telefon varchar2,
    p_email varchar2
)
is
begin
    insert into musteri(ad, soyad, telefon, email)
    values (p_ad, p_soyad, p_telefon, p_email);

    commit;
end;
/

begin
    pr_musteri_ekle('ali', 'veli', '5553332211', 'ali@mail.com');---TEST---
end;
/

------REZERVASYPN EKLEME----

create or replace procedure pr_rezervasyon_ekle(
    p_musteri_id number,
    p_oda_id number,
    p_giris date,
    p_cikis date,
    p_durum varchar2
)
is
begin
    insert into rezervasyon(musteri_id, oda_id, giris_tarihi, cikis_tarihi, durum)
    values (p_musteri_id, p_oda_id, p_giris, p_cikis, p_durum);

    commit;
end;
/

begin
    pr_rezervasyon_ekle(1, 1, sysdate, sysdate+2, 'onaylandi');----TEST---
end;
/

------PERSONEL EKLE----

create or replace procedure pr_personel_ekle(
    p_ad varchar2,
    p_soyad varchar2,
    p_gorev varchar2,
    p_telefon varchar2,
    p_maas number
)
is
begin
    insert into personel(ad, soyad, gorev, telefon, maas)
    values (p_ad, p_soyad, p_gorev, p_telefon, p_maas);

    commit;
end;
/

------REF CURSOR----

-----BİR MÜŞERİNİN REZERVASYONLARINI LİSTELEYEN PROSEDÜR--

create or replace procedure pr_musteri_rezervasyon_liste(
    p_musteri_id number,
    p_cursor out sys_refcursor
)
is
begin
    open p_cursor for
        select
            r.rezervasyon_id,
            o.oda_no,
            r.giris_tarihi,
            r.cikis_tarihi,
            r.durum
        from rezervasyon r
        join oda o on r.oda_id = o.oda_id
        where r.musteri_id = p_musteri_id;
end;
/

----TEST----

declare
    c sys_refcursor;
    v1 number;
    v2 varchar2(20);
    v3 date;
    v4 date;
    v5 varchar2(20);
begin
    pr_musteri_rezervasyon_liste(1, c);

    loop
        fetch c into v1, v2, v3, v4, v5;
        exit when c%notfound;
        dbms_output.put_line(v1 || ' ' || v2 || ' ' || v5);
    end loop;

    close c;
end;
/

---TRIGGER---
----rezervasyon log kaydı----
create or replace trigger trg_rezervasyon_log
after insert on rezervasyon 
for each row
begin
    insert into kullanici_log(
        islem_turu,
        tablo_adi,
        aciklama,
        islem_zamani
 )
 values(
  'insert',
  'rezervasyon',
  'yeni rezervasyon eklendi id=' || :new.rezervasyon_id,
  sysdate
  );
  end;
  /
  
  insert into rezervasyon(musteri_id,oda_id,giris_tarihi,cikis_tarihi,durum)
  values(1,1,sysdate,sysdate+2,'onaylandi');
  
  select * from kullanici_log;---test---
  
  -----2. trigger oda durumu otomatik güncelleme ---
  
  create or replace trigger trg_oda_durum_guncelle
after insert on rezervasyon 
for each row
begin
    update oda
    set durum='dolu'
    where oda_id = :new.oda_id;
    end;
    /
    
    insert into rezervasyon (musteri_id, oda_id, giris_tarihi, cikis_tarihi, durum)
values (1, 1, sysdate, sysdate+3, 'onaylandi');

select * from oda;---test---

----fatura vergi otomatik hesaplama----
drop trigger trg_fatura_vergi;

create or replace trigger trg_fatura_vergi
before insert on fatura
for each row
begin
    if :new.vergi_orani is null then
        :new.vergi_orani := 20;
    end if;

    :new.toplam_tutar := :new.toplam_tutar + (:new.toplam_tutar * :new.vergi_orani / 100);
end;
/
alter table fatura add vergi_orani number(5,2);--vergi orani kolonu ekledik ----

insert into fatura (rezervasyon_id, fatura_tarihi, toplam_tutar)
values (1, sysdate, 1000);

select * from fatura;

-------viewvler----

----müşteri+rezervasyon raporu--

create or replace view vw_rezervasyon_detay as
select
    r.rezervasyon_id,
    m.ad || ' ' || m.soyad as musteri,
    o.oda_no,
    r.giris_tarihi,
    r.cikis_tarihi,
    r.durum
from rezervasyon r
join musteri m on r.musteri_id = m.musteri_id
join oda o on r.oda_id = o.oda_id;

-----ODA DETAY RAPORU------
create or replace view vw_oda_detay as
select
    o.oda_id,
    o.oda_no,
    ot.tip_adi,
    ot.kapasite,
    ot.gunluk_ucret,
    o.durum
from oda o
join oda_tip ot on o.oda_tip_id = ot.oda_tip_id;

------FATURA RAPORU-----

create or replace view vw_fatura_rapor as
select
    f.fatura_id,
    f.rezervasyon_id,
    f.fatura_tarihi,
    f.toplam_tutar,
    f.vergi_orani
from fatura f;

-----test---

select * from vw_rezervasyon_detay;
select * from vw_oda_detay;
select * from vw_fatura_rapor;

-----prosedurler---

----müşteri ekle----

create or replace procedure sp_musteri_ekle (
    p_ad varchar2,
    p_soyad varchar2,
    p_telefon varchar2,
    p_email varchar2
)
as
begin
    insert into musteri (ad, soyad, telefon, email)
    values (p_ad, p_soyad, p_telefon, p_email);
end;
/

begin
    sp_musteri_ekle('Ali', 'Veli', '5559998877', 'ali2@mail.com');
end;
/

-----REZERVASYON EKLE----

create or replace procedure sp_rezervasyon_ekle (
    p_musteri_id number,
    p_oda_id number,
    p_giris date,
    p_cikis date,
    p_durum varchar2
)
as
    v_durum oda.durum%type;
begin
    -- oda durumunu kontrol et
    select durum into v_durum
    from oda
    where oda_id = p_oda_id;

    if v_durum = 'dolu' then
        raise_application_error(-20001, 'Bu oda dolu, rezervasyon yapılamaz');
    end if;

    -- rezervasyon ekle------------
    create or replace procedure sp_rezervasyon_ekle (
    p_musteri_id number,
    p_oda_id number,
    p_giris date,
    p_cikis date,
    p_durum varchar2
)
as
    v_durum oda.durum%type;
begin
    -- oda durumunu kontrol et
    select durum into v_durum
    from oda
    where oda_id = p_oda_id;

    if v_durum = 'dolu' then
        raise_application_error(-20001, 'Bu oda dolu, rezervasyon yapılamaz');
    end if;

    -- rezervasyon ekle
    insert into rezervasyon (
        musteri_id,
        oda_id,
        giris_tarihi,
        cikis_tarihi,
        durum
    )
    values (
        p_musteri_id,
        p_oda_id,
        p_giris,
        p_cikis,
        p_durum
    );

    -- oda durumunu güncelle
    update oda
    set durum = 'dolu'
    where oda_id = p_oda_id;

end;
/
select * from oda;

begin
    sp_rezervasyon_ekle(1,3, sysdate, sysdate+4, 'onaylandi');
end;
/

----ODA RAPORLAMA----

create or replace procedure sp_oda_rapor
as
    cursor c_oda is
        select oda_id, durum from oda;

    v_oda_id oda.oda_id%type;
    v_durum  oda.durum%type;

    v_dolu number := 0;
    v_bos  number := 0;
begin
    open c_oda;

    loop
        fetch c_oda into v_oda_id, v_durum;
        exit when c_oda%notfound;

        if v_durum = 'dolu' then
            v_dolu := v_dolu + 1;
        else
            v_bos := v_bos + 1;
        end if;
    end loop;

    close c_oda;

    dbms_output.put_line('DOLU ODA: ' || v_dolu);
    dbms_output.put_line('BOS ODA: ' || v_bos);
end;
/

set serveroutput on;

begin
    sp_oda_rapor;
end;
/


------FONKSİYONLAR----

-----Günlük rezervasyon sayısı----

create or replace function fn_gunluk_rezervasyon(p_tarih date)
return number
is
    v_sayi number;
begin
    select count(*)
    into v_sayi
    from rezervasyon
    where trunc(giris_tarihi) = trunc(p_tarih);

    return v_sayi;
end;
/

select fn_gunluk_rezervasyon(sysdate) from dual;---test--

----vıewler--

-----rezervasyon detay vıew--

create or replace view vw_rezervasyon as
select 
    r.rezervasyon_id,
    m.ad,
    m.soyad,
    o.oda_no,
    r.giris_tarihi,
    r.cikis_tarihi,
    r.durum
from rezervasyon r
join musteri m on m.musteri_id = r.musteri_id
join oda o on o.oda_id = r.oda_id;

-----oda durum vıew--

create or replace view vw_oda_durum as
select 
    o.oda_no,
    ot.tip_adi,
    o.durum,
    ot.kapasite,
    ot.gunluk_ucret
from oda o
join oda_tip ot on ot.oda_tip_id = o.oda_tip_id;

-----fatura vıew---

create or replace view vw_fatura as
select 
    f.fatura_id,
    f.rezervasyon_id,
    f.fatura_tarihi,
    f.toplam_tutar
from fatura f;

select * from vw_rezervasyon;
select * from vw_oda_durum;
select * from vw_fatura;

-----verilerin çalıştığını gösterme---

select * from musteri;
select * from oda;
select * from rezervasyon;
select * from fatura;

select * from user_objects;