import h2d.*;

class Point extends Object
{
    public static final SIZE:Float = 40;

    public var spr:Graphics;
    
	override public function new(color:Int, x = 0.0, y = 0.0, ?parent:Object)
	{
		super(parent);

		this.x = x;
		this.y = y;

        spr = new Graphics(this);
        spr.beginFill(color);
        spr.drawCircle(0, 0, SIZE); 
        spr.endFill();
	}
}
