CC = gcc
INCLUDES =
LDFLAGS = -lsqlite3
CFLAGS = -Og -g3 -Wall -Wextra

TARGET = testsql
OBJ_DIR = ../_obj
TEST_DIR = ../tests
HEADERS =
OBJS =

# Main target
all: $(TARGET)

testsql: testsql.c
	$(CC) $(CFLAGS) -o ../$@ $< $(LDFLAGS)

.PHONY: clean
clean:
	rm -f ../testsql
