"use strict";

let x, y, r ;
const svg = document.getElementById("svg");

// Функция для отрисовки точки на графике
function drawPoint(x, y, r, result) {
  const scale = 40; // Масштаб: 1 единица = 40 пикселей
  const centerX = 250;
  const centerY = 250;

  const circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
  circle.setAttribute("cx", x * scale + centerX);
  circle.setAttribute("cy", -y * scale + centerY);
  circle.setAttribute("r", 4);
  circle.style.fill = result ? "#FFD700" : "#C0C0C0";
  svg.appendChild(circle);
}

// Функция для обновления фигур на графике при изменении R
function updateShapes() {
  // Получаем значение радиуса
  r = parseFloat(document.querySelector("input[name='R-radio-group']:checked").value);
  const radius = r * 40; // Масштабируем радиус

  // Координаты центра
  const centerX = 250;
  const centerY = 250;

  // Очищаем предыдущие фигуры
  document.getElementById('triangle').setAttribute('points', '');
  document.getElementById('square').setAttribute('width', '0');
  document.getElementById('square').setAttribute('height', '0');
  document.getElementById('quarterCircle').setAttribute('d', '');

  // Обновляем треугольник (1 четверть)
  const trianglePoints = `
    ${centerX},${centerY}
    ${centerX},${centerY - radius / 2}
    ${centerX - radius / 2},${centerY}
  `;
  document.getElementById('triangle').setAttribute('points', trianglePoints.trim());

  // Обновляем прямоугольник (4 четверть)
  document.getElementById('square').setAttribute('x', centerX);
  document.getElementById('square').setAttribute('y', centerY);
  document.getElementById('square').setAttribute('width', radius);
  document.getElementById('square').setAttribute('height', radius);

  // Обновляем четверть круга (2 четверть)
  const quarterCirclePath = `
    M ${centerX} ${centerY}
    L ${centerX} ${centerY - radius}
    A ${radius} ${radius} 0 0 1 ${centerX + radius} ${centerY}
    Z
  `;
  document.getElementById('quarterCircle').setAttribute('d', quarterCirclePath.trim());

  // Обновляем подписи на осях (опционально, если они зависят от R)
}

// Преобразование координат SVG в координаты плоскости
function transformSvgToPlane(svgX, svgY, r) {
  const scale = 40; // Масштаб: 1 единица = 40 пикселей
  const centerX = 250;
  const centerY = 250;

  const planeX = (svgX - centerX) / scale;
  const planeY = (centerY - svgY) / scale;
  return { x: planeX, y: planeY };
}

// Добавление результатов в таблицу
function addToTable(x, y, r, result) {
  const table = document.getElementById("outputTable");
  const span = document.getElementById("notifications");
  if (span) {
    span.innerText = "";
    span.className = "notification";
  }

  const newRow = table.insertRow();
  newRow.insertCell().innerText = x;
  newRow.insertCell().innerText = y;
  newRow.insertCell().innerText = r;
  newRow.insertCell().innerHTML = result
    ? "<span class=\"success\">★ Hit</span>"
    : "<span class=\"fail\">☆ Miss</span>";
}

// Проверка точки на сервере
async function checkPoint(x, y, r) {
  const form = new FormData();
  form.append("X", x);
  form.append("Y", y);
  form.append("R", r);
  form.append("action", "checkPoint");

  const url = "controller?" + new URLSearchParams(form).toString();
  const response = await fetch(url, { method: "get" });

  if (!response.ok) {
    createNotification("Не удалось отправить точку.");
    return null;
  }

  const data = await response.json();
  if (data.error) {
    createNotification(data.error);
    return null;
  }

  return data;
}

// Отправка координат на сервер и обработка ответа
async function sendCoordinatesToServer(x, y, r) {
  const data = await checkPoint(x, y, r);

  if (data && !data.error) {
    drawPoint(x, y, r, data.result);
    addToTable(x, y, r, data.result);
  }
}

// Функция создания уведомлений об ошибках
function createNotification(message) {
  const outputContainer = document.getElementById("outputContainer");
  let notification = outputContainer.querySelector(".notification");

  if (notification) {
    notification.textContent = message;
    notification.classList.add("errorStub");
    if (notification.classList.contains("outputStub")) {
      notification.classList.remove("outputStub");
    }
  } else {
    const notificationElement = document.createElement("h4");
    notificationElement.innerHTML = "<span class='notification errorStub'></span>";
    outputContainer.prepend(notificationElement);
    notification = outputContainer.querySelector(".notification");
    notification.textContent = message;
  }
}

// Валидация X
function validateX() {
  if (isNumeric(x)) return true;
  else {
    alert("卧槽！俄罗斯人哈哈哈你们是这真的票冷但是你们是婊子。Value X is not selected");
    return false;
  }
}

// Валидация Y
function validateY() {
  y = document.querySelector("input[name='Y-input']").value.replace(",", ".");
  if (y === undefined || y === "") {
    alert("他妈的 Y is not entered");
    return false;
  } else if (!isNumeric(y)) {
    alert("他妈的 is not a number");
    return false;
  } else if (y < -3 || y > 5) {
    alert("他妈的 is out of range (-3..5)");
    return false;
  } else return true;
}

// Валидация R
function validateR() {
  try {
    r = parseFloat(document.querySelector("input[name='R-radio-group']:checked").value);
    return true;
  } catch (err) {
    alert("操操操操操操操操 R is not selected");
    return false;
  }
}

// Проверка на число
function isNumeric(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

// Основной обработчик событий после загрузки документа
document.addEventListener("DOMContentLoaded", () => {
  // Отрисовка точек из таблицы при загрузке страницы
  const table = document.getElementById("outputTable");

  if (table) {
    for (let i = 1; i < table.rows.length; i++) {
      const cells = table.rows[i].cells;
      const x = parseFloat(cells[0].innerText.trim());
      const y = parseFloat(cells[1].innerText.trim());
      const r = parseFloat(cells[2].innerText.trim());
      if (isNaN(x) || isNaN(y) || isNaN(r)) continue;

      const result = cells[3].innerText.includes("Попадание") || cells[3].innerText.includes("Hit");
      drawPoint(x, y, r, result);
    }
  }

  // Обработчик клика по SVG для добавления точки
  svg.addEventListener("click", (event) => {
    if (validateR()) {
      const rect = svg.getBoundingClientRect();
      const svgX = event.clientX - rect.left;
      const svgY = event.clientY - rect.top;

      const planeCoords = transformSvgToPlane(svgX, svgY, r);
      sendCoordinatesToServer(
        planeCoords.x.toFixed(2),
        planeCoords.y.toFixed(2),
        r
      );
    } else {
      createNotification("Пожалуйста, выберите значение R.");
    }
  });

  // Обработчик кнопок X
  const xButtons = document.querySelectorAll("input[name='X-button']");
  xButtons.forEach((element) => {
    element.addEventListener("click", function () {
      x = this.value;
      xButtons.forEach((btn) => btn.classList.remove("active"));
      this.classList.add("active");
    });
  });

  // Обработчик кнопки "Calculate and check"
  document.getElementById("checkButton").addEventListener("click", function (event) {
    event.preventDefault();
    if (validateX() && validateY() && validateR()) {
      const form = $('<form>', {
        action: "controller",
        method: "get"
      });

      const args = { action: "submitForm", X: x, Y: y, R: r };
      Object.entries(args).forEach(([key, value]) => {
        $('<input>').attr({
          type: "hidden",
          name: key,
          value: value
        }).appendTo(form);
      });

      form.appendTo('body').submit();
    }
  });

  // Обработчик изменения R
  document.querySelectorAll("input[name='R-radio-group']").forEach((radio) => {
    radio.addEventListener('change', () => {
      validateR(); // Обновляем значение R
      updateShapes(); // Обновляем график
    });
  });

  // Инициализация графика при загрузке страницы
  // if (validateR()) {
  //   updateShapes();
  // }

  // Обработчик сворачивания модулей с плавной анимацией затухания
  const modules = document.querySelectorAll('.module');
  modules.forEach(module => {
    const header = module.querySelector('.module-header');
    const content = module.querySelector('.module-content');
    header.addEventListener('click', () => {
      if (module.classList.contains('expanded')) {
        content.style.maxHeight = content.scrollHeight + 'px';
        requestAnimationFrame(() => {
          content.style.maxHeight = '0';
        });
      } else {
        content.style.maxHeight = '0';
        requestAnimationFrame(() => {
          content.style.maxHeight = content.scrollHeight + 'px';
        });
      }
      module.classList.toggle('expanded');
    });

    // Инициализация максимальной высоты контента для анимации
    if (module.classList.contains('expanded')) {
      content.style.maxHeight = content.scrollHeight + 'px';
    } else {
      content.style.maxHeight = '0';
    }
  });

  // Обработчик кнопки "Miracle" для управления музыкой
  const miracleButton = document.getElementById('miracleButton');
  const backgroundAudio = document.getElementById('backgroundAudio');
  let isPlaying = false;

  miracleButton.addEventListener('click', () => {
    if (isPlaying) {
      backgroundAudio.pause();
      miracleButton.textContent = 'Miracle';
    } else {
      backgroundAudio.play();
      miracleButton.textContent = 'Pause';
    }
    isPlaying = !isPlaying;
  });

  // Обработка окончания трека для повторного воспроизведения
  backgroundAudio.addEventListener('ended', () => {
    backgroundAudio.currentTime = 0;
    backgroundAudio.play();
  });
});

window.onload = function() {
  updateShapes();
};
