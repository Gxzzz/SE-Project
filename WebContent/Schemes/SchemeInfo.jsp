<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/time/bootstrap-datetimepicker.min.css" />
<title>驴吧</title>
</head>

<body>
  <s:bean name="Bean.CheckLoginState" var="checkloginstate"></s:bean>
  <s:bean name="Bean.MyGroups" var="mygroups"></s:bean>
  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand brand-lg" href="<%=request.getContextPath()%>/index.jsp">驴吧</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li><a href="<%=request.getContextPath()%>/index.jsp">首页</a></li>
        <li><a href="#">寻找旅伴</a></li>
        <li><a href="#">个人中心</a></li>
        <li class="dropdown"><a href="" class="dropdown-toggle" data-toggle="dropdown">旅游小组<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath()%>/Groups/AllGroups.jsp">所有小组</a></li>
            <li><a href="<%=request.getContextPath()%>/Groups/NewGroup.jsp">创建小组</a></li>
            <li><a href="<%=request.getContextPath()%>/Groups/MyGroups.jsp">我的小组</a></li>
          </ul></li>
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 出行攻略 <b class="caret"></b>
        </a>
          <ul class="dropdown-menu">
            <li><a href="allTravelNotes">查看所有攻略</a></li>
            <li><a href="<%=request.getContextPath()%>/travelNotes/editTravelNotes.jsp">写攻略</a></li>
          </ul></li>
        <li><a href="#">通知</a></li>
        <li class="dropdown"><a href="" class="dropdown-toggle" data-toggle="dropdown">私信<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath()%>/Privateletter/ReceivedPrivateletter.jsp">收信箱</a></li>
            <li><a href="<%=request.getContextPath()%>/Privateletter/SendedPrivateletter.jsp">已发送</a></li>
            <li><a href="<%=request.getContextPath()%>/Privateletter/SendPrivateletter.jsp">发私信</a></li>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <%
            ActionContext ac = ActionContext.getContext();
              Map<String, Object> session1 = ac.getSession();
              if (session1.containsKey("username")) {
        %>
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"> <s:property value="#session.username" /> <b class="caret"></b>
        </a>
          <ul class="dropdown-menu">
            <li><a href="<%=request.getContextPath()%>/PersonalSpace/PerfectInformation.jsp">个人中心</a></li>
            <li><a href="#">消息</a></li>
            <li><a href="Logout.action">退出</a></li>
          </ul></li>
        <%
            } else {
        %>
        <li><a data-toggle="modal" data-target="#login" href=""> <span class="glyphicon glyphicon-log-in"></span> 登录
        </a></li>
        <li><a href="<%=request.getContextPath()%>/Other/Register.jsp"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
        <%
            }
        %>
      </ul>

    </div>
  </div>
  </nav>

  <!-- 登陆模态框 -->
  <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <button class="close" data-dismiss="modal">
            <span>&times;</span>
          </button>
          <div class="modal-title">
            <h2 class="text-center">登录</h2>
          </div>
          <form class="form-group" method="post">
            <div class="form-group">
              <label for="username">用户名</label> <input class="form-control" type="text" id="username" required>
            </div>
            <div class="form-group">
              <label for="password">密码</label> <input class="form-control" type="password" id="password" required>
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

  <s:bean name="Bean.SchemeInfo" var="schemeinfo"></s:bean>
  <div class="container">
    <div style="padding: 5px" class="page-header"></div>
    <div class="panel panel-primary">
      <div class="panel-heading">
        帖子信息
      </div>
      <div class="panel-body">
        <div class="row">
          <div class="col-sm-2">标题:</div>
          <div class="col-sm-5"><s:property value="#schemeinfo.scheme.schemeTitle" /></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">小组:</div>
          <div class="col-sm-5">
            <s:a href="GroupInfo.action?groupid=%{#schemeinfo.group.groupid}">
              <s:property value="#schemeinfo.group.groupname" />
            </s:a>
          </div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">出发地:</div>
          <div class="col-sm-5"><s:property value="#schemeinfo.scheme.departureprovince" /> <s:property value="#schemeinfo.scheme.departurecity" /></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">目的地:</div>
          <div class="col-sm-5"><s:property value="#schemeinfo.scheme.destprovince" /> <s:property value="#schemeinfo.scheme.destcity" /></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">出发日期:</div>
          <div class="col-sm-5"><s:property value="#schemeinfo.scheme.beginDate" /></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">持续时间:</div>
          <div class="col-sm-5" id="duration"></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">预计开支:</div>
          <div class="col-sm-5" id="expenses"></div>
        </div>
        <hr/>
        <div class="row">
          <div class="col-sm-2">更多介绍:</div>
          <div class="col-sm-5"><s:property value="#schemeinfo.scheme.description" /></div>
        </div>
      </div>
    </div>
  </div>

  <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      $("#LoginButton").bind("click", function() {
        if ($("#username").val != "") {
          $.ajax({
            async: false,
            type : "post",
            url : "Login.action",
            data : {
              username : $("#username").val(),
              password : $("#password").val()
            },
            dataType : "json",
            success : function(data) {
              var d = eval("(" + data + ")");
              if (d.LoginResult == 1) {
                location.reload();
              } else if (d.LoginResult == 2) {
                $("LoginError").html("密码错误!");
                alert("密码错误!");
              }
            },
            error : function() {
              alert("系统异常，请稍后再试");
            }
          });
        }
      });
    });
  </script>
  <script type="text/javascript">
    $(function() {
      var duration;
      switch(parseInt('<s:property value="#schemeinfo.scheme.duration" />')) {
        case 1: duration = "1 - 3天"; break;
        case 2: duration = "4 - 7天"; break;
        case 3: duration = "7天以上"; break;
      }
      document.getElementById("duration").innerHTML = duration;
    });
  </script>
  <script type="text/javascript">
    $(function() {
      var expenses;
      switch(parseInt('<s:property value="#schemeinfo.scheme.expenses" />')) {
        case 1: expenses = "0 - 500"; break;
        case 2: expenses = "500 - 1000"; break;
        case 3: expenses = "1000 - 2000"; break;
        case 4: expenses = "2000以上"; break;
      }
      document.getElementById("expenses").innerHTML = expenses;
    });
  </script>  
</body>

</html>