#include<stdio.h>

void main(int argc, char* argv[]){
if (argc !=4)
	printf("Wrong args. Usage: test InputFile1 InputFile2 Outfile\n");
else{
	printf("ARG1:%s\nARG2:%s\n",argv[1], argv[2] );
FILE *file1 = fopen(argv[1],"r");
FILE *file2 = fopen(argv[2],"r");
FILE *out= fopen(argv[3],"w");
char fw;
char sw;
while((fscanf(file1,"%c", &fw) != EOF) && (fscanf(file2,"%c", &sw) != EOF)){
	fprintf(out, "%c", fw^sw);
	fprintf(stdout, "%c", fw^sw);
}




//while(( df = getchar()) != EOF)
//	printf("%c", df);

fclose(out);
fclose(file1);
fclose(file2);
}
}
