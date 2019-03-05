package DAO;

import java.util.List;

import Classes.User;

public interface UserDao {
	public List<User> getUsers();
	public int createUser(User u);
	public int updateUser(User u);
	public int deleteUser(int id);
}
