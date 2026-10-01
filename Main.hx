import hxd.App;
import hxd.res.DefaultFont;
import h2d.Text;

class Main extends App
{
	static function main() new Main();

	override function init()
	{
		var tf = new Text(DefaultFont.get(), s2d);
		tf.text = "Hello World !";
	}
}
