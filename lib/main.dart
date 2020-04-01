import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';

import 'package:flutter/gestures.dart';

import 'fly/scene/langaw_gm1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  await Flame.util.fullScreen();
  await Flame.util.setPortraitUpOnly();

  await Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
    'check/minotaur.png',
    'check/chopper.png',
    'parallax/bg.png',
    'parallax/mountain-far.png',
    'parallax/mountains.png',
    'parallax/trees.png',
    'parallax/foreground-trees.png',
    'fly/bg/lose-splash.png',
    'fly/branding/title.png',
    'fly/ui/dialog-credits.png',
    'fly/ui/dialog-help.png',
    'fly/ui/icon-credits.png',
    'fly/ui/icon-help.png',
    'fly/ui/start-button.png',
  ]);

  LangawGame game = LangawGame();
  runApp(game.widget);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
