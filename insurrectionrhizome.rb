#Insurrection-style-app
#Rhizomes/reflections are based on targets/industries/projects/etc. - to be discussed in theoretical discourse and trialled
#in CE-implementation.
#Next: society-organisation-style-app 
#Next: strategy-style-app

#PROJECT = An abstraction, based on the spiral, away from the "Grand project" - > each project must justify how it communises well (communisation as the grand project)
#OPERATION = An instance of the project's attempt to successfully complete itself, or hack from the virtual into the real (Mackenzie Wark). Another kind of abstraction. 

require 'optparse'

options = {}

optparse = OptionParser.new do|opts|
    opts.banner = "Usage: rhizome.rb <options>"
    #OPTIONS    
    #------------    
    options[:new] = false
    opts.on('-n', '--new', 'New operation altogether, new cell') do
        options[:new] = true
    end
    #--
    options[:add] = false 
    opts.on('-a', '--add', 'Add people to an existing operation cell') do
        options[:add] = true
    end
    #--
    options[:list] = false
    opts.on('-l', '--list', 'List all cells in rhizome') do
        options[:list] = true
    end
    #--
#    opts.on('') do
#        puts opts
#        exit
#    end
    #--
    opts.on('-h', 'help', 'Display this screen') do
        puts opts
        exit
    end
end

optparse.parse!

#----------
#CLASSES
#--

class OpCell
    
    def initialize(opname, start_date, end_date)
        @opname = opname
        @start_date = start_date
        @end_date = end_date
    end
    
    def makeCell(*args)
         @memberslist = args
         @members = args.join(', ')
    end
    
    def articulate()
         puts "----------------------------------"
         puts "The name of the op is: #{@opname}"
         puts "The start date is: #{@start_date}"
         puts "The end date is: #{@end_date}"
         puts "The members are: #{@members}"
    end

end

#------------
#FUNCTIONS
#--
def new()
    members = []
    time = Time.new
    starting = "#{time.day}/#{time.month}/#{time.year}" 
    
    puts "What is the name of this operation?"
    name = gets.chomp
    
    puts "Enter the people in this cell:"
    
    while true
        input = gets.chomp
        break if input.empty?
        members << input
    end
    
    puts "Enter the end date"
    ending = gets.chomp  
    
    cell = OpCell.new(name, starting, ending)
    cell.makeCell(*members)
    cell.articulate()
    
    #save obj to disk 
    #remember to sanitize input
    File.open("ops/#{name}", 'w+') do |f|
        Marshal.dump(cell, f)
    end 
end

def view()
    puts "Which operation to view?"
    opname = gets.chomp
    
    File.open("ops/#{opname}") do |f|
        @cell = Marshal.load(f)
    end
    
    @cell.articulate()
    #need to serialize all instances of Cell class
    #then choose out of the saved instances which one 
    #then open them for editing
    #then serialise and save again
    #ENSURE SAFE SERIALISATION RUBY
    
end

def connect()
    #this connects your cell to the operation with the origin-cell's permission
end

def list()
    puts "Listing off pseudos"
end            

  #########_ ########--        
 ###STARTING_HERE###----
###########_#######------

if options[:new]
    new()
elsif options[:add]
    view()
elsif options[:list]
    list()
else
    "fail"
    exit(0)
end
