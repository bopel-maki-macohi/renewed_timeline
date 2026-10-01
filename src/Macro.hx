class Macro
{
	public static macro function getBuildDate() return macro $v{Date.now().getTime()};
}
