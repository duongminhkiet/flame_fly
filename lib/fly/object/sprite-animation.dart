import 'dart:developer';
import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame_fly/fly/scene/langaw_gm1.dart';
class SpriteAnimationCheck {
  Canvas c;
  final LangawGame game;
  Sprite _sprite;

  SpriteAnimationCheck(this.game) {
    initialize();

  }
  void initialize() async {
    _sprite = await Sprite.loadSprite('check/minotaur.png', width: 96, height: 96);
    if(_sprite != null){

      log('xxx sprite is not NULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLL');
    }else{
      log('NULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLLNULLLLL');
    }
  }


  void render(Canvas c){
    this.c = c;
    if(_sprite == null){
      log('sprite is null');
    }else{
      _sprite.render(c);
    }

//    _sprite.renderPosition(c, new Position(game.screenSize.width/2,game.screenSize.height/2));
  }
  void update(double t){// t = 1/60

  }
}