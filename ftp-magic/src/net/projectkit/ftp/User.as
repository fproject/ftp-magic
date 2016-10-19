package net.projectkit.ftp
{
	[RemoteClass(alias="User")]
	public class User
	{
		public var name:String;
		public var password:String;
		public function User(name:String=null, password:String=null)
		{
			this.name = name;
			this.password = password;
		}
	}
}