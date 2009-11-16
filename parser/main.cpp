#include <iostream>
#include <stdio.h>
#include <string>
#include <cstring>
#include <stdlib.h>
#include <fstream>
using namespace std;

int main(int argc, char** argv)
{
	if(argc != 3)
	{
		cout<<"Erro: Número de argumentos inválido\n";
		return 1;
	}
	
	ifstream arq;
	arq.open(argv[1],ios::in); 
	FILE* out = fopen(argv[2],"w");
	if(arq != NULL)
	{
		int count = 0;
		while(!fin.eof())
		{
			char line[100];
			char* tok;
			arq.getline(line,100);
			tok = strtok(line," ,\n\r");
			//cout<<tok;
			count++;
			unsigned char instruction;
			char inst_text[50];
			if(strncmp(tok,"add",3) == 0)
			{
				if(strncmp(argv[3],"bin",3) == 0)
				{
					instruction = 0;
					tok = strtok(NULL," ,");
					if(strncmp(tok,"r0",2) == 0);
						//do nothing
					else if(strncmp(tok,"r1",2) == 0)
						instruction = instruction | 8;
					else if(strncmp(tok,"r2",2) == 0)
						instruction = instruction | 16;
					else if(strncmp(tok,"r3",2) == 0)
						instruction = instruction | 24;
					else
					{
						cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
						return 1;
					}

					fwrite(&instruction,1,1,out);
				}
				else if(strncmp(argv[3],"text",4)
				{
					inst_text
				}
			}
			else if(strncmp(tok,"sub",3) == 0)
			{
				instruction = 64;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"mta") == 0)
			{
				instruction = 192;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"mtb") == 0)
			{
				instruction = 193;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"mfa") == 0)
			{
				instruction = 224;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"mfb") == 0)
			{
				instruction = 225;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"halt") == 0)
			{
				instruction = 255;
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"addi") == 0)
			{
				tok = strtok(NULL," ,");
				instruction = atoi(tok);
				instruction = (instruction & 31) | 32;
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"lw") == 0)
			{
				instruction = 128;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"sw") == 0)
			{
				instruction = 160;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else if(strcmp(tok,"beq") == 0)
			{
				instruction = 96;
				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 8;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 16;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 24;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}

				tok = strtok(NULL," ,");
				if(strncmp(tok,"r0",2) == 0);
					//do nothing
				else if(strncmp(tok,"r1",2) == 0)
					instruction = instruction | 2;
				else if(strncmp(tok,"r2",2) == 0)
					instruction = instruction | 4;
				else if(strncmp(tok,"r3",2) == 0)
					instruction = instruction | 5;
				else
				{
					cout<<"Erro. Linha "<<count<<": registrador "<<tok<<" não existe\n";
					return 1;
				}
				fwrite(&instruction,1,1,out);
			}
			else
			{
				cout<<"Erro. Linha "<<count<<": instrução "<<tok<<" não existe\n";
				return 1;
			}
		}
	}
	else
	{
		cout<<"Erro: O arquivo não pode ser aberto para leitura\n";
		return 1;		
	}
	fclose(arq);
	fclose(out);
	return 0;
}
