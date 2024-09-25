-- Bài 1: Tạo cơ sở dữ liệu
CREATE DATABASE THUCHANH;
USE THUCHANH;

CREATE TABLE NHACUNGCAP(
  macongty NVARCHAR(10) PRIMARY KEY NOT NULL,
  tencongty NVARCHAR(40) NOT NULL,
  tengiaodich NVARCHAR(30),
  diachi NVARCHAR(50),
  dienthoai NVARCHAR(15),
  fax NVARCHAR(15),
  email NVARCHAR(30)
);

CREATE TABLE LOAIHANG(
  maloaihang NVARCHAR(10) PRIMARY KEY NOT NULL,
  tenloaihang NVARCHAR(40) NOT NULL
);

CREATE TABLE MATHANG(
  mahang NVARCHAR(10) PRIMARY KEY NOT NULL,
  tenhang NVARCHAR(50) NOT NULL,
  macongty NVARCHAR(10) NOT NULL,
  maloaihang NVARCHAR(10) NOT NULL,
  soluong INT,
  donvitinh NVARCHAR(10),
  giahang INT,

  CONSTRAINT fk_macongty FOREIGN KEY (macongty) REFERENCES NHACUNGCAP(macongty),
  CONSTRAINT fk_maloaihang FOREIGN KEY (maloaihang) REFERENCES LOAIHANG(maloaihang)
);

CREATE TABLE NHANVIEN(
  manhanvien NVARCHAR(10) PRIMARY KEY NOT NULL,
  ho NVARCHAR(20) NOT NULL,
  ten NVARCHAR(10) NOT NULL,
  ngaysinh DATE,
  ngaylamviec DATE,
  diachi NVARCHAR(50),
  dienthoai NVARCHAR(15),
  luongcoban INT,
  phucap INT
);

CREATE TABLE KHACHHANG(
  makhachhang NVARCHAR(10) PRIMARY KEY NOT NULL,
  tencongty NVARCHAR(50) NOT NULL,
  tengiaodich NVARCHAR(30),
  diachi NVARCHAR(50),
  dienthoai NVARCHAR(15),
  fax NVARCHAR(15),
  email NVARCHAR(30)
);

CREATE TABLE DONDATHANG(
  sohoadon INT PRIMARY KEY NOT NULL,
  makhachhang NVARCHAR(10),
  manhanvien NVARCHAR(10),
  ngaydathang DATE,
  ngaygiaohang DATE,
  ngaychuyenhang DATE,
  noigiaohang NVARCHAR(50),

  CONSTRAINT fk_makhachhang FOREIGN KEY (makhachhang) REFERENCES KHACHHANG(makhachhang),
  CONSTRAINT fk_manhanvien FOREIGN KEY (manhanvien) REFERENCES NHANVIEN(manhanvien)
);

CREATE TABLE CHITIETDATHANG(
  sohoadon INT NOT NULL,
  mahang NVARCHAR(10) NOT NULL,
  giaban INT,
  soluong SMALLINT,
  mucgiamgia NUMERIC(2,1),

  CONSTRAINT pk_chitietdathang PRIMARY KEY (sohoadon, mahang),
  CONSTRAINT fk_sohoadon FOREIGN KEY (sohoadon) REFERENCES DONDATHANG(sohoadon),
  CONSTRAINT fk_mahang FOREIGN KEY (mahang) REFERENCES MATHANG(mahang)
);

-- Bài 2: Bổ sung ràng buộc thiết lập giá trị mặc định bằng 1 cho cột SOLUONG và bằng 0 cho cột MUCGIAMGIA trong bảng CHITIETDATHANG
ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_soluong
	DEFAULT(1) FOR soluong

ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_mucgiamgia
	DEFAULT(0) FOR mucgiamgia

-- Bài 3: Bổ sung cho bảng DONDATHANG ràng buộc kiểm tra ngày giao hàng và ngày chuyển hàng phải sau hoặc bằng với ngày đặt hàng.
ALTER TABLE dondathang
ADD
	CONSTRAINT chk_dondathang_ngay CHECK (ngaygiaohang >= ngaydathang AND ngaychuyenhang >= ngaydathang)

-- Bài 4: Bổ sung ràng buộc cho bảng NHANVIEN để đảm bảo rằng một nhân viên chỉ có thể làm việc trong công ty khi đủ 18 tuổi và không quá 61 tuổi.
ALTER TABLE nhanvien
ADD 
	CONSTRAINT chk_tuoi 
	CHECK(DATEDIFF(YEAR, ngaysinh, GETDATE()) BETWEEN 18 AND 61);

-- Bài 5: Nhập giá trị cho bảng NHACUNGCAP, LOAIHANG, MATHANG, NHANVIEN, KHACHHANG, DONDATHANG, CHITIETDATHANG
INSERT INTO NHANVIEN(manhanvien, ho, ten, ngaysinh, ngaylamviec, diachi, dienthoai, luongcoban, phucap)
VALUES (1, 'Nguyen', 'Van A', '1990-12-1', '2010-12-1', 'Ha Noi', '0123456789', 1000000, 500000),
	   (2, 'Tran', 'Van B', '1991-12-2', '2011-12-2', 'Ha Noi', '0123456788', 2000000, 600000),
	   (3, 'Le', 'Van C', '1992-12-3', '2012-12-3', 'Ha Noi', '0123456787', 3000000, 700000),
	   (4, 'Pham', 'Van D', '1993-12-4', '2013-12-4', 'Ha Noi', '0123456786', 4000000, 800000),
	   (5, 'Hoang', 'Van E', '1994-12-5', '2014-12-5', 'Ha Noi', '0123456785', 5000000, 900000)

INSERT INTO KHACHHANG(makhachhang, tencongty, tengiaodich, diachi, dienthoai, fax, email)
VALUES (1, 'CT001', 'TGD001', 'Ha Noi', '0123456789', '0123456789', 'a@gmail.com'),
       (2, 'CT002', 'TGD002', 'Ha Noi', '0123456788', '0123456788', 'b@gmail.com'),
       (3, 'CT003', 'TGD003', 'Ha Noi', '0123456787', '0123456787', 'c@gmail.com'),
       (4, 'CT004', 'TGD004', 'Ha Noi', '0123456786', '0123456786', 'd@gmail.com'),
       (5, 'CT005', 'TGD005', 'Ha Noi', '0123456785', '0123456785', 'e@gmail.com');


INSERT INTO NHACUNGCAP(macongty, tencongty, tengiaodich, diachi, dienthoai, fax, email)
VALUES ('CT001', 'TGD001', 'Ha Noi', '0123456789', '0123456789', '01', 'ct1@gmail.com'),
	   ('CT002', 'TGD002', 'Ha Noi', '0123456788', '0123456788', '02', 'ct2@gmail.com'),
	   ('CT003', 'TGD003', 'Ha Noi', '0123456787', '0123456787', '03', 'ct3@gmail.com'),
	   ('CT004', 'TGD004', 'Ha Noi', '0123456786', '0123456786', '04', 'ct4@gmail.com'),
	   ('CT005', 'TGD005', 'Ha Noi', '0123456785', '0123456785', '05', 'ct5@gmail.com')

INSERT INTO LOAIHANG(maloaihang, tenloaihang)
VALUES ('LH001', 'TLH001'),
	   ('LH002', 'TLH002'),
	   ('LH003', 'TLH003'),
	   ('LH004', 'TLH004'),
	   ('LH005', 'TLH005')

INSERT INTO DONDATHANG(sohoadon, makhachhang, manhanvien, ngaydathang, ngaygiaohang, ngaychuyenhang, noigiaohang)
VALUES (1, 1, 1, '2024-12-9', '2024-12-15', '2024-12-10', 'haloi'),
	   (2, 2, 2, '2024-12-10', '2024-12-16', '2024-12-11', 'thainguyen'),
	   (3, 3, 3, '2024-12-11', '2024-12-17', '2024-12-12', 'namdinh'),
	   (4, 4, 4, '2024-12-12', '2024-12-18', '2024-12-13', 'haiphong'),
	   (5, 5, 5, '2024-12-13', '2024-12-19', '2024-12-14', 'thanhhoa')

INSERT INTO MATHANG(mahang, tenhang, macongty, maloaihang, soluong, donvitinh, giahang)
VALUES ('MH001', 'TH001', 'CT001', 'LH001', 100, 'hop', 10000),
	   ('MH002', 'TH002', 'CT002', 'LH002', 200, 'hop', 20000),
	   ('MH003', 'TH003', 'CT003', 'LH003', 300, 'hop', 30000),
	   ('MH004', 'TH004', 'CT004', 'LH004', 400, 'hop', 40000),
	   ('MH005', 'TH005', 'CT005', 'LH005', 500, 'hop', 50000)

INSERT INTO CHITIETDATHANG (sohoadon, mahang, giaban, soluong, mucgiamgia)
VALUES (1, 'MH001', 10000, 1, 0),
	   (2, 'MH002', 20000, 1, 0),
	   (3, 'MH003', 30000, 1, 0),
	   (4, 'MH004', 40000, 1, 0),
	   (5, 'MH005', 50000, 1, 0)



-- Bài 6: Xoá bảng 
-- Khong the thuc hien duoc cau lenh vi bang NHACUNGCAP dang duoc tham chieu boi bang MATHANG thong qua khoa ngoai 'macongty' 
-- ALTER TABLE MATHANG
-- DROP CONSTRAINT fk_macongty
DROP TABLE nhacungcap