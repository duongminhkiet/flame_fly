import 'dart:developer';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_fly/fly/scene/langaw_gm1.dart';
class TestObj {
  final LangawGame game;
  Rect flyRect;
  Paint flyPaint;
  Offset targetLocation;
  double get speed => game.tileSize * 3;
  Sprite objSprite;
  bool isDead = false;
  bool isOffScreen = false;
  TestObj(this.game) {

    double x = game.screenSize.width/2-game.tileSize;
    double y = 0;
    flyRect = Rect.fromLTWH(x, y, game.tileSize*2, game.tileSize*2);
    objSprite = Sprite('flies/house-fly-dead.png');
    setTargetLocation();
  }
  void setTargetLocation() {
    double x = game.screenSize.width/2 -game.tileSize;
    double y = game.screenSize.height*1.1;
    targetLocation = Offset(x, y);
  }

  void render(Canvas c){
    objSprite.renderRect(c, flyRect);
  }
  void update(double t){// t = 1/60

      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
        game.addTestObj();
      }
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
    }
  }
  void update2(double t){// t = 1/60
//    if (isDead) {
//      double xy = game.tileSize * 12 * t;
//      flyRect = flyRect.translate(0, xy);
//      if (flyRect.top > game.screenSize.height) {
//        isOffScreen = true;
//      }
//
//    }
    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      //setTargetLocation();
    }
  }
}