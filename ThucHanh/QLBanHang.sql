USE QLBanHang;
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