package Util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class ConnectionUtil
{
	private static Connection connection;
	
	public static Connection getConnectionFromFile() throws IOException, SQLException
	{
		Properties prop = new Properties();
		InputStream in = new FileInputStream("connection.properties");
		prop.load(in);
		if(connection == null || connection.isClosed()) {
			connection = DriverManager.getConnection(prop.getProperty("url"), prop.getProperty("username"), prop.getProperty("password"));
		}
		return connection;
	}
}