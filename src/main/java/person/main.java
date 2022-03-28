package person;

import java.io.File;
import java.util.*;

public class main {
    public static void main(String[] args) {
        ArrayList<Person> persons = new ArrayList<>();//создаём группу из 100 человек
        for (int i = 0; i < Person.COUNT_PERSON; i++) {
            persons.add(new Person(Person.generateName(), Person.generateSurName(), Person.generateAge()));
        }

        Person.sortingUnder21(persons); // выбираем тех кому меньше 21 года
        Person.sortingAndRemoveDuplicates(Person.listBy21);// сортируем по фамилии, а потом по имени и сразу же убираем дубликаты

        File myFile = new File("person.dat");//создаём пустой файл
        Person.savePerson(myFile, Person.personTreeSet);// сохраняем в файл каждый экземпляр
        Person.readPerson(myFile);//читаем из файла
        Person.streamsOutput(Person.readList);//используем стримы и выводим на экран
    }
}
