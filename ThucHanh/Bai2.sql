-- Bổ sung ràng buộc thiết lập giá trị mặc định bằng 1 cho cột SOLUONG và bằng 0 cho cột MUCGIAMGIA trong bảng CHITIETDATHANG
ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_soluong
	DEFAULT(1) FOR soluong

ALTER TABLE CHITIETDATHANG
ADD
	CONSTRAINT df_chitietdathang_mucgiamgia
	DEFAULT(0) FOR mucgiamgia

