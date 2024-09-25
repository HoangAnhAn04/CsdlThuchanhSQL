--Bổ sung cho bảng DONDATHANG ràng buộc kiểm tra ngày giao hàng và ngày chuyển hàng phải sau hoặc bằng với ngày đặt hàng.
ALTER TABLE dondathang
ADD
	CONSTRAINT chk_ngaygiaohang CHECK (ngaygiaohang >= ngaydathang)

ALTER TABLE dondathang
ADD
	CONSTRAINT chk_ngaychuyenhang CHECK (ngaychuyenhang >= ngaydathang)
