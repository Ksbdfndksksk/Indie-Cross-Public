package;

import animateAtlasPlayer.textures.SubTexture;
import flixel.math.FlxMath;
import Options;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class OptionsMenu extends MusicBeatState
{
	public static var instance:OptionsMenu;

	var selector:FlxText;
	var curSelected:Int = 0;

	var options:Array<OptionCategory> = [
		new OptionCategory("Jogabilidade", [
			new DFJKOption(),
			#if android
			new MechsInputVariants("Variantes de insumos para mecânica. !!!ESTA OPÇÃO AFETA APENAS A ENTRADA HITBOX!!!"),
			#end
			new DownscrollOption("Alterar o layout do strumline."),
			new GhostTapOption("Ghost Tapping é quando você toca em uma direção e não dá erro."),
			new BotPlay("Exiba seus gráficos e mods com reprodução automática."),
			new ResetButtonOption("Alterne pressionando R para gameover."),
			new Hitsounds("Alternar sons de acertos."),
			new Judgement("Personalize seus tempos de acerto (ESQUERDA ou DIREITA)"),
			new AccuracyDOption("Altere como a precisão é calculada. (Preciso = Simples, Complexo = Baseado em Milissegundos)")
		]),
		new OptionCategory("Aparencia", [
			new SongPositionOption("Mostra a posição atual das músicas (como uma barra)"),
			new HudAlpha("Altere a transparência do seu HUD"),
			new LaneUnderlayOption("Alternar uma faixa em andamento (esquerda ou direita para transparência)"),
			new CamZoomOption("Alterne o zoom da câmera no jogo."),
			new AccuracyOption("Exibir informações de precisão."),
			new NPSDisplayOption("Mostra suas notas atuais por segundo."),
			new ShowMS("Mostrar a contagem de MS para cada nota pressionada")
		]),
		new OptionCategory("atuacao", [
			new Photosensitive("Desligue os efeitos visuais que podem prejudicar sua visão."),
			new HighQuality("Ative o modo de baixa qualidade para uma experiência de jogo mais suave."),
		]),
		new OptionCategory("PC", [
			#if !android
			new Resolution("Altere a resolução do jogo, pressione ENTER para aplicar"),
			#end
			new Gamma("Alterar o valor gama do aplicativo."),
			new Brightness("Altere o valor de brilho do aplicativo."),
			new FocusFreeze("Congele o jogo ao clicar fora do aplicativo."),
			new FocusPause("Abra o menu de pausa ao clicar fora do aplicativo em uma música (funciona apenas com Focus Freeze)."),
			new FPSCapOption("Limite seu FPS"),
			new FPSOption("Alternar o contador de FPS"),
			new MemOption("Alternar o contador de memória"),
			new RainbowFPSOption("Faça o FPS e o contador de memória Arco-íris")
		]),
		new OptionCategory("Acessibilidade", [
			new ShowSubtitles("Mostrar legendas durante as cutscenes."),
			new Colorblind("")
			// new LogInGJ("Log into gamejolt for achievements & perks"),
			// new LogOutGJ("Log out of your gamejolt account")
		])
	];

	public var acceptInput:Bool = true;

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<Alphabet>;

	public static var versionShit:FlxText;

	var currentSelectedCat:OptionCategory;
	var blackBorder:FlxSprite;

	public static var fromFreeplay:Bool = false;
	public static var returnedfromOptions:Bool = false;

	var allowTransit:Bool = false;

	static var outOfCatSel:Int = 0;

	override function create()
	{
		super.create();

		persistentUpdate = true;

		instance = this;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/BG', 'preload'));
		// bg.setGraphicSize(Std.int(bg.width * 0.675));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.highquality;
		add(bg);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...options.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !! ma dumbass didnt read this lmao
		}

		currentDescription = "Nenhum";

		versionShit = new FlxText(5, FlxG.height + 40, 0, "Offset (Esquerda, Direita, Shift para lento): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2),
			12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(HelperFunctions.returnMenuFont(versionShit), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		blackBorder = new FlxSprite(-30, FlxG.height + 40).makeGraphic((Std.int(versionShit.width + 973)), Std.int(versionShit.height + 600), FlxColor.BLACK);
		blackBorder.alpha = 0.5;

		add(blackBorder);

		add(versionShit);

		FlxTween.tween(versionShit, {y: FlxG.height - 18}, 2, {ease: FlxEase.elasticInOut});
		FlxTween.tween(blackBorder, {y: FlxG.height - 18}, 2, {ease: FlxEase.elasticInOut});

		changeSelection(0);

		#if android
		addVirtualPad(LEFT_FULL, A_B_C);
		#end

		new FlxTimer().start(Main.transitionDuration, function(tmr:FlxTimer)
		{
			allowTransit = true;
		});
	}

	var isCat:Bool = false;
	var backed:Bool = false;

	function accept()
	{
		if (isCat)
		{
			FlxG.save.flush();
			if (currentSelectedCat.getOptions()[curSelected].press())
			{
				grpControls.members[curSelected].changeText(currentSelectedCat.getOptions()[curSelected].getDisplay());
				trace(currentSelectedCat.getOptions()[curSelected].getDisplay());
			}

			changeSelection(curSelected);
		}
		else
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			currentSelectedCat = options[curSelected];
			isCat = true;
			grpControls.clear();
			for (i in 0...currentSelectedCat.getOptions().length)
			{
				var controlLabel:Alphabet = new Alphabet(0, ((FlxMath.remapToRange(i, 0, 1, 0, 1.3) * 120) + (FlxG.height * 0.48)),
					currentSelectedCat.getOptions()[i].getDisplay(), true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			}

			outOfCatSel = curSelected;
			trace('outOfCatSel: ' + outOfCatSel);
			curSelected = 0;

			changeSelection(curSelected);
		}
	}

	function backOut()
	{
		FlxG.save.flush();
		if (!isCat && !backed)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			backed = true;
			returnedfromOptions = true;

			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.fadeOut(0.5, 0);
			}

			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				FlxG.sound.music.stop();
				if (fromFreeplay)
				{
					LoadingState.target = new PlayState();
					LoadingState.stopMusic = true;
					fromFreeplay = false;

					FlxG.switchState(new LoadingState());
				}
				else
					FlxG.switchState(new MainMenuState());
			});
		}
		else if (isCat && !backed)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			isCat = false;
			grpControls.clear();
			for (i in 0...options.length)
			{
				var controlLabel:Alphabet = new Alphabet(0, ((FlxMath.remapToRange(i, 0, 1, 0, 1.3) * 120) + (FlxG.height * 0.48)), options[i].getName(),
					true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			}

			trace('outOfCatSel: ' + outOfCatSel);
			// curSelected = outOfCatSel;
			curSelected = 0;

			changeSelection(curSelected);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing && !backed)
				FlxG.sound.playMusic(Paths.music('settin', 'preload'), 1);
		}

		if (acceptInput)
		{
			if (controls.ACCEPT)
			{
				accept();
			}

			if (controls.BACK && allowTransit)
			{
				backOut();
			}

			if (controls.UP_P)
			{
				changeSelection(curSelected - 1);
			}
			if (controls.DOWN_P)
			{
				changeSelection(curSelected + 1);
			}

			if (isCat)
			{
				if (currentSelectedCat.getOptions()[curSelected].getAccept())
				{
					catOption();
				}
				else
				{
					offsetChange();
				}
			}
			else
			{
				offsetChange();
			}
		}
	}

	function catOption()
	{
		if ((FlxG.keys.pressed.SHIFT #if android || virtualPad.buttonC.pressed #end)
			|| !currentSelectedCat.getOptions()[curSelected].allowFastChange)
		{
			if (controls.RIGHT_P)
				currentSelectedCat.getOptions()[curSelected].right();
			FlxG.save.flush();
			if (controls.LEFT_P)
				currentSelectedCat.getOptions()[curSelected].left();
			FlxG.save.flush();
		}
		else
		{
			if (controls.RIGHT)
				currentSelectedCat.getOptions()[curSelected].right();
			else if (controls.LEFT)
				currentSelectedCat.getOptions()[curSelected].left();
		}

		versionShit.text = currentSelectedCat.getOptions()[curSelected].getValue();
		if (currentDescription != '')
		{
			versionShit.text += " - Descrição - " + currentDescription;
		}
	}

	function offsetChange()
	{
		if (FlxG.keys.pressed.SHIFT #if android || virtualPad.buttonC.pressed #end)
		{
			if (controls.RIGHT_P)
				FlxG.save.data.offset += 0.1;
			else if (controls.LEFT_P)
				FlxG.save.data.offset -= 0.1;
		}
		else if (controls.RIGHT)
			FlxG.save.data.offset += 0.1;
		else if (controls.LEFT)
			FlxG.save.data.offset -= 0.1;

		versionShit.text = "Offset (Esquerda, Direita, Shift para lento): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Descrição - "
			+ currentDescription;
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		if (change != curSelected)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (change < 0)
			change = grpControls.length - 1;
		if (change >= grpControls.length)
			change = 0;

		curSelected = change;

		if (isCat)
			currentDescription = currentSelectedCat.getOptions()[curSelected].getDescription();
		else
			currentDescription = "Por favor, selecione uma categoria";
		if (isCat)
		{
			if (currentSelectedCat.getOptions()[curSelected].getAccept())
				versionShit.text = currentSelectedCat.getOptions()[curSelected].getValue() + " - Descrição - " + currentDescription;
			else
				versionShit.text = "Offset (Esquerda, Direita, Shift para lento): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Descrição - "
					+ currentDescription;
		}
		else
			versionShit.text = "Offset (Esquerda, Direita, Shift para lento): " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 2) + " - Descrição - "
				+ currentDescription;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}
}
