-- Bổ sung ràng buộc cho bảng NHANVIEN để đảm bảo rằng một nhân viên chỉ có thể làm việc trong công ty khi đủ 18 tuổi và không quá 61 tuổi.
ALTER TABLE nhanvien
ADD 
	CONSTRAINT chk_tuoi 
	CHECK(DATEDIFF(YEAR, ngaysinh, GETDATE()) BETWEEN 18 AND 61);