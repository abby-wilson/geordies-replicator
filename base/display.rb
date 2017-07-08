# IMPORTANT: DO NOT MODIFY THIS FILE.
# To complete this assignment you only need to modify
# the files inside the individual /episode-xx/ folders.
# You may, however, take a look inside this file to see
# how the entire program works. Ideally though, you'll
# only need to work with the files inside the individual
# /episode-xx/ folders to fix the replicator each episode.

class Display

  include StringHelper

  def initialize(episode)
    @episode = episode
  end

  def enterprise_image
    puts File.open("#{__dir__}/art/enterprise.txt").read
  end

  def episode_title_and_setup

    puts <<~OOO

    Episode ##{@episode.number}: "#{@episode.title}"

     #{word_wrap(@episode.lines['setup'])}

    OOO

  end

  def star_saying_replicator_command
    puts " #{@episode.star} says:"
    puts
    puts "    #{@episode.lines['replicator_command']}"
    puts
  end

  def press_any_key
    unless ARGV.last == 'fast' || ARGV.last == 'super-fast'
      temp_print('Press any key to start the replicator.') do
        exit if STDIN.getch == "\u0003" # Control-C
      end
    end
  end

  def replicator_whirling_effect
    print " The replicator begins to whirl "
    20.times do
      print '...'
      pause 0.1
      print "\b\b\b   \b\b\b"
      pause 0.1
    end
  end

  def star_anticipating_replicator_creation
    puts '... finished!'
    puts
    anticipating_creation_str = word_wrap(" #{@episode.star} #{@episode.lines['anticipating_replicator_creation']}")
    print anticipating_creation_str
    3.times do
      print '.'
      pause 1
    end
    puts
  end

  def star_responding_to_replicator_creation(glass)

    puts

    if !glass
      puts "   #{@episode.lines['responding_to_nothing_on_replicator_plate']}"
      use_debugging_techniques_msg

    elsif glass.errors?
      puts "   #{@episode.lines['responding_to_replicator_creation_failure']}"
      puts
      glass.errors.each do |error|
        puts "   #{error}"
      end
      puts
      puts "   #{@episode.lines['fix_replicator_request']}"
      puts
      use_debugging_techniques_msg

    elsif glass.valid?
      puts  "   #{@episode.lines['responding_to_replicator_creation_success']}"
      puts
      puts " #{@episode.lines['move_on_to_next_episode']}"
      puts
    end

  end

  def use_debugging_techniques_msg
    puts
    puts ' Use your newly learned debugging techniques to fix the issue and play the episode again.'
    puts
  end

  def pause(time)
    if ARGV.last == 'super-fast'
      return
    elsif ARGV.last == 'fast'
      sleep time / 10
    else
      sleep time
    end
  end

  def self.help_and_exit

    launch_file = caller.last[/.*.rb/]

    puts <<~OOO

     Usage
     =====

        ruby #{launch_file} <episode number>

        For example, to play episode one:
        ruby #{launch_file} 1

    OOO

    exit

  end

end
