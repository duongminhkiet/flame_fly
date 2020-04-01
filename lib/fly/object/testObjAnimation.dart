import 'dart:developer';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/sprite.dart';
import 'package:flame_fly/fly/scene/langaw_gm1.dart';
class TestObjAnimation {
  final LangawGame game;
  Rect flyRect;
  Paint flyPaint;
  Offset targetLocation;
  double get speed => game.tileSize * 3;

  Sprite  objSprite;
  bool isDead = false;
  bool isOffScreen = false;

  var player;
  static const TextConfig config = TextConfig(fontSize: 48.0, fontFamily: 'Awesome Font');

  Animation a;
  TestObjAnimation(this.game) {
    List<Sprite> sprites = [1, 2].map((i) => new Sprite('flies/macho-fly-${i}.png')).toList();
    //player = AnimationComponent(64.0, 64.0, new Animation.spriteList(sprites, stepTime: 0.01, loop: true)) as Sprite;

     a = Animation.spriteList(sprites, stepTime: 0.02);

    double x = game.screenSize.width/2-game.tileSize;
    double y = 0;
    flyRect = Rect.fromLTWH(x, y, game.tileSize*2, game.tileSize*2);
    objSprite = Sprite('flies/house-fly-dead.png');

//    const size = 128.0;
//    objSprite = SpriteComponent.fromSprite(size, size, Sprite('flies/house-fly-dead.png'));
//
    setTargetLocation();

    //config = TextConfig(fontSize: 48.0, fontFamily: 'Awesome Font', anchor: Anchor.rightBottom);
  }
  void setTargetLocation() {
    double x = game.screenSize.width/2 -game.tileSize;
    double y = game.screenSize.height*1.1;
    targetLocation = Offset(x, y);
  }

  void render(Canvas c){
    //objSprite.render(c);

    //objSprite.renderPosition(c, Position(100, 100));

    a.getSprite().render(c);
//    objSprite.renderRect(c, flyRect);

    config.render(c, "Flame is awesome", Position(10, 10));
  }
  void update(double t){// t = 1/60
    a.update(t);

      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
        game.addTestAniObj();
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