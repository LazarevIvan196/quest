<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Welcome to the Quest Game</title>
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/images/welcome.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#startGameBtn").click(function () {
                let playerName = $("#playerName").val();
                $.post("${pageContext.request.contextPath}/startGame", { playerName: playerName }, function (data) {
                    window.location.href = "${pageContext.request.contextPath}/quest";
                });
            });
        });
    </script>
</head>
<body>
<div class="container">
    <form style="text-align: center;">
        <h1>Добро пожаловать!</h1>
        <p>Ты готов начать приключение,
            <c:choose>
                <c:when test="${empty sessionScope.playerName or sessionScope.playerName eq ''}">
                    Гость
                </c:when>
                <c:otherwise>
                    ${sessionScope.playerName}
                </c:otherwise>
            </c:choose>?
        </p>
        <label for="playerName"></label><input type="text" id="playerName" name="playerName" placeholder="Press Name" style="text-align: center;">
        <button id="startGameBtn" type="button" style="margin-top: 10px;">Старт игры</button>
    </form>
</div>
</body>
</html>