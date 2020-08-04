package com.revature.models;

public class Driver {
	
	public static void main(String[] args) {
		
		System.out.println("FOUR PILLARS");
		System.out.println("------------\n");
		
		//Basic Animal
		Animal a1 = new Animal(); // this no arguments constructor creates an Animal object using the default constructor, which has default values as well
		System.out.println(a1.toString());
		// Aniaml with paramaterized constructor
		System.out.println();
		Animal a2 = new Animal(2, false);
		System.out.println(a2.toString());
		System.out.println();
		a2.setNumOfLegs(4); // change the number of legs on animal 2 with is access modifier
		System.out.println(a2.toString());
		System.out.println();
		
		// Using Covarient Types to create a new object.  A third type of polymorphism.
		Animal a3 = new Cat(); // because it is an Animal, it does not have access to the methods of the Cat class
		System.out.println(a3.toString());
		System.out.println();
		//Cat objects
		Cat c1 = new Cat(); // creating a Cat object with the null constructor
		System.out.println(c1.toString());
		System.out.println();
		Cat c2 = new Cat("Lion", true, "African Safari"); // Cat object using the constructor with parameters
		System.out.println(c2.toString());
		System.out.println(c2.run());
		System.out.println();
		
		
		// Panther objects
		Cat p1 = new Panther(); // the Panther class only has one constructor
		System.out.println(p1.toString());
		Panther p2 = new Panther();// 
		p2.setDomainStatus("Wakanda"); // changes the domain of the created p2 object
		System.out.println(p2.toString());
		System.out.println(p2.run()); // invokes the run method specified in the panther class

		System.out.println();
		
		// Sphynx objects
		Cat s1 = new Sphynx();  // another Covarient type
		System.out.println(s1.toString());
		System.out.println();
		Sphynx s2 = new Sphynx(); // a pure Sphynx objet
		s2.setBreed("Egyptian"); // change the breed of the stander Sphynx object
		System.out.println(s2.toString());
		System.out.println(s2.run()); // invoke the run method of the object
		System.out.println();
		
		// Monkey object
		Animal m1 = new Monkey(); // this covarient type will not have access to the methods of the Monkey class
		System.out.println(m1.toString());
		// m1.setBreed("Orangutan"); does not work because it is a Covarient type
		System.out.println();
		Monkey m2 = new Monkey("Chimpanzee");
		System.out.println(m2.toString());
		System.out.println(m2.swing());
		m2.setBreed("Gorilla"); // m2 is a pure monkey object, so the values can be accessed through the access modifiers
		m2.setHasTail(false);
		System.out.println();
		System.out.println(m2.toString());
		System.out.println(m2.run());
		
		
	}

}