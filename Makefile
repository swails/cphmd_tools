include config.h

.NOTPARALLEL:clean install all
.PHONY: test

OBJS = main.ph.o cpin.ph.o parse_cpin.ph.o string_manip.ph.o cloptions.ph.o test.ph.o cpout.ph.o \
       prottraj.ph.o utilities.ph.o conprob.ph.o
       
OBJS2 = main.redox.o cpin.redox.o parse_cpin.redox.o string_manip.redox.o cloptions.redox.o test.redox.o cpout.redox.o \
       prottraj.redox.o utilities.redox.o conprob.redox.o
       
PROGNAME  = cphstats

PROGNAME2 = cestats

all: $(PROGNAME) $(PROGNAME2)

$(PROGNAME): $(OBJS)
	$(LD) -o $(PROGNAME) $(OBJS) $(LDFLAGS)

$(PROGNAME2): $(OBJS2)
	$(LD) -o $(PROGNAME2) $(OBJS2) $(LDFLAGS2)

install: $(PROGNAME) $(PROGNAME2)
	/bin/mv $(PROGNAME) $(BASEDIR)/bin
	/bin/mv $(PROGNAME2) $(BASEDIR)/bin

uninstall:
	/bin/rm -f $(BASEDIR)/bin/$(PROGNAME)
	/bin/rm -f $(BASEDIR)/bin/$(PROGNAME2)

.SUFFIXES: .F90 .cpp .ph.o .redox.o

depends::
	./makedepends

.F90.ph.o:
	$(F90) $(F90FLAGS) -c $*.F90 -o $*.ph.o

.cpp.ph.o:
	$(CXX) $(CXXFLAGS) -c $*.cpp -o $*.ph.o

.F90.redox.o:
	$(F90) $(F90FLAGS2) -c $*.F90 -o $*.redox.o

.cpp.redox.o:
	$(CXX) $(CXXFLAGS2) -c $*.cpp -o $*.redox.o

clean:
	/bin/rm -f $(OBJS) $(OBJS2)
	cd test_ph && ./testall.sh clean
	cd test_redox && ./testall.sh clean

test: $(PROGNAME) $(PROGNAME2)
	cd test_ph && ./testall.sh
	cd test_redox && ./testall.sh

new: clean $(PROGNAME) $(PROGNAME2)

include depends
