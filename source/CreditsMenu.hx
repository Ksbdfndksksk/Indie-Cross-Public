package;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import sys.Http;
import sys.io.Process;

using StringTools;

// ye i fucked up formatting
// cry about it
// change hxformat.json if u wanna avoid
class CreditsMenu extends MusicBeatState
{
	static final credits:Array<Array<String>> = [
		[
			'Brightfyre',
			"indie cross temporada 2",
			'Líder',
			"0",
			"https://linktr.ee/BrightFyre"
		],
		[
			'moro',
			"Nada é permanente. Os maus momentos passarão. Apenas mantenha-se junto",
			'Animador',
			"2",
			"https://twitter.com/moro_nighteye"
		],
		[
			'JzBoy',
			"Eu quero jogar FNF Indie Cross",
			"Artista",
			"0",
			"https://twitter.com/JzBoyAnims"
		],
		[
			'Iku Aldena',
			"Jtm como l7em, mas l7em para chwa e você para l7wa",
			"Artista",
			"1",
			"https://twitter.com/Iku_Aldena"
		],
		[
			'Crae',
			"hahahahahahahahahahahaahahahahahahhahahahahahahahahahaha lol",
			"Artista",
			"2",
			"https://www.youtube.com/channel/UCw56btKqHAJUYPYhjrDjuAw"
		],
		[
			'Diavololi',
			"Flagelo da Mongólia",
			"Artista",
			"0",
			"https://twitter.com/d1avololi"
		],
		[
			'Sugarratio',
			"Eu gosto de desenhar e animar bonecos",
			'Artista',
			"1",
			"https://twitter.com/SugarRatio"
		],
		[
			'Cally3D',
			"Fiz um modelo 3D singular por que estou aqui!?",
			"Artista",
			"1",
			"https://twitter.com/Cally3D"
		],
		[
			'River',
			"Espere, eu trabalhei nisso?",
			"Artista",
			"0",
			"https://twitter.com/RiverOaken"
		],
		[
			'nonsense',
			"você acabou de atirar em mim?",
			"Artista",
			"0",
			"https://www.youtube.com/c/NonsenseHumorLOL"
		],
		[
			'Sector',
			"Eu não acho que o Indie Cross pode vencer o Goku :/",
			"Desenvolvedor",
			"1",
			"https://twitter.com/Sector0003"
		],
		['Shadowfi', "mozo", 'Desenvolvedor', "0", "https://twitter.com/Shadowfi1385"],
		[
			'Gedehari',
			"Bom em programação, ruim em todo o resto.",
			"Desenvolvedor",
			"1",
			"https://twitter.com/gedehari"
		],
		[
			'Perez',
			"o Pepe",
			"Desenvolvedor",
			"0",
			"https://www.youtube.com/c/sebaelperezoso/featured"
		],
		[
			'Proxy',
			"fez suporte mp4, siga-me no twitter!111",
			"Desenvolvedor",
			"1",
			"https://twitter.com/polybiusproxy"
		],
		['Smokey', "Kenny é uma vadia", 'Desenvolvedor', "0", "https://twitter.com/Smokey_5_"],
		[
			'Hexar',
			"BrightFyre é um 5head",
			"Desenvolvedor",
			"0",
			"https://twitter.com/hexar__"
		],
		['volv', "Como eu cheguei aqui?", "Desenvolvedor", "0", "https://twitter.com/_Volved"],
		[
			'KadeDev',
			"pasc *barulhos de beijos*",
			"Desenvolvedor",
			"0",
			"https://twitter.com/KadeDesenvolvedor"
		],
		['Taeyai', "Eu não posso fazer nada!", "Desenvolvedor", "0", "https://twitter.com/Taeyai_"],
		['isophoro', "jogar vs isophoro", 'Desenvolvedor', "3", "https://twitter.com/isophoro"],
		[
			'Saster',
			"conteúdo de qualidade, como de costume",
			"Músico",
			"0",
			"https://www.youtube.com/channel/UCC4CkqOAwulRil3BEK9L3Mg"
		],
		[
			'Saru',
			"macaco masoquista",
			'Músico',
			"0",
			"https://www.youtube.com/channel/UCKLD_M9TFSzgMTECZ6lcyrw"
		],
		[
			'Tenzu',
			"pic OPI exceto admiração no carro TU Mar ECU tem U Wu",
			"Músico",
			"1",
			"https://www.youtube.com/channel/UC7KmfbdAPt2bYCcSNJnCm-g"
		],
		[
			'TheInnuend0',
			"H",
			"Músico",
			"0",
			"https://www.youtube.com/channel/UCPM7_b1BzPxOerSEJmKxZCw"
		],
		[
			'Orenji',
			"10 melhores queijos",
			"Músico",
			"0",
			"https://www.youtube.com/channel/UCUrh__AJo0Y_pCwJYjB7shw"
		],
		[
			'Yingyang',
			"Sans Undertale é meu pai",
			'Músico',
			"0",
			"https://www.youtube.com/channel/UCnIjU-JNj3szZ1Q8tLCKjuw"
		],
		[
			'Rozebud',
			"Baixar Bunker Bumrush",
			'Músico',
			"0",
			"https://www.youtube.com/c/Rozebud/featured"
		],
		[
			'DAGames',
			"Cadê minha esposa? Alguém pode encontrar minha esposa?",
			"Músico",
			"1",
			"https://www.youtube.com/channel/UCK7OXr0m5mnM1z9p7n_Bwfw"
		],
		[
			'CrystalSlime', // the cool one of the team (shhh dont tell the others) //WTF Crystal? - TaeYai
			"você pode acordar sendo você mesmo, mas não pode acordar sendo um eu diferente do que era originalmente. então atire para a lua entre todas as estrelas porque todo dia é uma chance de começar o dia com um novo dia. esse é o primeiro passo no processo de abrir sua mente",
			"Músico",
			"3",
			"https://www.youtube.com/channel/UCT_wYKD4twxoYOZt2ggXHlw"
		],
		[
			'BLVKAROT',
			"50% Sea, 50% Weed e 100% razão para lembrar o nome.",
			"Músico",
			"1",
			"https://www.youtube.com/channel/UCPRT4ptgtoz-jPD_hqJ3mtg"
		],
		[
			'Joan Atlas',
			"coma você mesmo",
			"Músico",
			"0",
			"https://www.youtube.com/channel/UCraIAPdHnnkJxfapv8oRv0w"
		],
		[
			'Mike Geno',
			"Eu faço música por diversão",
			"Músico",
			"0",
			"https://www.youtube.com/channel/UCyDQKOgEjuIiuPXctcuQKlg"
		],
		[
			'CDmusic',
			"oi eu sou bri'ish e faço música para um monte de coisas :p também 375bpm",
			"Músico",
			"2",
			"https://www.youtube.com/channel/UCOItBqiAAbWEdm21Mcv3g_Q"
		],
		[
			'BBpanzu',
			"Saiba seu valor.",
			"Músico",
			"0",
			"https://www.youtube.com/c/bbpanzuRulesSoSubscribeplz123/featured"
		],
		[
			'Brandxn',
			"Você pode me chamar de pior produtor",
			'Músico',
			"1",
			"https://www.youtube.com/c/Brandxns/featured"
		],
		['Kal', "eu amo snas", "Criador de Charts", "0", "https://twitter.com/Kal_050"],
		[
			'DJ',
			"A quantidade de caspa em seu cabelo mano, se eu fosse bater na sua cabeça. Seria uma cortina de fumaça",
			"Criador de Charts",
			"3",
			"https://twitter.com/AlchoholicDj"
		],
		[
			'Cerbera',
			"Nightmare Nightmare Nightmare Nightmare Nightmare Nightmare Nightmare",
			"Criador de Charts",
			"2",
			"https://twitter.com/Cerbera_fnf"
		],
		['Cval', "o que? sou jad?", "Criador de Charts", "0", "https://twitter.com/cval_brown"]
	];

	var specialThanksMain:String = "James Dijit (VA of Sammy)\n
		Dextermanning (Devil vocals)\n
		Fliper (Pixel art for the First Sans Cutscene)\n
		OblivionFall (Additional Anims and Special Effects)\n
		Mashed:Tim Bender (Additional Special Effects)\n
		J-Bug and YamaHearted (Owners of the Papyrus Song)\n
		Salterino(Sound effects)\n
		SrPelo (VA of Saness)\n
		Axelorca (Menu SFX)\n
		TentaRJ/Firubii (Original Flixel Gamejolt support)\n
		CanadianGoose (Cuphead Gameover Editor)\n
		Yoshubs (Additional Programming)";

	var specialThanksExtra:String = 'Penkaru\n
		Uniquegeese, StickyBM\n
		Woops, RayZord\n
		8owser16, Core\n
		VaporTheGamer, 8-BitRyan\n
		Dawko, niffirg\n
		Mikeeey, JellyFish\n
		HugeNate (i love hugenate)\n';

	var bg:FlxSprite;
	var bigIcon:FlxSprite;

	var selctionHighlighter:FlxSprite;

	var credIcons:Array<FlxSprite> = [];
	var bigIconsAssets:Array<FlxGraphic> = [];

	var bgAssets:Array<FlxGraphic> = [];

	var selXLerp:Float = 0;
	var selYLerp:Float = 0;

	var curIcon:Int = -1;

	var credLargeName:FlxText;
	var credQuoteText:FlxText;
	var credRoleText:FlxText;

	var credTypes:Array<String> = ["Líder", "Codificador", "Music", "Criador de Charts", "Artista"];

	var quoteBack:FlxSprite;

	var specialThanksText:FlxText;

	var thanksOverlay:FlxSprite;

	var thanksTitle:FlxSprite;

	var allowTransit:Bool = false;

	override function create()
	{
		super.create();

		persistentUpdate = true;

		bg = new FlxSprite().loadGraphic(Paths.image('credits/bg/Líder_BG', 'preload'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.highquality;
		add(bg);

		for (i in 0...credTypes.length)
		{
			var bgBitmap:FlxGraphic = Paths.image("credits/bg/" + credTypes[i] + '_BG', "preload");
			bgAssets.push(bgBitmap);
		}

		for (i in 0...credits.length)
		{
			var bigIconAsset:FlxGraphic = Paths.image("credits/icons/big_icons/" + credits[i][0], "preload");
			bigIconsAssets.push(bigIconAsset);
			// make the small ones use the big ones just resized, saves a bit of loading time(not really)

			var smallIcon:FlxSprite = new FlxSprite().loadGraphic(bigIconAsset);
			smallIcon.setGraphicSize(102, 102);
			smallIcon.updateHitbox();

			if (i < 28)
			{
				smallIcon.x = (17 + ((i * 110) % (7 * 110)));
				smallIcon.y = 25 + (110 * Math.ffloor(i / 7));
			}
			else
			{
				smallIcon.x = (55 + (((i - 1) * 110) % (6 * 110)));
				smallIcon.y = 25 + (110 * (Math.ffloor((i - 4) / 6)));
			}

			add(smallIcon);
			smallIcon.ID = i;
			FlxMouseEventManager.add(smallIcon, null, null, hoverCallback, null, false, true, false);

			credIcons.push(smallIcon);
		}

		selctionHighlighter = new FlxSprite(3, 11).loadGraphic(Paths.image('credits/icons/selector', 'preload'));
		selctionHighlighter.setGraphicSize(Std.int(selctionHighlighter.width * 0.7));
		selctionHighlighter.updateHitbox();
		selctionHighlighter.antialiasing = FlxG.save.data.highquality;
		selctionHighlighter.visible = false;
		add(selctionHighlighter);

		bigIcon = new FlxSprite(718, -50);
		bigIcon.scale.set(0.65, 0.65);
		bigIcon.updateHitbox();
		bigIcon.antialiasing = FlxG.save.data.highquality;
		add(bigIcon);
		bigIcon.loadGraphic(bigIconsAssets[0], false, bigIcon.frameWidth, bigIcon.frameHeight, true);

		credLargeName = new FlxText(748, 422, 500, 'MORO');
		credLargeName.setFormat(Paths.font("Bronx.otf"), 64, FlxColor.WHITE);
		credLargeName.alignment = CENTER;
		add(credLargeName);

		credRoleText = new FlxText(770, 478, 450, 'Líder');
		credRoleText.setFormat(Paths.font("Bronx.otf"), 32, 0xFFB254FF);
		credRoleText.alignment = CENTER;
		add(credRoleText);

		quoteBack = new FlxSprite(744, 535).loadGraphic(Paths.image('credits/bg/quote_box', 'preload'));
		quoteBack.setGraphicSize(Std.int(quoteBack.width * 0.75));
		quoteBack.updateHitbox();
		quoteBack.antialiasing = FlxG.save.data.highquality;
		quoteBack.blend = OVERLAY;
		quoteBack.visible = false;
		add(quoteBack);

		specialThanksText = new FlxText(quoteBack.x, quoteBack.y + 120, 500, 'Pressione TAB para agradecimentos especiais');
		specialThanksText.setFormat(Paths.font("Bronx.otf"), 16, FlxColor.WHITE);
		specialThanksText.alignment = CENTER;
		add(specialThanksText);

		credQuoteText = new FlxText(740, 580, 500, " ");
		credQuoteText.setFormat(Paths.font("Bronx.otf"), 28, FlxColor.WHITE);
		credQuoteText.alignment = CENTER;
		add(credQuoteText);

		thanksOverlay = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
		thanksOverlay.updateHitbox();
		thanksOverlay.screenCenter();
		thanksOverlay.scrollFactor.set();
		thanksOverlay.alpha = 0.00001;
		add(thanksOverlay);

		thanksTitle = new FlxSprite(0, 50);
		thanksTitle.frames = Paths.getSparrowAtlas('credits/Special_Thanks', 'preload');
		thanksTitle.animation.addByPrefix('play', 'SP instance 1', 24, true);
		thanksTitle.animation.play('play');
		thanksTitle.updateHitbox();
		thanksTitle.screenCenter(X);
		thanksTitle.antialiasing = FlxG.save.data.highquality;
		thanksTitle.alpha = 0;
		add(thanksTitle);

		lthanks = new FlxText(0, 200, 500, specialThanksMain);
		lthanks.setFormat(Paths.font("Bronx.otf"), 16, FlxColor.WHITE);
		lthanks.alignment = LEFT;
		lthanks.screenCenter(X);
		lthanks.x -= 200;
		lthanks.alpha = 0;
		add(lthanks);

		rthanks = new FlxText(0, 200, 500, specialThanksExtra);
		rthanks.setFormat(Paths.font("Bronx.otf"), 16, FlxColor.WHITE);
		rthanks.alignment = RIGHT;
		rthanks.screenCenter(X);
		rthanks.x += 200;
		rthanks.alpha = 0;
		add(rthanks);

		updateSelection(0);

		#if android
		addVirtualPad(NONE, A_B_C);
		#end

		new FlxTimer().start(Main.transitionDuration, function(tmr:FlxTimer)
		{
			allowTransit = true;
		});
	}

	var lthanks:FlxText;
	var rthanks:FlxText;

	function hoverCallback(object:FlxObject)
	{
		if (!thanksOpen)
		{
			trace("overlap " + object.ID);
			FlxG.sound.play(Paths.sound('scrollMenu'));
			updateSelection(object.ID);
			curIcon = object.ID;
		}
	}

	function backOut()
	{
		if (thanksOpen)
		{
			thanksOpen = false;
			FlxTween.tween(selctionHighlighter, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(specialThanksText, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(thanksTitle, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(lthanks, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(rthanks, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(thanksOverlay, {alpha: 0}, 0.5, {
				ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					whiteTweening = false;
				}
			});
		}
		else
		{
			allowTransit = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}
	}

	var thanksOpen:Bool = false;
	var whiteTweening:Bool = false;

	function toggleThanks()
	{
		if (!whiteTweening)
		{
			whiteTweening = true;
			if (!thanksOpen)
			{
				// open menu
				thanksOpen = true;
				FlxTween.tween(selctionHighlighter, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(specialThanksText, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(thanksTitle, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(lthanks, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(rthanks, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(thanksOverlay, {alpha: 0.7}, 0.5, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						whiteTweening = false;
					}
				});
			}
			else
			{
				// close menu
				thanksOpen = false;
				FlxTween.tween(selctionHighlighter, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(specialThanksText, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(thanksTitle, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(lthanks, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(rthanks, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(thanksOverlay, {alpha: 0}, 0.5, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						whiteTweening = false;
					}
				});
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT && !thanksOpen)
		{
			HelperFunctions.fancyOpenURL(credits[curIcon][4]);
		}

		if (controls.BACK && allowTransit)
		{
			backOut();
		}

		if (FlxG.keys.justPressed.TAB #if android || virtualPad.buttonC.justPressed #end)
		{
			toggleThanks();
		}

		for (i in 0...credIcons.length)
		{
			var smallIcon:FlxSprite = credIcons[i];

			#if android
			for (touch in FlxG.touches.list)
			{
				if ((curIcon == i && touch.overlaps(credIcons[curIcon])) && !thanksOpen)
					smallIcon.alpha = 1.0;
				else
					smallIcon.alpha = 0.5;
			}
			#else
			if ((curIcon == i && FlxG.mouse.overlaps(credIcons[curIcon])) && !thanksOpen)
			{
				smallIcon.alpha = 1.0;
				if (FlxG.mouse.justReleased)
				{
					FlxG.openURL(credits[curIcon][4]);
				}
			}
			else
			{
				smallIcon.alpha = 0.5;
			}
			#end
		}

		selctionHighlighter.x = FlxMath.lerp(selctionHighlighter.x, selXLerp, 0.25);
		selctionHighlighter.y = FlxMath.lerp(selctionHighlighter.y, selYLerp, 0.25);

		super.update(elapsed);
	}

	function updateSelection(sel:Int)
	{
		var smallIcon:FlxSprite = credIcons[sel];

		selXLerp = smallIcon.x - 14;
		selYLerp = smallIcon.y - 14;
		selctionHighlighter.visible = true;

		smallIcon.alpha = 1.0;

		credLargeName.text = credits[sel][0];
		credQuoteText.text = credits[sel][1];

		quoteBack.visible = true;
		if (credQuoteText.text == " ")
		{
			quoteBack.visible = false;
		}

		switch (credits[sel][2])
		{
			case 'Líder':
				bg.loadGraphic(bgAssets[0], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(178, 84, 255);
				credRoleText.text = 'Líder';
			case 'Artista':
				bg.loadGraphic(bgAssets[4], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(255, 218, 82);
				credRoleText.text = 'Artista';
			case 'Animador':
				bg.loadGraphic(bgAssets[4], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(255, 218, 82);
				credRoleText.text = 'Animador';
			case 'Criador de Charts':
				bg.loadGraphic(bgAssets[3], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(82, 255, 151);
				credRoleText.text = 'Criador de Charts';
			case 'Desenvolvedor':
				bg.loadGraphic(bgAssets[1], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(255, 92, 82);
				credRoleText.text = 'Desenvolvedor';
			case 'Músico':
				bg.loadGraphic(bgAssets[2], false, bg.frameWidth, bg.frameHeight, true);
				credRoleText.color = FlxColor.fromRGB(82, 119, 255);
				credRoleText.text = 'Músico';
		}

		switch (credits[sel][0])
		{
			case 'Proxy':
				credLargeName.setFormat(Paths.font("Comic Sans MS.ttf"), 64, FlxColor.WHITE);
				credQuoteText.setFormat(Paths.font("Comic Sans MS.ttf"), 28, FlxColor.WHITE);
				credRoleText.font = Paths.font("Comic Sans MS.ttf");
				credLargeName.text = 'PolyProxy';
				credRoleText.offset.x = 5; // wtf i hate offsets
				credLargeName.offset.y = 10; // wtf i hate offsets
			case 'River':
				credLargeName.text = 'RiverOaken';
			case 'Gedehari':
				credLargeName.text = 'Sqirra-RNG';
			default:
				credRoleText.offset.x = 0;
				credLargeName.offset.x = 0;
				credLargeName.setFormat(Paths.font("Bronx.otf"), 64, FlxColor.WHITE);
				credQuoteText.setFormat(Paths.font("Bronx.otf"), 28, FlxColor.WHITE);
				credRoleText.font = Paths.font("Bronx.otf");
				credRoleText.offset.x = 0;
				credLargeName.offset.y = 0;
		}

		credQuoteText.y = 580;

		switch (credits[sel][3]) // no text heights on flxsprite bc its automatic? :C
		{
			case '1':
				credQuoteText.y -= (12 * 1);
			case '2':
				credQuoteText.y -= (12 * 2);
			case '3':
				credQuoteText.y -= (12 * 3);
		}

		bigIcon.loadGraphic(bigIconsAssets[sel], false, bigIcon.frameWidth, bigIcon.frameHeight, true);
	}
}
