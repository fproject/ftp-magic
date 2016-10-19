package net.projectkit.ftp
{
	import mx.collections.ArrayCollection;
	
	import spark.components.TextArea;
	
	import pl.maliboo.ftp.core.FTPClient;
	import pl.maliboo.ftp.events.FTPEvent;
	import pl.maliboo.ftp.utils.ConsoleListener;

	public class FTPClientApp
	{
		private static var _instance:FTPClientApp;
		
		/**
		 * Constructor 
		 * 
		 */
		public function FTPClientApp(se:SingletonEnforce)
		{
			if(se == null)
				throw new Error("Singleton Error");
			initClientHandlers();
		}
		
		/**
		 * Singleton 
		 * 
		 */
		public static function get instance():FTPClientApp
		{
			if (_instance == null)
				_instance = new FTPClientApp(new SingletonEnforce);
			return _instance;
		}
		
		private var _client:FTPClient;
		
		public function get client():FTPClient
		{
			if (_client == null)
				_client = new FTPClient;
			return _client;
		}
		
		public function get loginUser():User
		{
			return site.loginUser;
		}
		
		private var _site:Site;
		public function get site():Site
		{
			if(_site == null)
			{
				var user:User = new User("u660405012","qlda_12354");
				_site = new Site;
				_site.loginUser = user;
				_site.host = "31.220.110.91";
				_site.port = 21;
			}
			return _site;
		}
		
		private function handleConnected (evt:FTPEvent):void
		{
			client.login(loginUser.name, loginUser.password);
		}
		
		private function handleLogged (evt:FTPEvent):void
		{
			client.list();
		}
		
		private function handleChangeDir (evt:FTPEvent):void
		{
			client.list();
		}
		
		[Bindable]
		public var fileCollection:ArrayCollection;
		
		private function handleListing(evt:FTPEvent):void
		{
			this.fileCollection = new ArrayCollection(evt.listing);
		}
		
		private function initClientHandlers():void
		{
			client.addEventListener(FTPEvent.CONNECTED, handleConnected);
			client.addEventListener(FTPEvent.LOGGED, handleLogged);
			client.addEventListener(FTPEvent.LISTING, handleListing);
			client.addEventListener(FTPEvent.CHANGE_DIR, handleChangeDir);
		}
		
		public function connect():void
		{
			client.connect(site.host, site.port);
		}
		
		private var consoleListener:ConsoleListener;
		
		public function get logOutput():TextArea
		{
			return consoleListener ? consoleListener.textArea : null;
		}
			
		public function set logOutput(value:TextArea):void
		{
			if(value != null)
			{
				if (consoleListener == null)
				{
					consoleListener = new ConsoleListener(client, value);
				}
				consoleListener.textArea = value;
			}			
		}
	}
}
class SingletonEnforce{}