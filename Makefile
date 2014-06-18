
# java make file stuff
JC = /opt/jdk1.8.0_05/bin/javac  #using java 8 compiler
JCLASSPATH = -cp bin/
JFLAGS = -sourcepath src/ -d bin/
JA = /opt/jdk1.8.0_05/bin/java
JAFLAGS = -cp bin/
JD = javadoc
srcdir = src
bindir = bin
libdir = lib
datadir = data
docsdir = docs
dirs = $(srcdir) $(bindir) $(libdir) $(datadir) $(docsdir)
.SUFFIXES:
.SUFFIXES: .java .class

#src & obj locations, might need to expand the wildcard with deeper packages
VPATH = src/:$(wildcard $(bindir)/*/)

# general make stuff
SHELL = /bin/sh

# java variables
source = $(wildcard $(srcdir)/*.java)
objects = $(shell find ./bin/ -iname *.class -printf "%P\n") # java objects
main = $(notdir $(basename $(mainsrc) ) )
mainsrc = $(shell grep -l main src/*)
mainexe =  $(basename $(shell find ./bin/ -iname $(main).class -printf "%P\n"))

#manditory first target
.PHONY : all
all : withthemakingalready
	@echo ":: All Target ::"

#standard target
.PHONY : clean
clean :
	@echo ":: Clean Target ::"
	-rm -R $(bindir)
	-mkdir $(bindir)
	-rm *.jar

#standard target
.PHONY : install
install : 
	@echo ":: Install Target ::"
	$(PRE_INSTALL)
	@echo ".. Pre Install .."
	$(NORMAL_INSTALL)
	@echo ".. Normal Install .."
	$(POST_INSTALL)
	@echo ".. Post Install .."
#check for install as daemon and generate service scripts :D

#standard target
.PHONY : uninstall
uninstall : 
	@echo ":: Uninstall Target ::"

#standard target
.PHONY : install-html
install-html : 
	@echo ":: Install-html Target ::"

#standard target
.PHONY : html
html : 
	@echo ":: Html Target ::"
	$(JD) $(source) -d $(docsdir)

#javadoc

#standard target
.PHONY : check
check : 
	@echo ":: Check Target ::"

#standard target
.PHONY : installcheck
installcheck : 
	@echo ":: Installcheck Target ::"

#standard target
.PHONY : installdirs
installdirs : 
	@echo ":: Installdirs Target ::"
	-mkdir $(DESTDIR)$(bindir)
	-mkdir $(DESTDIR)$(libdir)

.PHONY : dirs
dirs : 
	@echo ":: Dirs Target ::"
	-mkdir $(bindir)
	-mkdir $(libdir)
	-mkdir $(srcdir)
	-mkdir $(datadir)
	-mkdir $(docsdir)

.PHONY : cleandirs
cleandirs : 
	-rmdir $(srcdir)
	-rmdir $(bindir)
	-rmdir $(libdir)
	-rmdir $(datadir)
	-rmdir $(docsdir)

#nice to do the dist/distclean stuff oneday

.PHONY : status
status :
	@echo " ::::::''''''''''''''''':::::: "
	@echo " ::       Make Status       :: "
	@echo " ::::::.................:::::: "
	@echo " :: Objects : $(objects)"
	@echo " :: Source  : $(source)"
	@echo " :: Main Src: $(mainsrc)"
	@echo " :: Main    : $(main)"
	@echo " :: Main Ex : $(mainexe)"
	@echo " ::::::.............................................. "
#add something about the packages found here too :p you lazy sod.

.PHONY : withthemakingalready
withthemakingalready :
	@echo ":: Making already Target ::"
	$(JC) $(JCLASSPATH) $(JFLAGS) $(source)

.PHONY : me
me : 
	@echo ":: Making JavaME Midlet ::"
#	JCLASSPATH = "bin/:/opt/wtk/lib/midpapi20.jar"
	$(JC) -cp "bin/:/opt/wtk/lib/midpapi20.jar" $(JFLAGS) $(source)
#	make withthemakingalready

.PHONY : jar
jar : 
	jar cvfm ./$(main).jar Manifest.mf $(bindir)/*

.PHONY : run
run :
	@echo ":: Run Target ::" 
	$(JA) $(JAFLAGS) $(mainexe)

.PHONY : runSilent
runSilent :
	$(JA) $(JAFLAGS) $(mainexe) > /dev/null

.PHONY : runSchedule
runSilent :
	@echo ":: Run Schedule ::" 
	crontab $(datadir)/default.cron

.PHONY : defaultSchedules
defaultSchedule :
	@echo ":: Making Schedules ::" 
	echo \* \* \* \* \*  $(JA) $(JAFLAGS) $(mainexe) > $(datadir)/default.cron
	echo 0,15,30,45 \* \* \* \*  $(JA) $(JAFLAGS) $(mainexe) > $(datadir)/quater-hour.cron
	echo 0,5,10,15,20,25,30,35,40,45,50,55 \* \* \* \*  $(JA) $(JAFLAGS) $(mainexe) > $(datadir)/5-min.cron

# Java rules
# or something like $(wildcard $(bindir)/*/%.class) : $(srcdir)/%.java
%.class : %.java
	@echo ":: Java Default ::"
	$(JC) $(JFLAGS) $^







#find -printf
#%f %p #file name only
#%h #dir only
#%P


#$(bin)/%.class : $(src)/%.java
#	$(JC) $(JFLAGS) src/$^




