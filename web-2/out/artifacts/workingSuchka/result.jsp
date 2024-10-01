<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="web.daos.PointDao" %>
<%@ page import="web.models.Point" %>

<!DOCTYPE html>
<html lang="ru-RU">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <meta name="author" content="Демин Артём Витальевич">
  <meta name="description" content="Веб-программирование: Лабораторная работа №2. Результаты проверки">
  <meta name="keywords" content="ITMO, ИТМО, ПИиКТ, ВТ, Лабораторная работа, Веб-программирование"/>

  <link href="stylesheets/styles.css" rel="stylesheet">
  <link rel="icon" type="image/png" href="images/favicon.png">
  <title>Результаты проверки | Веб-программирование</title>
</head>

<body>

<main>
  <section class="module">
    <div class="module-header">
      <h3>Results of calculating:</h3>
    </div>
    <div class="module-content">
      <% PointDao dao = (PointDao) request.getSession().getAttribute("bean");
        if (dao == null) {
      %>
      <h4>
        <span id="notifications" class="outputStub notification">No results</span>
      </h4>
      <table id="outputTable">
        <tr>
          <th>X</th>
          <th>Y</th>
          <th>R</th>
          <th>Результат</th>
        </tr>
      </table>
      <% } else { %>
      <table id='outputTable'>
        <tr>
          <th>X</th>
          <th>Y</th>
          <th>R</th>
          <th>Result</th>
        </tr>
        <% for (Point point : dao.getPoints()) { %>
        <tr>
          <td><%= point.getX() %></td>
          <td><%= point.getY() %></td>
          <td><%= point.getR() %></td>
          <td>
            <%= point.isInArea() ? "<span class=\"success\">★ Hit</span>"
              : "<span class=\"fail\">☆ Miss</span>" %>
          </td>
        </tr>
        <% } %>
      </table>
      <% } %>
      <div id="goBack">
        <a href="index.jsp" class="space-button">Back to form</a>
      </div>
    </div>
  </section>
</main>



<script src="script.js"></script>
</body>

</html>
