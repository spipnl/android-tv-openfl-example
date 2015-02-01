package;

import openfl.Lib;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Android TV OpenFL Example to demonstrate specific settings/functions for Andoid TV
 * 
 * @author spipnl (Jip Spinnewijn)
 */
class Main extends Sprite 
{
	var inited:Bool;
	var bitmap:Bitmap;
	var deviceTextField:TextField;

	function resize(e) 
	{
		if (!inited) {
			init();
		} else {
			resizeItems();
		}
	}
	
	/**
	 * Center the background image and the status text on resize
	 */
	function resizeItems()
	{
		var screenRatio = stage.stageWidth / stage.stageHeight;
		var bitmapRatio = bitmap.width / bitmap.height;
		
		var scale:Float = 1;
		bitmap.scaleX = bitmap.scaleY = scale;
		if (screenRatio > bitmapRatio) {
			scale = stage.stageHeight / bitmap.height;
		} else {
			scale = stage.stageWidth/ bitmap.width;
		}
		scale *= 0.9;
		
		bitmap.x = (stage.stageWidth - (bitmap.width * scale)) * 0.5;
		bitmap.y = (stage.stageHeight - (bitmap.height * scale)) * 0.5;
		bitmap.scaleX = bitmap.scaleY = scale;
		
		deviceTextField.width = stage.stageWidth;
		deviceTextField.y = (stage.stageHeight - deviceTextField.height) * 0.5;
	}
	
	/**
	 * On init, create a background image and a text field to show whether the app is running on Android TV or not
	 */
	function init() 
	{
		if (inited) return;
		inited = true;
		
        var bitmapData = Assets.getBitmapData("img/spipnl-logo.png");
		bitmap = new Bitmap(bitmapData);
		bitmap.smoothing = true;
		
		deviceTextField = new TextField();
		deviceTextField.width = stage.stageWidth;
		deviceTextField.height = 120;
		deviceTextField.border = true;
		deviceTextField.borderColor = 0x666666;
		deviceTextField.background = true;
		deviceTextField.backgroundColor = 0xFFFFFF;
		deviceTextField.alpha = 0.9;
		var textFormat:TextFormat = new TextFormat();
		var font = Assets.getFont("fonts/OpenSans-Bold.ttf");
		textFormat.font = font.fontName;
		textFormat.size = 80;
		textFormat.bold = true;
		textFormat.align = TextFormatAlign.CENTER;
		
		deviceTextField.embedFonts = true;
		
		// Call the native extension to check if the app is running on Android TV
		if (AndroidModeType.isAndriodTV()) {
			textFormat.color = 0x3C763D;
			deviceTextField.defaultTextFormat = textFormat;
			deviceTextField.text = 'Running on Android TV';
		} else {
			textFormat.color = 0xA94442;
			deviceTextField.defaultTextFormat = textFormat;
			deviceTextField.text = 'Not running on Android TV';
		}
		
        addChild(bitmap);
		addChild(deviceTextField);
		resizeItems();
	}
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
