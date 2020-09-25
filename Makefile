CC=crystal
SRC=src/cycling.cr
FLAGS=--release

cycling : $(SRC)
	$(CC) build $(FLAGS) $(SRC)

.PHONY: clean
clean :
	rm cycling
