package;

// import GameJolt.GameJoltAPI;
// import GameJolt.GameJoltLogin;
import Shaders.FXHandler;
import flixel.FlxG;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Lib;

class OptionCategory
{
	private var _options:Array<Option> = new Array<Option>();

	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Category";

	public final function getName()
	{
		return _name;
	}

	public function new(catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}

	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;

	public var allowFastChange:Bool = true;

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return throw "stub!";
	};

	// Returns whether the label is to be updated.
	public function press():Bool
	{
		return throw "stub!";
	}

	private function updateDisplay():String
	{
		return throw "stub!";
	}

	public function left():Bool
	{
		return throw "stub!";
	}

	public function right():Bool
	{
		return throw "stub!";
	}
}

class LaneUnderlayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		FlxG.save.data.laneUnderlay = !FlxG.save.data.laneUnderlay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.laneUnderlay ? "Subjacencia da pista" : "Sem underlay de pista");
	}

	override function right():Bool
	{
		FlxG.save.data.laneTransparency += 0.1;

		if (FlxG.save.data.laneTransparency < 0)
			FlxG.save.data.laneTransparency = 0;

		if (FlxG.save.data.laneTransparency > 1)
			FlxG.save.data.laneTransparency = 1;
		return true;
	}

	override function getValue():String
	{
		return "Transparencia atual da subjacencia da pista: " + HelperFunctions.truncateFloat(FlxG.save.data.laneTransparency, 1);
	}

	override function left():Bool
	{
		FlxG.save.data.laneTransparency -= 0.1;

		if (FlxG.save.data.laneTransparency < 0)
			FlxG.save.data.laneTransparency = 0;

		if (FlxG.save.data.laneTransparency > 1)
			FlxG.save.data.laneTransparency = 1;

		return true;
	}
}

class ShowMS extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.showms = !FlxG.save.data.showms;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.showms ? "Temporizacao MS habilitada" : "Temporizacai MS desabilitada");
	}
}

class MechsInputVariants extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.mechsInputVariants = !FlxG.save.data.mechsInputVariants;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		if (FlxG.save.data.mechsInputVariants == true)
		    return "Botoes Hitbox cima";
		else if (FlxG.save.data.mechsInputVariants == false)
			return "Botoes Hitbox baixo";

		return "a merda esta quebrada";
	}
}

class ShowSubtitles extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.showsubs = !FlxG.save.data.showsubs;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.showsubs ? "Legendas ligadas" : "Legendas desligada");
	}
}

class DFJKOption extends Option
{
	private var controls:Controls;

	public function new()
	{
		super();
	}

	public override function press():Bool
	{
		OptionsMenu.instance.openSubState(new KeyBindMenu());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Combinacoes de teclas";
	}
}

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.cpuStrums ? "Batentes de CPU leves" : "Os Strums da CPU permanecem estaticos";
	}
}

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.downscroll ? "Downscroll" : "Upscroll";
	}
}

class Photosensitive extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.photosensitive = !FlxG.save.data.photosensitive;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.photosensitive ? "Fotossensível ativado" : "Fotossensível desligado";
	}
}

class FocusFreeze extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.focusfreeze = !FlxG.save.data.focusfreeze;
		FlxG.autoPause = FlxG.save.data.focusfreeze;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.focusfreeze ? "Congelar Janela de Foco ligado" : "Congelar Janela de Foco desligado";
	}
}

class FocusPause extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.focuspause = !FlxG.save.data.focuspause;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.focuspause ? "Foco Pausa na Musica ligado" : "Foco Pausa na Música desligado";
	}
}

class HighQuality extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.highquality = !FlxG.save.data.highquality;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.highquality ? "Alta qualidade" : "Baixa Qualidade";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.ghost ? "com Ghost Tapping" : "sem Ghost Tapping";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Precisao " + (!FlxG.save.data.accuracyDisplay ? "desligado" : "ativo");
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Posicao da barra de musica " + (!FlxG.save.data.songPosition ? "desligado" : "ativo");
	}
}

class Hitsounds extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.hitsounds = !FlxG.save.data.hitsounds;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hitsounds " + (FlxG.save.data.hitsounds ? "ativo" : "desligado");
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Botao de reseta " + (!FlxG.save.data.resetButton ? "desligado" : "ativo");
	}
}

class ShowInput extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.inputShow = !FlxG.save.data.inputShow;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.inputShow ? "Informacoes de pontuacao estendida" : "Informacoes minimizadas");
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return true;
	}

	private override function updateDisplay():String
	{
		return "Taxa de Quadros";
	}

	override function left():Bool
	{
		if (Conductor.safeFrames == 1)
			return false;

		Conductor.safeFrames -= 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return false;
	}

	override function getValue():String
	{
		return "Taxa de Quadros: "
			+ Conductor.safeFrames
			+ " - SIK: "
			+ HelperFunctions.truncateFloat(45 * Conductor.timeScale, 0)
			+ "ms GD: "
			+ HelperFunctions.truncateFloat(90 * Conductor.timeScale, 0)
			+ "ms BD: "
			+ HelperFunctions.truncateFloat(135 * Conductor.timeScale, 0)
			+ "ms SHT: "
			+ HelperFunctions.truncateFloat(166 * Conductor.timeScale, 0)
			+ "ms TOTAL: "
			+ HelperFunctions.truncateFloat(Conductor.safeZoneOffset, 0)
			+ "ms";
	}

	override function right():Bool
	{
		if (Conductor.safeFrames == 20)
			return false;

		Conductor.safeFrames += 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return true;
	}
}

class Colorblind extends Option
{
	public function new(desc:String)
	{
		super();
		allowFastChange = false;
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	override function left():Bool
	{
		if (FlxG.save.data.colorblind == 0)
			return false;

		FlxG.save.data.colorblind -= 1;
		trace(FlxG.save.data.colorblind);

		FXHandler.UpdateColors();

		return true;
	}

	override function getValue():String
	{
		return "Modo daltonico: " + intToMode(FlxG.save.data.colorblind);
	}

	private override function updateDisplay():String
	{
		return "Modo daltonico";
	}

	function intToMode(i:Int):String
	{
		var mode:String = 'Nenhum';
		switch (i)
		{
			case 0:
				mode = 'Nenhum';
			case 1:
				mode = 'Protanopia (Red Blind)';
			case 2:
				mode = 'Protanomaly (Red Weak)';
			case 3:
				mode = 'Deuteranopia (Green Blind)';
			case 4:
				mode = 'Deuteranomaly (Green Weak)';
			case 5:
				mode = 'Tritanopia (Blue Blind)';
			case 6:
				mode = 'Tritanomaly (Blue Blind)';
			case 7:
				mode = 'Achromatopsia (Monochromacy)';
			case 8:
				mode = 'Achromatomaly (Blue Cone Monochromacy)';
		}
		return mode;
	}

	override function right():Bool
	{
		if (FlxG.save.data.colorblind == 8)
			return false;

		FlxG.save.data.colorblind += 1;
		trace(FlxG.save.data.colorblind);

		FXHandler.UpdateColors();

		return true;
	}
}

class Resolution extends Option
{
	public function new(desc:String)
	{
		super();
		allowFastChange = false;
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		FlxG.resizeWindow(intToMode(FlxG.save.data.resolution)[0], intToMode(FlxG.save.data.resolution)[1]);
		FlxG.resizeGame(intToMode(FlxG.save.data.resolution)[0], intToMode(FlxG.save.data.resolution)[1]);
		trace(FlxG.width);
		trace(FlxG.height);
		display = updateDisplay();
		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.resolution == 0)
			return false;

		FlxG.save.data.resolution -= 1;
		trace(FlxG.save.data.resolution);
		// FlxG.resizeWindow(intToMode(FlxG.save.data.resolution)[0],intToMode(FlxG.save.data.resolution)[1]);

		return true;
	}

	override function getValue():String
	{
		return "Resolucao " + intToMode(FlxG.save.data.resolution)[0] + 'x' + intToMode(FlxG.save.data.resolution)[1];
	}

	private override function updateDisplay():String
	{
		return "Resolucao " + intToMode(FlxG.save.data.resolution)[0] + 'x' + intToMode(FlxG.save.data.resolution)[1];
	}

	function intToMode(i:Int):Array<Int>
	{
		var resolution:Array<Int> = [];
		switch (i)
		{
			case 0:
				resolution = [640, 360];
			case 1:
				resolution = [768, 432];
			case 2:
				resolution = [896, 504];
			case 3:
				resolution = [1024, 576];
			case 4:
				resolution = [1152, 648];
			case 5:
				resolution = [1280, 720];
			case 6:
				resolution = [1920, 1080];
			case 7:
				resolution = [2560, 1440];
			case 8:
				resolution = [3840, 2160];
		}
		return resolution;
	}

	override function right():Bool
	{
		if (FlxG.save.data.resolution == 8)
			return false;

		FlxG.save.data.resolution += 1;
		trace(FlxG.save.data.resolution);

		return true;
	}
}

class Gamma extends Option
{
	public function new(desc:String)
	{
		super();
		allowFastChange = false;
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Gama";
	}

	override function right():Bool
	{
		if (FlxG.save.data.gamma < 5)
		{
			FlxG.save.data.gamma += 0.1;
			FXHandler.UpdateColors();
		}
		else
		{
			FlxG.save.data.gamma = 5;
			return false;
		}

		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.gamma > 0.1)
		{
			FlxG.save.data.gamma -= 0.1;
			FXHandler.UpdateColors();
		}
		else
		{
			FlxG.save.data.gamma = 0.1;
			return false;
		}

		return true;
	}

	override function getValue():String
	{
		return "Valor Gama Atual: " + FlxG.save.data.gamma;
	}
}

class Brightness extends Option
{
	public function new(desc:String)
	{
		super();
		allowFastChange = false;
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Brilho";
	}

	override function right():Bool
	{
		if (FlxG.save.data.brightness < 200)
		{
			FlxG.save.data.brightness += 10;
			FXHandler.UpdateColors();
		}
		else
		{
			FlxG.save.data.brightness = 200;
			return false;
		}

		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.brightness > -200)
		{
			FlxG.save.data.brightness -= 10;
			FXHandler.UpdateColors();
		}
		else
		{
			FlxG.save.data.brightness = -200;
			return false;
		}

		return true;
	}

	override function getValue():String
	{
		return "Valor de brilho atual: " + FlxG.save.data.brightness;
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast(Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Contador de FPS " + (!FlxG.save.data.fps ? "desligado" : "ativo");
	}
}

class MemOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.memory = !FlxG.save.data.memory;
		(cast(Lib.current.getChildAt(0), Main)).toggleMemCounter(FlxG.save.data.memory);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Contador de memoria " + (!FlxG.save.data.memory ? "desligado" : "ativo");
	}
}

class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Limite de FPS";
	}

	override function right():Bool
	{
		if (FlxG.save.data.fpsCap >= 290)
		{
			FlxG.save.data.fpsCap = 290;
			(cast(Lib.current.getChildAt(0), Main)).setFPSCap(290);
		}
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;
		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.fpsCap > 290)
			FlxG.save.data.fpsCap = 290;
		else if (FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
				(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		return true;
	}

	override function getValue():String
	{
		return "Limite de FPS atual: "
			+ FlxG.save.data.fpsCap
			+ (FlxG.save.data.fpsCap == Application.current.window.displayMode.refreshRate ? "Hz (Refresh Rate)" : "");
	}
}

class HudAlpha extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Transparencia do HUD";
	}

	override function right():Bool
	{
		if (FlxG.save.data.hudalpha >= 1)
			FlxG.save.data.hudalpha = 1;
		else
			FlxG.save.data.hudalpha += 0.1;

		return true;
	}

	override function left():Bool
	{
		if (FlxG.save.data.hudalpha <= 0.4)
			FlxG.save.data.hudalpha = 0.4;
		else
			FlxG.save.data.hudalpha -= 0.1;
		return true;
	}

	override function getValue():String
	{
		return "Valor atual da transparencia do Hud: " + FlxG.save.data.hudalpha;
	}
}

class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		(cast(Lib.current.getChildAt(0), Main)).changeDisplayColor(FlxColor.WHITE);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Exibir arco-iris " + (!FlxG.save.data.fpsRain ? "desligado" : "ativo");
	}
}

class Optimization extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.optimize = !FlxG.save.data.optimize;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Otimizacao " + (FlxG.save.data.optimize ? "ATIVO" : "DESLIGADO");
	}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Exibicao NPS " + (!FlxG.save.data.npsDisplay ? "desligado" : "ativo");
	}
}

class AccuracyDOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Modo preciso: " + (FlxG.save.data.accuracyMod == 0 ? "Exato" : "Complexo");
	}
}

class CustomizeGameplay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new GameplayCustomizeState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Personalizar jogabilidade";
	}
}

/*class LogInGJ extends Option
	{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("cock");
		GameJoltLogin.fromOptions = true;
		FlxG.switchState(new GameJoltLogin());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Log In to Gamejolt";
	}
	}

	class LogOutGJ extends Option
	{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		GameJoltAPI.deAuthDaUser();
		TitleState.restart();
		return false;
	}

	private override function updateDisplay():String
	{
		return "Log Out of Gamejolt";
	}
}*/
class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		var poop:String = Highscore.formatSong("Tutorial", 1);

		PlayState.SONG = Song.loadFromJson(poop, "Tutorial");
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
	}
}

class BotPlay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay " + (FlxG.save.data.botplay ? "ativo" : "desligado");
}

class CamZoomOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.camzoom = !FlxG.save.data.camzoom;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zoom " + (!FlxG.save.data.camzoom ? "desligado" : "ativo");
	}
}
