﻿<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/checklogin.jsp"%>
<%
	String menue = request.getParameter("menue");
	if (menue != null && menue.trim().length() > 0) {
		request.getSession().setAttribute("menue", menue);
		String menue2 = request.getParameter("menue2");
		request.getSession().setAttribute("menue2", menue + menue2);

	}
%>

<div id="sidebar">
	<c:choose>
		<c:when test="${(sessionScope.company.type==2)}">
			<!-- 超级用户 -->
			<ul>
				<li
					<c:if test="${sessionScope.menue=='manager'}">class="active"</c:if>>
					<a><i class="icon icon-th"></i> <span>系统管理员</span> </a></li>
				<li
					<c:if test="${sessionScope.menue=='company'}">class="active"</c:if>>
					<a href="${ctx}/pages/companyManagerList.jsp?menue=company"> <i
						class="icon icon-fullscreen"></i> <span>企业管理</span> </a>
				</li>
				<li
					<c:if test="${sessionScope.menue=='companyAccount'}">class="active"</c:if>>
					<a
					href="${ctx}/pages/companyAccountManagerList.jsp?menue=companyAccount">
						<i class="icon icon-pencil"></i> <span>企业帐号管理</span> </a>
				</li>
				<li
					<c:if test="${sessionScope.menue=='userAccount'}">class="active"</c:if>>
					<a href="${ctx}/pages/userAccountManagerList.jsp?menue=userAccount">
						<i class="icon icon-th"></i><span>个人用户管理</span> </a>
				</li>
				<li
					<c:if test="${sessionScope.menue=='blessingsManager'}">class="active"</c:if>>
					<a
					href="${ctx}/pages/blessingsManagerList.jsp?menue=blessingsManager">
						<i class="icon icon-th"></i> <span>节日祝福语</span> </a>
				</li>
				<li
					class="submenu <c:if test="${sessionScope.menue=='pushdd'}">active</c:if>  ">
					<a href="#"> <i class="icon icon-inbox"></i> <span>推送管理</span>
				</a>
					<ul>
						<li><a
							<c:if test="${sessionScope.menue2=='pushdd1'}">class="achoose"</c:if>
							href="${ctx}/pages/pushManagerList.jsp?menue=pushdd&menue2=0">推送消息</a>
						</li>
						<li><a
							<c:if test="${sessionScope.menue2=='pushdd1'}">class="achoose"</c:if>
							href="${ctx}/pages/versionManagerList.jsp?menue=pushdd&menue2=1">推送版本</a>
						</li>
					</ul>
				<li
					<c:if test="${sessionScope.menue=='accountTotal'}">class="active"</c:if>>
					<a href="#"> <i class="icon icon-th"></i> <span>账号统计</span> </a>
				</li>
		</c:when>
		<c:when test="${(sessionScope.company.type==1)}">
			<!-- 企业用户 -->
			<ul>
				<c:if test="${role.parentId==0}">
					<li
						<c:if test="${sessionScope.menue=='role'}">class="active"</c:if>>
						<a href="${ctx}/pages/roleManagerList.jsp?menue=role"> <i
							class="icon icon-th-list"></i> <span>职务管理</span> </a>
					</li>
				</c:if>


				<li
					class="submenu <c:if test="${sessionScope.menue=='mySubattend'}">active</c:if>  ">
					<a href="#"> <i class="icon icon-inbox"></i> <span>考勤管理</span>
				</a>
					<ul>
						<li><a
							<c:if test="${sessionScope.menue2=='mySubattend1'}">class="achoose"</c:if>
							href="${ctx}/pages/mySubattendanceManagerList.jsp?menue=mySubattend&menue2=0">考勤列表</a>
						</li>
						<%-- <li><a
							<c:if test="${sessionScope.menue2=='mySubattend1'}">class="achoose"</c:if>
							href="${ctx}/pages/attendancestatisticsManagerList.jsp?menue=mySubattend&menue2=1">考勤统计</a>
						</li>
						<li><a
							<c:if test="${sessionScope.menue2=='mySubattend1'}">class="achoose"</c:if>
							href="${ctx}/pages/manageworkManagerUpdate.jsp?menue=mySubattend&menue2=2">管理上班时间</a>
						</li> --%>
					</ul>
				<li
					<c:if test="${sessionScope.menue=='mySubUser'}">class="active"</c:if>>
					<a href="${ctx}/pages/mySubUserManagerList.jsp?menue=mySubUser">
						<i class="icon icon-indent-left"></i> <span>下属人员</span> </a>
				</li>

				<li
					<c:if test="${sessionScope.menue=='contacts'}">class="active"</c:if>>
					<a href="${ctx}/pages/contactsManagerList.jsp?menue=contacts"><i
						class="icon icon-twitter"></i> <span>联系人(客户)</span> </a>
				</li>
				<%-- 
				<li
					<c:if test="${sessionScope.menue=='product'}">class="active"</c:if>>
					<a href="${ctx}/pages/productManagerList.jsp?menue=product"><i
						class="icon icon-th-list"></i> <span>商品</span> </a>
				</li>

				<li <c:if test="${sessionScope.menue=='sell'}">class="active"</c:if>>
					<a href="${ctx}/pages/sellManagerList.jsp?menue=sell"><i
						class="icon icon-list-alt"></i> <span>销售</span> </a>
				</li>
				<li
					<c:if test="${sessionScope.menue=='project'}">class="active"</c:if>>
					<a href="${ctx}/pages/projectManagerList.jsp?menue=project"><i
						class="icon icon-star-empty"></i> <span>项目</span> </a>
				</li>
				--%>
				<li
					<c:if test="${sessionScope.menue=='things'}">class="active"</c:if>>
					<a href="${ctx}/pages/thingsManagerList.jsp?menue=things"><i
						class="icon icon-edit"></i> <span>待办</span> </a>
				</li> 


			</ul>
		</c:when>

		<c:when test="${(sessionScope.company.type==0)}">
			<!-- 个人用户 -->
			<ul>
				<li><a
					href="${ctx}/pages/groupManagerList.jsp?menue=contactsManager">
						<i class="icon icon-th"></i> <span>联系人分组</span> </a></li>
				<li
					<c:if test="${sessionScope.menue=='contacts'}">class="active"</c:if>>
					<a href="${ctx}/pages/contactsManagerList.jsp?menue=contacts"><i
						class="icon icon-twitter"></i> <span>联系人(客户)</span> </a>
				</li>
				<li
					<c:if test="${sessionScope.menue=='attendanceManager'}">class="active"</c:if>>
					<a
					href="${ctx}/pages/attendanceManagerList.jsp?menue=attendanceManager">
						<i class="icon icon-th"></i> <span>我的考勤</span> </a>
				</li>
			</ul>
		</c:when>
	</c:choose>
</div>