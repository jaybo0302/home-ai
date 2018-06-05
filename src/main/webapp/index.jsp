<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css"  media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/en.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<div class="layui-fluid">
    <span style="font-size: 50px;font-weight: bold">环境监测信息</span><br/>
    <span style="font-size: 20px;font-weight: bold">更新时间：</span>
    <span style="font-size: 20px;font-weight: bold" id="updateTime">2018-05-16 09:29:54</span>
    <div class="layui-row" style="margin-top: 10px">
        <div class="layui-col-md2">
            <div class="en_windVelocity">
                <img src="${pageContext.request.contextPath}/images/windVelocity.png" style="height: 128px;margin-top: 5px;margin-left: 10px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>风速：</label><span id="windVelocity">1.411</span><label>m/s</label>
                </div>
            </div>
        </div>
        <div class="layui-col-md2">
            <div class="en_direction">
                <img src="${pageContext.request.contextPath}/images/direction.png" style="height: 128px;margin-top: 5px;margin-left: 40px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>风向：</label><span id="direction">东北</span>
                </div>
            </div>
        </div>
        <%--<div class="layui-col-md1">
            <div class="en_pm100"><img src="/images/pm100.png" style="height: 80px;margin-top: 5px;margin-left: 22px"/>pm100</div>
        </div>--%>
        <div class="layui-col-md2">
            <div class="en_pm10">
                <img src="${pageContext.request.contextPath}/images/pm10.png" style="height: 128px;margin-top: 5px;margin-left: 22px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>PM10：</label><span id="pm10">538</span><label>ug/m<sup>3</sup></label>
                </div>
            </div>
        </div>
        <div class="layui-col-md2">
            <div class="en_pm25">
                <img src="${pageContext.request.contextPath}/images/pm25.png" style="height: 128px;margin-top: 5px;margin-left: 22px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>PM2.5：</label><span id="pm25">456</span><label>ug/m<sup>3</sup></label>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-row" style="margin-top: 2px">
        <div class="layui-col-md2">
            <div class="en_temperature">
                <img src="${pageContext.request.contextPath}/images/temperature.png" style="height: 128px;margin-top: 5px;margin-left: 20px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>温度：</label><span id="temperature">1.4</span><label>&#176;C</label>
                </div>
            </div>
        </div>
        <div class="layui-col-md2">
            <div class="en_dampness">
                <img src="${pageContext.request.contextPath}/images/dampness.png" style="height: 128px;margin-top: 5px;margin-left: 25px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>湿度：</label><span id="dampness">100</span><label>%RH</label>
                </div>
            </div>
        </div>
        <div class="layui-col-md2">
            <div class="en_noise">
                <img src="${pageContext.request.contextPath}/images/noise.png" style="height: 128px;margin-top: 5px;margin-left: 25px"/>
                <div style="margin-top: 80px;font-size: 30px;text-align: center">
                    <label>噪声：</label><span id="noise">1.4</span><label>dB</label>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js" charset="utf-8"></script>
<script>
    $(document).ready(function(){
        //进入页面，去拿数据，然后赋值；
        getdata();
    });
    function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
        h = date.getHours() + ':';
        m = date.getMinutes() + ':';
        s = date.getSeconds();
        return Y+M+D+h+m+s;
    }
    var int = self.setInterval("getdata()", 300 * 1000);
    function getdata(){
        $.ajax({
            type : "get",
            url : "en_monitor/index.do",
            async : false,
            success:function(data){
                $("#windVelocity").text(data.windVelocity/10);
                $("#direction").text(data.direction);
                $("#pm10").text(data.pm10);
                $("#pm25").text(data.pm25);
                $("#dampness").text(data.dampness);
                $("#temperature").text(data.temperature/10);
                $("#noise").text(data.noise/10);
                $("#updateTime").text(timestampToTime(data.createTime));
            }
        });
    }
</script>
</body>
</html>