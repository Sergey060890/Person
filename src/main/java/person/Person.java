package person;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

import java.io.*;
import java.util.*;
import java.util.stream.Stream;

@AllArgsConstructor
@Getter
@ToString

public class Person implements Serializable {
    public static final int COUNT_PERSON = 100;
    public static final int MIN_AGE = 15;
    public static final int MAX_AGE = 30;
    public static final int SORTED_BY_AGE = 21;
    private String name;
    private String surname;
    private int age;
    public static ArrayList<Person> listBy21 = new ArrayList<>();
    public static TreeSet<Person> personTreeSet;
    public static List<Person> readList = new ArrayList<>();

    public static String generateName() {
        Random random = new Random();
        String[] name = new String[]{"Sergey", "Roman", "Viktor", "Pavel", "Andrey", "Egor", "Nikolay", "Maksim", "Dmitriy", "Vitaliy"};
        return name[random.nextInt(name.length)];
    }

    public static String generateSurName() {
        Random random = new Random();
        String[] surname = new String[]{"Lisovec", "Orlov", "Ivanov", "Mirskiy", "Sergeev", "Polevoy", "Sanikovich", "Andryshenko", "Lamovoy", "Petrow"};
        return surname[random.nextInt(surname.length)];
    }

    public static int generateAge() {
        int getAge = MIN_AGE + (int) (Math.random() * MAX_AGE);
        return getAge;
    }

    public static List<Person> sortingUnder21(List<Person> list) {
        int count = 0;
        for (Person person : list
        ) {
            if (person.getAge() < Person.SORTED_BY_AGE) {
                listBy21.add(person);
                count++;
            }
        }
        System.out.println("Selected those under 21 years old:");
        for (Person person : listBy21
        ) {
            System.out.println(person);
        }
        System.out.println("Found: " + count + " persons");
        return listBy21;
    }

    public static TreeSet<Person> sortingAndRemoveDuplicates(ArrayList list) {
        int count = 0;
        Person.PersonNameComparator nameComparator = new Person.PersonNameComparator();//создаём компораторы
        Person.PersonSurNameComparator surnameComparator = new Person.PersonSurNameComparator();
        personTreeSet = new TreeSet<>(surnameComparator.thenComparing(nameComparator));//сортируем  и убираем дубли
        personTreeSet.addAll(list);
        System.out.println();
        System.out.println("After sorting:");
        for (Person person : personTreeSet
        ) {
            System.out.println(person.toStringTwo());
            count++;
        }
        System.out.println(count + " persons left");
        System.out.println();
        return personTreeSet;
    }

    public static void savePerson(File file, TreeSet treeSet) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file))) {
            for (Object person : treeSet//сохраняем
            ) {
                oos.writeObject(person);
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static void readPerson(File file) {
        System.out.println("Read from file:");
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
            Scanner sc = new Scanner(new FileInputStream((file)));
            while (sc.hasNext()) {
                Person p = (Person) ois.readObject();
                System.out.println("surname:" + p.getSurname() + ", name:" + p.getName() + ", age:" + p.getAge());
                readList.add(p);
            }
        } catch (Exception ex) {
        }
    }

    public static void streamsOutput(List list) {
        System.out.println();
        System.out.println("Read people by last name and first name:");
        Stream<Person> peoples = list.stream();
        peoples
                .map(p -> "surname: " + p.getSurname() + ", name: " + p.getName())
                .forEach(System.out::println);
    }

    public String toStringTwo() {
        return "Person:" +
                "surname='" + surname + '\'' + ", name='" + name + '\'' +
                ", age=" + age +
                '}';
    }

    static class PersonNameComparator implements Comparator<Person> {
        public int compare(Person a, Person b) {
            return a.getName().toUpperCase().compareTo(b.getName().toUpperCase());
        }
    }

    static class PersonSurNameComparator implements Comparator<Person> {
        public int compare(Person a, Person b) {
            return a.getSurname().toUpperCase().compareTo(b.getSurname().toUpperCase());
        }
    }

    @Override
    public boolean equals(Object obj) { //метод сравнения (пригодится в тестах)
        if (obj == this) return true;
        Person person = (Person) obj;
        return Objects.equals(person.surname, surname) && Objects.equals(person.name, name) && Objects.equals(person.age, age);
    }
}
