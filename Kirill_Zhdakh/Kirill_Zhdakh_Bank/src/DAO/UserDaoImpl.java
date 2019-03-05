package DAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import Classes.User;
import Util.ConnectionUtil;

public class UserDaoImpl implements UserDao {
	final private static Logger log = Logger.getRootLogger();
	@Override
	public List<User> getUsers() {
		List<User> userList = new ArrayList<>();
		String sql = "SELECT * FROM USER_TABLE";
		try(Connection c = ConnectionUtil.getConnectionFromFile();
			Statement s = c.createStatement();
			ResultSet rs = s.executeQuery(sql))
		{
			while(rs.next())
			{
				userList.add(new User(rs.getString("USER_FIRSTNAME"), rs.getString("USER_LASTNAME"), rs.getString("USER_USERNAME"), rs.getString("USER_PASSWORD")));			
			}
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		return userList;
	}

	@Override
	public boolean createUser(User u) {
		String sql = "INSERT INTO USER_TABLE (USER_FIRSTNAME,"
					+"USER_LASTNAME,USER_USERNAME,USER_PASSWORD)"
					+"VALUES (?,?,?,?)";
		
		try(Connection con = ConnectionUtil.getConnectionFromFile();
			PreparedStatement ps = con.prepareStatement(sql))
		{		
			ps.setString(1, u.getFirstName());
			ps.setString(2, u.getLastName());
			ps.setString(3, u.getUsername());
			ps.setString(4, u.getPassword());
			ps.executeUpdate();
			return true;
		} 
		catch (IOException e)
		{
			return false;
		}
		catch (SQLException e) 
		{
			return false;
		}
	}

	@Override
	public int updateUser(User u) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteUser(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

}