<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/time/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/my_navbar.css" />
<title>小组管理</title>
<style>
.table th, .table td {
  text-align: center;
  vertical-align: middle !important;
}
</style>
</head>

<body>
  <s:bean name="Bean.ManageGroup" var="content"></s:bean>
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
        <li class="dropdown active">
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
              <label for="username">用户名</label>
              <input class="form-control" type="text" name="username" id="username" required>
            </div>
            <div class="form-group">
              <label for="password">密码</label>
              <input class="form-control" type="password" name="password" id="password" required>
              <label id="LoginError"></label>
            </div>
            <div class="text-right">
              <button class="btn btn-primary" id="LoginButton">登录</button>
              <button class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
            <a href="<%=request.getContextPath() %>/Other/Register.jsp">还没有账号？点我注册</a>
          </form>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <div style="padding: 5px" class="page-header">
      <h1 style="font-size: 2em">小组管理</h1>
    </div>
    <div class="row"></div>


    <div class="panel-group col-sm-8" id="accordion">
      <div class="panel panel-info">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#GroupInfo"> 小组信息管理</a>
          </h4>
        </div>

        <div id="GroupInfo" class="panel-collapse collapse">
          <div class="panel-body">
            <form class="form-horizontal" role="form" method="post">
              <input type="hidden" id="groupid" name="groupid" value="<s:property value="#parameters.groupid"/>" />
              <div class="form-group">
                <label for="groupname" class="col-sm-2 control-label">组名</label>
                <div class="col-sm-4">
                  <input type="text" class="form-control" name="groupname" style="height:33px; width:210px"
                   value="<s:property value="#content.group.groupname" />" required />
                </div>
              </div>

              <!-- 出发地 -->
              <div class="form-group">
                <label class="col-sm-2 control-label">出发地</label>
                <div class="col-sm-4">
                  <label for="departureprovince"></label>
                  <select class="form-control" id="departureprovince" name="departureprovince" style="height:33px; width:210px" required></select>
                </div>
                <div class="col-sm-4">
                  <label for="departurecity"></label>
                  <select class="form-control" id="departurecity" name="departurecity" style="height:33px; width:210px" required></select>
                </div>
              </div>

              <!-- 目的地 -->
              <div class="form-group">
                <label class="col-sm-2 control-label">目的地</label>
                <div class="col-sm-4">
                  <label for="destprovince"></label>
                  <select class="form-control" id="destprovince" name="destprovince" style="height:33px; width:210px" required></select>
                </div>
                <div class="col-sm-4">
                  <label for="destcity"></label>
                  <select class="form-control" id="destcity" name="destcity" style="height:33px; width:210px" required></select>
                </div>
              </div>


              <div class="form-group">
                <label for="begindate" class="col-sm-2 control-label">出发日期</label>
                <div class="col-sm-4">
                  <div class='input-group date' id='datetimepicker'>
                    <input type="text" class="form-control" name="begindate" style="height:33px; width:210px"
                     value="<s:property value="#content.group.begindate"/>" required>
                    <span class="input-group-addon">
                      <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label for="maxmembercount" class="col-sm-2 control-label">人数上限</label>
                <div class="col-sm-4">
                  <input class="input" type="number" min="<s:property value="#content.group.membercount"/>" step="1" max="1000"
                  name="maxmembercount" style="height:33px; width:210px" pattern="^[0-9]*[1-9][0-9]*$"
                  value="<s:property value="#content.group.maxmembercount"/>" required />
                </div>
              </div>

              <!-- 按钮 -->
              <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-2">
                  <button id="ReviseGroupInfoButton" class="btn btn-block">提交</button>
                </div>
                <div class="col-sm-1"></div>
                <div class="col-sm-2">
                  <button type="reset" class="btn btn-block">重置</button>
                </div>
              </div>
            </form>

          </div>
        </div>
      </div>

      <div class="panel panel-info">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#GroupMembers"> 小组成员管理</a>
          </h4>
        </div>
        <div id="GroupMembers" class="panel-collapse collapse">
          <div class="panel-body">
            <ul>
              <li style="height: 33px"><s:property value="#session.username" />
                <button type="submit" class="btn btn-primary pull-right btn-sm disabled">请他/她离开</button></li>
              <s:iterator value="%{#content.users}" var="u">
                <s:if test="%{#u.username!=#session.username}">
                  <li style="height: 33px">
                    <form action="QuitGroup" method="post">
                      <s:a href="OtherSpace.action?username=%{#u.username}"><s:property value="#u.username" /></s:a>
                      <input type="hidden" name="groupid" value="<s:property value="#parameters.groupid"/>"/>
                      <input type="hidden" name="username" value="<s:property value="#u.username"/>"/>
                      <input type="hidden" name="managername" value="<s:property value="#session.username"/>"/>
                      <button type="submit" class="btn btn-primary pull-right btn-sm">请他/她离开</button>
                    </form>
                  </li>
                </s:if>
              </s:iterator>
            </ul>
          </div>
        </div>

      </div>
      <div class="col-sm-1"></div>
      <s:if test="%{#content.group.completed==0}">
      <div class="col-sm-2">
        <button id="EndTravelButton" class="btn btn-block">结束行程</button>
      </div>
      </s:if>
      <s:else>
        <button id="EndTravelButton" class="btn btn-block" disabled="disabled">行程已结束</button>
      </s:else>
    </div>
  </div>
  <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/moment-with-locales.js"></script>
  <script src="<%=request.getContextPath()%>/js/time/bootstrap-datetimepicker.zh-CN.js"></script>
  <script src="<%=request.getContextPath()%>/js/provincecity.js"></script>
  <script type="text/javascript">
      $(function() {
        $('#GroupInfo').collapse('toggle')
      })
      $(function() {
        $('#GroupMembers').collapse('toggle')
      })
  </script>
  <script type="text/javascript">
      $(function() {
        $('#datetimepicker').datetimepicker({
          language : 'zh-CN',
          format : 'yyyy-mm-dd',
          minView : "month",
          locale : moment.locale('zh-cn')
        });
      });
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
  <script type="text/javascript">
    $(document).ready(function() {
      $("#ReviseGroupInfoButton").bind("click", function() {
        var submitdata = $("form").serialize();
        submitdata = decodeURIComponent(submitdata, true);
        submitdata = encodeURI(encodeURI(submitdata));
        $.ajax({
          async: false,
          type: "post",
          url: "UpdateGroup.action",
          data: submitdata,
          dataType: "json",
          success:function(data) {
            var d = eval("(" + data + ")");
            if (d.success == "true") {
              alert("修改成功");
              location.reload();
            } else {
              window.alert("修改失败，请稍后再试");
            }
          },
          error:function() {
            window.alert("系统异常，请稍后重试");
          }
        });
      });
    });
  </script>
  
  <script type="text/javascript">
    $(function() {
      $("#EndTravelButton").bind("click", function() {
        $.ajax({
          async: false,
          type: "post",
          url: "EndTravel.action",
          data: {
              groupid: $("#groupid").val()
            },
          dataType: "json",
          success:function(data) {
            var d = eval("(" + data + ")");
            if (d.success == "true") {
              alert("结束成功");
              location.reload();
            } else {
              window.alert("结束失败，请稍后再试");
            }
          },
          error:function() {
            window.alert("系统异常，请稍后重试");
          }
        });
      });
    });
  </script>
  
  <script type="text/javascript">
    $(function() {
      CreateProvinceCity('departureprovince', 'departurecity');
      CreateProvinceCity('destprovince', 'destcity');
    });
  </script>
  <script type="text/javascript">
    $(function() {
      SetProvinceCityValue('destprovince', 'destcity',
      '<s:property value="#content.group.destprovince" />',
      '<s:property value="#content.group.destcity" />');
      SetProvinceCityValue('departureprovince', 'departurecity', 
      '<s:property value="#content.group.departureprovince" />',
      '<s:property value="#content.group.departurecity" />');
    });
  </script>
</body>

</html>
