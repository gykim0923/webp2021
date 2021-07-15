<%--
  Created by IntelliJ IDEA.
  User: Gabriel Yoon
  Date: 2021-07-15
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #map{
        height: 1000px;
    }
</style>
<div class="row">
    <div class="col-12 py-5">
        <h3><strong>주소 및 연락처</strong></h3>
        <div>DB로 연동?</div>
    </div>
    <hr>
    <div class="col-12 py-5">
        <h3><strong>오시는 길</strong></h3>
        <div id="map"></div>
        <script>
            function initMap() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 37.3007218, lng: 127.0392770},
                    zoom: 16
                });
                var marker = new google.maps.Marker({
                    position: {lat: 37.3007218, lng: 127.0392770},
                    map: map
                });
            }

        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBqeRrYz4_XJFY_vA9aqDbIiuU_Zs5odVA&callback=initMap"
                async defer></script>
        <div>DB로 오는 길 연동?</div>
    </div>

</div>
