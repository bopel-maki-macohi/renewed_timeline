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
	];

	var minX = 0.0;
	var maxX = 0.0;

	override function init()
	{
		final buildDate:Date = Date.fromTime(Macro.getBuildDate());

		var date = '${buildDate.getMonth() + 1}/${buildDate.getDate() + 1}/${buildDate.getFullYear()}';
		var time = '${buildDate.getHours()}:${buildDate.getMinutes()}:${buildDate.getSeconds()}';

		var title = new Text(DefaultFont.get(), s2d);
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

		for (entry in entries)
		{
			var posX = title.x + ((Point.SIZE * 4) * entry.point);
			var posY = title.y + (title.textHeight * title.scaleY) + (Point.SIZE * 4);

			var point = new Point(entry.color, posX, posY, s2d);
			points.push(point);
		}

		for (point in points) if (s2d.camera.x < point.x) s2d.camera.x += (Math.abs(point.x + point.spr.getSize().x) + 20);
		maxX = Math.round(s2d.camera.x);

		s2d.camera.x = 0;

		for (point in points) if (s2d.camera.x > point.x) s2d.camera.x -= (Math.abs(point.x + point.spr.getSize().x) + 20);
		minX = Math.round(s2d.camera.x);

		// title.text = 'maX : $maxX, miX : $minX';
	}

	final nudgeAmount:Float = 10;

	override function update(dt:Float)
	{
		super.update(dt);

		if (isPressed(LEFT) || isPressed(A)) nudge(-nudgeAmount, dt);
		if (isPressed(RIGHT) || isPressed(D)) nudge(nudgeAmount, dt);
	}

	function nudge(amount:Float, dt:Float) s2d.camera.x = Math.max(Math.min(s2d.camera.x + amount * dt, maxX), minX);
}
