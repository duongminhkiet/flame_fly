import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_fly/fly/component/backyard.dart';
import 'package:flame_fly/fly/component/house-fly.dart';
import 'package:flame_fly/fly/object/fly.dart';
import 'package:flame_fly/fly/object/testObj.dart';
import 'package:flame_fly/fly/object/testObjAnimation.dart';
import 'package:flame_fly/fly/view/home-view.dart';
import 'package:flame_fly/fly/view/view.dart';
import 'package:logger/logger.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';


import 'package:flame/animation.dart' as flame_animation;

import 'package:flame/sprite.dart';
import 'package:flame/components/animation_component.dart';
class LangawGame extends BaseGame {

  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard background;
  var logger;

  TestObj testObj;//ok
  TestObjAnimation testAni;//ok
  //SpriteAnimationCheck spriteAnimationCheck;//not ok
  ParallaxComponent parallaxComponent;

  HomeView homeView;
  View activeView = View.home;
  LangawGame() {
    initialize();




  }
  final animation = flame_animation.Animation.sequenced('check/chopper.png', 4,
      textureWidth: 48, textureHeight: 48, stepTime: 0.15);
  void addAnimation() {
    final animationComponent =
    AnimationComponent(100, 100, animation, destroyOnFinish: true);
    animationComponent.x = screenSize.width / 2 - 50;
    animationComponent.y = screenSize.height/2;
    animationComponent.anchor = Anchor(Offset(0.5, 0.5));

    add(animationComponent);
  }
  void addParallax(){
    final images = [
      ParallaxImage("parallax/bg.png"),
      ParallaxImage("parallax/mountain-far.png"),
      ParallaxImage("parallax/mountains.png"),
      ParallaxImage("parallax/trees.png"),
      ParallaxImage("parallax/foreground-trees.png"),
    ];
    parallaxComponent = ParallaxComponent(images,
        baseSpeed: const Offset(20, 0), layerDelta: const Offset(30, 0));

    add(parallaxComponent);
  }
  void initialize() async {

    logger = Logger();
    rnd = Random();
    flies = List<Fly>();
    resize(await Flame.util.initialDimensions());
    background = Backyard(this);

    addParallax();

    spawnFly();


    addTestAniObj();//ok
    addTestObj();
    addAnimation();

    //spriteAnimationCheck = SpriteAnimationCheck(this);
//    await spriteAnimationCheck.initialize();

    homeView = HomeView(this);
  }
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    parallaxComponent?.resize(size);
  }
  void spawnFly() {

    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    addFlies(x,y);


//    if(flies.length ==0){
//      double x = rnd.nextDouble() * (screenSize.width - tileSize);
//      double y = rnd.nextDouble() * (screenSize.height - tileSize);
//      addFlies(x,y);
//    }else if(flies.length == 1){
//      if(flies.elementAt(0).isDead){
//        double x = rnd.nextDouble() * (screenSize.width - tileSize);
//        double y = rnd.nextDouble() * (screenSize.height - tileSize);
//        addFlies(x,y);
//      }
//    }
  }
  void addTestObj(){
    testObj = new TestObj(this);
  }
  void addTestAniObj(){
    testAni = new TestObjAnimation(this);
  }
  void addFlies(double x,double y){
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        return;
      case 1:
        flies.add(DroolerFly(this, x, y));
        return;
      case 2:
        flies.add(AgileFly(this, x, y));
        return;
      case 3:
        flies.add(MachoFly(this, x, y));
        return;
      case 4:
        flies.add(HungryFly(this, x, y));
        return;
    }
//    flies.add(HouseFly(this, x, y));
//    flies.add(Fly(this, x, y));
    //flies.add(Fly(this, 50, 50));
  }
  void render(Canvas c) {
    background.render(c);

//    Paint bgPaint = Paint();
//    bgPaint.color = Color(0xff576574);
//    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
//    canvas.drawRect(bgRect, bgPaint);
    parallaxComponent?.render(c);
    flies.forEach((Fly fly) => fly.render(c));

    testObj.render(c);

    testAni.render(c);



    if (activeView == View.home) homeView.render(c);
  }

  void update(double t) {
    parallaxComponent?.update(t);
    flies.forEach((Fly fly) => fly.update(t));
    /*
    flies.forEach(
      (Fly fly){
        fly.update(t);
    }
    );
    */

    flies.removeWhere((Fly fly) => fly.isOffScreen);
    testObj.update(t);

    testAni.update(t);

    //spriteAnimationCheck.update(t);
  }
  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}