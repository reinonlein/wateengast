public class numbershapes {

    public static void main(String[] args) {

        class Number {

            int number;

            //check squared
            public boolean isSquared() {

                double root = Math.sqrt(number); 

                if (root == Math.floor(root)) {
                    return true;
                } else {
                    return false;
                }
            }

            //check triangular
            public boolean isTriangular() {

                int x = 1; 
                int triangularNumber = 1;
                while (triangularNumber < number) {
                    x++;
                    triangularNumber = triangularNumber + x;
                }

                if (triangularNumber == number) {
                    return true;
                } else {
                    return false;
                }
            }

        }
        
        Number myNumber = new Number();

        myNumber.number = 7;

        String message;

        if (myNumber.isSquared() && myNumber.isTriangular()) {
            message = "The number is squared and triangular";
        } else if (myNumber.isSquared()) {
            message = "The number is squared";
        } else if (myNumber.isTriangular()) {
            message = "This number is triangular";
        } else {
            message = "This number is crap.";
        }


        System.out.println(myNumber.isSquared());
        System.out.println(myNumber.isTriangular());
        System.out.println(message);


    }
    
}