package com.revature.models;

public class Frog extends Animal {
	//Inheritance: class derived from a superclass allowing access to their states and behaviors
	public Frog() {
		super(4, false);
	}
	//Abstraction/polymorphism: Implementation and overriding of the interface method
	public String talk() {
		return "Croak!";
	}
	
	public static void makeNoise() {
		System.out.println("Frog Noises");
	}
	@Override
	public boolean equals(Object o) {
		if(o.getClass() != this.getClass()) {
			return false;
		}
		Frog a = (Frog) o;
		if (a.getLegs() == this.getLegs() && a.isHasFur() == this.isHasFur()) {
			return true;
		}
		return false;
	}
}
