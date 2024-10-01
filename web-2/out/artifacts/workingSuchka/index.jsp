<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="web.daos.PointDao" %>
<%@ page import="web.models.Point" %>

<!DOCTYPE html>
<html lang="ru-RU">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <meta name="author" content="Демин Артём Витальевич">
  <meta name="description" content="Веб-программирование: Лабораторная работа №2.">
  <meta name="keywords" content="ITMO, ИТМО, ПИиКТ, ВТ, Лабораторная работа, Веб-программирование"/>

  <link href="stylesheets/styles.css" rel="stylesheet">
  <link rel="icon" type="image/png" href="images/favicon.png">
  <title>Лабораторная работа №2 | Веб-программирование</title>
</head>

<body>

<nav class="navbar">
  <ul>
    <li><a href="#">Main</a></li>
    <li><a href="#">About project</a></li>
    <li><a href="https://rt.pornhub.com/users/tashertemka">Contact us</a></li>
  </ul>
  <button id="miracleButton" class="miracle-button">Miracle</button>
</nav>

<main>
  <header class="header">
    <h2>
      <a href="https://se.ifmo.ru/courses/web" class="link-hover">Laboratory work №2, Variant 12086</a>
    </h2>
    <div id="credit">
      <a href="https://isu.ifmo.ru/pls/apex/f?p=2437:7:111073564843380" class="link-hover">Demin Artem Vitalyevich</a>,
      <a href="https://isu.ifmo.ru/pls/apex/f?p=2143:GR:111073564843380::NO:RP:GR_GR,GR_DATE:P3212" class="link-hover">Р3212</a>
    </div>
    <div id="teacher">
      <a href="https://isu.ifmo.ru/pls/apex/f?p=2143:PERSON:103488598122425::NO:RP:PID:243147" class="link-hover" title="My most definitely favourite teacher">我的最喜欢的老师</a>
    </div>
  </header>


  <section class="module">
    <div class="module-header">
      <h3>Please enter your details to verify:</h3>
      <button class="toggle-button">&#9660;</button>
    </div>
    <div class="module-content">
      <hr>
      <form id="inputForm">
        <div class="input-group">
          <label>Please select X:</label>
          <div class="button-group">
            <% for (int i = -4; i <= 4; i++) { %>
            <input name="X-button" type="button" value="<%= i %>">
            <% } %>
          </div>
        </div>

        <div class="input-group">
          <label>Please enter Y:</label>
          <input required name="Y-input" type="text" placeholder="-3..5" maxlength="6">
        </div>

        <div class="input-group">
          <label>Please select R :</label>
          <div class="radio-group">
            <% for (int i = 1; i <= 5; i++) { %>
            <label><input name="R-radio-group" type="radio" value="<%= i %>"><%= i %></label>
            <% } %>
          </div>
        </div>

        <button type="submit" id="checkButton">Calculate and check</button>
      </form>
    </div>
  </section>

  <!-- график типо -->
  <section class="module">
    <div class="module-header">
      <h3>Graphic:</h3>
      <button class="toggle-button">&#9660;</button>
    </div>
    <div class="module-content">
      <svg xmlns="http://www.w3.org/2000/svg" id="svg" width="500" height="500">
        <!-- triangle-->
        <polygon id="triangle" points="250,250 150,250 250,150" fill="#FFFFFF" fill-opacity="0.6"></polygon>
        <!-- square-->
        <rect id="square" x="250" y="250" width="200" height="200" fill="#FFFFFF" fill-opacity="0.6"></rect>
        <!-- circle-->
        <path id="quarterCircle" d="M 250 250 L 250 50 C 290 90 410 210 450 250 Z" fill="#FFFFFF" fill-opacity="0.6"></path>

        <!--X line-->
        <line x1="0" y1="250" x2="500" y2="250" stroke="#FFFFFF"></line>
        <!--Y line-->
        <line x1="250" y1="0" x2="250" y2="500" stroke="#FFFFFF"></line>

        <line x1="210" y1="248" x2="210" y2="252" stroke="#FFFFFF"></line> <!-- -1 point on x -->
        <line x1="290" y1="248" x2="290" y2="252" stroke="#FFFFFF"></line> <!-- 1 point on x -->
        <text x="205" y="240">-1</text> <!-- '-1' on x -->
        <text x="285" y="240">1</text> <!-- '1' on x -->

        <line x1="170" y1="248" x2="170" y2="252" stroke="#FFFFFF"></line> <!-- -2 point on x -->
        <line x1="330" y1="248" x2="330" y2="252" stroke="#FFFFFF"></line> <!-- 2 point on x -->
        <text x="165" y="240">-2</text> <!-- '-2' on x -->
        <text x="325" y="240">2</text> <!-- '2' on x -->

        <line x1="130" y1="248" x2="130" y2="252" stroke="#FFFFFF"></line> <!-- -3 point on x -->
        <line x1="370" y1="248" x2="370" y2="252" stroke="#FFFFFF"></line> <!-- 3 point on x -->
        <text x="125" y="240">-3</text> <!-- '-3' on x -->
        <text x="365" y="240">3</text> <!-- '3' on x -->

        <line x1="90" y1="248" x2="90" y2="252" stroke="#FFFFFF"></line> <!-- -4 point on x -->
        <line x1="410" y1="248" x2="410" y2="252" stroke="#FFFFFF"></line> <!-- 4 point on x -->
        <text x="85" y="240">-4</text> <!-- '-4' on x -->
        <text x="405" y="240">4</text> <!-- '4' on x -->

        <line x1="50" y1="248" x2="50" y2="252" stroke="#FFFFFF"></line> <!-- -5 point on x -->
        <line x1="450" y1="248" x2="450" y2="252" stroke="#FFFFFF"></line> <!-- 5 point on x -->
        <text x="45" y="240">-5</text> <!-- '-5' on x -->
        <text x="445" y="240">5</text> <!-- '5' on x -->


        <line x1="248" y1="210" x2="252" y2="210" stroke="#FFFFFF"></line> <!-- 1 on y -->
        <line x1="248" y1="290" x2="252" y2="290" stroke="#FFFFFF"></line> <!-- -1 on y -->
        <text x="256" y="215">1</text> <!-- 1 on y -->
        <text x="256" y="295">-1</text> <!-- -1 on y -->

        <line x1="248" y1="170" x2="252" y2="170" stroke="#FFFFFF"></line> <!-- 2 on y -->
        <line x1="248" y1="330" x2="252" y2="330" stroke="#FFFFFF"></line> <!-- -2 on y -->
        <text x="256" y="175">2</text> <!-- 2 on y -->
        <text x="256" y="335">-2</text> <!-- -2 on y -->

        <line x1="248" y1="130" x2="252" y2="130" stroke="#FFFFFF"></line> <!-- 3 on y -->
        <line x1="248" y1="370" x2="252" y2="370" stroke="#FFFFFF"></line> <!-- -3 on y -->
        <text x="256" y="135">3</text> <!-- 3 on y -->
        <text x="256" y="375">-3</text> <!-- -3 on y -->

        <line x1="248" y1="90" x2="252" y2="90" stroke="#FFFFFF"></line> <!-- 4 on y -->
        <line x1="248" y1="410" x2="252" y2="410" stroke="#FFFFFF"></line> <!-- -4 on y -->
        <text x="256" y="95">4</text> <!-- 4 on y -->
        <text x="256" y="415">-4</text> <!-- -4 on y -->

        <line x1="248" y1="50" x2="252" y2="50" stroke="#FFFFFF"></line> <!-- 5 on y -->
        <line x1="248" y1="450" x2="252" y2="450" stroke="#FFFFFF"></line> <!-- -5 on y -->
        <text x="256" y="55">5</text> <!-- 3 on y -->
        <text x="256" y="455">-5</text> <!-- -3 on y -->
        <!-- arrows -->
        <polygon points="250,0 255,5 245, 5" fill="#ffffff" stroke="#ffffff"></polygon>
        <polygon points="500, 250 495,245 495,255" fill="#ffffff" stroke="#ffffff"></polygon>
        <!-- Point-->
        <circle id="pointer" r="5" cx="250" cy="250" fill-opacity="0.9" fill="red" stroke="firebrick"
                visibility="hidden"></circle>
      </svg>
    </div>
  </section>


  <section class="module">
    <div class="module-header">
      <h3>Results of calculating:</h3>
      <button class="toggle-button">&#9660;</button>
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
          <th>Result</th>
        </tr>
      </table>
      <% } else { %>
      <h4>
        <span class="notification"></span>
      </h4>
      <table id="outputTable">
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
    </div>
  </section>
</main>



<audio id="backgroundAudio" loop>
  <source src="audio/Hans_Zimmer_S_T_A_Y_Interstellar_Main_Themeslowed_+_reverb.mp3" type="audio/mpeg">
  Ваш браузер не поддерживает воспроизведение аудио.
</audio>

<!-- Скрипты -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<script src="script.js"></script>
</body>

</html>
