import flixel.util.FlxColor;
// import GameJolt.GameJoltAPI;
import flixel.FlxG;

using StringTools;

/**
 * @author BrightFyre
 */
class Achieve
{
	public var name:String;
	public var desc:String;
	public var sec:Bool;
	public var id:Int;
	public var img:String;
	public var color:FlxColor;

	public function new(nm:String, dsc:String, sec:Bool, id:Int, img:String, ?color:FlxColor = 0xFFFF00)
	{
		name = nm;
		desc = dsc;
		this.sec = sec;
		this.id = id;
		this.img = img;
		this.color = color;
	}
}

class Achievements
{
	public static var achievements:Array<Achieve> = [
		// bronze achievements
		new Achieve("Capturado", "Perde para Sans e Papyrus", true, 148410, "b1", FlxColor.fromRGB(219, 148, 77)),
		// silver achievements
		new Achieve("Indigno", "Acerte 50 notas de osso azul", false, 148408, "s1", FlxColor.fromRGB(192, 192, 192)),
		new Achieve("Indigno II", "Acerte 50 notas de tinta", false, 148409, "s2", FlxColor.fromRGB(192, 192, 192)),
		new Achieve("Indigno III", "Morrer em desespero 50 vezes", false, 148405, "s3", FlxColor.fromRGB(192, 192, 192)),
		new Achieve("Pacifista", "Escolha a paz", true, 148406, "s4", FlxColor.fromRGB(192, 192, 192)),
		new Achieve("Genocídio", "Matar Sans", false, 148422, "s5", FlxColor.fromRGB(192, 192, 192)),
		// gold achievements
		new Achieve("Gose?", "Toque a música secreta de Gose", true, 148412, "g1", FlxColor.fromRGB(255, 204, 51)),
		new Achieve("Leve um para a equipe", "Morra protegendo mugman", true, 157761, "g2", FlxColor.fromRGB(255, 204, 51)),
		new Achieve("Saness", "Toque a música secreta de Sanes", true, 157762, "g3", FlxColor.fromRGB(255, 204, 51)),
		new Achieve("Coragem", "Bata o Last Reel com força sem se esquivar uma vez", true, 158227, "g4", FlxColor.fromRGB(255, 204, 51)),
		new Achieve("O que é sangue?", "Jogue o segredo Fuel Canção", true, 0 /* there's no achievement yet, i don't wanna break anything tho*/, "g5",
			FlxColor.fromRGB(255, 204, 51)), // DO NOT USE THIS ONE YET! !!!!
		// platinum achievements
		new Achieve("O Cálice Lendário", "FC a semana inteira de Cuphead no Hard", false, 148401, "p1", FlxColor.fromRGB(254, 224, 104)),
		new Achieve("Determinação", "FC toda a semana Sans no Hard", false, 148402, "p2", FlxColor.fromRGB(254, 224, 104)),
		new Achieve("Traga para casa o bacon", "FC toda a semana Ink Demon no Hard", false, 148400, "p3", FlxColor.fromRGB(254, 224, 104)),
		new Achieve("Nocaute Supremo", "Derrote o Nightmare Cuphead", false, 148398, "p4", FlxColor.fromRGB(255, 0, 102)),
		new Achieve("TEMPO RUIM", "Derrote Nightmare Sans", false, 148399, "p5", FlxColor.fromRGB(0, 251, 251)),
		new Achieve("Erro de tinta", "Derrote Nightmare Bendy", false, 148397, "p6", FlxColor.fromRGB(255, 206, 0)),
		new Achieve("O Fim", "Passar toda semana", false, 148396, "p7", FlxColor.fromRGB(214, 214, 214))
	];

	public static function unlockAchievement(name:String = "", ?hasSound:Bool = true):Void
	{
		var ID:Int = 0;

		for (i in 0...achievements.length)
		{
			if (achievements[i].name == name)
			{
				ID = i;
			}
		}

		if (!FlxG.save.data.achievementsIndie[achievements[ID].id])
		{
			FlxG.save.data.achievementsIndie[achievements[ID].id] = true;

			// GameJoltAPI.getTrophy(achievements[ID].id);
			Main.gjToastManager.createToast(Paths.getPath('images/' + Achievements.achievements[ID].img + '.png', IMAGE, 'achievements'), Achievements.achievements[ID].name,
				Achievements.achievements[ID].desc, hasSound, Achievements.achievements[ID].color);

			FlxG.save.flush();
		}
	}

	public static function gotAll():Bool
	{
		var unfinished:Int = 0;
		for (i in 0...achievements.length)
		{
			if (!FlxG.save.data.achievementsIndie[achievements[i].id])
			{
				trace('hasnt done ' + achievements[i].name);
				unfinished++;
			}
		}

		if (unfinished == 0)
		{
			trace('user has 100%d :D');
			return true;
		}
		else
		{
			trace('user has not 100%d :(((');
			return false;
		}
	}

	public static function syncGJ():Void
	{
		for (i in 0...achievements.length)
		{
			if (FlxG.save.data.achievementsIndie[i])
			{
				// GameJoltAPI.getTrophy(achievements[i].id);
			}
		}
	}

	public static function defaultAchievements()
	{
		FlxG.save.data.achievementsIndie = [];
		for (i in 0...achievements.length)
		{
			FlxG.save.data.achievementsIndie[achievements[i].id] = false;
		}
		FlxG.save.flush();
	}
}
