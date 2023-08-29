<%--
  Created by IntelliJ IDEA.
  User: takda
  Date: 9/29/2022
  Time: 11:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Footer Start -->
<div class="container-fluid bg-dark text-light mt-5 py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container pt-5">
<%--        <div class="row g-5">--%>
<%--            <div class="col-lg-3 col-md-6">--%>
<%--                <h3 class="text-white mb-4">การทำงานร่วมกัน</h3>--%>
<%--                <div class="d-flex flex-column justify-content-start">--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>หน้าหลัก</a>--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>สำหรับผู้รับผิดชอบหลักสูตร</a>--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>สำหรับผู้ดูแลระบบ</a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-lg-3 col-md-6">--%>
<%--                <h3 class="text-white mb-4">เมนู</h3>--%>
<%--                <div class="d-flex flex-column justify-content-start">--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>หน้าหลัก</a>--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>เกี่ยวกับคณะ</a>--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>หลักสูตรการอบรม</a>--%>
<%--                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>ข่าวสารและกิจกรรม</a>--%>
<%--                    <a class="text-light" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>เกี่ยวกับเรา</a>--%>
<%--                    <a class="text-light" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>เข้าสู่ระบบ</a>--%>
<%--                </div>--%>
<%--            </div>--%>
            <div id="map" style="width: 200px; height: 200px;"></div>
            <div class="col-lg-3 col-md-6">
                <h3 class="text-white mb-4">ติดต่อ</h3>
                <p class="mb-2"><i class="bi bi-geo-alt text-primary me-2"></i>63 หมู่ 4 ตำบลหนองหาร <br> &nbsp;&nbsp;&nbsp; อำเภอสันทราย จังหวัดเชียงใหม่ 50290</p>
                <p class="mb-2"><i class="bi bi-envelope-open text-primary me-2"></i>inter.scitechmaejo@gmail.com</p>
                <p class="mb-0"><i class="bi bi-telephone text-primary me-2"></i>0 5387 3800, 0 5387 3801</p>
            </div>
        </div>
    </div>
</div>

<!-- ส่วนสคริปต์เรียกใช้ Google Maps API -->
<script>
    // ใช้ API Key ที่คุณได้สร้างมา
    const apiKey = 'AIzaSyDEkk98GDmfltntnR9WMsYI7G-b56f2EPs';

    // เรียก Google Maps API
    function initMap() {
        const mapOptions = {
            center: { lat: 18.895918, lng: 99.012985 }, // ตำแหน่งศูนย์กลางแผนที่ (กรุงเทพ)
            zoom: 15, // ระดับการซูม
        };

        // สร้างแผนที่
        const map = new google.maps.Map(document.getElementById('map'), mapOptions);
    }
</script>
<!-- เรียกใช้งาน Google Maps API -->
<script src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap" async defer></script>

<!-- Footer End -->

