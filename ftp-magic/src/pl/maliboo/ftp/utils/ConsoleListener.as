package pl.maliboo.ftp.utils
{
	import spark.components.TextArea;
	import spark.components.TextInput;
	
	import pl.maliboo.ftp.FTPListener;
	import pl.maliboo.ftp.core.FTPClient;
	import pl.maliboo.ftp.events.FTPEvent;

	public class ConsoleListener extends FTPListener
	{
		private var textArea:TextArea;
		private var input:TextInput;
		public function ConsoleListener(client:FTPClient, output:TextArea, input:TextInput=null)
		{
			super(client);
			textArea = output;
			this.input = input;
		}
		
		private function append (text:String):void
		{
			textArea.text += text + "\n";
		}
		
		override public function commandSent (evt:FTPEvent):void
		{
			append("\t"+evt.command.toExecuteString().replace(/PASS .+/gi, "PASS *****"));
		}
		
		override public function responseReceived(evt:FTPEvent):void
		{
			append(evt.response.code + " " +evt.response.message);
		}		
	}
}