package com.revature.dao;

import java.util.List;

import com.revature.model.BankingAccount;

//Constructs the layout of the Banking Account Dao implementation
public interface BankingAccountDao {
	
	public List<BankingAccount> getBankingAccount();
	public BankingAccount getBankingAccountById(int id);
	public int createAccount(BankingAccount b);
	public int updateAccount(BankingAccount b);
	public int deleteAccount(int id);
	public int changeAccountBalance(int id, double changeAmount);
}