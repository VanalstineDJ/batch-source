package com.revature.models;

//abstract class to define some common behavior that can be inherited by multiple subclasses like Lion class
public class Mamals {
	private String name;
	private String genus;
	private boolean canHunt;

	public Mamals() {
		
	}
	
	public Mamals(String name, String genus,boolean canHunt) {
		this.name = name;
		this.genus= genus;
		this.canHunt = canHunt;
	}
	//Encapsulation can be achieved by: Declaring all the variables in the class 
	//as private and writing public methods in the class to set and get the values of variables.

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGenus() {
		return genus;
	}

	public void setGenus(String genus) {
		this.genus = genus;
	}

	public boolean isCanHunt() {
		return canHunt;
	}

	public void setCanHunt(boolean canHunt) {
		this.canHunt = canHunt;
	}

}