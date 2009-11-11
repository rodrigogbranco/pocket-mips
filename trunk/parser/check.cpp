#include <iostream>
#include <stdio.h>
#include <string>
#include <cstring>
#include <stdlib.h>
using namespace std;

int main(int argc, char** argv)
{
	if(argc != 2)
	{
		cout<<"Erro: Número de argumentos inválido\n";
		return 1;
	}
	
	FILE* arq = fopen(argv[1],"rt");
	if(arq != NULL)
	{
		while(!feof(arq))
		{
			char c;
			fread(&c,1,1,arq);
			unsigned int op, r1, r2, func, im;
			op = c & 224;
			op = op >> 5;
			r1 = c & 24;
			r1 = r1 >> 3;
			r2 = c & 6;
			r2 = r2 >> 1;
			func = c & 3;
			im = c & 31;

			if (op == 0)
			{
				cout<<"add ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 2)
			{
				cout<<"sub ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 6)
			{
				if (func == 0)
					cout<<"mta ";
				else
					cout<<"mtb ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 7)
			{
				if (func == 0)
					cout<<"mfa ";
				else if(func == 1)
					cout<<"mfb ";
				else
					cout<<"halt\n";
				if(func != 3)
				{
					switch(r1)
					{
						case 0 : cout<<"r0\n"; break;
						case 1 : cout<<"r1\n"; break;
						case 2 : cout<<"r2\n"; break;
						case 3 : cout<<"r3\n"; break;
					}
				}
			}
			else if (op == 1)
				cout<<"addi "<<im<<endl;
			else if (op == 2)
			{
				cout<<"sub ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 4)
			{
				cout<<"lw ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 5)
			{
				cout<<"sw ";
				switch(r1)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
			else if (op == 3)
			{
				cout<<"beq ";
				switch(r1)
				{
					case 0 : cout<<"r0 "; break;
					case 1 : cout<<"r1 "; break;
					case 2 : cout<<"r2 "; break;
					case 3 : cout<<"r3 "; break;
				}
				switch(r2)
				{
					case 0 : cout<<"r0\n"; break;
					case 1 : cout<<"r1\n"; break;
					case 2 : cout<<"r2\n"; break;
					case 3 : cout<<"r3\n"; break;
				}
			}
		}
	}
	fclose(arq);
	return 0;
}
