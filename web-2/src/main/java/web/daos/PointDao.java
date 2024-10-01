package web.daos;

import jakarta.ejb.Stateful;
import jakarta.enterprise.context.SessionScoped;

import web.models.Point;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

@Stateful // stateful session bean, сохранение
@SessionScoped //
public class PointDao implements Serializable {

  // хранение списка точек, добавленных пользователем.
  private final List<Point> points = new ArrayList<>();

  public void addPoint(Point point) {
    points.add(point);
  }

  public List<Point> getPoints() {
    return points;
  }
}
