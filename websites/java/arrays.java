import java.util.*;

public class arrays {

    public static void main(String[] args) {

        List<String> landen = new ArrayList<String>();

        landen.add("Nederland");
        landen.add("België");
        landen.add("Duitsland");

        System.out.println(landen.get(1));

        landen.remove("België");
        
        System.out.println(landen.get(1));


        int[] nummers = {42, 42};

        if (nummers[0] > nummers[1]) {
            System.out.println("Het eerste getal is groter");
        } else if (nummers[1] > nummers[0]) {
            System.out.println("Het tweede getal is groter");
        } else {
            System.out.println("De getallen zijn even groot");
        }

    }
    
}