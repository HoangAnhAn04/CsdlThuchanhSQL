USE QLBanHang

--1. Cho biết danh sách các đối tác cung cấp hàng cho công ty.
SELECT macongty, tencongty FROM NHACUNGCAP;

--2. Mã hàng, tên hàng và số lượng hiện có trong công ty
SELECT mahang, tenhang, soluong FROM MATHANG;

--3. Địa chỉ, số điện thoại của nhà cung cấp có tên giao dịch VINAMILK là gì?
SELECT diachi, dienthoai FROM NHACUNGCAP
WHERE tengiaodich='VINAMILK';

--4. Cho biết mã và tên các mặt hàng có giá lơn hơn 100000 và số lượng hiện có ít hơn 50
SELECT mahang, tenhang FROM MATHANG
WHERE giahang > 100000 AND soluong < 50;

--5. Đơn đặt hàng số 1 do ai đặt, do nhân viên nào lập, thời gian và địa điểm giao hàng ở đâu?
SELECT KHACHHANG.tengiaodich AS 'Khách hàng',
       NHANVIEN.ho + ' ' + NHANVIEN.ten AS 'Nhân viên lập đơn',
       DONDATHANG.ngaygiaohang,
       DONDATHANG.noigiaohang
FROM DONDATHANG
JOIN KHACHHANG ON DONDATHANG.makhachhang = KHACHHANG.makhachhang
JOIN NHANVIEN ON DONDATHANG.manhanvien = NHANVIEN.manhanvien
WHERE DONDATHANG.sohoadon = 1;

--6. Hiển thị những nhân viên có lương cơ bản cao nhất công ty
SELECT manhanvien, ho, ten, luongcoban FROM NHANVIEN
WHERE luongcoban = (SELECT MAX(luongcoban) FROM NHANVIEN);

--7. Nhân viên nào trong công ty bán được nhiều hàng nhất và số lượng bán được là bao nhiêu?
SELECT NV.manhanvien, NV.ho + ' ' + NV.ten AS 'Tên nhân viên', SUM(CTDH.soluong) AS 'Tổng số lượng bán'
FROM NHANVIEN NV
JOIN DONDATHANG DDH ON NV.manhanvien = DDH.manhanvien
JOIN CHITIETDATHANG CTDH ON DDH.sohoadon = CTDH.sohoadon
GROUP BY NV.manhanvien, NV.ho, NV.ten
ORDER BY SUM(CTDH.soluong) DESC
LIMIT 1;

--8. Hãy cho biết tổng số hàng của mỗi loại hàng
SELECT LOAIHANG.tenloaihang, SUM(MATHANG.soluong) AS 'Tổng số lượng'
FROM LOAIHANG
JOIN MATHANG ON LOAIHANG.maloaihang = MATHANG.maloaihang
GROUP BY LOAIHANG.tenloaihang;

--9. Tăng lương lên 50% cho những nhân viên bán được số lượng hàng >=100 trong năm 2023.
UPDATE NHANVIEN
SET luongcoban = luongcoban * 1.5
WHERE manhanvien IN (
    SELECT NV.manhanvien
    FROM NHANVIEN NV
    JOIN DONDATHANG DDH ON NV.manhanvien = DDH.manhanvien
    JOIN CHITIETDATHANG CTDH ON DDH.sohoadon = CTDH.sohoadon
    WHERE YEAR(DDH.ngaydathang) = 2023
    GROUP BY NV.manhanvien
    HAVING SUM(CTDH.soluong) >= 100
);

--10. Xóa những đơn hàng có ngày đặt hàng trước năm 2020 ra khỏi CSDL
DELETE FROM DONDATHANG
WHERE YEAR(ngaydathang) < 2020;

--11.Xóa khỏi bảng NHANVIEN những nhân viên đã làm việc cho công ty trên 40 năm
DELETE FROM NHANVIEN
WHERE DATEDIFF(YEAR, ngaylamviec, GETDATE()) > 40;

S
