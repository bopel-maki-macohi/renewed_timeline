import hxd.Key.*;
import hxd.*;
import hxd.res.DefaultFont;
import h2d.*;

class Main extends App
{
	static function main() new Main();

	var entries = [
		{
			label: 'Renewed',
			url: 'https://docs.google.com/document/d/1ly5j3QDGpF3IUqMjyI2g6HWqnl4b9aObvczvmvBcLUw/edit?usp=sharing',
			point: 0,
			color: 0xF9E643,
		},
		{
			label: 'Renewed : Nicom',
			url: 'https://docs.google.com/document/d/1Tswod1xQVUFuXYcvITwCPebYGMkgRxZ437h-zw3lPBc/edit?usp=sharing',
			point: 1,
			color: 0x84FF5F,
		},
		{
			label: 'A Story About Desire',
			url: 'https://docs.google.com/document/d/1r46TpTyLjDt2G2Bg1Be-NAFQoefBgpiDlMBMj77nxWA/edit?usp=sharing',
			point: -1,
			color: 0xFFFF00,
		},
		{
			label: 'N / A',
			url: null,
			point: 2,
			color: 0xFFFFFF,
		},
		{
			label: 'N / A',
			url: null,
			point: 3,
			color: 0xFFFFFF,
		},
		{
			label: 'N / A',
			url: null,
			point: 4,
			color: 0xFFFFFF,
		},
	];

	var minX = 0.0;
	var maxX = 0.0;

	var title:Text;

	override function init()
	{
		final buildDate:Date = Date.fromTime(Macro.getBuildDate());

		var date = '${buildDate.getMonth() + 1}/${buildDate.getDate() + 1}/${buildDate.getFullYear()}';
		var time = '${buildDate.getHours()}:${buildDate.getMinutes()}:${buildDate.getSeconds()}';

		title = new Text(DefaultFont.get(), s2d);
		title.setScale(4);
		title.text = 'Renewed Timeline ($date @ $time)';
		title.x = title.y = 50;

		// ascending
		var order = -1;

		entries.sort((a, b) ->
		{
			if (a.point < b.point) return order;
			if (a.point > b.point) return -order;

			return 0;
		});

		trace([for (entry in entries) entry.label]);

		var points:Array<Point> = [];
		var pointTexts:Array<Text> = [];

		for (i => entry in entries)
		{
			var posX = title.x + ((Point.SIZE * 10) * i);
			var posY = title.y + (title.textHeight * title.scaleY) + (Point.SIZE * 4);

			var point = new Point(entry.color, posX, posY, s2d);
			points.push(point);

			var text = new Text(DefaultFont.get(), s2d);

			text.text = entry.label;
			text.setScale(2);

			text.x = posX - text.textWidth;
			text.y = posY + (point.spr.getSize().y * 2);

			pointTexts.push(text);
		}

		for (point in points) if (maxX < point.camPos()) maxX = point.camPos();
		for (text in pointTexts) if (minX > text.x) minX = text.x;
		
		maxX *= .15;
		minX *= 1.15;

		title.text = 'maX : $maxX, miX : $minX';
	}

	final nudgeAmount:Float = 1 / 10;

	override function update(dt:Float)
	{
		super.update(dt);

		// title.text = '$dt';

		if (isDown(LEFT) || isDown(A)) nudge(-nudgeAmount, dt);
		if (isDown(RIGHT) || isDown(D)) nudge(nudgeAmount, dt);
	}

	function nudge(amount:Float, dt:Float)
	{
		s2d.camera.x += amount / dt;

		if (s2d.camera.x < minX) s2d.camera.x = minX;
		if (s2d.camera.x > maxX) s2d.camera.x = maxX;
	}
}
