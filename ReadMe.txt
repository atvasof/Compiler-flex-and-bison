Compiler Project 2012 FORT320 Language

Instructions :
1)	flex mylex_return.lex

2)	bison -dv syntax.y

3)	gcc -o output syntax.tab.c -lfl

4)	./output<test.f
