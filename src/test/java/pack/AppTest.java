package pack;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import person.Person;

import java.io.File;
import java.util.*;


public class AppTest {
    ArrayList<Person> persons = new ArrayList<>();
    ArrayList<Person> personsSorting = new ArrayList<>();
    File myFiles = new File("persons.dat");//тестовый файл

    @Before
    public void setPersons() {
        persons.add(new Person("Dmitriy", "Andrychenko", 17));
        persons.add(new Person("Viktor", "Komarov", 23));
        persons.add(new Person("Egor", "Creed", 25));
        persons.add(new Person("Anton", "Zacepin", 19));
        persons.add(new Person("Cristiano", "Ronaldo", 18));
    }

    @Test
    public void checkAge21() {
        int expected = 0;
        for (Person person : persons
        ) {
            if (person.getAge() < 21) {
                expected++;
            }
        }
        int actual = 3;//Ожидаем количество
        Assert.assertEquals("Mistake! Quantity doesn't match!", expected, actual);
    }

    @Before
    public void sorting() {
        personsSorting.add(new Person("Dmitriy", "Andrychenko", 17));//Ожидаем такую последовательность
        personsSorting.add(new Person("Egor", "Creed", 25));
        personsSorting.add(new Person("Viktor", "Komarov", 23));
        personsSorting.add(new Person("Cristiano", "Ronaldo", 18));
        personsSorting.add(new Person("Anton", "Zacepin", 19));

        ArrayList<Person> personsSortingNew = new ArrayList<>();
        personsSortingNew.addAll(Person.sortingAndRemoveDuplicates(persons));//добавили в новую коллекцию отсортированные обьекты
        Assert.assertEquals(personsSortingNew, personsSorting);//сравниваем две коллекции (переопределили equals)
    }

    public boolean isFileEmpty(File file) {
        return file.length() == 0;
    }

    @Test
    public void save() {
        Person.savePerson(myFiles, Person.sortingAndRemoveDuplicates(persons));
        if ((!isFileEmpty(myFiles))) {
            System.out.println("Objects saved to file");
        } else {
            System.out.println("Error, objects not saved to file");
        }

    }

    @Test
    public void read() {
        if ((!isFileEmpty(myFiles))) {
            Person.readPerson(myFiles);
            Assert.assertEquals(Person.readList, personsSorting);//содержимое считываемого файл совпадает с записанным
        } else {
            System.out.println("File is empty!");
        }
    }
}


