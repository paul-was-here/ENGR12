//Paul Kullmann
#include <iostream>

void Function1(void);
int Function2(void);
float Function3(char, float, float);
void Function4(float, char, float, float);
void Function5(int[], int[], int);
void Function6(int[], int[], int);

int main(int argc, char **argv)
{
	char goagain;
	do {
		printf("I, Paul Kullmann, certify that I have completed this assignment in an honest manner.\n");
		Function1();
		int choice;
		choice = Function2();
		if (choice == 1) { //Math Operations
			float num1, num2;
			printf("Enter a real number: ");
			scanf("%f",&num1);
			printf("Enter a second real number: ");
			scanf("%f",&num2);
			char operation;
			do {
			printf("Choose the operation:\n(a) Addition\n(s) Subtraction\n(m) Multiplication\n(d) Division\n");
			scanf(" %c",&operation);
			} while((operation != 'a') && (operation != 's') && (operation != 'm') && (operation != 'd'));
			float output;
			output = Function3(operation, num1, num2);
			Function4(output, operation, num1, num2);
		}
		else if (choice == 2) { //Array
			int elements, i;
			do {
			printf("Enter the desired number of array elements, maximum 5: ");
			scanf("%d",&elements);
			} while ((elements > 5) || (elements < 0));
			int array[elements];
			for (i=0;i<elements;i++) {
				printf("Enter the value for array element %d: ",(i+1));
				scanf("%d",&array[i]);
			}
			int function5return[2] = {-100000000,0};
			Function5(array, function5return, elements);
			Function6(function5return, array, elements);
		}
		do {
		printf("\n\nDo you want to run the program again? (Y/N): ");
		scanf(" %c",&goagain);
		} while ((toupper(goagain) != 'N') && (toupper(goagain) != 'Y'));
	} while(toupper(goagain) == 'Y');
	return 0;
}

void Function1(void) {
	printf("Paul Kullmann\n");
	printf("April 6, 2024\n");
	printf("The purpose of this program is to either let the user perform some mathematical operations or to perform some analysis on an array.\n");
}

int Function2(void) {
	int choice;
	do {
	printf("Enter 1 to perform math operations, or enter 2 to create an array: ");
	scanf("%d",&choice);
	} while ((choice != 1) && (choice != 2));
	return (choice);
}

float Function3(char operation, float num1, float num2) {
	float output;
	switch (operation) {
		case 'a': //Addition
			output = num1 + num2;
			break;
		case 's': //Subtraction
			output = num1 - num2;
			break;
		case 'm': //Multiplication
			output = num1 * num2;
			break;
		case 'd': //Division
			output = num1 / num2;
			break;
	}
	return(output);
}

void Function4(float output, char operation, float num1, float num2) {
	printf("\nThe two values you entered were %f and %f\n",num1,num2);
	printf("You chose the operation %c\n",operation);
	printf("The result of the operation is %f",output);
	FILE *results;
	results = fopen("results.txt","w");
	fprintf(results,"The two values you entered were %f and %f\n",num1,num2);
	fprintf(results,"You chose the operation %c\n",operation);
	fprintf(results,"The result of the operation is %f",output);
	fclose(results);
}

void Function5(int array[], int function5return[], int elements) {
	int i;
	for(i=0;i<elements;i++) {
		if (array[i]>function5return[0]) {
			function5return[0] = array[i];
			function5return[1] = i;
		}
	}
}

void Function6(int function5return[], int array[], int elements) {
	FILE *results;
	results = fopen("results.txt","w");
	printf("The array you entered is:\n");
	fprintf(results,"The array you entered is:\n");
	int i;
	for (i=0;i<elements;i++) {
		printf("%d\t",array[i]);
		fprintf(results,"%d\t",array[i]);
	}
	printf("\nThe max is %d located at array index %d",function5return[0],function5return[1]);
	fprintf(results,"\nThe max is %d located at array index %d",function5return[0],function5return[1]);
}
