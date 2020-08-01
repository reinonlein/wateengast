public class classes {
    
    public static void main(String[] args) {

        class Number {

            int number;

            public boolean isPositive() {
                if (number >= 0) {
                    return true;
                    
                } else {
                    return false;
                }
            }

        }

        Number myNumber = new Number();

        myNumber.number = 42;

        if (myNumber.isPositive()) {
            System.out.println(myNumber.number + " is a positive number.");
        } else {
            System.out.println(myNumber.number + " is a negative number.");
        }

    }

}