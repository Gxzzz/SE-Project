<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/my_navbar.css" />
<title>发送私信</title>
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
        <li class="dropdown active">
          <a href="" class="dropdown-toggle" data-toggle="dropdown">私信<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath() %>/Privateletter/ReceivedPrivateletter.jsp">收信箱</a></li>
            <li><a href="<%=request.getContextPath() %>/Privateletter/SendedPrivateletter.jsp">已发送</a></li>
            <li><a href="<%=request.getContextPath() %>/Privateletter/SendPrivateletter.jsp">发私信</a></li>
          </ul>
        </li>
        <li><a href="<%=request.getContextPath() %>/Route/Route.jsp">路线推荐</a></li>
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

  <!-- 登陆模态框 -->
  <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <button class="close" data-dismiss="modal" id="CloseLoginModal">
            <span>&times;</span>
          </button>
          <div class="modal-title">
            <h2 class="text-center">登录</h2>
          </div>
          <form class="form-group" method="post">
            <div class="form-group">
              <label for="username">用户名</label> <input class="form-control" type="text" name="username" id="username" required>
            </div>
            <div class="form-group">
              <label for="password">密码</label> <input class="form-control" type="password" name="password" id="password" required> <label id="LoginError"></label>
            </div>
            <div class="text-right">
              <button class="btn btn-primary" id="LoginButton">登录</button>
              <button class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
            <a href="<%=request.getContextPath()%>/Other/Register.jsp">还没有账号？点我注册</a>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <div style="padding: 5px" class="page-header">
      <h1 style="font-size: 2em">发送私信</h1>
    </div>

    <s:bean name="Bean.CheckLoginState" var="checkloginstate"></s:bean>
    <s:if test="%{#checkloginstate.loggedin==false}">
      <div style="font-size: 110%">
        <p>您尚未登录</p>
        <ul>
          <li><a data-toggle="modal" data-target="#login" href=""> 登录</a></li>
          <li><a href="<%=request.getContextPath() %>/Other/Register.jsp">还没有账号？点击此处注册</a></li>
          <li><a href="<%=request.getContextPath() %>/index.jsp">再看看</a></li>
        </ul>
      </div>
    </s:if>
    <s:else>
      <form class="form-horizontal" role="form" method="post">
        <div class="form-group">
          <label for="privateletterTitle" class="col-lg-1 control-label">标题</label>
          <div class="col-lg-3">
            <input type="text" class="form-control" name="privateletterTitle" id="privateletterTitle" placeholder="请输入标题" required />
          </div>
        </div>

        <div class="form-group">
          <label for="receiver" class="col-lg-1 control-label">收件人</label>
          <div class="col-lg-3">
            <input type="text" class="form-control" name="receiver" id="receiver" placeholder="请输入收件人" required>
          </div>
        </div>

        <div class="form-group">
          <label for="content" class="col-lg-1 control-label">私信内容</label>
          <div class="col-lg-5">
            <textarea class="form-control" rows="3" name="content" id="content"></textarea>
          </div>
        </div>

        <!-- 按钮 -->
        <div class="row">
          <div class="col-lg-1"></div>
          <div class="col-lg-1">
            <button onclick="sendprivateletter()" class="btn btn-block">发送</button>
          </div>
          <div class="col-lg-1"></div>
          <div class="col-lg-1">
            <button type="reset" class="btn btn-block">重置</button>
          </div>
        </div>
      </form>
    </s:else>

  <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/moment-with-locales.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.zh-CN.js"></script>
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
  <script type="text/javascript" language="javascript">
    function sendprivateletter() {
      var submitdata = $("form").serialize();
      submitdata = decodeURIComponent(submitdata, true);
      submitdata = encodeURI(encodeURI(submitdata));
      $.ajax({
        async: false,
        type: "post",
        url: "SendPrivateLetter.action",
        data: submitdata,
        dataType: "json",
        success : function(data) {
          var d = eval("(" + data + ")");
          if (d.SendResult == 'success') {
            alert("发送成功");
          }
          else if (d.SendResult == 'error') {
            alert("收件人不存在");
          }
        },
        error : function() {
          alert("系统异常，请稍后再试");
        }
      });
    }
  </script>
</body>
</html>
