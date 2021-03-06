package com.revature.models;

public class Vehicle {
	// this is a single line comment
	
	/*
	 * this is a multiline comment
	 * also part of this comment
	 */
	
	/**
	 * this is for documentation
	 */
	
	// instance variables of vehicle class
	private int numOfWheels;
	private boolean isMoving;
	
	public Vehicle() {
		super();
	}
	
	public Vehicle(int numOfWheels) {
		super();
		this.numOfWheels = numOfWheels;
	}
	
	public Vehicle(int numOfWheels, boolean isMoving) {
		super();
		this.numOfWheels = numOfWheels;
		this.isMoving = isMoving;
	}

	public int getNumOfWheels() {
		return numOfWheels;
	}
	
	public void setNumOfWheels(int numOfWheels) {
		this.numOfWheels = numOfWheels;
	}
	
	public boolean getIsMoving() {
		return isMoving;
	}
	
	public void setIsMoving(boolean isMoving) {
		this.isMoving = isMoving;
	}
	
	public static void myStaticMethod() {
		System.out.println("static method from Vehicle");
	}
	
	public String toString() {
		return "Vehicle: numOfWheels="+numOfWheels+", isMoving="+isMoving;
	}
	
	@Override
	public boolean equals(Object o) {
		if(o.getClass()!=this.getClass()) {
			return false;
		}
		Vehicle v = (Vehicle) o;
		if(v.isMoving!=this.isMoving) {
			return false;
		}
		if(v.numOfWheels!=this.numOfWheels) {
			return false;
		}
		return true;
		
	}
	

}
