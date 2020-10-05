CC = g++
CFLAGS = -std=c++0x -Wall -g
EXEC_NAME = Exercice1_ionEuler_student
INCLUDES =
LIBS =
OBJ_FILES = Exercice1_ionEuler_student.o

all : $(EXEC_NAME)

clean :
	rm $(EXEC_NAME) $(OBJ_FILES) *.out

$(EXEC_NAME) : $(OBJ_FILES)
	$(CC) -o $(EXEC_NAME) $(OBJ_FILES) $(LIBS)

%.o: %.cpp
	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<

