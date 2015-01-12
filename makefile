CC=g++
CFLAGS=-Wall -std=c++11 -o2
LDFLAGS=-lsfml-system -lsfml-audio -lsfml-network -lsqlite3
SOURCES=main.cpp src/admin.cpp src/HolidayLights.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXE=HolidayLights

all: $(SOURCES) $(EXE)

$(EXE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@
	
.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm $(EXE)
	rm -rf *.o