import hxd.App;
import hxd.res.DefaultFont;
import h2d.Text;

class Main extends App
{
	static function main() new Main();

	override function init()
	{
		final buildDate:Date = Date.fromTime(Macro.getBuildDate());

		var date = '${buildDate.getMonth() + 1}/${buildDate.getDate() + 1}/${buildDate.getFullYear()}';
		var time = '${buildDate.getHours()}:${buildDate.getMinutes()}:${buildDate.getSeconds()}';

		var tf = new Text(DefaultFont.get(), s2d);
		tf.setScale(4);
		tf.text = 'Renewed Timeline ($date @ $time)';
		tf.x = tf.y = 50;
	}
}
