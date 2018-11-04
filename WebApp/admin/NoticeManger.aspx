﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeManger.aspx.cs" Inherits="WebApp.admin.NoticeManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Insert title here</title>
<link rel="stylesheet" href="/admin/css/bootstrap.min.css" />
<link rel="stylesheet" href="/admin/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/admin/css/uniform.css" />
<link rel="stylesheet" href="/admin/css/unicorn.main.css" />
<link rel="stylesheet" href="/admin/css/unicorn.grey.css" class="skin-color" />
<script type="text/javascript" src="/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    function modifyNotice(noid, notitle, nocontent, adminid, notime) {
        $("#myModalLabel").html("修改公告");
        $("#noid").val(noid);
        $("#notitle").val(notitle);
        $("#nocontent").val(nocontent);
        $("#adminid").val(adminid);
        $("#notime").val(notime);
    }
    function addNotice()
    {
        $("#myModalLabel1").html("发布公告");
    }
    function publishNotice() {
        $.post("/admin/NoticeAdd.ashx", $("#fm1").serialize(), function (data)//序列化表单值
        {
            if (data) {
                alert("公告发布成功");
                //resetValue(); //清空
                location.reload(true);
            }
            else {
                alert("发布失败");
            }
        }, "text");
    }
    function saveNotice() {
        $.post("/admin/NoticeSave.ashx", $("#fm").serialize(), function (data)//序列化表单值
        {

            if (data) {
                alert("公告修改成功");
                //resetValue(); //清空
                location.reload(true);
            }
            else {
                alert("修改失败");
            }
        }, "text");
    }
    function noticeDelete(NoticeId) {
        if (confirm("确定要删除这条数据吗?")) {
            $.post("/admin/NoticeDelete.ashx", { NoticeId: NoticeId },
                    function (result) {
                        if (result) {
                            alert("删除成功！");
                            window.location.reload(true);

                        } else {
                            alert("删除失败");
                        }
                    }, "text");
        }
    }
    function deleteNotices() {
        var selectedSpan = $(".checked").parent().parent().next("td");
        if (selectedSpan.length == 0) {
            alert("请选择要删除的数据");
            return;
        }
        var strIds = [];
        for (var i=0;i<selectedSpan.length; i++) {
            strIds.push(selectedSpan[i].innerHTML);
        }
        var nids = strIds.join(",");
        if (confirm("你确定要删除这" + selectedSpan.length + "条数据吗")) {
            $.post("/admin/NoticeDelete.ashx", { nids: nids }, function (result) {
                if (result) {
                    alert("删除成功！");
                    location.reload(true);
                }
                else {
                    alert("删除失败");
                }
            }, "text");
        }
        else {
            return;
        }
    }


</script>
</head>
 <%
        if(Session["admin"]==null){
	        Response.Redirect("/admin/Login.aspx");
	        return;
        }
        %>
<body>
	<div id="header">
		<h1 style="margin-left: 0px;padding-left: 0px;"><a href="#">湖北理工学院</a></h1>	
	</div>
	<div id="sidebar">
		<ul>
            <li id="u"><a href="/admin/Main.aspx"><i class="icon icon-home"></i> <span>主界面</span></a></li>
			<li id="userLi"><a href="/admin/UserManger.aspx"><i class="icon icon-home"></i> <span>用户管理</span></a></li>
			<li class="submenu"><a href="#"><i class="icon icon-th-list"></i>
					<span>商品管理</span> <span class="label">3</span></a>
				<ul>
                    <li><a href="/admin/GoodsManger.aspx">商品管理</a></li>
					<li><a href="/admin/BigManger.aspx">商品大类管理</a></li>
					<li><a href="/admin/SmallManger.aspx">商品小类管理</a></li>
				</ul></li>
			<li id="topicLi"><a href="/admin/OrderManger.aspx"><i class="icon icon-home"></i> <span>订单管理</span></a></li>
			 <li><a href="/admin/NoticeManger.aspx"><i class="icon icon-home"></i> <span>公告管理</span></a></li> 
             <li><a href="/admin/TagManger.aspx"><i class="icon icon-home"></i> <span>标签管理</span></a></li> 
            <li><a href="/admin/VoteManger.aspx"><i class="icon icon-home"></i> <span>投票管理</span></a></li> 
			<li id="zoneLi"><a href="/admin/CommentManger.aspx"><i class="icon icon-home"></i> <span>留言管理</span></a></li>
			<li class="submenu"><a href="#"><i class="icon icon-th-list"></i>
					<span>系统管理</span> <span class="label">3</span></a>
				<ul>
					<li><a href="#">修改密码</a></li>
					<li><a href="#">安全退出</a></li>
					<li><a href="#">刷新系统缓存</a></li>
				</ul></li>
		</ul>

	</div>

	<div id="style-switcher">
		<i class="icon-arrow-left icon-white"></i> <span>颜色:</span> 
		<a href="#grey" style="background-color: #555555; border-color: #aaaaaa;"></a> 
		<a href="#blue" style="background-color: #2D2F57;"></a> 
		<a href="#red" style="background-color: #673232;"></a>
	</div>

	<div id="content">
		<div id="content-header">
			<h1>乐易购后台管理</h1>
			<!-- <div class="btn-group">
				<a class="btn btn-large tip-bottom" title="Manage Files"><i
					class="icon-file"></i></a> <a class="btn btn-large tip-bottom"
					title="Manage Users"><i class="icon-user"></i></a> <a
					class="btn btn-large tip-bottom" title="Manage Comments"><i
					class="icon-comment"></i><span class="label label-important">5</span></a>
				<a class="btn btn-large tip-bottom" title="Manage Orders"><i
					class="icon-shopping-cart"></i></a>
			</div> -->
		</div>
		<div id="breadcrumb">
			<a href="#" title="首页" class="tip-bottom">
			<i class="icon-home"></i> 首页</a> 
		</div>
		<%--//主部分--%>
        <div class="container-fluid">
		<div id="tooBar" style="padding: 10px 0px 0px 10px;">
		    <button class="btn btn-primary" type="button" data-backdrop="static" data-toggle="modal" data-target="#dlg1" onclick="return addNotice()">添加公告</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" role="button" class="btn btn-danger" onclick="javascrip:deleteNotices()">批量删除</a>
            <form method="post" action="/admin/NoticeManger.aspx" class ="form-search"  style="display:inline;">
                <input  name="unoname" value="<%=noname%>" id="unoname" type="text" class="input-medium search-query" placeholder="请输入公告标题或内容..."/>
                 &nbsp;
			  <button type="submit" class="btn btn-primary" title="Search">查询&nbsp;<i class="icon  icon-search"></i></button>
            </form>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h5>公告列表</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped with-check">
							<thead>
								<tr>
									<th><i class=""></i></th>
									<th>编号</th>
                                    <th>主题</th>
                                    <th>内容</th>
									<th>发布人</th>
                                    <th>发布时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								 <%foreach(Shop.Model.Notice Notice in noticeList) {%>
									<tr>
										<td><input type="checkbox" /></td>
										<td style="text-align: center;vertical-align: middle;"><%=Notice.noid%></td>
										<td style="text-align: center;vertical-align: middle;"><%=Notice.notitle%></td>
                                        <td style="text-align: center;vertical-align: middle;"><%=Notice.nocontent%></td>
                                        <td style="text-align: center;vertical-align: middle;"><%=Notice.adminid%></td>
										<td style="text-align: center;vertical-align: middle;"><%=Notice.notime %></td>
										<td style="text-align: center;vertical-align: middle;">
											<button class="btn btn-info" type="button" data-backdrop="static" data-toggle="modal" data-target="#dlg"

                                            onclick="return modifyNotice(<%=Notice.noid %>,'<%=Notice.notitle%>','<%=Notice.nocontent%>','<%=Notice.adminid%>','<%=Notice.notime%>')">修改
											</button>&nbsp;&nbsp;<button class="btn btn-danger" type="button" onclick="javascript:noticeDelete(<%=Notice.noid%>)">删除</button>
										</td>
									</tr>
                                <%} %>
							</tbody>
						</table>
					</div>
				</div>
				<div class="pagination alternate">
					<ul class="clearfix"><%=pageCode %>
					</ul>
				</div>


			</div>
		</div>

         <div id="dlg1" class="modal hide fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" onclick="return resetValue()">×</button>
				<h3 id="myModalLabel1">公告</h3>
			</div>
			<div class="modal-body">
				<form id="fm1" action="/admin/NoticeAdd.ashx" method="post">
					<table>
						<tr>
							<td>
								<label class="control-label" for="title">主题：</label>
							</td>
							<td>
								<input id="notitle1" type="text" name="notitle1" placeholder="请输入数据！"/>
							</td>
						</tr>
						<tr>
							<td>
								<label class="control-label" for="contents">内容：</label>
							</td>
							<td>
								<input id="nocontent1" type="text" name="nocontent1" placeholder="请输入数据！"/>
							</td>
						</tr>
						<tr>
							<td>
								<label class="control-label" for="adminname">发布人：</label>
							</td>
							<td>
								<input id="adminid1" type="text" name="adminid1" value="<%=((Shop.Model.Admin)Session["admin"]).adminid %>" disabled="disabled" placeholder="请输入数据！"/>
							</td>
						</tr>	
						<tr>
							<td>
								<label class="control-label" for="putime">发布时间：</label>
							</td>
							<td>
								<input id="notime1" type="text" name="notime1" value="<%=DateTime.Now %>" placeholder="导入数据失败！"/>
							</td>
						</tr>
					</table>
					<input id="noid1" type="hidden" name="noid1"/>
				</form>
			</div>
			<div class="modal-footer">
				<font id="error1" style="color: red;"></font>
				<button class="btn" data-dismiss="modal" aria-hidden="true"
					onclick="return resetValue()">关闭</button>
				<button class="btn btn-primary" onclick="javascript:publishNotice()">保存</button>
			</div>
		</div>

		<div id="dlg" class="modal hide fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" onclick="return resetValue()">×</button>
				<h3 id="myModalLabel">修改公告</h3>
			</div>
			<div class="modal-body">
				<form id="fm" action="/admin/NoticeSave.ashx" method="post">
					<table>
						<tr>
							<td>
								<label class="control-label" for="title">主题：</label>
							</td>
							<td>
								<input id="notitle" type="text" name="notitle" placeholder="导入数据失败！"/>
							</td>
						</tr>
						<tr>
							<td>
								<label class="control-label" for="contents">内容：</label>
							</td>
							<td>
								<input id="nocontent" type="text" name="nocontent" placeholder="导入数据失败！"/>
							</td>
						</tr>
						<tr>
							<td>
								<label class="control-label" for="adminname">发布人：</label>
							</td>
							<td>
								<input id="adminid" type="text" name="adminid" disabled="disabled" placeholder="导入数据失败！"/>
							</td>
						</tr>
						<%--<tr>
							<td>
								<label class="control-label" for="headphoto">头像：</label>
							</td>
							
							<td>
								<img id="ImgPr" class="pull-left" style="width: 120px; height: 120px;" />
							</td>
						</tr>--%>
                        
							
						<tr>
							<td>
								<label class="control-label" for="putime">发布时间：</label>
							</td>
							<td>
								<input id="notime" type="text" name="notime" disabled="disabled" placeholder="导入数据失败！"/>
							</td>
						</tr>
					</table>
					<input id="noid" type="hidden" name="noid"/>
				</form>
			</div>
			<div class="modal-footer">
				<font id="error" style="color: red;"></font>
				<button class="btn" data-dismiss="modal" aria-hidden="true"
					onclick="return resetValue()">关闭</button>
				<button class="btn btn-primary" onclick="javascript:saveNotice()">保存</button>
			</div>
		</div>
	</div>
		<div class="row-fluid">
			<div id="footer" class="span12">
				2018 &copy;  作者：计算机学院毕设&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://www.hbpu.edu.cn/">湖北理工学院</a>
			</div>
		</div>
	</div>

<script src="/admin/js/jquery.min.js"></script>
<script src="/admin/js/jquery.ui.custom.js"></script>
<script src="/admin/js/bootstrap.min.js"></script>
<script src="/admin/js/jquery.uniform.js"></script>
<!-- <script src="js/select2.min.js"></script> -->
<script src="/admin/js/jquery.dataTables.min.js"></script>
<script src="/admin/js/unicorn.js"></script>
<script src="/admin/js/unicorn.tables.js"></script>
<script type="text/javascript" src="/js/uploadPreview.min.js"></script>
</body>
</html>