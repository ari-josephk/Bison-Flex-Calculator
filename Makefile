build:
	bison -d calc1.y
	flex calc1.l
	g++ lex.yy.c calc1.tab.c

run:
ifeq (,$(wildcard a.out))
	@echo "Need to build first!"
else
	@echo "Starting Calculator:"
	@./a.out
endif

clean:
	rm -f calc1.tab.c calc1.tab.h calc2.tab.c calc2.tab.h lex.yy.c a.out