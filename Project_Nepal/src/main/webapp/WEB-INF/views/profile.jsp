<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Profile — Explore Nepal</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value=""/>
</jsp:include>

<div class="container" style="padding:40px 20px;">

    <div style="
        max-width:700px;
        margin:auto;
        background:#fff;
        border-radius:16px;
        padding:32px;
        box-shadow:var(--shadow-card);
        border:1px solid var(--color-outline-variant);
    ">

        <h1 style="margin-bottom:24px;">My Profile</h1>

        <table style="width:100%; border-collapse:collapse;">

            <tr>
                <td style="padding:12px; font-weight:700;">Full Name</td>
                <td style="padding:12px;">
                    <c:out value="${sessionScope.loggedInUser.fullName}"/>
                </td>
            </tr>

            <tr>
                <td style="padding:12px; font-weight:700;">Email</td>
                <td style="padding:12px;">
                    <c:out value="${sessionScope.loggedInUser.email}"/>
                </td>
            </tr>

            <tr>
                <td style="padding:12px; font-weight:700;">Phone</td>
                <td style="padding:12px;">
                    <c:out value="${sessionScope.loggedInUser.phone}"/>
                </td>
            </tr>

            <tr>
                <td style="padding:12px; font-weight:700;">Role</td>
                <td style="padding:12px;">
                    <c:out value="${sessionScope.loggedInUser.role}"/>
                </td>
            </tr>

            <tr>
                <td style="padding:12px; font-weight:700;">Status</td>
                <td style="padding:12px;">
                    <c:out value="${sessionScope.loggedInUser.status}"/>
                </td>
            </tr>

        </table>

    </div>
</div>

<jsp:include page="_footer.jsp"/>

</body>
</html>