import 'dart:developer';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_fly/fly/scene/langaw_gm1.dart';

class Fly{
  final LangawGame game;
  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  Offset targetLocation;
  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
  }
  void setTargetLocation() {
//    double x = 0.5 * (game.screenSize.width - (game.tileSize * 2.025));
//    double y = 0.5 * (game.screenSize.height - (game.tileSize * 2.025));
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }
  void render(Canvas c){
//    c.drawRect(flyRect, flyPaint);
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      int x = flyingSpriteIndex.toInt();
      //log('XX: $x');
      flyingSprite[x].renderRect(c, flyRect.inflate(2));
    }
  }
  void update(double t){// t = 1/60
    if (isDead) {
      double xy = game.tileSize * 12 * t;
      flyRect = flyRect.translate(0, xy);
//      log('drop: $xy');
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }

    }else {
      flyingSpriteIndex += 30 * t;
      //log('index: $flyingSpriteIndex xxxxx t: $t');
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }
  }
  void onTapDown() {
    isDead = true;
    if(flyPaint != null) {
      flyPaint.color = Color(0xffff4757);
    }
      game.spawnFly();
    }
}