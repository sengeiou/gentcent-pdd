<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle res = ResourceBundle.getBundle("11erp");
%>
<!DOCTYPE html>
<html>

<head>
	<base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>红包列表</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.minb16a.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/plugins/sweetalert/sweetalert.css">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <script type="text/javascript" src="manager/js/jquery.js"></script>
    <style type="text/css">
    	.qrcodeIcon {
		    background-image: url("images/ermIcon.png?v=201507271756");
		    background-position: 11px 10px;
		    background-repeat: no-repeat;
		    display: inline-block;
		    height: 25px;
		    width: 33px;
		}
		.qrcodeBox {
		    background-color: #fff;
		    border: 1px solid #cfcfcf;
		    border-radius: 4px;
		    height: 150px;
		    left: 80px;
		    margin-top: -58px;
		    padding: 5px;
		    position: absolute;
		    width: 150px;
		    z-index: 1000;
		}
    </style>
	<script type="text/javascript">
	function showImg(index){
		document.getElementById("wxImg"+index).style.display='block';
	}
	function hideImg(index){
		document.getElementById("wxImg"+index).style.display='none';
	}
	
	</script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                   <div class="ibox-content">
						<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline" >
							<form action="redAlterable/lool" method="post" >
								<input type="hidden" name="_method" value="put" />
								<input type="hidden" name="id" value="${activity.id}">
								<div class="row" style="width: 100%;height:40px">
	                           	     <div class="col-sm-3" style="width: 34%" id="sear"> 
										<div class="dataTables_length" id="DataTables_Table_0_filter" >
											<label>
												查找：
					                        	<input type="text"  name="code" placeholder="根据红包码查询">
					                        	<input type="button" onclick="query()" class="btn btn-sm btn-primary" value="搜索"> 
											</label>
										</div>
										<div style="margin-left: 200%;margin-top: -36px;width: 60%">
											<a href="${basePath }redAlterable/look?id=${rae.id }&&noUse=no"><button class="btn btn-primary" type="button">未使用红包</button></a>
											<button onclick="shuaxin()"  class="btn btn-primary" type="button" >开启自动刷新</button>
										</div>
									</div>
									<span style="color:red;float:right;">ps:为避免出现跳码的情况，请开启自动刷新！</span>
               				  </form>
							</div>
						</div>
	                      <table class="table table-striped table-bordered table-hover dataTables-example" id="editable" style="table-layout:fixed;">
	                            <thead class="pn-lthead">
	                                <tr >
	                                	<th style="width: 5%">二维码</th>
	                                	<th>序号</th>
                                    	<th>金额</th>
                                    	<th>领取状态</th>    
                                    	<th>领取时间</th>                              
	                                </tr>
	                            </thead>
	                            <tbody id="user" style="height: 10%">
	                            	<c:forEach items="${list}" var="items" varStatus="status">
	                            		<tr  <c:if test="${items.status==1 }">style="color: green;"</c:if> <c:if test="${items.status==2 }">style="color: red;"</c:if> >
		                            		<td>
			                                	<div class="qrcodeIcon" _style="16" _id="5" onMouseOut="hideImg('${status.index }')"  onmouseover="showImg('${status.index }')"></div>
			                                    <div class="qrcodeBox" style="display: none;" id="wxImg${status.index }">
			                                    	<div class="inIcon"></div>
													<img alt="Wxmenu" src="wresource/url?url=<%=res.getString("project.host")%>/item/${items.id }" style="height:100%;width:100%;">
												</div>
                            				</td>
		                            		<td>
		                            			${items.code }
		                            		</td>
		                            		<td>
		                            			${items.money}
		                            		</td>
		                            		<td id="status">
		                            		<c:if test="${items.status==1 }">
												未领取
											</c:if>
											<c:if test="${items.status==2 }">
												已领取
											</c:if>
		                            		</td>
		                            		<td>
		                            			${items.overTime}
		                            		</td>
	                            		</tr>
	                            	</c:forEach>
	                            </tbody>
	                        </table>
	                         <div method="post" id="tableForm">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                        <tbody>
		                            <tr>
		                                <td align="center" class="pn-sp">
		                                    <form id="paging" action="redAlterable/look" method="get">
		                                      <input type="hidden" name="id" value="${rae.id}">
		                                      <input type="hidden" name="noUse" value="${noUse}">
		                                        <%@include file="paging.jsp" %>
		                                    </form>
		                                </td>
		                            </tr>
		                        </tbody>
		                    </table>
	                  	</div>	
                    </div>
                </div>
            </div>
    </div>
    <script src="js/jquery.min63b9.js"></script>
    <script src="js/layer/layer.js"></script>
    <script type="text/javascript" src="js/childrenToMenu.js"></script>
    <script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
    <script type="text/javascript" src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="js/mui.min.js"></script>
</body>
<script>
	function query(){
			var id = '${rae.id}';
			var code = $.trim($("input[name='code']").val());
			window.location.href="redAlterable/look?code="+code+"&&id="+id;
		}
	function shuaxin(){
		var id = "${rae.id}";
		$.ajax({
			url:'redAlterable/shua_huo',
			type:"post",
			data:{
				id:id
			},
			success:function(data){
				layer.alert("刷新成功，自动刷新只会维持3个小时！");
			}
		});
	}
</script>
</html>
