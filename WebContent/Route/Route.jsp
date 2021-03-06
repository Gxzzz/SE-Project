<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/my_navbar.css" />
<title>展示路线</title>

</head>

<body>
  <s:bean name="Bean.CheckNewMessage" var="checknewmessage"></s:bean>
  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand brand-lg" href="<%=request.getContextPath() %>/index.jsp">驴吧</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li><a href="<%=request.getContextPath() %>/index.jsp">首页</a></li>
        <li><a href="<%=request.getContextPath() %>/Schemes/NewScheme.jsp">寻找旅伴</a></li>
        <li><a href="<%=request.getContextPath() %>/PersonalSpace/PersonalSpace.jsp">个人中心</a></li>
        <li class="dropdown">
          <a href="" class="dropdown-toggle" data-toggle="dropdown">旅游小组<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath() %>/Groups/AllGroups.jsp">所有小组</a></li>
            <li><a href="<%=request.getContextPath() %>/Groups/NewGroup.jsp">创建小组</a></li>
            <li><a href="<%=request.getContextPath() %>/Groups/MyGroups.jsp">我的小组</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">出行攻略<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="allTravelNotes">查看所有攻略</a></li>
            <li><a href="<%=request.getContextPath() %>/travelNotes/editTravelNotes.jsp">写攻略</a></li>
          </ul>
        </li>
        <s:if test="%{#checknewmessage.messageNumber==0}">  
        <li><a href="<%=request.getContextPath() %>/Other/Message.jsp">通知</a></li>
        </s:if>
        <s:else>
        <li><a href="<%=request.getContextPath() %>/Other/Message.jsp">通知(${checknewmessage.messageNumber})</a></li>
        </s:else>
        <li class="dropdown">
          <a href="" class="dropdown-toggle" data-toggle="dropdown">私信<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath() %>/Privateletter/ReceivedPrivateletter.jsp">收信箱</a></li>
            <li><a href="<%=request.getContextPath() %>/Privateletter/SendedPrivateletter.jsp">已发送</a></li>
            <li><a href="<%=request.getContextPath() %>/Privateletter/SendPrivateletter.jsp">发私信</a></li>
          </ul>
        </li>
        <li class="active"><a href="<%=request.getContextPath() %>/Route/Route.jsp">路线推荐</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <% ActionContext ac=ActionContext.getContext();
          Map<String, Object> session1=ac.getSession();
          if(session1.containsKey("username")){
        %>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <s:property value="#session.username"/>
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath() %>/PersonalSpace/PerfectInformation.jsp">个人中心</a></li>
            <li><a href="#">消息</a></li>
            <li><a href="Logout.action">退出</a></li>
          </ul>
        </li>
        <%}else{ %>
        <li><a data-toggle="modal" data-target="#login" href=""> <span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
        <li><a href="<%=request.getContextPath() %>/Other/Register.jsp"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
        <%} %>
      </ul>

    </div>
  </div>
  </nav>
  <div class="container">
    <div style="padding: 5px" class="page-header">
    </div>
    <table>
      <thead>
        <tr>
        <th><label for="s">起点</label></th>
        <th style="width: 10px;"></th>
        <th><input id="s" type="text" class="form-control" name="s" style="height: 33px; width: 200px" required /></th>
        <th style="width: 50px;"></th>
        <th><label for="e">终点</label></th>
        <th style="width: 10px;"></th>
        <th><input id="e" type="text" class="form-control" name="e" style="height: 33px; width: 200px" required /></th>
        <th style="width: 50px;"></th>
        <th><label for="m">出行方式</label></th>
        <th style="width: 10px;"></th>
        <th><select id="m" class="form-control" name="m" style="height: 33px; width: 200px" required>
            <option value=0>驾车</option>
            <option value=1>公交</option>
            <option value=2>步行</option>
        </select></th>
        <th style="width: 50px;"></th>
        <th><button class="btn btn-primary" onclick="ShowRoute2()">查询</button></th>
        </tr>
      </thead>
    </table>
    <br/>
    <div class="container">
      <div id="container2" style="margin: 0 auto; width: auto; height: 500px"></div>
    </div>
    <br/>
    <div class="container">
      <div id="panel"></div>
    </div>
  </div>
  <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=Humudg8I39n6YPBWjlXvsLLnrZzQgncY"></script>
  <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/moment-with-locales.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.zh-CN.js"></script>
  <script type="text/javascript" language="javascript">
      var map = new BMap.Map("container2");
      map.centerAndZoom("北京", 12);
      function ShowRoute2() {
        map.clearOverlays();//清空原来的标注
        var start = $("#s").val();
        var end = $("#e").val();
        var mean = $("#m").val();
        var driving;
        if (mean == '0') {
          driving = new BMap.DrivingRoute(map, {
            renderOptions : {
              map : map,
              panel : "panel"
            }
          });
          driving.search(start, end);
        } else if (mean == '1') {
          driving = new BMap.TransitRoute(map, {
            renderOptions : {
              map : map,
              panel : "panel"
            }
          });
          driving.search(start, end);
        } else if (mean == '2') {
          driving = new BMap.WalkingRoute(map, {
            renderOptions : {
              map : map,
              panel : "panel"
            }
          });
          driving.search(start, end);
        }
      }
    </script>
  <script type="text/javascript">
    $(document).ready(function() {
      $("#LoginButton").bind("click", function() {
        if ($("#username").val != "") {
          $.ajax({
            async: false,
            type: "post",
            url: "Login.action",
            data: {
              username: $("#username").val(),
              password: $("#password").val()
            },
            dataType: "json",
            success: function(data) {
              var d = eval("(" + data + ")");
              if (d.LoginResult == 1) {
                location.reload();
              }
              else if (d.LoginResult == 2) {
                $("LoginError").html("密码错误!");
                alert("密码错误!");
              }
            },
            error: function() {
              alert("系统异常，请稍后再试");
            }
          });
        }
      });
    });
  </script>
</body>

</html>
