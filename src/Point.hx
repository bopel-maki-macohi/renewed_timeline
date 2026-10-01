import h2d.*;

class Point extends Object
{
	public static final SIZE:Float = 40;

	public var spr:Graphics;

	public var hitbox:Interactive;

	public var url:String;

	override public function new(color:Int, x = 0.0, y = 0.0, ?parent:Object, ?url:String)
	{
		super(parent);

		this.x = x;
		this.y = y;
		this.url = url;

		spr = new Graphics(this);
		spr.beginFill(color);
		spr.drawCircle(0, 0, SIZE);
		spr.endFill();

		hitbox = new Interactive(SIZE, SIZE, this);
		hitbox.onClick = (e:Dynamic) ->
		{
			trace('[UNIMPLEMENTED] opening url $url');
		};

		hitbox.backgroundColor = 0xFF0000;

		hitbox.x += spr.getSize().x * .6;
		hitbox.y += spr.getSize().y * .5;
	}

	public function camPos() return this.x + (spr.getSize().x * 4);
}
