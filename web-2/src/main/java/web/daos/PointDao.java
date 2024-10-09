package web.daos;

import jakarta.ejb.Stateful;
import jakarta.enterprise.context.SessionScoped;

import web.models.Point;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;




@Stateful // stateful session bean, сохранение
// состояние между запросами в рамках одной сессии

@SessionScoped // облaсть видимости

public class PointDao implements Serializable {

  private static final long serialVersionUID = 1L;

  // хранение списка точек, добавленных пользователем.
  private final List<Point> points = new ArrayList<>();

  public void addPoint(Point point) {
    points.add(point);
  }

  public List<Point> getPoints() {
    return points;
  }
}
