OBJS = main.o cpin.o parse_cpin.o string_manip.o cloptions.o test.o
CXX = g++
F90 = gfortran
#OPTFLAGS = -O3 -mtune=native
OPTFLAGS = -O0 -g

install: $(OBJS)
	g++ -Wall -o cphutil $(OBJS) -lgfortran

.SUFFIXES: .F90 .cpp .o

.F90.o:
	$(F90) $(OPTFLAGS) -Wall -c $*.F90

.cpp.o:
	$(CXX) $(OPTFLAGS) -Wall -c $*.cpp

clean:
	/bin/rm -f $(OBJS)
