ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_soluong
	DEFAULT(1) FOR soluong

ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_mucgiamgia
	DEFAULT(0) FOR mucgiamgia

ALTER TABLE dondathang
ADD
	CONSTRAINT chk_ngaygiaohang CHECK (ngaygiaohang >= ngaydathang)

ALTER TABLE dondathang
ADD
	CONSTRAINT chk_ngaychuyenhang CHECK (ngaychuyenhang >= ngaydathang)
