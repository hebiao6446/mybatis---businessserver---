<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="http_img" value="http://127.0.0.1:8080/businessServer" />

<%
	//  request.getSession().setAttribute("user", null);
%>
<c:choose>
	<c:when test="${user == null}">
		<script>
			if (top != null)
				top.location.href = "${ctx}/pages/login.jsp";
			else
				location.href = "${ctx}/pages/login.jsp";
		</script>
	</c:when>
</c:choose>